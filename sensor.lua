local wibox = require("wibox")
local awful = require("awful")

local temp = 0
local high = 0
local crit = 0


function parse(widget, stdout)
    for line in stdout:gmatch("[^\r\n]+") do
        if line:match("Core") then
            if line:match("Core 0") then
                temp = 0
                high = 0
                crit = 0
            end
            out = ""
            for t in line:gmatch("Core [0-9]:.*+([0-9.]+)°C.*[0-9.]+°C.*[0-9.]+°C") do
                if tonumber(t) > tonumber(temp) then
                    temp = t
                end
            end
            for h in line:gmatch("Core [0-9]:.*+[0-9.]+°C.*+([0-9.]+)°C.*[0-9.]+°C") do
                high = h
            end
            for c in line:gmatch("Core [0-9]:.*+[0-9.]+°C.*+[0-9.]+°C.*+([0-9.]+)°C") do
                crit = c
            end
            if tonumber(temp) >= tonumber(high) then
                --widget:background().set_fg("#f1fa8c") --  yellow #f1fa8c
                out = "!"
            elseif tonumber(temp) >= tonumber(crit) then
                --widget:background().set_fg("#ff5555") -- red #ff5555
                out = "!!"
            end
            widget:set_text(out .. temp .. "°C ")
        end
    end
end

local temp = wibox.widget {
    widget = awful.widget.watch('sensors',
    5,
    parse),
}

temp.font = "Fira Code 8"

local temp_clr = wibox.widget.background()
temp_clr:set_widget(temp)

return temp_clr