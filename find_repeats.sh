samtools view -b JA1.sorted.bam chr21 > JA1_chr21.sorted.bam
mv JA1_chr21.sorted.bam JA1_chr21.bam
samtools sort -o JA1_chr21.sorted.bam JA1_chr21.bam
samtools index JA1_chr21.sorted.bam
samtools view JA1_chr21.bam .
samtools view JA1_chr21.sorted.bam . | less
awk '{print $6"\t"$7"\t"$8"\t"$12;}' rna_repeat_chr21 > rna_repeat_chr21.bed

# Make file header say chrom chromStart chromEnd
# comment header rna_repeat_chr21.bed of with #

bedtools intersect -sorted -c -a rna_repeat_chr21.bed -b JA1_chr21.sorted.bam > intersect
#intersect is a file that has counts in last column


TODO
- write python script for getting repeat states
- Get #reads in bamfile -- from stat file, YOU HAVE THIS RIGHT?
- Write general script
	- Test on one file with all chromosomes


# Get counts for each class from intersect file (do in python script)
# Get #reads in OG bam file
# Show: 
For each file
	Pie chart of repeat class
	What % of reads are repeats
	Raw repeat count
	Raw repeat count bar chart of diff classes 

Combine all repeats into one
	pie chart of what class