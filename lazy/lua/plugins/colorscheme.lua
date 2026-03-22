return {
  -- 1. Install and configure Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      terminal_colors = true,
      contrast = "hard", -- options: "hard", "medium", "soft"
      transparent_mode = false,
    },
  },

  -- 2. Set it as the active theme for LazyVim
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
