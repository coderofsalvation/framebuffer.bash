source framebuffer.bash
source plugins/box.bash
clear; init_screen; 
box 1 1 $(tput cols) 10; put 2 2 "date: $(date) ${BLOCK[0]}"
for((i=0;i<10;i++)); do echo; done
