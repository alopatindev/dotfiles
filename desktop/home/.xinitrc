source ~/.bashrc

#xrandr --dpi 160

# xmodmap -e "pointer = 1 3 2"
(setxkbmap -layout us,ru -option grp:caps_toggle,lv3:rwin_switch,compose:ralt,grp_led:scroll,compose:rwin && xmodmap .Xmodmap) &

(synclient HorizTwoFingerScroll=1 \
          PalmDetect=1 PalmMinWidth=40 \
          FingerLow=8 FingerHigh=8 \
          TapButton1=0 TapButton2=0 TapButton3=0 \
          RBCornerButton=3 RTCornerButton=2 \
          VertScrollDelta=115 HorizScrollDelta=115 \
          MinSpeed=1.8 MaxSpeed=2 && \
syndaemon -t -k -i 1 -d ) &
#PalmMinWidth=100

#xsetroot -solid '#464646' &
#feh -q --bg-scale /home/sbar/pictures/wallpapers/cold_laptop.png &
#~/.bin/dmenu_path > /tmp/.dmenu &
xbindkeys
#xterm -T 'terms' -e 'screen -DRm' &
xterm -T 'terms' -e 'tmux attach || tmux' &
#xterm -geometry 141x59+0+0 -fg white -bg black -sb -T '/var/log/messages' -e 'tail -F -n 1000 /var/log/messages' &
~/git/qdevicemonitor/qdevicemonitor/qdevicemonitor &
~/.bin/psi &
#qtox &
chromium &
conky -d
#~/.bin/sskype &
stardict -h &
#~/.progs/gmailcheck.sh &
~/scripts/edit-server &
~/.config/awesome/lib/second_panel.sh &

#xscreensaver -no-splash &
#~/coding/lightsOn/lightsOn.sh &

skb | while read x ; do echo "myskb.text = '<b>[ $x ]</b>'" | awesome-client ; done &
exec awesome
#exec dwm
#exec i3

#killall gmailcheck.sh
killall lightsOn.sh
killall edit-server

# vim: textwidth=0:ft=sh
