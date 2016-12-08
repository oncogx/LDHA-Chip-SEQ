# To Plot histograms for each experiment
setwd('/Volumes/oncogxA/Projects/CHENCS')

# Load map of numbers to biology names
samplesheet <- read.csv("samplesheet.txt", sep="", header = FALSE)
colnames(samplesheet) <- c("num", "name")
samplesheet <- samplesheet[1:2]

# Number is name eg. "JA1" in caps
getBioName <- function(number){
  return(toString(samplesheet[samplesheet$num == "JA1",2]))
}

# Load each experiment into its own dataframe
# NOTE: cannot take raw homer output, must get line 40, remove # from beginning and replace all spaces with _
JA1 = read.csv("homer_peak_files/ja1_peaks.txt", comment.char = "#", header = TRUE, sep="")
JA1$nLogPval = -log10(JA1$p.value_vs_Control)

# Plot histograms
library(ggplot2)
testplot <- ggplot(data = JA1, aes(nLogPval))
testplot + geom_histogram(binwidth = 5) + ggtitle("-log pval")

score.plot <- ggplot(data = JA1, aes(findPeaks_Score))
score.plot + geom_histogram(binwidth = 20) + ggtitle("findPeaks score")
