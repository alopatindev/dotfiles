function network_status()
    local text = ''
    p = io.popen('ip route')

    for i in p:lines() do
        if string.match(i, "default via.* dev wlan0") ~= nil then
            text = '<b>[ NOT SECURED CONNECTION! ]</b>'
        elseif string.match(i, "default via.* dev ppp0") ~= nil then
            text = '[ secured connection ]'
        end
    end

    if text == '' then
        text = '<b>[ WRONG connection? ]</b>'
    end

    p:close()

    return text
end

print(network_status())
