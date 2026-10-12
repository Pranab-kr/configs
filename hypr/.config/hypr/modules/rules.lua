--------------------------------
---- WINDOW RULES --------------
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Suppress maximize requests
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix dragging issues with XWayland popups
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Noctalia app & settings
hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
	center = true,
})

-- Music Scratchpad (ytm-tui)
hl.window_rule({
	match = { class = "ytm-tui" },
	workspace = "special:music",
	float = true,
	size = { 1100, 750 },
	center = true,
})

-- WhatsApp Web
hl.window_rule({
	match = {
		class = "brave-web\\.whatsapp\\.com.*",
	},
	workspace = "special:communication",
})

-- Picture-in-Picture
hl.window_rule({
	match = { title = "Picture(-| )in(-| )[Pp]icture" },
	float = true,
	pin = true,
	keep_aspect_ratio = true,
	move = "(monitor_w*0.98-window_w) (monitor_h*0.97-window_h)",
})

-- File pickers and save dialogs
hl.window_rule({
	match = { title = "(Select|Open)( a)? (File|Folder)(s)?|Save As|File Upload" },
	float = true,
	size = { 960, 640 },
	center = true,
})

-- Audio & system utilities
hl.window_rule({
	match = {
		class = "org.pulseaudio.pavucontrol|com.saivert.pwvucontrol|blueman-manager|nm-connection-editor|nwg-look|file-roller|org.gnome.FileRoller",
	},
	float = true,
	size = { 960, 640 },
	center = true,
})

-- Bitwarden & credential managers
hl.window_rule({
	match = { class = "Bitwarden" },
	float = true,
	size = { 900, 700 },
	center = true,
})

-- Media viewers & small popups
hl.window_rule({
	match = { class = "feh|imv|swappy|yad|zenity|wev" },
	float = true,
	center = true,
})

-- Steam & Games
hl.window_rule({
	match = { class = "steam", title = "Friends List" },
	float = true,
})
hl.window_rule({
	match = { class = "steam_app_[0-9]+|gamescope" },
	immediate = true,
	idle_inhibit = "always",
})

--------------------------------
---- LAYER RULES ---------------
--------------------------------

-- Noctalia shell surfaces (bar, popups, notifications, panels, switcher, OSD, annotate)
hl.layer_rule({
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher|annotate)$",
	},
	blur = false,
	blur_popups = true,
	ignore_alpha = 0.5,
})

-- Wallpaper surface
hl.layer_rule({
	match = { namespace = "noctalia-wallpaper" },
	no_anim = true,
})

-- Overview (Quickshell)
hl.layer_rule({
	match = { namespace = "^(overview|quickshell|org.quickshell)$" },
	blur = false,
	ignore_alpha = 0.5,
})

-- Screen utilities
hl.layer_rule({ match = { namespace = "hyprpicker" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "selection" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "wayfreeze" }, animation = "fade" })
