setwd("/Volumes/oncogxA/Projects/CHENCS/Olivier/bed")
all = read.table("all.merged.bed")

# Remove u2os only peaks, we only care about ln229
#all = subset(all, grep("JA", all$V4)) # Remove anything that's JA7 only or JA8 only or only JA7 and JA8

all.og = all

shared.everything = subset(all, grep("JA1^JA2^JA3^JA4^JA5^JA6", all$V4))