local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.color_scheme = 'nord'
config.font = wezterm.font_with_fallback({
    { family = 'JetBrains Mono', weight = 'Regular' },
    { family = 'BIZ UDGothic' },
})
config.font_size = 9
config.bold_brightens_ansi_colors = 'BrightAndBold'
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.window_background_opacity = 0.98
config.text_background_opacity = 0.98
config.hide_tab_bar_if_only_one_tab = true

{{if .wezterm_default_domain}}
config.default_domain = '{{.wezterm_default_domain}}'
{{end}}

return config
