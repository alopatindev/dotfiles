source ~/.bashrc

xrdb -merge ~/.Xdefaults

xgamma -gamma 0.9

#xrandr --dpi 160

~/scripts/set_touchpad.sh &

rm -f ~/progs/scalafmt-server-*/RUNNING_PID
~/progs/scalafmt-server-1.0-SNAPSHOT/scalafmt-server.sh 8899 &

chromium &
#pidgin &
qtox &
xterm -T 'terms' -e 'tmux attach || tmux' &
stardict &
qdevicemonitor &
xbindkeys
conky -d

eval $(luarocks path --bin)

setxkbmap -layout us,ru -option grp:caps_toggle,lv3:rwin_switch,compose:ralt,grp_led:caps,compose:rwin

night-mode.sh

~/scripts/assign_tags_to_apps.rb > /tmp/.apps_to_tags
exec awesome

# vim: textwidth=0:ft=sh
