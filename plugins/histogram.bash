# renders simple 3-state ascii barcharts using framebuffer.bash
# usage :
#   source framebuffer.bash
#   source plugins/histogram.bash
#   dmesg | histogram 2 25 25
#

# usage: echo "foo bar flop" | fb histogram <fieldnumber> [width] [padding]
histogram(){
  [[ -n $1 ]] && field="$1" || field=1; 
  [[ -n $2 ]] && WIDTH=$2   || WIDTH=20; 
  [[ -n $3 ]] && PADDING=$3
  if [[ -n $PADDING ]]; then 
    cat - | awk '{h[$'"$field"']++}END{for(i in h){print h[i],i|"sort -rn|head -20"}}' |awk '!max{max=$1;}{r="";i=s='$WIDTH'*$1/max;while(i-->0)r=r"'"${BAR[5]}"'";printf "%'$PADDING's %5d %s %s",$2,$1,r,"\n";}'
  else
    cat - | awk '{h[$'"$field"']++}END{for(i in h){print h[i],i|"sort -rn|head -20"}}' |awk '!max{max=$1;}{r="";i=s='$WIDTH'*$1/max;while(i-->0)r=r"'"${BAR[5]}"'";printf "%s %s: %5d\n",r,$2,$1;}' | tr -s " " 
  fi 
  echo; echo
}
