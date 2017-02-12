setwd("/Volumes/oncogxA/Projects/CHENCS/bam/chr21/repeats")
filenames <- list.files(path="/Volumes/oncogxA/Projects/CHENCS/bam/chr21/repeats", pattern="*_chr21_repeats.bed", full.names=T, recursive=FALSE)
baseNames <- lapply(filenames, basename)
bioNames <- lapply(baseNames, getBioName)

# Append full repeats file to get expected
#filenames[[17]] = "/Volumes/oncogxA/Projects/CHENCS/bam/chr21/rna_repeat_chr21_c.bed"
#bioNames[[17]] = "Expected"

# Get number of repeats which is sum of counts in repeats file
counts <- as.vector(lapply(filenames, getTotalRepeatCount)) # Counts of repeats in order of filenames

# Get total number of reads in each file
statNames <- list.files(path="/Volumes/oncogxA/Projects/CHENCS/bam/chr21/", pattern="*.sorted.bam.stat", full.names=T, recursive=FALSE)
totalCounts <- as.vector(lapply(statNames, getReadCount))

#exps <- data.frame(bioName = as.array(bioNames), repeats = as.numeric(as.array(counts)), reads = as.numeric(as.array(totalCounts)) )
#exps <- data.frame(bioName = bioNames, repeats = as.numeric(counts), reads = as.numeric(totalCounts) )
exps <- as.data.frame(cbind(t(as.data.frame(bioNames)), t(as.data.frame(counts)), t(as.data.frame(totalCounts))))
colnames(exps) = c("bioName", "repeats", "reads")

exps = rbind(exps, "Expected" = c("Expected", 60998,48129895)) #repeats is #lines in rna_repeats bed file, #reads is from hg-19.chr-sizes on Pranav's folder in share drive
exps$repeats <- as.numeric(as.character(exps$repeats))
exps$reads <- as.numeric(as.character(exps$reads))
exps$bioName <- as.character(as.character(exps$bioName))
# Add in expected manually

exps$propRepeat = exps$repeats / exps$reads
exps = exps[c(17,16,2,3,4,5,6,7,8,1,9,10,11,12,13,14,15),]

p = ggplot(exps, aes(x=bioName, y=propRepeat)) + geom_bar(stat = "identity") + coord_flip()
p + ggtitle("Proportion of repeat reads in chr21")

getReadCount <- function(statFile) {
  return(as.double(system(paste("awk 'NR == 1 {print $1}'", statFile), intern = TRUE)))
}

getTotalRepeatCount <- function(filename) {
  overlap <- read.table(filename, col.names = c("chrom", "start", "end", "class", "num_overlaps"))
  
  class.table = aggregate(x = overlap$num_overlaps, by = list(class=overlap$class), FUN = sum)
  
  colnames(class.table) <- c("class", "count")
  return(sum(class.table$count))
}

samplesheet <- read.csv("/Volumes/oncogxA/Projects/CHENCS/samplesheet.txt", sep="", header = FALSE)
colnames(samplesheet) <- c("num", "name")
samplesheet <- samplesheet[1:2]
getBioName <- function(filename){
  
  number = gsub("_chr21_repeats.bed","", filename)
  number = toupper(number)
  name = toString(samplesheet[samplesheet$num == number,2])
  name = gsub("-", "_", name)
  return(name)
  
}
