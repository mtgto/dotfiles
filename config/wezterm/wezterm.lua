local wezterm = require 'wezterm';

return {
  font = wezterm.font("Cica"),
  use_ime = true,
  font_size = 14.0,
  color_scheme = "Monokai Remastered",
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  initial_cols = 150,
  initial_rows = 40,
  -- https://wezfurlong.org/wezterm/config/lua/config/macos_forward_to_ime_modifier_mask.html
  macos_forward_to_ime_modifier_mask = "SHIFT|CTRL",
  -- Can open hyperlink cmd + click in mouse enabled tmux
  bypass_mouse_reporting_modifiers = "SUPER",
}
