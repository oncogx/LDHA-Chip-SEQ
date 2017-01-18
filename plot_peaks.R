# To Plot histograms for each experiment
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

# Returns 1.5*IQR + q3
getMaxLim <- function(elements) {
    return(quantile(elements)[4] + 1.5*IQR(elements))
}

## Plot LDHA ########################################################
# Load Data
ldha.data <- list()
nums <- list()
names <- list()
pval.plots <- list()
peakscore.plots <- list()
ldha.score.binwidths=c(1, 13, 1, 1)
filenames <- list.files(path="homer_peak_files/LDHA", pattern="*.txt", full.names=T, recursive=FALSE)
i = 1

for(peak.file in filenames) {
  # Get and transform data
  table <- read.csv(peak.file, comment.char = "#", header = TRUE, sep="")
  
  # Set0s to minimum so they are not omitted from plots
  min.pval = min(table$p.value_vs_Control[table$p.value_vs_Control != 0])
  table$p.value_vs_Control[table$p.value_vs_Control == 0] <- min.pval
  table$nLogPval = -log10(table$p.value_vs_Control)
  
  # Remove outliers for things we will plot
  pval.lim = getMaxLim(table$nLogPval)
  table = subset(table, nLogPval <= pval.lim)
  score.lim = getMaxLim(table$findPeaks_Score)
  table = subset(table, findPeaks_Score <= score.lim)
  
  
  ldha.data[[i]] = table
  
  # Get number and corresponding bio name
  base.file = basename(peak.file)
  exp.num = gsub("_peaks.txt", "", base.file)
  nums[[i]] = exp.num
  names[[i]] = getBioName(exp.num)
 
  # Make pval plot
  pval.plot <- ggplot(data = table, aes(nLogPval))
  pval.plot <- pval.plot + geom_histogram(binwidth = 5)
  pval.plot <- pval.plot + annotate("text",  x=Inf, y = Inf, label = names[[i]], vjust=1, hjust=1)
  pval.plot <- pval.plot + theme(axis.title.x=element_blank(), axis.title.y=element_blank())
  pval.plot <- pval.plot + expand_limits(x = 0, y = 0) + scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))
  pval.plots[[i]] <- pval.plot 
  
  # Make findPeaks plot
  peakscore.plot <- ggplot(data = table, aes(findPeaks_Score))
  peakscore.plot <- peakscore.plot + geom_histogram(binwidth = ldha.score.binwidths[i])
  peakscore.plot <- peakscore.plot + annotate("text",  x=Inf, y = Inf, label = names[[i]], vjust=1, hjust=1)
  peakscore.plot <- peakscore.plot + theme(axis.title.x=element_blank(), axis.title.y=element_blank())
  #peakscore.plot <- peakscore.plot + xlim(min(table$findPeaks_Score)*0.95, max(table$findPeaks_Score)*1.1)
  peakscore.plot <- peakscore.plot + expand_limits(x = 0, y = 0) + scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))
  peakscore.plots[[i]] <- peakscore.plot 
  
  i = i+1
}
grid.arrange(pval.plots[[1]], pval.plots[[2]], pval.plots[[3]], pval.plots[[4]],
             ncol = 1, top = "Peak Signifiance", left = "count", bottom = "-log(p val)")

grid.arrange(peakscore.plots[[1]], peakscore.plots[[2]], peakscore.plots[[3]], peakscore.plots[[4]], 
             ncol = 1, top = "HOMER findPeaks Score", left = "count", bottom = "Score")


## Plot gH2AX ########################################################
# Load Data
gh2ax.data <- list()
nums <- list()
names <- list()
pval.plots <- list()
peakscore.plots <- list()
gh2ax.score.binwidths=c(5, 2, 5)
filenames <- list.files(path="homer_peak_files/GH2AX", pattern="*.txt", full.names=T, recursive=FALSE)
i = 1

