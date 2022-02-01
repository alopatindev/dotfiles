source ~/.bash_env

#xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto

xrdb -merge ~/.Xdefaults

xgamma -gamma 0.9

#xrandr --dpi 160

#set_touchpad.sh &
#~/scripts/restart-co2mond.sh

#rm -f ~/progs/scalafmt-server-*/RUNNING_PID ; ~/progs/scalafmt-server-1.0-SNAPSHOT/scalafmt-server.sh 8899 &

#parcellite -n 2>>/dev/null &

#sudo /usr/local/sbin/hdmi_hotplug.sh 0 &

chromium &
#pidgin &
#qtox &
xterm -T 'terms' -e 'tmux attach || tmux' &
stardict &
#qdevicemonitor &
xbindkeys
conky -d

# keep clipboard in sync with primary buffer
autocutsel -selection CLIPBOARD -fork
# keep primary buffer in sync with clipboard
#autocutsel -selection PRIMARY -fork

#autocutsel -selection SECONDARY -fork

eval $(luarocks path --bin)

#setxkbmap -layout us,ru -option grp:caps_toggle,lv3:rwin_switch,compose:ralt,grp_led:caps,compose:rwin,shift:breaks_caps
#skb | while read x ; do echo "myskb.text = '<b>[ $x ]</b>'" | awesome-client ; done &
#while true ; do echo "exrate.text = '<b>[ $(~/scripts/exchange-rates.sh) ]</b>'" | awesome-client ; sleep 1m ; done &

#~/.config/awesome/lib/second_panel.sh &

#night-mode.sh
#feh -q --no-fehbg --bg-scale ~/pictures/wallpapers/pine_trees_forest-wallpaper-2560x1440_1.png &
feh -q --no-fehbg --bg-fill ~/pictures/wallpapers/space/cosmos-1853491.jpg &
#feh -q --no-fehbg --bg-scale ~/pictures/wallpapers/wallhaven-551538.png &
#feh -q --no-fehbg --bg-center ~/pictures/wallpapers/nature/leaves.jpg &

~/scripts/assign_tags_to_apps.rb > /tmp/.apps_to_tags
exec awesome

# vim: textwidth=0:ft=sh
