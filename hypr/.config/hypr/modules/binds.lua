--------------------------------------------------------------------------------
-- KEYBINDINGS CONFIGURATION
--------------------------------------------------------------------------------
-- Organized by category and function with descriptions on all bindings.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- 1. APPLICATION & SHELL VARIABLES
--------------------------------------------------------------------------------
local terminal = "kitty"
local fileManager = "thunar"
local browser = "helium-browser"
local altBrowser = "brave-origin"
local ipc = "noctalia msg "
local mainMod = "SUPER"

--------------------------------------------------------------------------------
-- 2. HELPER FUNCTIONS
--------------------------------------------------------------------------------

-- Relative window resizing helper
local function resize_active_window(x, y)
	return function()
		local win = hl.get_active_window()
		if win and win.size then
			local w = (win.size.x * (x / 100)) or 800
			local h = (win.size.y * (y / 100)) or 600
			hl.dispatch(hl.dsp.window.resize({ x = w, y = h, relative = true }))
		else
			hl.dispatch(hl.dsp.no_op())
		end
	end
end

-- Smart scratchpad toggler: launches app if absent, or reveals/hides workspace
local function smart_scratchpad(special_name, app_class, spawn_cmd)
	return function()
		local active_special = hl.get_active_special_workspace()
		local target_special = "special:" .. special_name

		if active_special and active_special.name == target_special then
			hl.dispatch(hl.dsp.workspace.toggle_special(special_name))
			return
		end

		local windows = hl.get_windows() or {}
		local matched_win = nil
		for _, win in ipairs(windows) do
			if win.class == app_class or (win.class and win.class:find(app_class, 1, true)) then
				matched_win = win
				break
			end
		end

		if not matched_win then
			hl.dispatch(hl.dsp.exec_cmd(spawn_cmd))
		elseif matched_win.workspace and matched_win.workspace.name ~= target_special then
			hl.dispatch(hl.dsp.window.move({ window = matched_win, workspace = target_special }))
		end

		hl.dispatch(hl.dsp.workspace.toggle_special(special_name))
	end
end

-- Game mode toggler: disables animations, blur, shadows, and gaps for performance
local gamemode_active = false
local function toggle_gamemode()
	gamemode_active = not gamemode_active
	if gamemode_active then
		hl.config({
			animations = { enabled = false },
			general = {
				gaps_in = 0,
				gaps_out = 0,
			},
			decoration = {
				rounding = 0,
				shadow = { enabled = false },
				blur = { enabled = false },
			},
		})
		hl.exec_cmd(ipc .. 'notification-show "Game Mode" "Enabled - animations, blur, shadows & gaps disabled"')
	else
		hl.exec_cmd("hyprctl reload")
		hl.exec_cmd(ipc .. 'notification-show "Game Mode" "Disabled - standard desktop restored"')
	end
end

--------------------------------------------------------------------------------
-- 3. CORE APPLICATIONS
--------------------------------------------------------------------------------

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal), {
	description = "Launch terminal emulator (Kitty)",
})

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager), {
	description = "Launch file manager (Nautilus)",
})

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser), {
	description = "Launch primary web browser (" .. browser .. ")",
})

hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd(altBrowser), {
	description = "Launch secondary web browser (" .. altBrowser .. ")",
})

hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("obsidian"), {
	description = "Launch Obsidian",
})

--------------------------------------------------------------------------------
-- 4. WINDOW MANAGEMENT & STATES
--------------------------------------------------------------------------------

hl.bind(mainMod .. " + Q", hl.dsp.window.close(), {
	description = "Close active window",
})

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), {
	description = "Toggle true fullscreen",
})

hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen({ mode = "maximized" }), {
	description = "Toggle maximized window (keep borders)",
})

hl.bind("SUPER + ALT + SPACE", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))

	local w = hl.get_active_window()

	if w and w.class == "kitty" then
		hl.dispatch(hl.dsp.window.resize({
			x = w.monitor.width * 0.6,
			y = w.monitor.height * 0.6,
			relative = false,
			window = w,
		}))

		hl.dispatch(hl.dsp.window.center({
			window = w,
		}))
	end
end, {
	description = "Toggle floating mode on active window (auto-resize and center kitty)",
})

