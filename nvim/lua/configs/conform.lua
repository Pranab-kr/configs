local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    -- Web dev (React, Next.js, TypeScript, JavaScript)
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    markdown = { "prettier" },
    yaml = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return options
