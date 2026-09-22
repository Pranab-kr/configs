# Nvim Keybinds

Parent note: [[Nvim Config]]

`<leader>` = `Space`

## Everyday Editing

- `J` in normal mode: join line below without moving your view
- `J` in visual mode: move selected lines down
- `K` in visual mode: move selected lines up
- `<` in visual mode: indent left and keep selection
- `>` in visual mode: indent right and keep selection
- `x`: delete character without polluting registers
- `p` in visual mode: paste over selection without losing the yanked text
- `<leader>d`: delete to black hole register in visual mode, and in normal mode when no buffer-local LSP override is active
- `<C-c>` in insert mode: escape
- `<C-c>` in normal mode: clear search highlight
- `<leader>sr`: global search and replace for word under cursor
- `<leader>X`: make current file executable
- `<leader>ff`: LSP format current file
- `<leader>mp`: format file or visual selection with Conform (Python: `isort` + `black`, Markdown: `prettier`, Lua: `stylua`, Web: `biome`/`prettier`)
- `<leader>cw`: trim trailing whitespace
- `sj`: join arguments or split structures back together
- `sk`: split arguments or structures across lines
- `<leader>xe`: wrap selection or target with Emmet abbreviation

## Surround (mini.surround)

- `sa`: add surrounding in normal and visual mode (e.g. `saiw"` surrounds a word with quotes)
- `ds`: delete surrounding
- `ca`: replace/change surrounding
- `sf`: find surrounding to the right
- `sF`: find surrounding to the left
- `sh`: highlight surrounding
- `sn`: update `n_lines`

## Movement

- `<C-d>`: half-page down and re-center
- `<C-u>`: half-page up and re-center
- `n`: next search result and re-center
- `N`: previous search result and re-center
- `<C-o>`: jump backward in jumplist (previous location)
- `<C-i>`: jump forward in jumplist (next location)

## Flash (Navigation & Motions)

- `s`: Flash jump (fuzzy multi-window search motion with labels)
- `S`: Flash Treesitter (select syntax tree nodes)
- `r` in operator-pending mode: Remote Flash (operate on a distant target without moving cursor)
- `R` in operator/visual mode: Treesitter Search
- `<C-s>` in command-line search mode: toggle Flash search on/off during regular `/` or `?`

## Buffers, Tabs, And Splits

- `<S-l>`: next buffer (BufferLine)
- `<S-h>`: previous buffer (BufferLine)
- `<leader>to`: new tab
- `<leader>tx`: close current tab
- `<leader>tn`: next tab
- `<leader>tp`: previous tab
- `<leader>tf`: open current buffer in a new tab
- `<leader>sv`: vertical split
- `<leader>sh`: horizontal split
- `<leader>se`: equalize split sizes
- `<leader>sx`: close current split
- `<leader>sm`: maximize or restore current split

## Files And Navigation

- `-`: open parent directory in Oil
- `<leader>-`: toggle Oil float
- `<leader>ee`: open MiniFiles explorer
- `<leader>ef`: open MiniFiles focused on current file
- `<leader>el`: open the Snacks file explorer
- `<leader>fp`: copy current file path to clipboard
- `<leader>ft`: toggle floating terminal (Snacks)
- `<leader>pf`: fast file search (fff.nvim)
- `<leader>ps`: live fuzzy grep (fff.nvim)
- `<leader>pgf`: find files in git root (fff.nvim)
- `<leader>pcf`: find files in Neovim config (fff.nvim)
- `<leader><space>`: smart find files (Snacks picker)
- `<leader>pb`: find buffer with Snacks picker
- `<leader>pws`: grep current word or visual selection (Snacks picker)
- `<leader>pWs`: grep current `WORD` under cursor with Telescope
- `<leader>pk`: search keymaps
- `<leader>pr`: recent files
- `<leader>pt`: pick all TODO comments in Snacks
- `<leader>pT`: pick main TODO-style keywords in Snacks
- `<leader>vh`: help pages
- `<esc>` in terminal mode: exit terminal insert mode

## Inside File Explorers

### Oil

- `<C-r>`: refresh
- `<M-h>`: open entry in a split
- `q`: close Oil
- `<C-c>` is intentionally disabled there so it does not close Oil

### MiniFiles

- `<CR>`: go into directory or open file
- `L`: go in with the alternate mapping
- `_`: go out
- `H`: go out with the alternate mapping

