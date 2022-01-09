#!/bin/sh

REMOTE_HOST="mind"
DATA_DIR="/tmp/co2mond"
CO2_PATH="${DATA_DIR}/CntR"
TEMP_PATH="${DATA_DIR}/Tamb"
LAST_NOTIFICATION_TIME_PATH="${DATA_DIR}/notification_time"
PAUSE_BETWEEN_NOTIFICATIONS_IN_MINS=15

YELLOW_ZONE=800
RED_ZONE=1200

maybe_notify () {
    current_timestamp=$(date +%s)
    priority="$1"
    text="$2"
    mins_since_last_notification=$((( (${current_timestamp} - $(cat ${LAST_NOTIFICATION_TIME_PATH})) / 60 )))
    if [ "${mins_since_last_notification}" -gt "${PAUSE_BETWEEN_NOTIFICATIONS_IN_MINS}" ]; then
        notify-send -t 0 -u "${priority}" "${text}"
        echo "${current_timestamp}" > "${LAST_NOTIFICATION_TIME_PATH}"
    fi
}

DISPLAY= rsync -r "${REMOTE_HOST}:${DATA_DIR}" /tmp

if [ ! -f "${LAST_NOTIFICATION_TIME_PATH}" ]; then
    echo 0 > "${LAST_NOTIFICATION_TIME_PATH}"
fi

if [ -f "${TEMP_PATH}" ]; then
    TEMP=$(cat "${TEMP_PATH}")
    printf 'Room %.1f °C\n' ${TEMP}
fi

if [ -f "${CO2_PATH}" ]; then
    CO2=$(cat "${CO2_PATH}")
    echo -n "CO2 ${CO2} PPM"

    if [ "${CO2}" -lt "${YELLOW_ZONE}" ]; then
        echo ' (normal)'
    elif [ "${CO2}" -lt "${RED_ZONE}" ]; then
        echo ' (WARNING)'
        maybe_notify normal ' o_o time to open the window!'
    else
        echo ' (CRITICAL)'
        maybe_notify critical ' O_O TIME TO OPEN THE WINDOW!'
    fi
    echo "Last update $(date +%H:%M)"
fi
