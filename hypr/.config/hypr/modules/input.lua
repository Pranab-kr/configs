-- for mouse
hl.device({
	name = "instant-usb-gaming-mouse-",
	accel_profile = "flat",
	sensitivity = -0.1,
})

---------------
---- INPUT ----
---------------
hl.config({
	input = {
		kb_layout = "us",
		numlock_by_default = false,
		repeat_delay = 250,
		repeat_rate = 35,
		focus_on_close = 1,

		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			scroll_factor = 0.3,
		},

		sensitivity = 0.4,
	},

	binds = {
		scroll_event_delay = 0,
		workspace_back_and_forth = true,
	},

	cursor = {
		hotspot_padding = 1,
	},
})
