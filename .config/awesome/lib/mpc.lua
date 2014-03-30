function mpc_widget()
    p = io.popen("/usr/bin/mpc")
    artist_title = p:read()
    status = p:read()
    p:close()
    text = ''
    if status ~= nil then
        status = status:match('.*\]')
        if status ~= nil then
            text = text .. '<b>' .. status .. '</b> '
        end
    end
    if artist_title ~= nil then
        text = text .. artist_title
    end
    return "[ " .. text .. " ]"
end
