source framebuffer.bash
source plugins/histogram.bash
dmesg | PADDING=25 histogram 2
cat /var/log/auth.log | sed 's/://g' | WIDTH=10 histogram 5 

