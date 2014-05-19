# usage: animate <x> <y> <sleepframe> <characterarray> 
animate(){ while animate_chars "$1" "$2" "$3" "$4" $FRAME; do :; done }
animate_chars(){
  x=$1; y=$2; sleep=$3; FRAMES="$4"; [[ -n "$5" ]] && FRAME=$5 || FRAME=0
  read -a CHARS <<< "$FRAMES"
  put $x $y ${CHARS[ $(( FRAME % ${#CHARS[@]} ))  ]}
  ((FRAME+=1)); sleep "$sleep"s; return 0;
}
