return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		-- labels shown on jump targets (home-row order by default)
		labels = "asdfghjklqwertyuiopzxcvbnm",

		search = {
			-- "exact" | "search" (regex) | "fuzzy"
			mode = "fuzzy",
			-- search across all windows
			multi_window = true,
		},

		jump = {
			-- jump immediately when there's only one match
			autojump = true,
			-- save jumps in the jumplist so <C-o>/<C-i> work
			jumplist = true,
		},

		label = {
			-- allow uppercase labels (shift+letter jumps)
			uppercase = true,

			-- label the first match so <CR> jumps to it
			current = true,
		},

		highlight = {
			-- dim the background while jumping
			backdrop = true,
		},

		modes = {
			-- enable flash during regular / and ? search
			-- (toggle any time with <C-s> in search mode)
			search = {
				enabled = true,
			},
			-- enhanced f, F, t, T motions (enabled by default)
			char = {
				enabled = true,
				-- show labels after f/t motions too
				jump_labels = true,
				-- only current line for f/t (set false for multi-line)
				multi_line = false,
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
}
