# Nvim Hacks

Parent note: [[Nvim Config]]

This note is for the custom ideas behind the config, not just raw keybinds.

See also: [[Nvim Keybinds]]

## Mapping Collision To Remember

`<leader>d` is overloaded.

- global meaning: black-hole delete
- LSP-attached normal buffer meaning: line diagnostics float
- visual mode still keeps the delete behavior

Mental model: if `d` suddenly opens diagnostics, you are in an LSP buffer and the normal-mode mapping was overridden locally.

## Register Protection

The config is built to stop small edits from destroying useful yank history.

- `x` deletes into the black hole register
- `<leader>d` deletes without saving into default register
- visual `p` replaces selection without losing what you copied before

Mental model: destructive edits should not poison your paste memory.

## Cursor Stability

Several mappings preserve visual context on purpose.

- `J` joins lines but keeps your cursor and view stable
- `<C-d>` and `<C-u>` re-center after moving
- `n` and `N` re-center after search jumps
- visual indenting with `<` and `>` keeps the selection active

Mental model: movement should not make you re-find your place.

## Search And Replace Flow

`<leader>sr` pre-fills a global substitute command using the word under cursor.

Why it helps:

- you avoid manually typing the target word
- the cursor lands near the flags so you can refine the command before running it

## Diagnostics Toggle

Virtual text diagnostics can be turned on and off on demand.

- `<leader>lx`: toggle inline virtual text diagnostics

Mental model:

- keep virtual text on while coding
- flip it off with `<leader>lx` when the inline noise gets distracting, and read details on demand with `<leader>d` (line float) or the Trouble lists

## Auto Inlay Hint Handling

Inlay hints start **disabled** on LSP attach and are opt-in per buffer.

- `<leader>ih`: toggle hints for the current buffer (only mapped when the server supports them)

Mental model: hints are there when you want extra type/parameter context, but they do not clutter the buffer by default.

## File Browsing Philosophy

You are using both Oil and MiniFiles for different reasons.

- `-` or `<leader>-` with Oil: quick parent-directory editing, float explorer, file operations
- `<leader>ee` or `<leader>ef` with MiniFiles: simple tree-style movement and reveal-current-file flow
- Oil also disables `<C-c>` closing behavior, so your escape habit does not accidentally kill the file browser

Mental model: Oil is for editing directories; MiniFiles is for browsing structure.

## Surround Editing

`mini.surround` handles brackets, quotes, and tags with `s`-prefixed verbs instead of the default `sa`/`sd` scheme being spread out.

- `sa` adds a surround (`saiw"` wraps the inner word in quotes)
- `ds` deletes a surround
- `ca` changes/replaces a surround
- `sf` / `sF` find the surround to the right / left
- `sh` highlights the matching surround

Mental model: think "surround add / delete / change" mapped onto `sa` / `ds` / `ca`, and note `ca` here is the surround-replace verb, not the built-in change-around.

## Picker Split

You use `fff.nvim`, Snacks, and Telescope for different jobs:

- **`fff.nvim`**: ultra-fast Rust-based file finder (`<leader>pf`) and live fuzzy grep (`<leader>ps`). Honors `.gitignore` and `.ignore`.
- **Snacks**: smart finder (`<leader><space>`), buffers (`<leader>pb`), keymaps (`<leader>pk`), Git branches, help, and TODOs.
- **Telescope**: LSP references/definitions and targeted queries like `WORD` grep.

Mental model: `fff.nvim` is your primary fast code finder; Snacks is the general picker/utility launcher; Telescope stays for LSP workflows.


## Git Workflow Opinions

The Git config has a few strong workflow choices.

- Fugitive opens in a dedicated fullscreen tab with `<leader>gg`
- pull inside Fugitive is wired to `--rebase`
- there is a shortcut for fixing upstream tracking with `<leader>t`
- Gitsigns gives hunk-level staging and reset without leaving the buffer
- Snacks handles Lazygit and branch picking

Mental model: quick local review in-buffer, deeper repo operations in dedicated Git UIs.

## Session Behavior

`auto-session` is installed, but auto-restore is disabled.

What that means:

- sessions are intentional, not automatic
- save with `<leader>ws`
- restore with `<leader>wr`

It avoids surprise state when jumping between unrelated folders.

## Formatting And Linting Split

Formatting and linting are separate on purpose.

- formatting runs on save through Conform (Python: `isort` + `black`, Markdown: `prettier`, Lua: `stylua`, Web: `biome-check`/`prettier`)
- `<leader>mp` forces formatting now (supports visual range format)
- linting auto-runs on `BufEnter`, `BufWritePost`, and `InsertLeave`
- `<leader>l` forces linting now

