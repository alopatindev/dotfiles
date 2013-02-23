-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("lib/second_panel")

beautiful.init("/home/sbar/.config/awesome/theme.lua")

-- safeCoords = {x = 1024, y = 598}
safeCoords = {x = 1366, y = 768}
mouse.coords(safeCoords)

terminal = "xterm"
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "1 im", "2 term", "3 web", "4 main", "5 media", "6 graphics", "7 misc", "8 misc", "9 doc", "0 logs" }, s, layouts[2])

--    -- FIXME: ugly hack, just to set the 3rd tag's layout to max
--    awful.tag.viewonly(tags[s][3])
--    awful.layout.inc(layouts, -3)

--    tag({name = "im"}).screen = s
--    tag({name = "term", layout = "max"}).screen = s
--    tag({name = "web", layout = "max"}).screen = s
--    tag({name = "media", layout = "max"}).screen = s
--    tag({name = "doc", layout = "max"}).screen = s
--    tag({name = "graphics"}).screen = s
--    tag({name = "misc0", layout = "max"}).screen = s
--    tag({name = "misc1", layout = "max"}).screen = s
--    tag({name = "download"}).screen = s
--    tag({name = "logs"}).screen = s
end

--awful.tag.setproperty(tags[s][1], "mwfact", 0.13)
-- awful.tag.incmwfact(0.15)
awful.tag.incmwfact(0.20)
tags[1][3].layout = layouts[5]

mymainmenu = awful.menu({ items = {} })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })

mytextclock = awful.widget.textclock({ align = "right" }, "[ %a %d %b, %H:%M (%p) ] ", 2)
mysystray = widget({ type = "systray" })
myskb = widget({type = "textbox", name = "myskb"})

-- Create a wibox for each screen and add it
mywibox = {}
box2 = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytasklist = {}

spanelwi = widget({type = "textbox", name = "spanelwi"})
spaneltimer = timer({timeout = 1})
spaneltimer:add_signal("timeout",
    function()
        spanelwi.text = second_panel()
    end
)
spanelwi.text = ""
spaneltimer:start()

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = "25", screen = s })
    box2[s] = awful.wibox({ position = "bottom", height = "17", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            --mylauncher,
            mypromptbox[s],
            mytaglist[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        layout = awful.widget.layout.horizontal.rightleft,
        mytextclock,
        myskb,
        s == 1 and mysystray or nil,
        mytasklist[s],
    }

    box2[s].widgets = { spanelwi }
end
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey }, "0",
                  function ()
                        t = awful.tag.selected()
                        awful.tag.setproperty(t, "mouse", mouse.coords())

                        local screen = mouse.screen
                        nt = tags[screen][10]
                        if nt then
                            awful.tag.viewonly(nt)
                            c = awful.tag.getproperty(nt, "mouse")
                            mouse.coords(c or safeCoords)
                        end
                  end),
    awful.key({ modkey }, "F12",
                  function ()
                        t = awful.tag.selected()
                        awful.tag.setproperty(t, "mouse", mouse.coords())

                        local screen = mouse.screen
                        nt = tags[screen][10]
                        if nt then
                            awful.tag.viewonly(nt)
                            c = awful.tag.getproperty(nt, "mouse")
                            mouse.coords(c or safeCoords)
                        end
                  end),


    -- move floating windows to screen edges
