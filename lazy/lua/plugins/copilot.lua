return {
  "zbirenbaum/copilot.lua",
  opts = function(_, opts)
    opts.suggestion = opts.suggestion or {}

    opts.suggestion.enabled = true
    opts.suggestion.auto_trigger = true

    opts.suggestion.keymap = vim.tbl_extend("force", opts.suggestion.keymap or {}, {
      accept = "<M-l>",
      accept_word = "<M-w>",
      accept_line = "<M-j>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    })
  end,
}
