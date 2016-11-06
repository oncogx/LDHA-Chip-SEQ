#!/bin/sh
# This script goes through each Chip-SEQ experiment and its respective control 
# and finds its peaks using HOMER package
# PREREQUISITE: HOMER is installed on this machine and in the directory that 
# this script is being ran from

# TODO: change these paths to work on the VM this script is being ran on
BW_PATH=/Volumes/oncogxA/Projects/CHENCS/BigWig/*.bw
BED_PATH=/Volumes/oncogxA/Projects/CHENCS/bed/
BAM_PATH=/Volumes/oncogxA/Projects/CHENCS/bam/*.bam

for bamfile in $BAM_PATH
do
	echo $bamfile

done
