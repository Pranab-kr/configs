return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = {
      multi_window = true,
      forward = true,
      wrap = true,
    },
    jump = {
      jumplist = true,
      pos = "start",
      autojump = false,
    },
    label = {
      uppercase = false,
      rainbow = {
        enabled = true,
        shade = 5,
      },
    },
    modes = {
      search = {
        enabled = false,
      },
      char = {
        enabled = true,
        jump_labels = true,
        multi_line = true,
      },
      treesitter = {
        labels = "abcdefghijklmnopqrstuvwxyz",
        jump = { pos = "range" },
        label = { before = true, after = true },
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
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
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
