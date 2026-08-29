# LazyVim Cheat Sheet

## Core Navigation

- `Ctrl + f` → Page down
    
- `Ctrl + d` → Half page down
    
- `Ctrl + b` → Page up
    
- `Ctrl + u` → Half page up
    
- `Ctrl + o` → Jump back
    
- `Ctrl + i` → Jump forward
    
- `gg` → First line
    
- `Shift + G` → Last line
    
- `:10` or `10gg` → Jump to line 10
    
- `10j` → Down 10 lines
    
- `10k` → Up 10 lines
    
- `J` → Join lines
    

---

## UI / UX

- `<leader>uC` → Colorscheme preview
    
- `<leader>uD` → Toggle code block dimming
    
- `<leader>ul` → Toggle line number
    
- `<leader>uL` → Toggle relative number
    
- `<leader>uw` → Toggle word wrap
    
- `Ctrl + /` → Toggle terminal
    
- `:Neotree` → Open file explorer
    

---

## Buffer Management

- `<leader>fb` → List open buffers
    
- `Shift + l` → Next buffer
    
- `Shift + h` → Previous buffer
    
- `]b` → Next buffer
    
- `[b` → Previous buffer
    
- `<leader>bd` → Close current buffer
    

### Split Windows

- `Ctrl + w v` → Vertical split
    
- `Ctrl + w s` → Horizontal split
    
- `Ctrl + w h/j/k/l` → Move between splits
    

---

## Text Objects

- `viw` → Select word
    
- `vi"` → Select inside quotes
    
- `vi{` → Select inside braces
    
- `vip` → Select paragraph
    
- `va[` → Select around brackets
    
- `dap` → Delete paragraph
    

---

## Code Folding

- `zR` or `zi` → Open all folds
    
- `zM` → Close all folds
    
- `za` → Toggle fold
    
- `zA` → Toggle nested folds
    
- `zc` → Close fold
    
- `zo` → Open fold
    
- `zO` → Open nested folds
    

---

## Marks / Bookmarks

- `<leader>sm` → Show marks
    
- `m[a-z]` → Set mark
    
- `'[a-z]` → Jump to mark
    
- `''` → Last position
    
- `` `[a-z] `` → Exact mark position
    
- `:delmarks a-z` → Delete lowercase marks
    
- `:delmarks!` → Delete all marks except special
    

---

## LSP / Code Symbols

- `:LspInfo` → Show LSP info
    
- `<leader>cs` → Document symbols
    
- `gr` → References
    
- `gd` → Definition
    
- `gD` → Declaration
    
- `gy` → Type definition
    
- `K` → Hover docs
    
- `[[` / `]]` → Prev / Next reference
    

---

## Diagnostics

- `]d` → Next diagnostic
    
- `[d` → Previous diagnostic
    
- `<leader>sd` → File diagnostics
    
- `<leader>sD` → Workspace diagnostics
    

---

## Code Actions

- `<leader>cr` → Rename symbol
    
- `<leader>cf` → Format file
    
- `<leader>ca` → Code actions
    

---

## Indentation

- `>` → Indent right
    
- `<` → Indent left
    
- `=` → Auto-indent
    
- `=ip` → Indent paragraph
    
- `gg=G` → Format full file
    

---

## Search

- `<leader>sr` → Search & replace
    
- `<leader>fc` → Find config files
    
- `<leader>ff` → Find files
    
- `<leader>/` → Grep root
    
- `<leader>sG` → Grep cwd
    
- `<leader>ss` → Symbol search
    
- `<leader>sc` → Command history
    
- `<leader>sw` → Search word under cursor
    
- `<leader>sk` → Search keymaps
    
- `<leader>st` → Search TODOs
    

---

## Git (fzf-lua)

- `<leader>gc` → Commit log search
    
- `<leader>gs` → Git status
    
- `<leader>ge` → Git explorer
    
- `<leader>gf` → File history
    

---

## LazyGit

- `<leader>gg` → Open LazyGit
    
- `Ctrl + r` → Recent repo
    
- `Ctrl + b` → Filter files
    
- `p` → Pull
    
- `P` → Push
    
- `Space` → Stage
    
- `a` → Stage all
    
- `c` → Commit
    
- `s` → Stash
    
- `z` → Undo
    
- `Ctrl + z` → Redo
    
- `i` → Add to `.gitignore`
    
- `q` → Quit
    

---

# Personal Daily Must-Remember (Recommended ⭐)

- `gd`
    
- `gr`
    
- `<leader>ff`
    
- `<leader>/`
    
- `<leader>ca`
    
- `<leader>cf`
    
- `<leader>bd`
    
- `<leader>gg`
    
- `Ctrl + /`
