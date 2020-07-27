source ~/.bash_env

#xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto

xrdb -merge ~/.Xdefaults

xgamma -gamma 0.9

#xrandr --dpi 160

~/scripts/set_touchpad.sh &
~/scripts/restart-co2mond.sh

#rm -f ~/progs/scalafmt-server-*/RUNNING_PID ; ~/progs/scalafmt-server-1.0-SNAPSHOT/scalafmt-server.sh 8899 &

chromium &
#pidgin &
#qtox &
xterm -T 'terms' -e 'tmux attach || tmux' &
stardict &
#qdevicemonitor &
xbindkeys
conky -d

eval $(luarocks path --bin)

#setxkbmap -layout us,ru -option grp:caps_toggle,lv3:rwin_switch,compose:ralt,grp_led:caps,compose:rwin
#skb | while read x ; do echo "myskb.text = '<b>[ $x ]</b>'" | awesome-client ; done &
#while true ; do echo "exrate.text = '<b>[ $(~/scripts/exchange-rates.sh) ]</b>'" | awesome-client ; sleep 1m ; done &

#~/.config/awesome/lib/second_panel.sh &

#night-mode.sh
feh -q --bg-scale ~/pictures/wallpapers/wallhaven-551538.png &

~/scripts/assign_tags_to_apps.rb > /tmp/.apps_to_tags
exec awesome

# vim: textwidth=0:ft=sh