## LSP

These only exist after an LSP attaches to the buffer.

- `gR`: references
- `gD`: declaration
- `gd`: definitions
- `gi`: implementations
- `gt`: type definitions
- `K`: hover docs
- `<C-h>` in insert mode: signature help
- `<leader>vca`: code actions
- `<leader>rn`: rename symbol
- `<leader>D`: buffer diagnostics list
- `<leader>d`: line diagnostics float in normal mode for that LSP buffer
- `<leader>rs`: restart LSP (buffer-local, from within an LSP buffer)
- `<leader>ih`: toggle inlay hints when supported (they start disabled)
- `<leader>lx`: toggle virtual text diagnostics on and off

## Diagnostics And Trouble

- `<leader>xw`: workspace diagnostics in Trouble
- `<leader>xd`: current buffer diagnostics in Trouble
- `<leader>xq`: quickfix list in Trouble
- `<leader>xl`: location list in Trouble
- `<leader>xt`: TODO list in Trouble

## TODO Comments And Folds

- `]t`: next TODO-style comment
- `[t`: previous TODO-style comment
- `zR`: open all folds
- `zM`: close all folds
- `za`: toggle fold under cursor
- `Left Click` on `` / `` in gutter: click to fold / unfold block (statuscol.nvim)

## Markdown (inside Markdown buffers)

- `tn`: toggle numbered list on current line (or visual selection)
- `tb`: toggle bullet list on current line (or visual selection)
- `tc`: toggle checkbox on current line (or visual selection)
- `tt`: toggle task state (done/undone) on current line (or visual selection)
- `tl`: smart list toggle (cycles bullet -> checkbox -> number -> plain)
- `<leader>tc`: mark all tasks done in buffer
- `<leader>tu`: mark all tasks undone in buffer
- `<leader>h1` to `<leader>h6`: toggle heading levels H1 through H6
- formatted with `prettier` on save or `<leader>mp`


## Git

- `<leader>gg`: open Fugitive in a fullscreen tab
- `<leader>lg`: open Lazygit through Snacks
- `<leader>gl`: open Lazygit log view
- `<leader>gbr`: pick and switch branches
- `<leader>wl`: list Git worktrees
- `<leader>wc`: create Git worktree

## Gitsigns

- `]h`: next hunk
- `[h`: previous hunk
- `<leader>gs`: stage hunk
- `<leader>gr`: reset hunk
- `<leader>gS`: stage buffer
- `<leader>gR`: reset buffer
- `<leader>gu`: undo staged hunk
- `<leader>gp`: preview hunk
- `<leader>gbl`: full blame for current line
- `<leader>gB`: toggle current line blame
- `<leader>gd`: diff current file
- `<leader>gD`: diff against `~`
- `ih`: Git hunk text object

## Sessions And Utilities

- `<leader>wr`: restore session for current working directory
- `<leader>ws`: save session
- `<leader>u`: toggle Undotree
- `<leader>l`: trigger lint manually
- `<leader>th`: colorscheme picker
- `<leader>ths`: Telescope theme switcher
- `<leader>rN`: rename current file fast
- `<leader>bd`: delete or close buffer with confirmation
- `<leader>bD`: delete all buffers
- `<leader>lr`: restart LSP (global, with a notification)
- `<leader>re`: restart Neovim (`:restart`)

## Telescope Picker UI

- `<C-j>` in Telescope insert mode: move selection down
- `<C-k>` in Telescope insert mode: move selection up

## Completion Menu

Completion is now handled by `blink.cmp` using its `default` keymap preset (sources: LSP, path, buffer, snippets via LuaSnip). Cmdline completion is enabled with the `cmdline` preset.

- `<C-y>`: accept the selected completion
- `<C-n>`: next completion item
- `<C-p>`: previous completion item
- `<C-e>`: hide the completion menu
- `<C-Space>`: open completion / toggle documentation
- `<C-b>`: scroll documentation up
- `<C-f>`: scroll documentation down
- `<C-k>`: toggle signature help
- `<Tab>`: jump forward in snippet
- `<S-Tab>`: jump backward in snippet

Auto-brackets on accept are enabled; ghost text is off.

## Fugitive Buffer Only

These work when you are inside a Fugitive buffer.

- `<leader>P`: `Git push`
- `<leader>p`: `Git pull --rebase`
- `<leader>t`: `Git push -u origin ...`
