setwd("/Volumes/oncogxA/Projects/CHENCS/bam/chr21/repeats")
filenames <- list.files(path="/Volumes/oncogxA/Projects/CHENCS/bam/chr21/repeats", pattern="*_chr21_repeats.bed", full.names=T, recursive=FALSE)
baseNames <- lapply(filenames, basename)
bioNames <- lapply(baseNames, getBioName)

# number of reads in chr21
numReads =  48129895;

# Add expected distribution
filenames = c(filenames, "/Volumes/oncogxA/Projects/CHENCS/bam/chr21/rna_repeat_chr21_c.bed")
bioNames=  c(bioNames, "Expected")

all.tables = lapply(filenames, getClassTable)
names(all.tables) <- bioNames
all.tables = lapply(all.tables, removeQs)
#all.tables = lapply(all.tables, function(df){non_repeat = numReads- sum(df["count"]); df = rbind(df, c("non_repeat", as.numeric(non_repeat))); df})
#all.tables <- lapply(all.tables, function(df) { df["count"] <- NULL; df })
#all.tables <- lapply(all.tables, function(df){df["count"] = as.numeric(df["count"]); df})
eg.table <- all.tables[[1]]

all.tables <- lapply(all.tables, t)
all.tables <- lapply(all.tables, as.data.frame)
all.tables <- lapply(all.tables, function(df) { colnames(df) = as.character(as.matrix(df[1,])); df})
all.tables <- lapply(all.tables, function(df) { df <- df[-1,]; df})
master.table = do.call("rbind", all.tables)
master.table.t = as.data.frame(t(master.table))
master.table.n = apply(master.table.t, 2, as.numeric)


statNames <- list.files(path="/Volumes/oncogxA/Projects/CHENCS/bam/chr21/", pattern="*.sorted.bam.stat", full.names=T, recursive=FALSE)
totalCounts <- as.vector(lapply(statNames, getReadCount))

master.table = apply(master.table, 2, as.numeric)
master.table = as.data.frame(master.table)
master.table$non_repeat = as.numeric(totalCounts) - rowSums(master.table)
master.table$class = bioNames

master.table.t = t(master.table)
master.table.td = as.data.frame(master.table.t)
colnames(master.table.td) <- master.table.t["class",]
master.table.td = master.table.td[-18,]
master.table.td = apply(master.table.td, 2, as.numeric)

#master.table.ntr = master.table.nt[c(17,16,2,3,4,5,6,7,8,1,9,10,11,12,13,14,15),]

# TODO remove irrelevant columns?
plot = ggplot(data = master.table.nt, aes(x=factor(1), y = LN229_vehicle_LDHA, fill = class)) + geom_bar(stat = "identity")
plot
plot + facet_grid(. ~ LN229_IR_input_LDHA + LN229_H2O2_input_LDHA)
plot + facet_wrap(. ~ LN229_IR_input_LDHA + LN229_H2O2_input_LDHA)





class.tables = list()
plots = list()
i=1


for(file in filenames) {
  
  classtable = getClassTable(file)
  classtable = removeQs(classtable)
  name = basename(file)
  
  plot = ggplot(data = classtable, aes(x=factor(1), y = prop_class, fill=class))
  plot = plot + geom_bar(stat = 'identity') + xlab(getBioName(name)) + theme(axis.text.x=element_blank(), axis.title.x = element_text(angle = 90, hjust=1))

  if(i != 8) {
    plot = plot + guides(fill = FALSE)  
  }
  if(i != 1) {
    plot = plot + theme(axis.title.y=element_blank(), axis.text.y=element_blank(), axis.ticks.y=element_blank())
  }
  
  print(plot)
    
   
  class.tables[[i]] = classtable
  plots[[i]] = plot
  i=i+1
}

grid.arrange(plots[[1]], plots[[9]], plots[[10]], plots[[11]], plots[[12]], plots[[13]], plots[[14]], plots[[15]], plots[[16]], plots[[2]], plots[[3]], plots[[4]], plots[[5]], plots[[6]], plots[[7]], plots[[8]],
             ncol = 16, top = "Categories of repeat classes", bottom = "experiment", widths = c(2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,5))

# Reads in the .bed file output by bedtools intersect and assembles a class count dataframe, returns the class count dataframe
getClassTable <- function (filename) {
  overlap <- read.table(filename, col.names = c("chrom", "start", "end", "class", "num_overlaps"))
  
  class.table = aggregate(x = overlap$num_overlaps, by = list(class=overlap$class), FUN = sum)
  
  colnames(class.table) <- c("class", "count")
  return(class.table)
}

# Takes a class count dataframe and removes the classes with ?s in them, combining them
removeQs <- function(class.table) {
  class.table$class <- gsub("\\?","", class.table$class)
  no_qs = tapply(class.table$count, class.table$class, FUN=sum)
  
  class.table = as.data.frame(no_qs)
  class.table$class = rownames(class.table)
  rownames(class.table) = c()
  class.table <- class.table[c(2,1)]
  colnames(class.table) <- c("class", "count")
  
  #class.table$prop_class = class.table$count / sum(class.table$count)
  return(class.table)
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
