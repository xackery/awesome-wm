local awful = require('awful')

local startup = {
    is_loaded = false,
}

function startup.load()
    if startup.is_loaded then
        return
    end

    startup.is_loaded = true

    apps = {
        'nm-applet --indicator', -- wifi
        'pnmixer', -- shows an audiocontrol applet in systray when installed.
        --'xfce4-power-manager', -- Power manager
    }
    for app = 1, #apps do
        -- check if program is already running
        awful.spawn.with_shell('pgrep -u $USER -x ' .. apps[app] .. ' || (' .. apps[app] .. ')')
        -- awful.util.spawn(apps[app])
    end
end

return startup