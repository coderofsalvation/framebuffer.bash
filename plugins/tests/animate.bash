source framebuffer.bash
source plugins/animate.bash
clear; init_screen; 
animate 2 4 0.1 ". o O o" &
pid=$!; sleep 2s; kill -9 $pid &>/dev/null
