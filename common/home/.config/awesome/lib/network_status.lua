local PPP_IFACE="ppp0"
local WLAN_IFACE="wlp7s0"

function network_status()
    local text = ''
    p = io.popen('ip route')

    local lines = {}
    local k = 1
    for i in p:lines() do
        lines[k] = i
        k = k + 1
    end

    --TODO: check /var/run/shuttle.pid exists and if the process exists

    for i = 1, table.getn(lines) do
        if string.match(lines[i], "default via.* dev " .. WLAN_IFACE) ~= nil then
            text = '<b>[ connected ]</b>'
            break
        end
    end
--    if text == '' then
--        for i = 1, table.getn(lines) do
--            if string.match(lines[i], "default via.* dev " .. PPP_IFACE) ~= nil then
--                text = '[ secured connection ]'
--                break
--            end
--        end
--    end

    if text == '' then
        text = '<b>[ WRONG connection? ]</b>'
    end

    p:close()

    return text
end
