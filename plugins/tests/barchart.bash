source framebuffer.bash
source plugins/barchart.bash
export WIDTH=22
export X=12
clear
put 2 3  "apple   :"; echo "0,1,2,0,2,1,0,1,2,1" | vbarchart $X 2 20 
put 2 5  "pear    :"; echo "0,1,2,0,2,1,0,1,2,1" | OFFSET=3 vbarchart $X 4 20 
put 2 7  "banana  :"; redis-cli --csv LRANGE foo 0 -1 | sed 's/[^0-9,\\-]*//g' | vbarchart $X 6 20
put 2 9  "plum    :"; echo 10 | OFFSET=5 DIVIDE=5 hbarchart $X 9 20 
put 2 10 "cheese  :"; echo 90 | OFFSET=5 DIVIDE=5 hbarchart $X 10 20 
put 2 11 "orange  :"; echo 50 | OFFSET=5 DIVIDE=5 hbarchart $X 11 20 
