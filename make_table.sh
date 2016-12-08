# Script to make table compiling info from all peak files


echo -e "exp_num\tnum_peaks\tIP_efficiency\n" > peak_cmp_table.tsv

for filename in *.txt
do
  num=`basename "$filename" _peaks.txt`
  echo $num

  num_peaks=`awk 'NR == 5 {print $5; exit}' "$filename"`
  echo num_peaks: $num_peaks

  ip_eff=`awk 'NR == 13 {print $6; exit}' "$filename"`
  echo ip_eff: $ip_eff
  echo

  echo -e "$num\t$num_peaks\t$ip_eff\n" >> peak_cmp_table.tsv
done

cat peak_cmp_table.tsv
