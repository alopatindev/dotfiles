source ~/.bashrc

#xrandr --dpi 160

# xmodmap -e "pointer = 1 3 2"
#setxkbmap -layout us,ru -option grp:caps_toggle,lv3:rwin_switch,compose:ralt,grp_led:scroll,compose:ralt &
setxkbmap -layout us,ru -option grp:caps_toggle,lv3:rwin_switch,compose:ralt,grp_led:scroll,compose:rwin &

(synclient HorizTwoFingerScroll=1 \
          PalmDetect=1 PalmMinWidth=40 \
          FingerLow=8 FingerHigh=8 \
          TapButton1=0 TapButton2=0 TapButton3=0 \
          RBCornerButton=3 RTCornerButton=2 \
          VertScrollDelta=115 HorizScrollDelta=115 \
          MinSpeed=1.8 MaxSpeed=2 && \
syndaemon -t -k -i 1 -d ) &

xbindkeys
xterm -T 'terms' -e 'tmux attach || tmux' &
#~/git/qdevicemonitor/qdevicemonitor/qdevicemonitor &
#chromium &
#conky -d

#skb | while read x ; do echo "myskb.text = '<b>[ $x ]</b>'" | awesome-client ; done &
#~/.config/awesome/lib/second_panel.sh &
exec awesome

# vim: textwidth=0:ft=sh