--    awful.key({modkey, "Shift"}, "Left", function(c)
--      if floats(c) then
--        local g = c:geometry()
--        local w = screen[c.screen].workarea
--        g.x = 0 + w.x
--        g.y = (w.height - g.height)/2 + w.y
--        c:geometry(g)
--        mouse_warp(c)
--      end
--    end),
    awful.key({"Mod4"}, "Escape",
        function()
            mouse.coords(safeCoords)
        end),

    awful.key({ modkey,           }, "Left",
        function()
            t = awful.tag.selected()
            awful.tag.setproperty(t, "mouse", mouse.coords())

            awful.tag.viewprev()

            t = awful.tag.selected()
            c = awful.tag.getproperty(t, "mouse")
            mouse.coords(c or safeCoords)
        end),
    awful.key({ modkey,           }, "Right",
        function()
            t = awful.tag.selected()
            awful.tag.setproperty(t, "mouse", mouse.coords())

            awful.tag.viewnext()

            t = awful.tag.selected()
            c = awful.tag.getproperty(t, "mouse")
            mouse.coords(c or safeCoords)
        end),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    -- awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    -- awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    -- awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    -- awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ "Mod1",           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end
    ),

    -- Standard program
    -- awful.key({ "Mod4",           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control", "Shift" }, "r", awesome.restart),
    awful.key({ modkey, "Control", "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    --awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ "Mod1",           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ "Mod1", "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end)

    -- Prompt
    -- awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end)
    --awful.key({ "Mod1", "Shift"   }, "r", function () awful.util.spawn("drun") end)

--    awful.key({ modkey }, "x",
--              function ()
--                  awful.prompt.run({ prompt = "Run Lua code: " },
--                  mypromptbox[mouse.screen].widget,
--                  awful.util.eval, nil,
--                  awful.util.getdir("cache") .. "/history_eval")
--              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift"   }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, }, "space",  awful.client.floating.toggle                     ),
    -- awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    -- awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    -- awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end)
--    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
--    awful.key({ modkey,           }, "m",
--        function (c)
--            c.maximized_horizontal = not c.maximized_horizontal
--            c.maximized_vertical   = not c.maximized_vertical
--        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
mouses = {}
--awful.tag.setproperty("mousex", 123)
--awful.tag.add("mouse", safeCoords)
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        t = awful.tag.selected()
                        awful.tag.setproperty(t, "mouse", mouse.coords())

                        local screen = mouse.screen
                        nt = tags[screen][i]
                        if nt then
                            awful.tag.viewonly(nt)
                            c = awful.tag.getproperty(nt, "mouse")
                            mouse.coords(c or safeCoords)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 2, awful.mouse.client.resize))
    --awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set chromium to always map on tags number 2 of screen 1.
    { rule = { class = "[Cc]hrome" },
       properties = { tag = tags[1][3] } },
    { rule = { class = "XTerm", name = "terms" }, properties = { tag = tags[1][2]}},
    { rule = { class = "XTerm", name = "index.wiki .*" }, properties = { tag = tags[1][2]}},


    { rule =  { class = "Qtcreator"} , properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "Gimp"} , properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "Openshot" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "Gimp", name = "Open Image"}, properties = { floating = true }},
    { rule =  { class = "fontforge" }, properties = { tag = tags[1][6], floating = true }},
    { rule =  { class = "CinePaint" }, properties = { tag = tags[1][6], floating = true }},
    { rule =  { class = "Gcalctool*"}, properties = { floating = true }},
    { rule =  { class = "Galculator", name = "galculator"}, properties = { floating = true }},
    { rule =  { class = "Zenity"}, properties = { floating = true } },
    { rule =  { class = "Xmessage"}, properties = { floating = true }},
    { rule =  { class = "Midori" }, properties = { tag = tags[1][3] }},
    { rule =  { class = "Minefield" }, properties = { tag = tags[1][3] }},
    { rule =  { class = "Crashreporter" }, properties = { tag = tags[1][3] }},
    { rule =  { class = "Arora" }, properties = { tag = tags[1][3] }},
    --{ rule =  { class = "Firefox", name = "Dialog" }, properties = { tag = tags[1][3], floating = true }},
    { rule =  { class = "Firefox" }, properties = { tag = tags[1][3], floating = false }},
    { rule =  { class = "Npviewer.bin" }, properties = { floating = true }},
    { rule =  { class = "Exe" }, properties = { floating = true }},
    { rule =  { class = "Opera" }, properties = { tag = tags[1][3], floating = false }},
    { rule =  { class = "Chrome" }, properties = { tag = tags[1][3] }},
    { rule =  { class = "Chromium" }, properties = { tag = tags[1][3] }},
    { rule =  { class = "Operapluginwrapper" }, properties = { tag = tags[1][3], floating = true }},
    { rule =  { class = "Epiphany", name = "epiphany" }, properties = { tag = tags[1][3] }},
    { rule =  { class = "Rhythmbox" }, properties = { tag = tags[1][5] }},
    { rule =  { class = "Pavucontrol" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "TuxGuitar" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Nessus" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "M[pP]layer*"}, properties = { tag = tags[1][5], floating = true }},
    { rule =  { class = "ffplay", name = "ffplay" }, properties = { tag = tags[1][5], floating = true }},
    { rule =  { class = "Gxine" }, properties = { tag = tags[1][5] }},
    { rule =  { class = "Streamtuner" }, properties = { tag = tags[1][5] }},
    { rule =  { class = "banshee*" }, properties = { tag = tags[1][5] }},
    { rule =  { class = "Flashplayer" }, properties = { tag = tags[1][5], floating = true }},
    { rule =  { class = "Ogle", name = "Ogle.*" }, properties = { tag = tags[1][5], floating = true }},
    { rule =  { class = "Pidgin" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Gajim.py"  }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Qutim" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Skype" }, properties = { tag = tags[1][4] }},
    { rule =  { class = "Mangler" }, properties = { tag = tags[1][4] }},
    { rule =  { class = "Gucharmap" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "emulator64-arm" }, properties = { tag = tags[1][4] }},
    { rule =  { class = "Googleearth-bin", name = "googleearth-bin*" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Gajim.py", name = "Gajim: Account Creation Wizard" }, properties = { tag = tags[1][1], floating = true }},
    { rule =  { class = "Gajim.py", name = "Subscription Request" }, properties = { tag = tags[1][1], floating = true }},
    { rule =  { class = "Gajim.py", name = "Contact Information" }, properties = { tag = tags[1][1], floating = true }},
    { rule =  { class = "Gajim.py", name = "Advanced Configuration Editor" }, properties = { tag = tags[1][1], floating = true }},
    { rule =  { class = "Gajim.py", name = "Add New Contact" }, properties = { floating = true }},
    { rule =  { class = "Inkscape"}, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "Pgadmin3"}, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "URxvt"}, properties = { tag = tags[1][2], floating = false }},
    { rule =  { class = "XTerm", name = "screen" }, properties = { tag = tags[1][2], floating = false }},
    { rule =  { class = "XTerm", name = "terms" }, properties = { tag = tags[1][2], floating = false }},
    { rule =  { class = "URxvt", name = "ncmpc"  }, properties = { tag = tags[1][5], floating = false }},
    { rule =  { class = "XTerm", name = "ncmpc*"  }, properties = { tag = tags[1][5], floating = false }},
    { rule =  { class = "XTerm", name = "python*"   }, properties = { tag = tags[1][1], floating = false}},
    { rule =  { class = "XTerm", name = "MOC*"  }, properties = { tag = tags[1][5], floating = false }},
    { rule =  { class = "XTerm", name = "/var/log/*" }, properties = { tag = tags[1][10], floating = false }},
    { rule =  { class = "Sonata" }, properties = { tag = tags[1][5], floating = false }},
    { rule =  { class = "Gmpc", name = "gmpc"        }, properties = { tag = tags[1][5], floating = false}},
    { rule =  { class = "Last.fm*"    }, properties = { tag = tags[1][5] }},
    { rule =  { class = "Mozilla-bin", name = "Gecko" }, properties = { tag = tags[1][3], floating = false}},
    { rule =  { class = "Vlc" }, properties = { tag = tags[1][5], floating = true }},
    --{ rule =  { class = "vlc" }, properties = { tag = tags[1][5] }},
    { rule =  { class = "Audacious" }, properties = { tag = tags[1][5], floating = true }},
    { rule =  { class = "XDosEmu", name = "XDosEmu*"  }, properties = { tag = tags[1][1],   floating = true }},
    { rule =  { class = "Gwget2", name = "Gwget2*"  }, properties = { tag = tags[1][8], floating = true }},
    { rule =  { class = "frame", name = "frame"}, properties = { floating = true }},
    { rule =  { class = "Wine", name = "Flash.exe*"  }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "Wine", name = "premiere.exe" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "Wine", name = "IEXPLORE.EXE" }, properties = { tag =tags[1][3], floating = false }},
    { rule =  { class = "Wine", name = "Photoshop.exe" }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "Wine", name = "SAFlashPlayer.exe" }, properties = { tag = tags[1][5], floating = false }},
    { rule =  { class = "Gnome-commander", name = "*copied"}, properties = { floating = true }},
    { rule =  { class = "XCalc"}, properties = { floating = true }},
    { rule =  { class = "XFontSel", name = "xfontsel" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Gthumb" }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "Xzgv" }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "feh", name = "feh" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "Gv", name = "gv" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "Gpicview", }, properties = { tag = tags[1][6] }},
    { rule =  { class = "Mirage", name = "mirage" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "display", name = "ImageMagick"}, properties = { tag = tags[1][6], floating = true }},
    { rule =  { class = "Eog", name = "eog"}, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "Toplevel", name = "userinfo*"  }, properties = { tag = tags[1][1], floating = true }},
    { rule =  { class = "Tkabber", name = "tkabber"  }, properties = { tag = tags[1][1], floating = false }},
    { rule =  { class = "config.hs", name = "config.hs:config.hs"}, properties = { tag = tags[1][1], floating = false }},
    { rule =  { class = "[gG]ens", name = "gens"  }, properties = { tag = tags[1][7], floating = true }},
    { rule =  { class = "Wine", name = "Gens32 Surreal.exe" }, properties = { tag = tags[1][7], floating = true }},
    { rule =  { class = "Gvim" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Leafpad" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Audacity" }, properties = { tag = tags[1][5] }},
    { rule =  { class = "Qtractor" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Ardour*" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Jokosher", name = "jokosher" }, properties = { tag = tags[1][1] }},
    { rule =  { name = "Qt Designer" }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { name = "Qtcreator" }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { name = "MonoDevelop" }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { name = "Wxmaxima" }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "java-lang-Thread" }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "org-netbeans-updater-UpdaterFrame" }, properties = { tag = tags[1][6], floating = true }},
    { rule =  { class = "Umbrello" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "VirtualBox"}, properties = { tag = tags[1][7], floating = true }},
    { rule =  { class = "Qt-subapplication"}, properties = { tag = tags[1][7], floating = true }},
    { rule =  { class = "qemu", name = "qemu"  }, properties = { tag = tags[1][7], floating = false }},
    { rule =  { class = "Kchmviewer", name = "kchmviewer" }, properties = { tag = tags[1][9] }},
    { rule =  { class = "OpenOffice.org"}, properties = { tag = tags[1][9], floating = false }},
    { rule =  { class = "LibreOffice [0-9]*.[0-9]*"}, properties = { tag = tags[1][9], floating = false }},
    { rule =  { class = "OpenOffice.org [0-9]*.[0-9]*", name = "VCLSalFrame.DocumentWindow" }, properties = { tag = tags[1][9], floating = false }},
    { rule =  { class = "LibreOffice [0-9]*.[0-9]*", name = "VCLSalFrame.DocumentWindow" }, properties = { tag = tags[1][9], floating = false }},
    { rule =  { class = "OpenOffice.org [0-9]*.[0-9]*", name = "VCLSalFrame:Стили и форматирование" }, properties = { tag = tags[1][9], floating = true }},
    { rule =  { class = "OpenOffice.org [0-9]*.[0-9]*", name = "VCLSalFrame:OpenOffice.org [0-9]*.[0-9]*" }, properties = { tag = tags[1][9], floating = false }},
    { rule =  { class = "OpenOffice.org [0-9]*.[0-9]*", name = "VCLSalFrame:(Найти и заменить|Find & Replace)" }, properties = { tag = tags[1][9], floating = true }},
    { rule =  { class = "OpenOffice.org [0-9]*.[0-9]*", name = "VCLSalFrame:Welcome to OpenOffice.org [0-9]*.[0-9]*" }, properties = { tag = tags[1][9], floating = true }},
    { rule =  { class = "Abiword"   }, properties = { tag = tags[1][9], floating = false }},
    { rule =  { class = "Gnumeric"   }, properties = { tag = tags[1][9], floating = false }},
    { rule =  { class = "Links"   }, properties = { tag = tags[1][3], floating = false }},
    { rule =  { class = "Dillo"   }, properties = { tag = tags[1][3], floating = false }},
    { rule =  { class = "K3b"   }, properties = { tag = tags[1][7], floating = false }},
    { rule =  { class = "Gnomebaker" }, properties = { tag = tags[1][7], floating = false }},
    { rule =  { class = "Graveman" }, properties = { tag = tags[1][7], floating = false }},
    { rule =  { class = "psi*" }, properties = { tag = tags[1][1], floating = false }},
    { rule =  { class = "Xchm", name = "xchm" }, properties = { tag = tags[1][9] }},
    { rule =  { class = "Avidemux2_gtk"  }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "Blender", name = "Blender"  }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "Glade-3" }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "Qtcreator", name = "qtcreator*" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "com-sun-kvem-toolbar-Main" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "Qtcreator.bin" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "Blender", name = "Render"  }, properties = { tag = tags[1][6], floating = true }},
    { rule =  { class = "XVkbd"}, properties = { floating = true }},
    { rule =  { class = "Evince" }, properties = { tag = tags[1][9], floating = false }},
    { rule =  { class = "Zathura" }, properties = { tag = tags[1][9], floating = false }},
    { rule =  { class = "Pybr" }, properties = { tag = tags[1][9], floating = false }},
    { rule =  { class = "Apvlv" }, properties = { tag = tags[1][9], floating = false }},
    { rule =  { class = "Epdfview", name = "epdfview*" }, properties = { tag = tags[1][9] }},
    { rule =  { class = "Assistant" }, properties = { tag = tags[1][9] }},
    { rule =  { class = "Stardict", name = "StarDict" }, properties = { tag = tags[1][7],  floating = false }},
    { rule =  { class = "Isomaster", name = "" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Xvidcap" }, properties = { floating = true }},
    { rule =  { class = "XTerm", name = "wget*" }, properties = { tag = tags[1][8] }},
    { rule =  { class = "XTerm", name = "lftpget download*" }, properties = { tag = tags[1][8] }},
    { rule =  { class = "Android SDK Manager", name = "Android SDK Manager" }, properties = { tag = tags[1][8] }},
    { rule =  { class = "Deluge" }, properties = { tag = tags[1][8] }},
    { rule =  { class = "Transmission-gtk" }, properties = { tag = tags[1][8] }},
    { rule =  { class = "Transmission" }, properties = { tag = tags[1][8] }},
    { rule =  { class = "Multiget" }, properties = { tag = tags[1][8] }},
    { rule =  { class = "Mlgui" }, properties = { tag = tags[1][8] }},
    { rule =  { class = "Linuxdcpp" }, properties = { tag = tags[1][8] }},
    { rule =  { class = "supertuxkart*" }, properties = { tag = tags[1][7], floating = true  }},
    { rule =  { class = "Super Tux Kart"}, properties = { tag = tags[1][7], floating = true }},
    { rule =  { class = "Gnome-system-monitor", name = "gnome-system-monitor" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Lazarus" }, properties = { tag = tags[1][1], floating = true }},
    { rule =  { class = "Easytag" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Gparted" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "Tile Racer*"}, properties = { floating = true }},
    { rule =  { class = "Dia", name = "dia*" }, properties = { tag = tags[1][6], floating = false }},
    { rule =  { class = "SWT", name = "SWT" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "/usr/games/lib/torcs/torcs-bin*" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "python2.5" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "Lxdream" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "WorldOfGoo*" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "pouetChess" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "do-not-directly-run-secondlife-bin" }, properties = { tag = tags[1][7], floating = true }},
    { rule =  { class = "dccnitghtmare" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "foobillard", name = "foobillard" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "[nN]everball" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "ppracer", name = "ppracer" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "etracer" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "btanks", name = "btanks" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "smc", name = "smc" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "toppler", name = "toppler" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "wormux", name = "wormux" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "xmoto", name = "xmoto" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "warzone2100", name = "warzone2100" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "DarkPlaces", name = "Nexuiz" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "linux_client" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "nexuiz-sdl" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "ioUrbanTerror.i386" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "Wine", name = "hl.exe"}, properties = { floating = true, tag = tags[1][7] }},
    { rule =  { class = "Hedgewars" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "Gtk-lshw" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Qtconfig" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Qcad" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "Kino", name = "kino" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "OpenShot.py" }, properties = { tag = tags[1][6] }},
    { rule =  { class = "Ghamachi" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "armagetronad" }, properties = { tag = tags[1][7], floating = true }},
    { rule =  { class = "Wine", name = "gta_sa.exe" }, properties = { tag = tags[1][7] }},
    { rule =  { class = "Gconf-editor" }, properties = { tag = tags[1][1] }},
    { rule =  { class = "Edb", name = "edb" }, properties = { tag = tags[1][1] }},
}


-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
