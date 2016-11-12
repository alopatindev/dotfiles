require("lib/mpd")

function mpd_widget()
    local function escape(x)
        return awful.util.escape(x or "")
        -- return x or ""
    end

    local status = mpc:send("status")

    if status.errormsg then
        return "[ " .. escape(status.errormsg) .. " ]"
    end

    local state = ""
    if status.state == "stop" then
        return "[ stopped ]"
    end
    if status.state == "play" then
        state = "<b>playing </b>"
    else
        if status.state == "pause" then
            state = "<b>paused </b>"
        end
    end

    local stats = mpc:send("playlistid " .. status.songid)
    local playing = ""

    if stats.artist then
        playing = playing .. stats.artist
    end

    if stats.title then
        if stats.artist then playing = playing .. " — " end
        playing = playing .. stats.title
    end

    if stats.album then
        playing = playing .. " (" .. stats.album .. ") "
    end

    if stats.name then  -- it's a radio
        playing = playing .. " {" .. stats.name .. "}"
    end

    if #playing == 0 then
        playing = stats.file
    end

    return "[ " .. state .. escape(playing) .. " ]"
end

mpc = mpd.new()
