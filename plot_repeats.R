# Plots number of repeats (overlaps with UCSC repeatMasker track) for each experiment

setwd("/Users/massoudmaher/Documents/Code/LDHA-Chip-SEQ/docker_mnt")

overlap <- read.table("intersect.bed", col.names = c("chrom", "start", "end", "class", "num_overlaps"))
total.overlaps = sum(overlap$num_overlaps)
num.reads = 29.312214e6

class.table = aggregate(x = overlap$num_overlaps, by = list(class=overlap$class), FUN = sum)
colnames(class.table) <- c("class", "count")

# Some classes are DNA?, this may vary by file
# Remove all appended ?s then combine classes that have the same name
class.table$class <- gsub("\\?","", class.table$class)
no_qs = tapply(class.table$count, class.table$class, FUN=sum)
class.table = as.data.frame(no_qs)
class.table$class = rownames(class.table)
rownames(class.table) = c()
class.table <- class.table[c(2,1)]
colnames(class.table) <- c("class", "count")

class.table$prop_reads = class.table$count / num.reads
class.table$prop_class = class.table$count / sum(class.table$count)

library(ggplot2)
plot = ggplot(data = class.table, aes(x=factor(1), y = prop_class, fill=class))
plot = plot + geom_bar(stat = 'identity')
plot

plot2 = ggplot(data = class.table, aes(x=factor(1), y = prop_class, fill=class))
plot2 = plot + geom_bar(stat = 'identity')
plot2

require(gridExtra)
grid.arrange(plot, plot2,  
             ncol = 2, top = "Categories of repeat classes", left = "count", bottom = "-log(p val)")
# Remove ylabels, y axis labels, only have legend on last plot, only have y axis label on first plot?
