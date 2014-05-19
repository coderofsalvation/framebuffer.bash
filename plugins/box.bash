# usage: init_screen; box 1 1 $(tput cols) 10; put 2 2 "date: $(date) ${BLOCK[0]}"

# usage: box <x> <y> <width> <height>
box(){
  x="$1"; y="$2"; w="$3"; h="$4"
  put $x $y ${BOX[0]} ; put $w $y ${BOX[2]}          # top corners
  for((i=x+1;i<w;i++)); do put $i $y ${BOX[1]}; done # horiz.line
  for((i=y+1;i<h;i++)); do put $x $i ${BOX[5]}; done # left vertline
  for((i=y+1;i<h;i++)); do put $w $i ${BOX[5]}; done # left vertline
  for((i=x+1;i<w;i++)); do put $i $h ${BOX[1]}; done # horiz.line
  put $x $h ${BOX[3]} ; put $w $h ${BOX[4]}          # bottom corners
}
