local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local timer = require("gears.timer")

require ('battery')

local battery_widget = { mt = {} }

local function calc_timeout(real_timeout)
    return real_timeout - os.time() % real_timeout
end

function battery_widget.new(format, timeout, timezone)
    timeout = timeout or 3

    local w = textbox()
    local t
    function w._private.battery_widget_update_cb()
        b = battery.batclosure ('BAT0')()
        w:set_markup('[' .. b .. ' ]')
        t.timeout = calc_timeout(timeout)
        t:again()
        return true -- Continue the timer
    end
    t = timer.weak_start_new(timeout, w._private.battery_widget_update_cb)
    t:emit_signal("timeout")
    return w
end

function battery_widget.mt:__call(...)
    return battery_widget.new(...)
end

--

--

return setmetatable(battery_widget, battery_widget.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
