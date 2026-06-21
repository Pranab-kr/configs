return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	dependencies = {
		"folke/snacks.nvim",
	},
	keys = {
		{
			"<leader>y",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open Yazi at the current file",
			-- {
			-- 	"<leader>yw",
			-- 	"<cmd>Yazi cwd<cr>",
			-- 	desc = "Open the file manager in nvim's working directory",
			-- },
		},
	},
	opts = {
		open_for_directories = false,
	},
}
