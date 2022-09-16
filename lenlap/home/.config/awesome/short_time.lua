local setmetatable = setmetatable
local textbox = require("wibox.widget.textbox")
local timer = require("gears.timer")

local short_time_widget = { mt = {} }

local function short_time_text()
    local f = io.open("/tmp/.short_time")
    local text = f:read()
    f:close()

    local result = ''
    if text ~= nil and text ~= "0" then
        result = ' ' .. '<b>' .. text .. '</b> ]'
    end
    return result
end

local function calc_timeout(real_timeout)
    return real_timeout - os.time() % real_timeout
end

function short_time_widget.new(format, timeout, timezone)
    timeout = 0.5

    local w = textbox()
    --w:set_font("Iosevka Term SS08")

    local t
    function w._private.short_time_widget_update_cb()
        w:set_markup(short_time_text())
        t.timeout = calc_timeout(timeout)
        t:again()
        return true -- Continue the timer
    end
    t = timer.weak_start_new(timeout, w._private.short_time_widget_update_cb)
    t:emit_signal("timeout")
    return w
end

function short_time_widget.mt:__call(...)
    return short_time_widget.new(...)
end

return setmetatable(short_time_widget, short_time_widget.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
