local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'CommitMono Nerd Font'
config.color_scheme = 'Dark Ocean (terminal.sexy)'
config.audible_bell = 'Disabled'
config.font_size = 13

wezterm.on('update-right-status', function(window, pane)
  -- "Wed Mar 3 08:14"
  local date = wezterm.strftime '%a %b %-d %H:%M '

  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    bat = '🔋 ' .. string.format('%.0f%%', b.state_of_charge * 100)
  end

  window:set_right_status(wezterm.format {
    { Text = bat .. '   ' .. date },
  })
end)

return config
