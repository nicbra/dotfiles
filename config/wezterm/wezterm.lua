local wezterm = require 'wezterm'
local config = {}

config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'Morada (Gogh)'

config.window_background_opacity = .95


config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'PrimarySelection',
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SHIFT',
    action = wezterm.action.CompleteSelection 'PrimarySelection',
  },
  -- keep the default "click on link to open" behaviour for triple/double
}

return config
