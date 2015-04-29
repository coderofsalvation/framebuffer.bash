# renders simple 3-state ascii barcharts using framebuffer.bash
# usage :
#   source framebuffer.bash
#   source plugins/barchart.bash
#   export WIDTH=22
#   put 2 3 "stock:"; echo "0,1,2,0,2,1,0,1,2,1" | vbarchart 10 2 20 
#   put 2 5 "rates:"; echo "0,10,2,0,7,1,0,4,10" | MAX=10 vb:rchart 10 4 20 
#   put 2 7 "redis:"; redis-cli --csv LRANGE foo 0 -1 | sed 's/[^0-9,\\-]*//g' | vbarchart 10 6 20
#

# usage: fb put 2 3 "stock:"; echo "0,1,2,0,2,1,0,1,2,1" | fb vbarchart 10 2 20 
vzbarchart(){
  x="$1"; y="$2"; h=3; IFS=',' read -a CHARS <<< "$(cat -)"
  [[ -n $WIDTH ]] && w=$WIDTH || w=15;
  [[ -n OFFSET ]] && offset=$OFFSET || offset=0
  for((i=x+2;i<w+x+1;i++)); do put $i $((y+1)) ${ZBAR[offset]}; done # horiz.line
  ((y+=1)); 
  for i in ${CHARS[@]}; do 
    (( i > 2 )) && i=2; (( i < 0 )) && i=0; z=$((i+offset)); 
    put $x $y ${ZBAR[z]}; put $((x+1)) $y ${ZBAR[z]} 
    ((x+=2)); 
  done
  echo; echo
}

vbarchart(){
  x="$1"; y="$2"; h=3; 
  [[ -n $WIDTH ]] && w=$WIDTH || w=15;
  [[ -n $DIVIDE ]] && d=$DIVIDE || d=1;
  IFS=' ' read -a CHARS <<< "$( _dividenumbers $d "$(cat -)" )"; 
  for((i=x+2;i<w+x+1;i++)); do put $i $((y+1)) ${BAR[offset]}; done # horiz.line
  ((y+=1)); 
  for i in ${CHARS[@]}; do 
    put $x $y ${BAR[i]}; put $((x+1)) $y ${BAR[i]} 
    ((x+=2)); 
  done
  echo; echo
}

hbarchart(){
  x="$1"; y="$2"; h=3; IFS=',' read -a CHARS <<< "$(cat -)"; 
  [[ -n $DIVIDE ]] && d=$DIVIDE || d=1;
  [[ -n OFFSET ]] && offset=$OFFSET || offset=0
  for i in ${CHARS[@]}; do 
    z=$((i/d)); for((t=0;t<z;t++)); do put $((x+t)) $y ${BAR[offset]}; done
    ((y+=1)); 
  done
  echo; echo
}

_dividenumbers(){
  divide="$1"; values="${2//,/ }"; result=()
  for i in $values; do result="$result $((i/divide))"; done
  echo "$result"
}