for(peak.file in filenames) {
  # Get and transform data
  table <- read.csv(peak.file, comment.char = "#", header = TRUE, sep="")
  
  # Set0s to minimum so they are not omitted from plots
  min.pval = min(table$p.value_vs_Control[table$p.value_vs_Control != 0])
  table$p.value_vs_Control[table$p.value_vs_Control == 0] <- min.pval
  table$nLogPval = -log10(table$p.value_vs_Control)
  
  # Remove outliers for things we will plot
  pval.lim = getMaxLim(table$nLogPval)
  table = subset(table, nLogPval <= pval.lim)
  score.lim = getMaxLim(table$findPeaks_Score)
  table = subset(table, findPeaks_Score <= score.lim)
  
  gh2ax.data[[i]] = table
  
  # Get number and corresponding bio name
  base.file = basename(peak.file)
  exp.num = gsub("_peaks.txt", "", base.file)
  nums[[i]] = exp.num
  names[[i]] = getBioName(exp.num)
 
  # Make pval plot
  pval.plot <- ggplot(data = table, aes(nLogPval))
  pval.plot <- pval.plot + geom_histogram(binwidth = 4)
  pval.plot <- pval.plot + annotate("text",  x=Inf, y = Inf, label = names[[i]], vjust=1, hjust=1)
  pval.plot <- pval.plot + theme(axis.title.x=element_blank(), axis.title.y=element_blank())
  pval.plot <- pval.plot + expand_limits(x = 0, y = 0) + scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))
  pval.plots[[i]] <- pval.plot 
  
  # Make findPeaks plot
  peakscore.plot <- ggplot(data = table, aes(findPeaks_Score))
  peakscore.plot <- peakscore.plot + geom_histogram(binwidth = gh2ax.score.binwidths[i])
  peakscore.plot <- peakscore.plot + annotate("text",  x=Inf, y = Inf, label = names[[i]], vjust=1, hjust=1)
  peakscore.plot <- peakscore.plot + theme(axis.title.x=element_blank(), axis.title.y=element_blank())
  peakscore.plot <- peakscore.plot + expand_limits(x = 0, y = 0) + scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))
  peakscore.plots[[i]] <- peakscore.plot 
  
  i = i+1
}
grid.arrange(pval.plots[[1]], pval.plots[[2]], pval.plots[[3]], 
             ncol = 1, top = "Peak Signifiance", left = "count", bottom = "-log(p val)")

grid.arrange(peakscore.plots[[1]], peakscore.plots[[2]], peakscore.plots[[3]],
             ncol = 1, top = "HOMER findPeaks Score", left = "count", bottom = "Score")


## Plot U2OS ########################################################
# Load Data
u2os.data <- list()
nums <- list()
names <- list()
pval.plots <- list()
peakscore.plots <- list()
filenames <- list.files(path="homer_peak_files/U2OS", pattern="*.txt", full.names=T, recursive=FALSE)
i = 1

for(peak.file in filenames) {
  # Get and transform data
  table <- read.csv(peak.file, comment.char = "#", header = TRUE, sep="")
  
  # Set0s to minimum so they are not omitted from plots
  min.pval = min(table$p.value_vs_Control[table$p.value_vs_Control != 0])
  table$p.value_vs_Control[table$p.value_vs_Control == 0] <- min.pval
  table$nLogPval = -log10(table$p.value_vs_Control)
  
  # Remove outliers for things we will plot
  pval.lim = getMaxLim(table$nLogPval)
  table = subset(table, nLogPval <= pval.lim)
  score.lim = getMaxLim(table$findPeaks_Score)
  table = subset(table, findPeaks_Score <= score.lim)
  
  u2os.data[[i]] = table
  
  # Get number and corresponding bio name
  base.file = basename(peak.file)
  exp.num = gsub("_peaks.txt", "", base.file)
  nums[[i]] = exp.num
  names[[i]] = getBioName(exp.num)
 
  # Make pval plot
  pval.plot <- ggplot(data = table, aes(nLogPval))
  pval.plot <- pval.plot + geom_histogram(binwidth = 5)
  pval.plot <- pval.plot + annotate("text",  x=Inf, y = Inf, label = names[[i]], vjust=1, hjust=1)
  pval.plot <- pval.plot + theme(axis.title.x=element_blank(), axis.title.y=element_blank())
  pval.plot <- pval.plot + expand_limits(x = 0, y = 0) + scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))
  pval.plots[[i]] <- pval.plot 
  
  # Make findPeaks plot
  peakscore.plot <- ggplot(data = table, aes(findPeaks_Score))
  peakscore.plot <- peakscore.plot + geom_histogram(binwidth = 1.85)
  peakscore.plot <- peakscore.plot + annotate("text",  x=Inf, y = Inf, label = names[[i]], vjust=1, hjust=1)
  peakscore.plot <- peakscore.plot + theme(axis.title.x=element_blank(), axis.title.y=element_blank())
  peakscore.plot <- peakscore.plot + expand_limits(x = 0, y = 0) + scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))
  peakscore.plots[[i]] <- peakscore.plot 
  
  i = i+1
}
grid.arrange(pval.plots[[1]], pval.plots[[2]],  
             ncol = 1, top = "Peak Signifiance", left = "count", bottom = "-log(p val)")

grid.arrange(peakscore.plots[[1]], peakscore.plots[[2]], 
             ncol = 1, top = "HOMER findPeaks Score", left = "count", bottom = "Score")
