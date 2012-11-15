function skb_widget()
    p = io.popen("/usr/bin/skb -1")
    text = p:read()
    p:close()
    return "[ <b>" .. text .. "</b> ]"
end
