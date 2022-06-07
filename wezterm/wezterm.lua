local wezterm = require("wezterm")

return {
  font = wezterm.font("Iosevka"),
  font_size = 14,

  window_decorations = "NONE",
  window_background_opacity = 0.9,
  window_close_confirmation = "NeverPrompt",

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

    { key = "1", mods = "ALT", action = wezterm.action({ ActivateTab = 0 }) },
    { key = "2", mods = "ALT", action = wezterm.action({ ActivateTab = 1 }) },
    { key = "3", mods = "ALT", action = wezterm.action({ ActivateTab = 2 }) },
    { key = "4", mods = "ALT", action = wezterm.action({ ActivateTab = 3 }) },
    { key = "5", mods = "ALT", action = wezterm.action({ ActivateTab = 4 }) },
    { key = "6", mods = "ALT", action = wezterm.action({ ActivateTab = 5 }) },
    { key = "7", mods = "ALT", action = wezterm.action({ ActivateTab = 6 }) },
    { key = "8", mods = "ALT", action = wezterm.action({ ActivateTab = 7 }) },
  },
}
