-- hyprland startup
hl.on("hyprland.start", function()
	hl.exec_cmd("qs -c overview")
end)

-- Enable back-and-forth workspace jumping
hl.config({
	binds = {
		workspace_back_and_forth = true,
	},
	input = {
		sensitivity = 0.4,

		-- kb_options = "caps:escape",
	},
})

-- Rules
hl.window_rule({
	match = {
		class = "brave-music\\.youtube\\.com.*",

		-- class = "chrome-music.youtube.com__-Default",
		-- class = "brave-music.youtube.com__-Default",
	},
	workspace = "special:music",
})

hl.window_rule({
	match = {
		class = "brave-web\\.whatsapp\\.com.*",
		-- class = "brave-web.whatsapp.com__-Default",
	},
	workspace = "special:communication",
})

-- for mouse
hl.device({
	name = "instant-usb-gaming-mouse-",
	accel_profile = "flat",
	sensitivity = -0.1,
})

-- Default monitor conf
hl.monitor({
	output = "",
	mode = "preferred",
	-- mode = "1920x1080@60.02",
	-- mode = "1920x1080@144.03",
	position = "auto",
	scale = 1,
})

-- custom keyBinds
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"), { description = "Toggle split" })

hl.bind("SUPER + ALT + M", hl.dsp.exec_cmd("brave-origin --app=https://music.youtube.com/"))
-- hl.bind("SUPER + ALT + M", hl.dsp.exec_cmd("helium-browser --app=https://music.youtube.com/"))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("brave-origin --app=https://web.whatsapp.com/"))
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + TAB", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("brave-origin"))
hl.bind("SUPER + H", hl.dsp.exec_cmd("helium-browser"))
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("obsidian"))
hl.bind("SUPER + G", hl.dsp.exec_cmd("steam"))
hl.bind("SUPER + CTRL + V", hl.dsp.exec_cmd("$HOME/.local/bin/toggle-caelestia-visualiser"))