hl.bind("CTRL + SUPER + Backslash", hl.dsp.window.center(), {
	description = "Center active floating window",
})

hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pin(), {
	description = "Pin active window (visible on all workspaces)",
})

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), {
	description = "Toggle pseudo-tiling mode",
})

hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), {
	description = "Toggle horizontal / vertical dwindle split",
})

hl.bind(mainMod .. " + SHIFT + G", toggle_gamemode, {
	description = "Toggle Game Mode (disable animations, blur, gaps)",
})

--------------------------------------------------------------------------------
-- 5. WINDOW GROUPS (TABS)
--------------------------------------------------------------------------------

hl.bind(mainMod .. " + G", hl.dsp.group.toggle(), {
	description = "Toggle window grouping into tabs",
})

hl.bind(mainMod .. " + ALT + G", hl.dsp.group.lock_active(), {
	description = "Lock / unlock active tabbed group",
})

hl.bind("ALT + bracketleft", hl.dsp.group.prev(), {
	description = "Switch to previous tab in group",
	repeating = true,
})

hl.bind("ALT + bracketright", hl.dsp.group.next(), {
	description = "Switch to next tab in group",
	repeating = true,
})

hl.bind(mainMod .. " + U", hl.dsp.window.move({ out_of_group = true }), {
	description = "Eject active window from group (ungroup)",
})

--------------------------------------------------------------------------------
-- 6. WINDOW NAVIGATION & FOCUS
--------------------------------------------------------------------------------

for _, dir in ipairs({ "left", "right", "up", "down" }) do
	hl.bind("SUPER + " .. dir, hl.dsp.focus({ direction = dir }), {
		description = "Focus window " .. dir,
	})
	hl.bind("SUPER + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }), {
		description = "Move active window " .. dir,
	})
end

-- Keyboard window resizing
hl.bind("SUPER + ALT + Left", resize_active_window(-10, 0), {
	description = "Shrink active window width",
	repeating = true,
})
hl.bind("SUPER + ALT + Right", resize_active_window(10, 0), {
	description = "Expand active window width",
	repeating = true,
})
hl.bind("SUPER + ALT + Up", resize_active_window(0, -10), {
	description = "Shrink active window height",
	repeating = true,
})
hl.bind("SUPER + ALT + Down", resize_active_window(0, 10), {
	description = "Expand active window height",
	repeating = true,
})

-- Mouse window dragging and resizing
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), {
	description = "Drag to move active window",
	mouse = true,
})
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), {
	description = "Drag to resize active window",
	mouse = true,
})
hl.bind("SUPER + Z", hl.dsp.window.drag(), {
	description = "Drag window under cursor (keyboard alias)",
	mouse = true,
})
hl.bind("SUPER + X", hl.dsp.window.resize(), {
	description = "Resize window under cursor (keyboard alias)",
	mouse = true,
})

--------------------------------------------------------------------------------
-- 7. WORKSPACE NAVIGATION
--------------------------------------------------------------------------------

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), {
		description = "Switch to workspace " .. i,
	})
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i }), {
		description = "Move active window to workspace " .. i,
	})
end

-- Relative workspace stepping
hl.bind("CTRL + SUPER + Left", hl.dsp.focus({ workspace = "-1" }), {
	description = "Switch to previous workspace",
})
hl.bind("CTRL + SUPER + Right", hl.dsp.focus({ workspace = "+1" }))

-- Mouse scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), {
	description = "Switch to next workspace via scroll down",
})
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), {
	description = "Switch to previous workspace via scroll up",
})

--------------------------------------------------------------------------------
-- 8. SCRATCHPADS & SPECIAL WORKSPACES
--------------------------------------------------------------------------------

hl.bind(
	mainMod .. " + M",
	smart_scratchpad("music", "ytm-tui", "kitty --class ytm-tui -T ytm-tui -e ~/.local/bin/ytm-tui"),
	{ description = "Toggle music scratchpad (ytm-tui)" }
)

hl.bind(
	mainMod .. " + C",
	smart_scratchpad("communication", "web.whatsapp.com", "helium-browser -origin --app=https://web.whatsapp.com"),
	{ description = "Toggle WhatsApp Web scratchpad" }
)

