#!/bin/bash
# shows temperature in Velikij Novgorod town

TEMP=$(wget -qO - --timeout=5 http://www.novgorod.ru/weather \
    | iconv -f cp1251 \
    | grep -aio 'Фактическая</td><td>.* °C</td>' \
    | sed 's/Фактическая<\/td><td>//g;s/<\/td>//g')
echo ${TEMP:0:1} | egrep -q '^[0-9]' && TEMP="+${TEMP}"
echo ${TEMP}
