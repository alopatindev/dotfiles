#!/bin/bash

SENSORS_OUT=$(sensors)

for i in $(echo "${SENSORS_OUT}" | grep -v ^T | grep : | egrep -o '(.*?): *(\+[0-9.-]*)°C '); do
    echo -n "$i "
done | sed 's/°C / °C   /g'

echo
echo "${SENSORS_OUT}" | grep RPM
