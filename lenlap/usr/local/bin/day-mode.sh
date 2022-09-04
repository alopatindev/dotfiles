#!/bin/sh

export XAUTHORITY=.Xauthority
export DISPLAY=:0

feh -q --no-fehbg --bg-fill ~al/pictures/wallpapers/space/milky-way-3840x2160-stars-4k-18250.jpg

redshift -x
sudo /usr/local/sbin/bl-brightness.sh max
