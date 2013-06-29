function storage_widget()
    f = io.open("/proc/mounts")

    devices = ""
    for i in f:lines() do
        local device = string.match(i, "/media/([%w_]+)")
        if device then
            if #devices == 0 then
                devices = device
            else
                devices = devices .. ", " .. device
            end
        end
    end

    f:close()

    if #devices ~= 0 then
        return "<b>[ removable: " .. awful.util.escape(devices) .. " ]</b>"
    else
        return ""
    end
end
