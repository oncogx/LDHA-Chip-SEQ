setwd('/Volumes/oncogxA/Projects/CHENCS')

all_peaks <- read.csv("Olivier/bed/all.merged.bed", header = FALSE, sep="\t")
colnames(all_peaks) <- c("chrom", "start", "end", "exps")