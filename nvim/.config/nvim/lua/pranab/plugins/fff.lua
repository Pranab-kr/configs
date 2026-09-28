return {
	"dmtrKovalenko/fff", -- repo renamed from fff.nvim -> fff
	enabled = true,
	build = function()
		-- downloads a prebuilt binary or falls back to cargo build from source
		-- (use `gb` in lazy.nvim to rebuild the plugin if needed)
		require("fff.download").download_or_build_binary()
	end,
	lazy = false, -- the plugin lazy-initialises itself
	config = function()
		require("fff").setup({
			title = "Find Files", -- Window title
			max_results = 100, -- Maximum search results to display
			max_threads = 4, -- Maximum threads for fuzzy search
			lazy_sync = true,

			prompt = "🛸 ", -- Input prompt symbol
			layout = {
				width = 0.75, -- Window width as fraction of screen
				height = 0.85, -- Window height as fraction of screen
				prompt_position = "bottom", -- or 'top'
				preview_position = "right", -- 'left' | 'right' | 'top' | 'bottom'
				preview_size = 0.5,
			},
			preview = {
				enabled = true,
				max_size = 10 * 1024 * 1024, -- 10MB
				chunk_size = 8192,
				binary_file_threshold = 1024,
				line_numbers = false,
				wrap_lines = false,
			},
			keymaps = {
				close = { "<C-c>", "<Esc>" },
				select = "<CR>",
				select_split = "<C-s>",
				select_vsplit = "<C-v>",
				select_tab = "<C-t>",
				move_up = { "<Up>", "<C-p>", "<C-k>" },
				move_down = { "<Down>", "<C-n>", "<C-j>" },
				preview_scroll_up = "<C-u>",
				preview_scroll_down = "<C-d>",
			},
			git = {
				status_text_color = true, -- color filenames by git status
				recency = {
					enabled = true, -- boost files touched in recent commits
					max_commits = 10,
					max_files_per_commit = 50,
				},
			},
			hl = {
				border = "FloatBorder",
				normal = "Normal",
				cursor = "CursorLine",
				matched = "IncSearch",
				title = "Title",
				prompt = "Question",
				active_file = "Visual",
				frecency = "Number",
				debug = "Comment",
				git_staged = "FFFGitStaged",
				git_modified = "FFFGitModified",
				git_deleted = "FFFGitDeleted",
				git_renamed = "FFFGitRenamed",
				git_untracked = "FFFGitUntracked",
				git_ignored = "FFFGitIgnored",
			},
			frecency = {
				enabled = true,
				db_path = vim.fn.stdpath("cache") .. "/fff_nvim",
			},
			history = {
				enabled = true,
				db_path = vim.fn.stdpath("data") .. "/fff_queries",
				min_combo_count = 3, -- boost files selected 3x in a row for a query
				combo_boost_score_multiplier = 100,
			},
			debug = {
				show_scores = false, -- toggle with F2 or :FFFDebug
				show_file_info = true, -- file info panel above the preview
			},
		})
	end,
	keys = {
		{
			"<leader>pf",
			function()
				require("fff").find_files()
			end,
			desc = "Open file picker",
		},
		{
			"<leader>ps",
			function()
				require("fff").live_grep({
					grep = {
						modes = { "fuzzy", "plain" },
					},
				})
			end,
			desc = "Live fuzzy grep",
		},
		{
			"<leader>pgf",
			function()
				require("fff").find_in_git_root()
			end,
			desc = "Find files in git root",
		},
		{
			"<leader>pcf",
			function()
				require("fff").find_files_in_dir("~/my-config/nvim/.config/nvim/")
			end,
			desc = "Find files in specified path",
		},
	},
}
