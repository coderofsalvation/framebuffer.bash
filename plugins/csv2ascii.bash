# converts numbers into bars, easy render ascii barcharts 
# usage :
#   source framebuffer.bash
#   source plugins/histogram.bash
#   echo -e "milk 5\ncheese 2" | number2bar 2
#

# usage: cat foo.csv | [SEP=';'] fb csv2ascii [maxcolumn]  (default seperator is ,)
csv2ascii(){
  [[ -t 0 ]] && { echo "Usage: cat foo.csv | [SEP=';'] csv2ascii [maxcolumn] # default seperator is comma"; exit 0; }
  [[ ! -n $SEP ]] && SEP=','
  # maximum field to display 
  max=9999; [[ -n $1 ]] && max=$1                                           
  # split on multiple seperators (gawk only) + loop over field + output table 
  cat - | sed 's/,"",/," ",/g' | gawk -vFS='^"|"'$SEP'"|"$|"'$SEP'|'$SEP'"|'$SEP    \
          '{out=""; for(i=1;i<NF+1&&i<max;i++) out=out"\t"$i; print out }'      \
          max=$max | sed 's/""/"/g' | column -t -s $'\t' 
}
