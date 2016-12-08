
# TODO change to /mnt/
BAM_PATH=/Volumes/oncogxA/Projects/CHENCS/peak_graphs_lite_align/
OUT_PATH=/Volumes/oncogxA/Projects/CHENCS/peak_overlaps_lite_align/
#SKIP_FILE=/Volumes/oncogxA/Projects/CHENCS/peak_graphs_lite_align/JA1_peaks.bed

# for each pair of files
#for file1 in $BAM_PATH
for i in $(seq 1 7)
do

  #for file2 in $BAM_PATH
  for j in $(seq $((i+1)) 8)
  do

    file1=$BAM_PATH"JA"$i"_peaks.bed"
    file2=$BAM_PATH"JA"$j"_peaks.bed"

    echo $file1
    echo $file2
    echo

    name1=`basename $file1 "_peaks.bed"`
    name2=`basename $file2 "_peaks.bed"`

    echo $name1
    echo $name2
    echo

    outname=$name1"_"$name2"_overlap.bam"
    outpath=$OUT_PATH$outname

    echo $outpath
    echo
    echo "-------------------------------"

    #bedtools intersect -sorted -c -a $file1 -b $file2 > $outpath
  done
  

done

