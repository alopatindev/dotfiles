#!/bin/sh

DATA_DIR="/tmp/co2mond"
CO2_PATH="${DATA_DIR}/CntR"
TEMP_PATH="${DATA_DIR}/Tamb"

if [ -f "${TEMP_PATH}" ]; then
    TEMP=$(cat "${TEMP_PATH}")
    printf 'Room %.1f °C\n' ${TEMP}
fi

if [ -f "${CO2_PATH}" ]; then
    CO2=$(cat "${CO2_PATH}")
    echo -n "CO2 ${CO2} PPM"

    if [ ${CO2} -lt 700 ]; then
        echo ' (normal)'
    elif [ ${CO2} -lt 1200 ]; then
        echo ' o_o time to open the window!'
    else
        echo ' O_O OMG! open the window, now!!!'
    fi
fi
