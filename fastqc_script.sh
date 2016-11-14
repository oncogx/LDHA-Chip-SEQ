#!/bin/sh
# This script runs fastqc on all of the fastqc files
# NEEDS fastqc to be installed first

all_unz=""
for i in $(seq 1 8)
do
  filename=JA$i.fastq.bz2
  unz_file=JA$i.fastq

  all_unz="$all_unz $unz_file"
  
  echo $filename
  echo $unz_file
  echo $all_unz

  #bzip2 -d -k $filename

done


#fastqc --outdir=./qc/ $all_unz