hl.bind(mainMod .. " + backslash", hl.dsp.workspace.toggle_special("magic"), {
	description = "Toggle general scratchpad workspace",
})

hl.bind(mainMod .. " + ALT + backslash", hl.dsp.window.move({ workspace = "special:magic" }), {
	description = "Move active window into general scratchpad",
})

hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }), {
	description = "Move active window into general scratchpad (alias)",
})

hl.bind(mainMod .. " + SHIFT + backslash", hl.dsp.window.move({ workspace = "e+0" }), {
	description = "Return window from scratchpad to current workspace",
})

--------------------------------------------------------------------------------
-- 9. NOCTALIA SHELL & PANELS
--------------------------------------------------------------------------------

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"), {
	description = "Toggle Noctalia application launcher",
})

hl.bind(mainMod .. " + period", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher :emo"), {
	description = "Toggle Noctalia emoji picker",
})

hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"), {
	description = "Toggle Noctalia control center",
})

hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"), {
	description = "Toggle Noctalia settings window",
})

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"), {
	description = "Toggle Noctalia clipboard history",
})

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"), {
	description = "Toggle Noctalia wallpaper selector",
})

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(ipc .. "wallpaper-random"), {
	description = "Switch to a random wallpaper via Noctalia",
})

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center notifications"), {
	description = "Toggle Noctalia notifications panel",
})

hl.bind("CTRL + ALT + P", hl.dsp.exec_cmd(ipc .. "panel-toggle session"), {
	description = "Toggle Noctalia session / power menu",
})

hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd(ipc .. "panel-toggle session"), {
	description = "Toggle Noctalia session / power menu (PC alias)",
})

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(ipc .. "session lock"), {
	description = "Lock the screen session",
})

--------------------------------------------------------------------------------
-- 10. TASK SWITCHER & OVERVIEW
--------------------------------------------------------------------------------

hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher hold"), {
	description = "Open Noctalia window switcher overlay",
})

hl.bind("SUPER + TAB", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"), {
	description = "Toggle Quickshell overview",
})

--------------------------------------------------------------------------------
-- 11. SCREENSHOTS & SCREEN CAPTURE
--------------------------------------------------------------------------------

hl.bind("PRINT", hl.dsp.exec_cmd(ipc .. "screenshot-fullscreen"), {
	description = "Capture fullscreen screenshot",
})

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(ipc .. "screenshot-region"), {
	description = "Freeze screen and open annotation screenshot tool",
})

hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd(ipc .. "screenshot-annotate"), {
	description = "Select and capture screen region",
})

--------------------------------------------------------------------------------
-- 12. HARDWARE & MEDIA KEYS (WITH NOCTALIA OSD)
--------------------------------------------------------------------------------

-- Audio Volume & Mic
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up 5"), {
	description = "Raise speaker volume (Noctalia OSD)",
	locked = true,
	repeating = true,
})

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down 5"), {
	description = "Lower speaker volume (Noctalia OSD)",
	locked = true,
	repeating = true,
})

hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"), {
	description = "Toggle speaker mute",
	locked = true,
})

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. "mic-mute"), {
	description = "Toggle microphone mute",
	locked = true,
})

-- Display Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. 'brightness-up "" 5'), {
	description = "Increase display brightness (Noctalia OSD)",
	locked = true,
	repeating = true,
})

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. 'brightness-down "" 5'), {
	description = "Decrease display brightness (Noctalia OSD)",
	locked = true,
	repeating = true,
})

-- Media Playback
hl.bind("CTRL + SUPER + Space", hl.dsp.exec_cmd("playerctl play-pause || " .. ipc .. "media toggle"), {
	description = "Play / Pause active media playback",
	locked = true,
})

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(ipc .. "media toggle"), {
	description = "Toggle media play/pause",
	locked = true,
})

hl.bind("XF86AudioPause", hl.dsp.exec_cmd(ipc .. "media toggle"), {
	description = "Pause media playback",
	locked = true,
})

hl.bind("XF86AudioNext", hl.dsp.exec_cmd(ipc .. "media next"), {
	description = "Skip to next media track",
	locked = true,
})

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(ipc .. "media previous"), {
	description = "Skip to previous media track",
	locked = true,
})
