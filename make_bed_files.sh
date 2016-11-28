# Convert homer peak files to bed plots
# Run from home dir, requires homer

PEAK_PATH=/mnt/oncogxA/Projects/CHENCS/tag_dirs_lite_align/JA

mkdir ~/peak_graphs_lite_align
for i in $(seq 1 8)
do

  filepath=$PEAK_PATH$i/peaks.txt
  outpath=~/peak_graphs_lite_align/JA$((i))_peaks.txt

  echo $filepath
  echo $outpath
  echo

  pos2bed.pl $filepath > $outpath

done


pos2bed.pl ~/ja1_ja12_peaks.txt > ~/peak_graphs_lite_align/JA1_JA12_peaks.txt
