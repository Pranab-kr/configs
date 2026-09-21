return {
	-- Statuscolumn configuration for clickable fold buttons and clean gutter
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true,
				ft_ignore = {
					"snacks_dashboard",
					"snacks_picker_input",
					"snacks_terminal",
					"lazy",
					"mason",
					"oil",
					"trouble",
					"help",
					"fugitive",
				},
				bt_ignore = {
					"terminal",
					"nofile",
					"prompt",
					"quickfix",
				},
				segments = {
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					{ text = { "%s" }, click = "v:lua.ScSa" },
					{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				},
			})
		end,
	},
}
