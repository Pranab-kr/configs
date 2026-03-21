require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyzer", "clangd", "ts_ls", "tailwindcss", "eslint", "emmet_ls" }
vim.lsp.enable(servers)

-- Emmet LSP for HTML/JSX/TSX snippets
vim.lsp.config("emmet_ls", {
  filetypes = {
    "html", "css", "scss",
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
  },
})

-- Configure clangd for C/C++
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
  },
})

-- Configure rust-analyzer with inlay hints
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        typeHints = { enable = true },
        parameterHints = { enable = true },
        chainingHints = { enable = true },
      },
    },
  },
})

-- TypeScript/JavaScript LSP (ts_ls)
vim.lsp.config("ts_ls", {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

-- Tailwind CSS LSP
vim.lsp.config("tailwindcss", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidScreen = "error",
        invalidVariant = "error",
        invalidConfigPath = "error",
        invalidTailwindDirective = "error",
        recommendedVariantOrder = "warning",
      },
      experimental = {
        classRegex = {
          { "tw`([^`]*)", "tw`([^`]*)" },
          { 'tw="([^"]*)"', '([^"]*)' },
          { 'tw=\\{"([^"}]*)"\\}', '([^"]*)' },
        },
      },
    },
  },
})

-- ESLint LSP
vim.lsp.config("eslint", {
  settings = {
    workingDirectories = { mode = "auto" },
  },
  on_attach = function(client, bufnr)
    -- Auto-fix on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- read :h vim.lsp.config for changing options of lsp servers
