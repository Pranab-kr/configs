-----------------------
---- LOOK AND FEEL ----
-----------------------
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
	general = {
		gaps_in = 8,
		gaps_out = 10,

		border_size = 1,

		col = {
			-- active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 20,
		rounding_power = 5,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 20,
			render_power = 3,
			color = "0xee121212",
		},

		blur = {
			enabled = true,
			size = 6,
			passes = 2,
			ignore_opacity = true, -- Allows opacity blurring
			new_optimizations = true,
			input_methods = true,
			xray = false,
			popups = true,
			special = false,
			vibrancy = 0.1696,
		},
	},

	group = {
		insert_after_current = true,
		groupbar = {
			font_family = "JetBrains Mono NF",
			font_size = 14,
			gradients = true,
			gradient_round_only_edges = false,
			gradient_rounding = 5,
			height = 24,
			indicator_height = 0,
			gaps_in = 3,
			gaps_out = 3,
			render_titles = true,
		},
	},
})
