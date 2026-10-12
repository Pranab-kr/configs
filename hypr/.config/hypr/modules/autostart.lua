-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	-- Keyring and authentication
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")

	-- Clipboard history for Noctalia clipboard manager
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	-- Cursor settings (Hyprland & GTK / GNOME interface)
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Ice")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")

	-- Bluetooth media commands forwarding to MPRIS
	hl.exec_cmd("mpris-proxy")

	-- Noctalia shell & Quickshell overview
	hl.exec_cmd("noctalia")
	hl.exec_cmd("qs -c overview")

	-- Auto-empty trash older than 30 days if available
	hl.exec_cmd("command -v trash-empty >/dev/null 2>&1 && trash-empty 30")
end)
