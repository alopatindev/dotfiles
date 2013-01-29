#!/bin/bash

for i in $(sensors | grep : | egrep -o '(.*?): *(\+[0-9.-]*)°C '); do
    echo -n "$i "
done | sed 's/°C / °C   /g'
