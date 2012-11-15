#!/usr/bin/lua

require ('battery')

b = battery.batclosure ('BAT0')()
print(b)
