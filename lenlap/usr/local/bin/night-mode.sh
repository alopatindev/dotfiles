#!/bin/sh

export XAUTHORITY=.Xauthority
export DISPLAY=:0

feh -q --no-fehbg --bg-fill ~al/pictures/wallpapers/orange-nature-dark.png

redshift -x
redshift -O 3500K

sudo /usr/local/sbin/bl-brightness.sh down 1.3
