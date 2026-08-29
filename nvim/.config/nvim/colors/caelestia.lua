-- Colorscheme built from caelestia's scheme.json, reloaded on wallpaper change.

local state_home = vim.env.XDG_STATE_HOME or ((vim.env.HOME or vim.fn.expand("~")) .. "/.local/state")
local scheme_dir = state_home .. "/caelestia"
local scheme_path = scheme_dir .. "/scheme.json"
local uv = vim.uv or vim.loop

local required = {
  "surface", "surfaceContainer", "surfaceContainerLow", "surfaceContainerHigh",
  "surfaceContainerHighest", "onSurface", "onSurfaceVariant", "outline", "outlineVariant",
  "primary", "onPrimary", "primaryContainer", "onPrimaryContainer",
  "tertiary", "onTertiary", "tertiaryContainer", "onTertiaryContainer", "error",
  "term1", "term2", "term3", "term4", "term5", "term6",
}

local function read_scheme()
  local file = io.open(scheme_path, "r")
  if not file then return nil end
  local raw = file:read("*a")
  file:close()
  local ok, data = pcall(vim.json.decode, raw)
  if not ok or type(data) ~= "table" or type(data.colours) ~= "table" then return nil end

  local palette = {}
  for name, colour in pairs(data.colours) do
    if type(colour) == "string" and colour:match("^%x%x%x%x%x%x$") then
      palette[name] = "#" .. colour
    end
  end
  for _, name in ipairs(required) do
    if not palette[name] then return nil end
  end
  return palette, data.mode == "light" and "light" or "dark"
end

local function blend(first, second, alpha)
  local function rgb(hex)
    return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
  end
  local r1, g1, b1 = rgb(first)
  local r2, g2, b2 = rgb(second)
  return string.format("#%02x%02x%02x", math.floor(r1 * alpha + r2 * (1 - alpha)), math.floor(g1 * alpha + g2 * (1 - alpha)), math.floor(b1 * alpha + b2 * (1 - alpha)))
end

