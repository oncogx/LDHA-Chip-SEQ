# To Plot bar chart of number of peaks per experiment
setwd('/Volumes/oncogxA/Projects/CHENCS')

library(ggplot2)
require(gridExtra)

# Load map of numbers to biology names
samplesheet <- read.csv("samplesheet.txt", sep="", header = FALSE)
colnames(samplesheet) <- c("num", "name")
samplesheet <- samplesheet[1:2]

# Number is name eg. "JA1" in caps
getBioName <- function(number){
  number = toupper(number)
  
  if(number == "JA1_JA12")
    return("LN229-vehicle-LDHA aligned w/JA12")
  else
    return(toString(samplesheet[samplesheet$num == number,2]))
}

# Load table of exp and peak numbers
exp <- read.table("homer_peak_files/peak_cmp_table.tsv", sep="\t", header= TRUE)
exp$bioName = lapply(exp$exp_num, getBioName)

barplot(exp$num_peaks, main = "Number of peaks", names.arg = exp$bioName)

# Fitting Labels 
#par(las=2) # make label text perpendicular to axis
#par(mar=c(5,8,4,2)) # increase y-axis margin.
#
#counts <- table(mtcars$gear)
#barplot(counts, main="Car Distribution", horiz=TRUE, names.arg=c("3 Gears", "4 Gears", "5   Gears"), cex.names=0.8)