Mental model: format fixes structure; lint catches correctness and style issues.

## Whitespace Cleanup

Trailing whitespace cleanup is explicit.

- `<leader>cw` trims it
- highlight is automatically removed on cursor movement so it does not stay visually noisy

Small detail, but it keeps cleanup visible without being annoying.

## Markdown Productivity & Rendering

Markdown gets dedicated editing utilities and live preview:

- `after/ftplugin/markdown.lua` provides fast line and visual toggles for numbers (`tn`), bullets (`tb`), checkboxes (`tc`), task completion (`tt`), smart lists (`tl`), and headings (`<leader>h1`-`h6`).
- `render-markdown.nvim` delivers live in-buffer rendering (concealing raw markdown syntax and styling headings, code blocks, tables, and checkboxes) with dynamic colors that inherit directly from your active theme.

## TODO System

Your TODO setup is more than plain `TODO:`.

Recognized tags include:

- `FIX`, `TODO`, `HACK`, `WARN`, `PERF`, `NOTE`, `TEST`, `FORGETNOT`
- aliases also exist, like `FIXME`, `BUG`, `ISSUE`, `WARNING`, `XXX`, `INFO`, `READ`, `Custom`

You can navigate with `[t` and `]t`, open a larger list with `<leader>xt`, inspect all TODOs with `<leader>pt`, or focus the main keywords with `<leader>pT`.

## Folding Setup

Folding uses `nvim-ufo` backed by Treesitter and indent fallback, paired with `statuscol.nvim`:

- folds start effectively open because `foldlevel` and `foldlevelstart` are high
- `statuscol.nvim` provides clean gutter arrows (`` open, `` closed) without ugly fold-level digits
- clicking the arrow with your mouse folds / unfolds the block directly
- keyboard fold commands: `za` (toggle), `zM` (close all), `zR` (open all)

Mental model: folding is clickable in the gutter like a modern IDE, or driven by keyboard when preferred.


## Completion Behavior

Completion moved from `nvim-cmp` to `blink.cmp`, running its stock `default` preset (plus a `cmdline` preset for the command line).

- `<C-y>` accepts, `<C-n>`/`<C-p>` move, `<C-e>` hides — no custom `Tab`/`Enter` remapping
- `Tab`/`S-Tab` only jump within snippets (LuaSnip + friendly-snippets)
- auto-brackets fire on accept, so accepting a function inserts its parentheses
- documentation auto-shows; ghost text is intentionally off to keep the buffer clean
- the Rust fuzzy matcher (`prefer_rust`) is used for ranking

Mental model: completion is now the boring, predictable default set rather than a hand-tuned `Tab` state machine — fewer surprises, standard blink muscle memory.

## Buffer Cycling vs Jumplist (<S-h> / <S-l> vs <Tab> / <C-i>)

Buffer cycling uses `<S-l>` (next buffer) and `<S-h>` (previous buffer) instead of `<Tab>` and `<S-Tab>`.

Why this matters:
- In terminal emulators, `<C-i>` and `<Tab>` send the exact same ASCII byte sequence (`0x09`).
- When `<Tab>` is mapped in normal mode, Neovim intercepts `<C-i>` as `<Tab>`, hijacking your forward jump in the jumplist.
- Moving buffer cycling to `<S-l>` and `<S-h>` leaves `<C-i>` completely unshadowed, ensuring `<C-o>` (jump back) and `<C-i>` (jump forward) both work reliably across all jumps.

Mental model: `<S-h>` and `<S-l>` slide left/right across buffers, keeping `<C-o>` / `<C-i>` exclusively for your historical jump stack.

## Flash Navigation & Remote Operations

`flash.nvim` provides fast 2-character / fuzzy label-based motion jumping across windows and syntax trees.

Key capabilities:
- `s`: regular Flash jump. Type search characters, then the displayed label to land instantly.
- `S`: Flash Treesitter. Highlights syntax tree scopes around your cursor so you can jump to or visually select enclosing code blocks with one keystroke.
- `r` (Remote Flash in operator-pending mode): perform an operation on a distant target without moving your cursor (e.g. `yr{search}{label}` to yank text elsewhere while staying in place).
- `jumplist = true`: every flash jump automatically registers in the jumplist, so you can bounce back with `<C-o>` and return with `<C-i>`.

Mental model: search motions replace repetitive `w`/`b`/`f`/`t` movements with a direct 2-step hop to any visible position.
