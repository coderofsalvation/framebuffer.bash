# renders simple 3-state ascii barcharts using framebuffer.bash
# usage:
#   source framebuffer.bash
#   export WIDTH=22
#   barchart 20 2 20 "0,1,2,2,1,2,1,0,1,2,0"
#   barchart 20 4 20 "0,1,2,1,0,1,2,0"

barchart(){
  x="$1"; y="$2"; h=3; IFS=',' read -a CHARS <<< "$4"; [[ -n $WIDTH ]] && w=$WIDTH || w=15;
  put $x $y ${BOX[0]}; put $((w+1+x)) $y ${BOX[2]}; 
  for((i=x+1;i<w+x+1;i++)); do put $i $y ${BOX[1]}; done # horiz.line
  for((i=x+1;i<w+x+1;i++)); do put $i $((y+1)) "_"; done # horiz.line
  ((y+=1)); 
  put $x $y ${BOX[5]}; put $((w+1+x)) $y ${BOX[5]}; ((x+=1)); 
  for i in ${CHARS[@]}; do 
    put $x $y ${BAR[i]}
    ((x+=1)); (( x > w )) 
  done
  echo; echo
}
