return {
  -- 1. Install and configure Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      terminal_colors = true,
      contrast = "medium", -- options: "hard", "medium", "soft"
      transparent_mode = false,
    },
  },

  -- 2. Nordic theme

  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("nordic")
    end,
  },

  -- 2. Set it as the active theme for LazyVim
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nordic",
    },
  },
}
