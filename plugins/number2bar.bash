# converts numbers into bars, easy render ascii barcharts 
# usage :
#   source framebuffer.bash
#   source plugins/histogram.bash
#   echo -e "milk 5\ncheese 2" | number2bar 2
#

# usage: echo "milk 5" | fb number2bar <fieldnumber> [padding] [char]
number2bar(){
  [[ -n $1 ]] && field="$1"   || field=1; 
  [[ -n $2 ]] && padding=$2   || padding=20
  [[ -n $3 ]] && char=$3      || char=${BAR[5]}
  cat - | awk '{ 
    for(i = 1; i <= NF; i++) { 
      if( $i != $'"$field"' ){
         printf "%-'"$padding"'s ",$i
      }else{
         printf "%-'"$padding"'s ",$i
         for(j=0;j<$i;j++){ printf "%s","'"$char"'" }
      }
    }
    printf "\n"
  }'
}

