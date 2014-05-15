# framebuffer in bash to draw ascii pixels, borders, animate e.g. (bash ui bootstrap)
#
# for plugins and more info see https://github.com/coderofsalvation/framebuffer.bash
#
# usage: init_screen; box 1 1 $(tput cols) 10; put 2 2 "date: $(date) ${BLOCK[0]}"
#           or
#        init_screen; animate 2 4 0.1 ". o O o"


# our drawing tools :)
FRAME=0
SYMBOLS=(« » Ø O)
BLOCK=(░ ▒ ▓ █ ▄ ▀)
BAR=(_ ▄ █)
BOX=(┌ ─ ┐ └ ┘ │ ┤ ┴ ┬ ├ ┼)
CHARS=()

init_screen(){
  trap "tput cnorm -- normal" 0 1 5
  tput civis -- invisible # hide cursor
}

# usage: put <x> <y> <string>
put() { printf "\x1B["$2";"$1"f$3" "$4"; }

# usage: resetlines <y> [amount=1]
resetlines(){
  startline="$1"; [[ -n "$2" ]] && amount="$2" || amount=1
  put 0 $startline
  for yy in $( seq 1 $amount ); do tput el; printf "\r"; done
}

# usage: animate <x> <y> <sleepframe> <characterarray> 
animate(){ while animate_chars "$1" "$2" "$3" "$4" $FRAME; do :; done }
animate_chars(){
  x=$1; y=$2; sleep=$3; FRAMES="$4"; [[ -n "$5" ]] && FRAME=$5 || FRAME=0
  read -a CHARS <<< "$FRAMES"
  put $x $y ${CHARS[ $(( FRAME % ${#CHARS[@]} ))  ]}
  ((FRAME+=1)); sleep "$sleep"s; return 0;
}

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
