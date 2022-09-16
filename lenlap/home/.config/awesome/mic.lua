local setmetatable = setmetatable
local textbox = require("wibox.widget.textbox")
local timer = require("gears.timer")

local spinner_states = "|/-\\"

local compiler_processes_widget = { mt = {} }

local function compiler_processes_text()
    local f = io.open("/tmp/.mic")
    local text = f:read()
    f:close()

    local result = ''
    if text ~= nil then
        result = '[ ' .. '<b>' .. text .. '</b> ]'
    end
    return result
end

local function calc_timeout(real_timeout)
    return real_timeout - os.time() % real_timeout
end

function compiler_processes_widget.new(format, timeout, timezone)
    timeout = 0.5

    local w = textbox()
    -- w:set_font("Iosevka Term SS08")

    local t
    function w._private.compiler_processes_widget_update_cb()
        w:set_markup(compiler_processes_text())
        t.timeout = calc_timeout(timeout)
        t:again()
        return true -- Continue the timer
    end
    t = timer.weak_start_new(timeout, w._private.compiler_processes_widget_update_cb)
    t:emit_signal("timeout")
    return w
end

function compiler_processes_widget.mt:__call(...)
    return compiler_processes_widget.new(...)
end

return setmetatable(compiler_processes_widget, compiler_processes_widget.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
