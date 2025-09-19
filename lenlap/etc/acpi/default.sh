#!/bin/sh
# /etc/acpi/default.sh
# Default acpi script that takes an entry for all actions

set $*

group=${1%%/*}
action=${1#*/}
device=$2
id=$3
value=$4

log_unhandled() {
    logger "ACPI event unhandled: $*"
}

case "$group" in
#    '9DBB5994-A997-')
#        logger "probably unhealthy temperature: $*"
#        #touch /tmp/.thermal_alert && sleep 20 && rm /tmp/.thermal_alert
#        ;;

    button)
        case "$action" in
            power)
                logger 'power event' $*
                if [[ $2 -eq PBTN ]] ; then
                    logger 'power button'
                    #/usr/local/sbin/hibernate
                    #/etc/acpi/actions/powerbtn.sh
                fi
                ;;

            # if your laptop doesnt turn on/off the display via hardware
            # switch and instead just generates an acpi event, you can force
            # X to turn off the display via dpms.  note you will have to run
            # 'xhost +local:0' so root can access the X DISPLAY.
            lid)
                logger 'lid event' $*
                if [[ $3 -eq close ]] ; then
                    /usr/local/sbin/lock_screen.sh
                #    /usr/local/sbin/standby
                #    #xset dpms force off
                fi
                ;;

            volumeup)
                /usr/local/sbin/change_volume.sh +
                ;;

            volumedown)
                /usr/local/sbin/change_volume.sh -
                ;;

            left | right | up | down)
                ;;

            *)    log_unhandled $* ;;
        esac
        ;;

    ac_adapter)
        case "$value" in
            # Add code here to handle when the system is unplugged
            # (maybe change cpu scaling to powersave mode).  For
            # multicore systems, make sure you set powersave mode
            # for each core!
            *0)
                /usr/local/sbin/switch-governor.sh powersave
                #cpufreq-set -g powersave
                ;;

            # Add code here to handle when the system is plugged in
            # (maybe change cpu scaling to performance mode).  For
            # multicore systems, make sure you set performance mode
            # for each core!
            *1)
                /usr/local/sbin/switch-governor.sh performance
                #cpufreq-set -g performance
                ;;

            *)    log_unhandled $* ;;
        esac
        ;;

    *)    log_unhandled $* ;;
esac
