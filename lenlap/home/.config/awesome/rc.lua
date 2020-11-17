-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
--local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local posix = require("posix")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
require("sizes")
local battery_widget = require("battery_widget")
local keyboardlayout = require("keyboardlayout")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_xdg_config_home() .. "awesome/theme.lua")

local screen = awful.screen.focused()
local safeCoords = {x = screen.geometry.width, y = screen.geometry.height}
mouse.coords(safeCoords)

function save_mouse_position()
    local tag = awful.tag.selected()
    awful.tag.setproperty(tag, "mouse", mouse.coords())
end

function load_mouse_position()
    local tag = awful.tag.selected()
    local coords = awful.tag.getproperty(tag, "mouse") or safeCoords
    mouse.coords(coords)
end

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile.bottom,
    awful.layout.suit.floating,
--    awful.layout.suit.tile.left,
--    awful.layout.suit.tile.top,
--    awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.tile,
--    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier,
--    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- Menubar configuration
--menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("[ %H:%M ]")
mybattery = battery_widget()

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    -- set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1 tasks", "2 term", "3 web", "4 main", "5 media", "6 graphics", "7 misc", "8 misc", "9 doc", "0 logs" }, s, awful.layout.layouts[3])

    -- FIXME: ugly hack, just to set the 3rd tag's layout to max
    --awful.tag.viewonly(s.tags[3])
    --awful.layout.inc(-3)

    --FIXME
    awful.tag.viewonly(s.tags[1])
    awful.tag.incmwfact(0.20)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, {})

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = top_box_height })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            mybattery,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

--b = battery.batclosure ('BAT0')()

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "Left", function ()
                save_mouse_position()
                awful.tag.viewprev()
                load_mouse_position()
              end,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right", function ()
                save_mouse_position()
                awful.tag.viewnext()
                load_mouse_position()
              end,
              {description = "view next", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            --awful.client.focus.history.previous()
            awful.client.focus.byidx(1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
--    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
--              {description = "open a terminal", group = "launcher"}),
    --awful.key({ modkey, "Control" }, "r", awesome.restart,
    --          {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control", "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"})

    -- Prompt
--    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
--              {description = "run prompt", group = "launcher"}),
--
--    awful.key({ modkey }, "x",
--              function ()
--                  awful.prompt.run {
--                    prompt       = "Run Lua code: ",
--                    textbox      = awful.screen.focused().mypromptbox.widget,
--                    exe_callback = awful.util.eval,
--                    history_path = awful.util.get_cache_dir() .. "/history_eval"
--                  }
--              end,
--              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
--    awful.key({ modkey }, "p", function() menubar.show() end,
--              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
--    awful.key({ modkey,           }, "f",
--        function (c)
--            c.fullscreen = not c.fullscreen
--            c:raise()
--        end,
--        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"})
    --awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
    --          {description = "toggle floating", group = "client"}),
    --awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    --          {description = "move to master", group = "client"}),
    --awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
    --          {description = "move to screen", group = "client"}),
    --awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
    --          {description = "toggle keep on top", group = "client"}),
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

for i = 0, 9 do
    local tag_index = i == 0 and 10 or i
    local key = i == 0 and "0" or ("#" .. i + 9)
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, key,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[tag_index]
                        if tag then
                           save_mouse_position()
                           tag:view_only()
                           load_mouse_position()
                        end
                  end,
                  {description = "view tag #"..tag_index, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, key,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[tag_index]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..tag_index, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- "Hide" all splash screens
    { rule_any = {type = { "splash" }
      }, properties = { tag = "7 misc" }
    },

    { rule = { role = "browser" }, properties = { tag = "3 web" } },
    { rule = { class = "VirtualBox"}, properties = { tag = "7 misc", floating = true } },
    { rule = { class = "QDeviceMonitor" }, properties = { tag = "0 logs" }},
    { rule = { class = "Zathura" }, properties = { tag = "9 doc" }},
    { rule = { class = "Code" }, properties = { tag = "2 term" } },
    { rule = { class = "libreoffice-writer" }, properties = { tag = "9 doc" } },
    { rule = { class = "TelegramDesktop" }, properties = { tag = "1 tasks" } },
}

apps_to_tags = {}
for line in io.lines("/tmp/.apps_to_tags") do
    local tab_position = string.find(line, "\t")
    local app = string.sub(line, 1, tab_position - 1)
    if app ~= "qdevicemonitor" and app ~= "VirtualBox" then
        local tag_index = string.sub(line, tab_position + 1)
        apps_to_tags[app] = tonumber(tag_index)
    end
    --awful.rules.rules[#awful.rules.rules + 1] = { rule = { class = app, properties = { tag = tag_name } } }
end
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("property::instance", function(c)
    if c.pid ~= nil then
        local app_path = posix.readlink("/proc/" .. c.pid .. "/exe")
        if app_path ~= nil then
            local app = string.match(app_path, ".*/(.*)")

            local tag_index = apps_to_tags[app]
            if tag_index == nil then
                tag_index = apps_to_tags[c.class]
            end
            if tag_index == nil then
                tag_index = apps_to_tags[c.instance]
            end

            if tag_index ~= nil then
                local screen = awful.screen.focused()
                local tag = screen.tags[tag_index]
                c:move_to_tag(tag)
            end
        end
    end
end)
-- awful.rules.rules[#awful.rules.rules + 1] = line
-- }}}
