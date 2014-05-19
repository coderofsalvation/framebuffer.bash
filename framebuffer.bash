# framebuffer in bash to draw ascii pixels, borders, animate e.g. (bash ui bootstrap)
#
# for plugins and more info see https://github.com/coderofsalvation/framebuffer.bash
#
# run ./build to bake all plugins into one script

# our drawing tools :)
FRAME=0
SYMBOLS=(« » Ø O)
BLOCK=(░ ▒ ▓ █ ▄ ▀)
BAR=(— ▄ ▀ _ ▄ █ _ — ¯)
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
