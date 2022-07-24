local wez = require 'wezterm'

return {
  font = wez.font 'Roboto Mono',
  font_size = 11.0,

  -- Works better for low DPI screens.
  freetype_load_target = 'HorizontalLcd',

  color_scheme = 'GitHub Dark',

  -- Minimize window decorations and optimize for tmux/vim.
  use_resize_increments = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = 'TITLE | RESIZE',
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
  }
}

