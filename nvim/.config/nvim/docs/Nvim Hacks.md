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

You are using both Snacks and Telescope, but for different jobs.

- Snacks is the default picker layer for files, grep, keymaps, Git branches, help, colorschemes, and TODO lists
- Telescope is still used for LSP references/definitions and a couple of targeted commands like recent files and `WORD` grep

Mental model: Snacks is the general launcher; Telescope stays for LSP-heavy or already-working flows.

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

- formatting runs on save through Conform
- `<leader>mp` forces formatting now
- linting auto-runs on `BufEnter`, `BufWritePost`, and `InsertLeave`
- `<leader>l` forces linting now

Mental model: format fixes structure; lint catches correctness and style issues.

## Whitespace Cleanup

Trailing whitespace cleanup is explicit.

- `<leader>cw` trims it
- highlight is automatically removed on cursor movement so it does not stay visually noisy

Small detail, but it keeps cleanup visible without being annoying.

## TODO System

Your TODO setup is more than plain `TODO:`.

Recognized tags include:

- `FIX`, `TODO`, `HACK`, `WARN`, `PERF`, `NOTE`, `TEST`, `FORGETNOT`
- aliases also exist, like `FIXME`, `BUG`, `ISSUE`, `WARNING`, `XXX`, `INFO`, `READ`, `Custom`

You can navigate with `[t` and `]t`, open a larger list with `<leader>xt`, inspect all TODOs with `<leader>pt`, or focus the main keywords with `<leader>pT`.

## Folding Setup

Folding uses `nvim-ufo` with Treesitter plus indent fallback.

- folds start effectively open because `foldlevel` and `foldlevelstart` are high
- `zM` closes all
- `zR` opens all

Mental model: folding is available when you need it, not forced on you at startup.

## Completion Behavior

Completion moved from `nvim-cmp` to `blink.cmp`, running its stock `default` preset (plus a `cmdline` preset for the command line).

- `<C-y>` accepts, `<C-n>`/`<C-p>` move, `<C-e>` hides — no custom `Tab`/`Enter` remapping
- `Tab`/`S-Tab` only jump within snippets (LuaSnip + friendly-snippets)
- auto-brackets fire on accept, so accepting a function inserts its parentheses
- documentation auto-shows; ghost text is intentionally off to keep the buffer clean
- the Rust fuzzy matcher (`prefer_rust`) is used for ranking

Mental model: completion is now the boring, predictable default set rather than a hand-tuned `Tab` state machine — fewer surprises, standard blink muscle memory.