local function apply(palette, mode)
  if not palette then return end
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
  vim.o.background = mode or "dark"
  vim.g.colors_name = "caelestia"

  local transparent = vim.g.caelestia_transparent ~= false
  local bg = transparent and "NONE" or palette.surface
  local container = transparent and "NONE" or palette.surfaceContainer
  local container_low = transparent and "NONE" or palette.surfaceContainerLow
  local hl = function(group, spec) vim.api.nvim_set_hl(0, group, spec) end

  hl("Normal", { fg = palette.onSurface, bg = bg })
  hl("NormalNC", { fg = palette.onSurface, bg = bg })
  hl("NormalFloat", { fg = palette.onSurface, bg = container })
  hl("FloatBorder", { fg = palette.outline, bg = "NONE" })
  hl("FloatTitle", { fg = palette.primary, bold = true })
  hl("CursorLine", { bg = palette.surfaceContainerHigh })
  hl("CursorLineNr", { fg = palette.primary, bold = true })
  hl("LineNr", { fg = palette.outline })
  hl("SignColumn", { bg = bg })
  hl("WinSeparator", { fg = palette.outlineVariant })
  hl("VertSplit", { fg = palette.outlineVariant })
  hl("MatchParen", { fg = palette.primary, bold = true, underline = true })
  hl("NonText", { fg = palette.outline })
  hl("Whitespace", { fg = palette.outlineVariant })
  hl("ColorColumn", { bg = palette.surfaceContainer })
  hl("Folded", { fg = palette.onSurfaceVariant, bg = palette.surfaceContainer })
  hl("Conceal", { fg = palette.onSurfaceVariant })
  hl("Visual", { fg = palette.onPrimaryContainer, bg = palette.primaryContainer })
  hl("VisualNOS", { fg = palette.onPrimaryContainer, bg = palette.primaryContainer })
  hl("Search", { fg = palette.onTertiaryContainer, bg = palette.tertiaryContainer })
  hl("IncSearch", { fg = palette.onPrimary, bg = palette.primary })
  hl("CurSearch", { fg = palette.onPrimary, bg = palette.primary })
  hl("Pmenu", { fg = palette.onSurface, bg = palette.surfaceContainerHigh })
  hl("PmenuSel", { fg = palette.onPrimaryContainer, bg = palette.primaryContainer, bold = true })
  hl("PmenuSbar", { bg = palette.surfaceContainerHighest })
  hl("PmenuThumb", { bg = palette.outline })
  hl("StatusLine", { fg = palette.onSurface, bg = container })
  hl("StatusLineNC", { fg = palette.onSurfaceVariant, bg = container_low })
  hl("TabLineSel", { fg = palette.primary, bg = bg, bold = true })
  hl("WinBar", { fg = palette.onSurfaceVariant, bg = bg })

  hl("SpellBad", { sp = palette.error, undercurl = true })
  hl("SpellCap", { sp = palette.term3, undercurl = true })
  hl("SpellRare", { sp = palette.term5, undercurl = true })
  hl("SpellLocal", { sp = palette.term6, undercurl = true })
  hl("DiffAdd", { bg = blend(palette.term2, palette.surface, 0.25) })
  hl("DiffChange", { bg = blend(palette.term3, palette.surface, 0.20) })
  hl("DiffDelete", { bg = blend(palette.term1, palette.surface, 0.25) })
  hl("DiffText", { bg = blend(palette.term3, palette.surface, 0.45) })

  hl("Comment", { fg = palette.onSurfaceVariant, italic = true })
  hl("String", { fg = palette.term2 })
  hl("Number", { fg = palette.term3 })
  hl("Boolean", { fg = palette.term3 })
  hl("Constant", { fg = palette.term3 })
  hl("Function", { fg = palette.term4 })
  hl("Statement", { fg = palette.term5 })
  hl("Operator", { fg = palette.term6 })
  hl("Type", { fg = palette.term3 })
  hl("PreProc", { fg = palette.term1 })
  hl("Special", { fg = palette.term6 })
  hl("Delimiter", { fg = palette.onSurfaceVariant })
  hl("Error", { fg = palette.error })
  hl("Todo", { fg = palette.onTertiary, bg = palette.tertiary, bold = true })
  hl("Title", { fg = palette.primary, bold = true })
  hl("Identifier", { fg = palette.onSurface })

  local groups = {
    ["@variable"] = { fg = palette.onSurface }, ["@variable.builtin"] = { fg = palette.term5 },
    ["@variable.parameter"] = { fg = palette.onSurface }, ["@variable.member"] = { fg = palette.onSurface },
    ["@property"] = { fg = palette.onSurface }, ["@function"] = { fg = palette.term4 },
    ["@function.builtin"] = { fg = palette.term5 }, ["@function.macro"] = { fg = palette.term1 },
    ["@constructor"] = { fg = palette.term3 }, ["@keyword"] = { fg = palette.term5 },
    ["@keyword.return"] = { fg = palette.term5, bold = true }, ["@string.escape"] = { fg = palette.term6 },
    ["@type.builtin"] = { fg = palette.term3, italic = true }, ["@tag"] = { fg = palette.term4 },
    ["@tag.attribute"] = { fg = palette.onSurface }, ["@namespace"] = { fg = palette.term3 },
    ["@punctuation.bracket"] = { fg = palette.onSurfaceVariant }, ["@markup.heading"] = { fg = palette.primary, bold = true },
    ["@markup.link"] = { fg = palette.term4, underline = true }, ["@diff.plus"] = { fg = palette.term2 },
    ["@diff.minus"] = { fg = palette.term1 },
    ["DiagnosticError"] = { fg = palette.error }, ["DiagnosticWarn"] = { fg = palette.term3 },
    ["DiagnosticInfo"] = { fg = palette.term4 }, ["DiagnosticHint"] = { fg = palette.term6 }, ["DiagnosticOk"] = { fg = palette.term2 },
    ["DiagnosticUnderlineError"] = { sp = palette.error, undercurl = true }, ["DiagnosticUnderlineWarn"] = { sp = palette.term3, undercurl = true },
    ["DiagnosticUnderlineInfo"] = { sp = palette.term4, undercurl = true }, ["DiagnosticUnderlineHint"] = { sp = palette.term6, undercurl = true },
    ["DiagnosticUnderlineOk"] = { sp = palette.term2, undercurl = true },
    ["DiagnosticVirtualTextError"] = { fg = palette.error, bg = blend(palette.error, palette.surface, 0.15) },
    ["DiagnosticVirtualTextWarn"] = { fg = palette.term3, bg = blend(palette.term3, palette.surface, 0.15) },
    ["DiagnosticVirtualTextInfo"] = { fg = palette.term4, bg = blend(palette.term4, palette.surface, 0.15) },
    ["DiagnosticVirtualTextHint"] = { fg = palette.term6, bg = blend(palette.term6, palette.surface, 0.15) },
    ["DiagnosticVirtualTextOk"] = { fg = palette.term2, bg = blend(palette.term2, palette.surface, 0.15) },
    ["Directory"] = { fg = palette.term4 }, ["NeoTreeDirectoryName"] = { fg = palette.term4 }, ["NeoTreeDirectoryIcon"] = { fg = palette.term4 },
    ["NeoTreeFileName"] = { fg = palette.onSurface }, ["NeoTreeFileNameOpened"] = { fg = palette.primary, bold = true },
    ["NeoTreeRootName"] = { fg = palette.primary, bold = true, italic = true }, ["NeoTreeSymbolicLinkTarget"] = { fg = palette.term6 },
    ["NeoTreeDotfile"] = { fg = palette.outline }, ["NeoTreeHiddenByName"] = { fg = palette.outline },
    ["NeoTreeIndentMarker"] = { fg = palette.outlineVariant }, ["NeoTreeExpander"] = { fg = palette.outline },
    ["NeoTreeModified"] = { fg = palette.term3 }, ["NeoTreeGitModified"] = { fg = palette.term3 },
    ["NeoTreeGitAdded"] = { fg = palette.term2 }, ["NeoTreeGitDeleted"] = { fg = palette.term1 },
    ["NeoTreeGitUntracked"] = { fg = palette.term2, italic = true }, ["NeoTreeGitIgnored"] = { fg = palette.outline },
    ["NeoTreeGitConflict"] = { fg = palette.error, bold = true }, ["NeoTreeGitStaged"] = { fg = palette.term2 },
    ["NeoTreeGitUnstaged"] = { fg = palette.term1 }, ["GitSignsAdd"] = { fg = palette.term2 },
    ["GitSignsChange"] = { fg = palette.term3 }, ["GitSignsDelete"] = { fg = palette.term1 },
    ["MiniIconsAzure"] = { fg = palette.term4 }, ["MiniIconsBlue"] = { fg = palette.term4 }, ["MiniIconsCyan"] = { fg = palette.term6 },
    ["MiniIconsGreen"] = { fg = palette.term2 }, ["MiniIconsGrey"] = { fg = palette.onSurfaceVariant }, ["MiniIconsOrange"] = { fg = palette.term1 },
    ["MiniIconsPurple"] = { fg = palette.term5 }, ["MiniIconsRed"] = { fg = palette.error }, ["MiniIconsYellow"] = { fg = palette.term3 },
  }
  for group, spec in pairs(groups) do hl(group, spec) end
  for _, group in ipairs({ "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeEndOfBuffer", "TelescopeNormal", "TelescopePromptNormal", "TelescopeResultsNormal", "TelescopePreviewNormal", "LazyNormal", "MasonNormal", "WhichKeyFloat", "WhichKeyNormal", "SnacksDashboardNormal", "SnacksPickerNormal" }) do hl(group, { bg = container }) end
  for _, group in ipairs({ "TelescopeBorder", "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder", "NeoTreeFloatBorder", "SnacksPickerBorder" }) do hl(group, { fg = palette.outline, bg = "NONE" }) end
  hl("TelescopeSelection", { bg = palette.surfaceContainerHigh, bold = true })
  hl("TelescopeMatching", { fg = palette.primary, bold = true })
  hl("TelescopePromptPrefix", { fg = palette.primary })
  hl("@lsp.type.namespace", { link = "@namespace" })
  hl("@lsp.type.type", { link = "@type" })
  hl("@lsp.type.class", { link = "@type" })
  hl("@lsp.type.parameter", { link = "@variable.parameter" })
  hl("@lsp.type.property", { link = "@property" })
  hl("@lsp.type.enumMember", { link = "@number" })
  hl("@lsp.type.function", { link = "@function" })
  hl("@lsp.type.method", { link = "@function" })
  hl("@lsp.type.macro", { link = "@function.macro" })
  hl("@lsp.typemod.variable.readonly", { fg = palette.term3 })
end

local verify_timer
local function read_apply()
  if vim.g.colors_name ~= "caelestia" then return true end
  local palette, mode = read_scheme()
  if not palette then return false end
  apply(palette, mode)
  pcall(vim.api.nvim_exec_autocmds, "ColorScheme", { pattern = "caelestia", modeline = false })
  return true
end

local function trigger()
  pcall(read_apply)
  if verify_timer and not verify_timer:is_closing() then verify_timer:stop(); verify_timer:close() end
  local timer = uv.new_timer()
  verify_timer = timer
  timer:start(250, 0, vim.schedule_wrap(function()
    if not timer:is_closing() then timer:close() end
    if verify_timer == timer then verify_timer = nil end
    pcall(read_apply)
  end))
end

local function watch()
  if vim.g.caelestia_watching then return end
  local handle = uv.new_fs_event()
  if not handle then return end
  local ok = handle:start(scheme_dir, {}, vim.schedule_wrap(function(err, filename)
    if not err and (filename == nil or filename == "scheme.json") then trigger() end
  end))
  if not ok then handle:close(); return end
  vim.g.caelestia_watching = true
end

local palette, mode = read_scheme()
if palette then
  apply(palette, mode)
else
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
  vim.g.colors_name = "caelestia"
end
watch()
