local config = {
	-- Rendering Options
	front_end = "WebGpu", -- Use WebGPU for rendering

	-- Font Configuration
	font = wezterm.font("JetBrains Mono"), -- Replace with your preferred font
	font_size = 12.0,

	-- Appearance
	color_scheme = "Rosé Pine (base16)", -- Replace with your favorite color scheme
	window_background_opacity = 0.90, -- Slightly transparent background
	text_background_opacity = 1.0,
	tab_bar_at_bottom = true, -- Move the tab bar to the bottom
	hide_tab_bar_if_only_one_tab = true, -- Hide tab bar if only one tab is open

	-- Pane Management
	adjust_window_size_when_changing_font_size = false, -- Keep window size constant when changing font size

	-- Performance Tweaks
	enable_tab_bar = true,
	enable_scroll_bar = false, -- Disable scroll bar for minimal UI
	window_close_confirmation = "NeverPrompt", -- No confirmation when closing

	-- Scrollback
	scrollback_lines = 5000, -- Increase scrollback buffer

	-- Miscellaneous
	check_for_updates = false, -- Disable update checks
	warn_about_missing_glyphs = false, -- Suppress missing glyph warnings
}

return config
