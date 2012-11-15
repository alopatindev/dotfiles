function sound_widget()
    local text = ""
    p = io.popen("amixer sget Master")

    for i in p:lines() do
        if string.find(i, "off") ~= nil then
            text = "<b>[ NO sound ]</b>"
        end
    end
    p:close()

    return text
end
