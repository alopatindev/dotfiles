source ~/.bashrc

# xmodmap -e "pointer = 1 3 2"
setxkbmap -layout us,ru -option grp:caps_toggle,lv3:rwin_switch,compose:ralt,grp_led:scroll,compose:ralt &

synclient HorizTwoFingerScroll=1 TapButton3=3 FastTaps=1 &
#syndaemon -t -i 1 -d &

#xsetroot -solid '#464646' &
#feh -q --bg-scale /home/sbar/pictures/wallpapers/cold_laptop.png &
xmodmap .Xmodmap &
#~/.bin/dmenu_path > /tmp/.dmenu &
xbindkeys
#xterm -T 'terms' -e 'screen -DRm' &
xterm -T 'terms' -e 'tmux attach || tmux' &
xterm -geometry 141x59+0+0 -fg white -bg black -sb -T '/var/log/messages' -e 'tail -f -n 1000 /var/log/messages' &
~/.bin/psi &
chromium &
conky -d
#~/.bin/sskype &
stardict -h &
~/.progs/gmailcheck.sh &

xscreensaver -no-splash &
~/coding/lightsOn/lightsOn.sh &

(~/.bin/skb 'myskb.text = " [ \%s ]"' | awesome-client) &
exec awesome
#exec dwm
#exec i3

killall gmailcheck.sh
killall lightsOn.sh

# vim: textwidth=0:ft=sh
