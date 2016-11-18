#!/bin/sh
# This script goes through each Chip-SEQ experiment and its respective control 
# and finds its peaks using HOMER package
# PREREQUISITES: HOMER is installed on this machine and in the directory that 
# this script is being ran from AND tag directories have been made

# path prefixes
BW_PATH=/mnt/oncogxA/Projects/CHENCS/BigWig/*.bw
BED_PATH=/mnt/oncogxA/Projects/CHENCS/bed/
BAM_PATH=/mnt/oncogxA/Projects/CHENCS/bam/
TAG_DIR_PATH=~/tag_dirs/tag_dirs/

# For each experiment/control pair
for i in $(seq 1 8)
do

  # Generate tag directory path
  ctrl_num=$((i+8))
  exp_name=JA$i
  ctrl_name=JA$ctrl_num
  exp_tag=$TAG_DIR_PATH$exp_name
  ctrl_tag=$TAG_DIR_PATH$ctrl_name
  
  echo $exp_tag
  echo $ctrl_tag
  echo

  # Find peaks
  # Usage: findPeaks <tag directory> -style <factor | histone> -o auto -i <control tag directory>
  findPeaks $exp_tag -style factor -o auto -i $ctrl_tag 

done
