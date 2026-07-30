return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	event = "VeryLazy", -- Loads right after the main editor UI initializes
	keys = {
		{ "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
	},
	opts = {
		options = {
			mode = "buffers",
			separator_style = "slant",
			offsets = {
				{
					filetype = "snacks_layout_box",
					text = "File Explorer",
					text_align = "center",
					separator = true,
				},
			},
		},
	},
}
