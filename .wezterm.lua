local wez = require 'wezterm'

is_windows = package.config:sub(1, 1) == "\\"

local c = {}
if wez.config_builder then
  c = wez.config_builder()
end

c.default_domain = is_windows and 'WSL:Ubuntu-24.04' or c.default_domain
c.font = is_windows and wez.font 'Consolas' or wez.font 'SF Mono'
c.font_size = 12
c.audible_bell = 'Disabled'
c.scrollback_lines = 999999
c.enable_scroll_bar = true

c.window_background_opacity = 0.97
c.color_scheme = 'OneHalfDark'
c.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }
c.front_end = 'WebGpu'
c.webgpu_power_preference = 'HighPerformance'

return c
