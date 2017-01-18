for filename in *.txt
do
  echo $filename
  gawk -i inplace 'NR == 40{gsub(/(\(|\)| )/,"_"); gsub(/#/, "")} {print}' $filename
done
