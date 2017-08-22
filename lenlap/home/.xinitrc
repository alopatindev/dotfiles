source ~/.bashrc

xgamma -gamma 0.9

#xrandr --dpi 160

#setxkbmap -layout us,ru -option grp:caps_toggle,lv3:rwin_switch,compose:ralt,grp_led:caps,compose:ralt &
setxkbmap -layout us,ru -option grp:caps_toggle,lv3:rwin_switch,compose:ralt,grp_led:caps,compose:rwin &

~/scripts/set_touchpad.sh &

rm -f ~/progs/scalafmt-server-*/RUNNING_PID
~/progs/scalafmt-server-*/scalafmt-server.sh 8899 &

chromium &
#pidgin &
xterm -T 'terms' -e 'tmux attach || tmux' &
stardict &
qdevicemonitor &
xbindkeys
conky -d

skb | while read x ; do echo "myskb.text = '<b>[ $x ]</b>'" | awesome-client ; done &
while true ; do echo "exrate.text = '<b>[ $(~/scripts/exchange-rates.sh) ]</b>'" | awesome-client ; sleep 1m ; done &

~/.config/awesome/lib/second_panel.sh &

exec awesome

# vim: textwidth=0:ft=sh
