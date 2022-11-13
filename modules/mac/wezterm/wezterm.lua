local wezterm = require("wezterm")

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  font = wezterm.font("VictorMono Nerd Font"),
  font_size = 12,

  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  hide_tab_bar_if_only_one_tab = true,

  window_background_opacity = 0.85,

  colors = {
    foreground = "#dfbf8e",
    background = "#282828",
    cursor_bg = "#d4be98",
    cursor_border = "#d4be98",
    cursor_fg = "#101010",
    selection_bg = "#d4be98",
    selection_fg = "#3c3836",

    ansi = { "#665c54", "#ea6962", "#a9b665", "#e78a4e", "#7daea3", "#d3869b", "#89b482", "#dfbf8e" },
    brights = { "#928374", "#ea6962", "#a9b665", "#e3a84e", "#7daea3", "#d3869b", "#89b482", "#dfbf8e" },
  },

  keys = {
    { key = "h", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
    { key = "j", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
    { key = "k", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
    { key = "l", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },

    { key = "[", mods = "ALT", action = wezterm.action({ ActivateTabRelativeNoWrap = -1 }) },
    { key = "]", mods = "ALT", action = wezterm.action({ ActivateTabRelativeNoWrap = 1 }) },
  },
}
