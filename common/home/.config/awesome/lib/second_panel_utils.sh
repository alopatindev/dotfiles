#!/bin/sh

string_to_htmlentities () {
    str=$1
    for (( i=0; i<${#str}; i++ )); do
      c=${str:$i:1}
      printf "&#%d;" "'$c"
    done
    echo ""
}

storage_widget () {
    devices=$(egrep '/media/' /proc/mounts | sed 's!.*/media/!!;s! .*!!' | paste -sd ',' -)
    if [[ $devices == '' ]]; then
        echo ''
    else
        echo "<b>[ removable: $(string_to_htmlentities ${devices}) ]</b>"
    fi
}

sound_widget () {
    amixer sget Headphone | grep off >> /dev/null && echo '<b>[ NO sound ]</b>' || echo ''
}

network_widget () {
    ip route | egrep "default via.* dev " >> /dev/null && echo '<b>[ connected ]</b>' || echo '<b>[ WRONG connection? ]</b>'
}

mpc_widget () {
    output="$(/usr/bin/mpc -h /var/lib/mpd/socket)"
    artist_title=
    status=$(echo "${output}" | egrep -o '\[.*\]' | tail -n1)
    if [[ $status == '' ]]; then
        status='[stopped]'
    else
        artist_title=$(echo "${output}" | head -n1)
        artist_title=" ${artist_title}"
        artist_title=$(string_to_htmlentities "${artist_title}")
    fi
    status="<b>$(string_to_htmlentities ${status})</b>"
    echo "[ ${status}${artist_title} ]"
}

battery_widget () {
    echo "[ $(./show_bat.lua) ]"
}
