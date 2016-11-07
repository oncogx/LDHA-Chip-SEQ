#!/bin/sh
# This script goes through each Chip-SEQ experiment and its respective control 
# and finds its peaks using HOMER package
# PREREQUISITE: HOMER is installed on this machine and in the directory that 
# this script is being ran from

# TODO: change these paths to work on the VM this script is being ran on
BW_PATH=/Volumes/oncogxA/Projects/CHENCS/BigWig/*.bw
BED_PATH=/Volumes/oncogxA/Projects/CHENCS/bed/
BAM_PATH=/Volumes/oncogxA/Projects/CHENCS/bam/
TAG_DIR_PATH=/Volumes/oncogxA/Projects/CHENCS/tag_dirs/

# Following arrays hold file names of experiments with corresponding controls
experiment=(JA1.sorted.bam JA2.sorted.bam JA3.sorted.bam JA4.sorted.bam JA5.sorted.bam JA6.sorted.bam JA7.sorted.bam JA8.sorted.bam )
control=(JA9.sorted.bam JA10.sorted.bam JA11.sorted.bam JA12.sorted.bam JA13.sorted.bam JA14.sorted.bam JA15.sorted.bam JA16.sorted.bam )

# Make directory to store tag directories for each experiment
mkdir $TAG_DIR_PATH

# Generate string that holds paths to all of the bam files to be used as param 
# for batchParallel.pl
all_paths_str=""
exp_paths_str=""
ctrl_paths_str=""
for i in $(seq 1 8)
do
	exp_paths_str="$exp_paths_str $BAM_PATH${experiment[i-1]}"
	ctrl_paths_str="$ctrl_paths_str $BAM_PATH${control[i-1]}"
	
	all_paths_str="$exp_paths_str $BAM_PATH${experiment[i-1]}"
	all_paths_str="$exp_paths_str $BAM_PATH${control[i-1]}"
done

#echo $all_paths_str
#echo
#echo $ctrl_paths_str
#echo
#echo $exp_paths_str
#echo


## For each experiment/control pair
#for i in $(seq 1 8)
#do
#
#  # Get bam filepaths
#  exp_path=$BAM_PATH${experiment[i-1]}
#  ctrl_path=$BAM_PATH${control[i-1]}
#  #echo $exp_path
#  #echo $ctrl_path2
#
#  # Generate experiment name
#  ctrl_num=$[i+8]
#  exp_name=JA$i
#  ctrl_name=JA$ctrl_num
#  #echo $exp_name
#  #echo $ctrl_name
#  echo $TAG_DIR_PATH$exp_name
#  echo $TAG_DIR_PATH$ctrl_name
#
#  # Make tag directories and do quality control, in parallel
#  # quality control info is in same directory as tag
#  # Usage: batchParallel.pl <command> <stdoutSuffix | none> [options] -f <file1> <file2>
#  # Usage: makeTagDirectory <Output Directory Name> [options] <alignment file1> [alignment file 2] ...	 
#  # Sample commands 
#  #RUN THIS FIRST AS A TEST ./makeTagDirectory ./testTag/JA7 /Volumes/oncogxA/Projects/CHENCS/bam/JA7.sorted.bam
#  #makeTagDirectory $TAG_DIR_PATH$exp_name $exp_path
#  #makeTagDirectory $TAG_DIR_PATH$ctrl_name $ctrl_path
#  batchParallel.pl makeTagDirectory tag_dir -f 
#
#
#  # Find peaks
#  # Usage: findPeaks <tag directory> -style <factor | histone> -o auto -i <control tag directory>
#
#
#  
#
#done
