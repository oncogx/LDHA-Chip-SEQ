#!/bin/bash

ref=/mnt/idash/Genomics/data_resources/references-and-indexes/GRCh37/GRCh37-lite.fa
fastq=$1

# remove .fastq.bz2 extension
name=`basename $fastq ".fastq.bz2"`
echo $name
echo $name.bam
echo $ref

# decompress, pipe into bwa alginment, pipe into samtools view which prints into
# alignment file
# - makes output/input to stdin/out
bzip2 -dc $fastq | bwa mem $ref - | samtools view -buSh - > ~/bam/$name.bam
samtools sort -m 10G ~/bam/$name.bam ~/bam/$name.sorted 
samtools index ~/bam/$name.sorted.bam
samtools flagstat ~/bam/$name.sorted.bam > ~/bam/$name.stat
