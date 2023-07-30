local wezterm = require 'wezterm';

local config = wezterm.config_builder()

config.font = wezterm.font("Cica")
config.use_ime = true
config.font_size = 14.0
config.color_scheme = "Monokai Remastered"
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.initial_cols = 150
config.initial_rows = 40
-- https://wezfurlong.org/wezterm/config/lua/config/macos_forward_to_ime_modifier_mask.html
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"
-- Can open hyperlink cmd + click in mouse enabled tmux
config.bypass_mouse_reporting_modifiers = "SUPER"
-- Use Homebrew's zsh
if wezterm.target_triple == 'aarch64-apple-darwin' then
  local homebrew_prefix = os.getenv("HOMEBREW_PREFIX")
  if homebrew_prefix then
    local homebrew_zsh = homebrew_prefix .. "/bin/zsh"
    if wezterm.run_child_process{"file", "-f", homebrew_zsh} then
      config.default_prog = { homebrew_zsh, '-l' }
    end
  end
end

return config
