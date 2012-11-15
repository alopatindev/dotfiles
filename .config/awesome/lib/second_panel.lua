require("lib/skb")
require("lib/storage")
require("lib/sound")
require("lib/mpd_widget")
require("lib/battery")

function battery_widget()
    return "[ " .. battery.batclosure("BAT0")() .. "]"
end

local t = 5
local nonoften_widgets = ''

function second_panel()
    if t >= 5 then
        nonoften_widgets = battery_widget() .. sound_widget()
        t = 0
    else
        t = t + 1
    end
    return skb_widget() .. storage_widget() .. nonoften_widgets .. mpd_widget()
end
