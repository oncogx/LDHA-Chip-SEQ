#!/bin/sh
#!/bin/sh
# This script goes through each Chip-SEQ experiment and creates tag dirs for HOMER
# PREREQUISITE: HOMER is installed on this machine and in the directory that 
# this script is being ran from

BAM_PATH=/mnt/oncogxA/Projects/CHENCS/bam/

# For JA2-16 make a tag directory
for i in $(seq 2 16)
do
	filename=JA$i.sorted.bam
	
	echo $BAM_PATH$filename
	echo ~/tag_dirs/JA$i
	mkdir ~/tag_dirs/JA$i

	makeTagDirectory ~/tag_dirs/JA$i $BAM_PATH$filename
	echo
done