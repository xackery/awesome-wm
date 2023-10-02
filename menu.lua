local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
 }

return awful.menu({ items = {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "terminal", terminal },
    { "disord", "flatpak run com.discordapp.Discord" },
}})