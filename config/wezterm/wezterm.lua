local wezterm = require 'wezterm'
local config = {}

config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'Morada (Gogh)'

return config
