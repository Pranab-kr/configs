# Nvim Config

These notes are based on your actual config in `~/.config/nvim`, not generic Vim docs.

## Read This First

- `mapleader` is `Space`
- most custom actions are under `<leader>`
- some mappings only exist when LSP is attached
- some Git mappings only exist inside Fugitive buffers

## Notes

- [[Nvim Keybinds]]: the practical cheat sheet
- [[Nvim Hacks]]: the custom behaviors, workflow tricks, and mental models behind the setup

## Fast Memory Hooks

- movement polish: `J`, `n`, `N`, `<C-d>`, `<C-u>`
- editing polish: `<leader>d`, `x`, `p` in visual mode
- surround: `sa`, `ds`, `ca`
- search and replace: `<leader>sr`
- files and search: `fff.nvim` (`<leader>pf`, `<leader>ps`, `<leader>pgf`), Snacks (`<leader><space>`, `<leader>pb`, `<leader>pk`)
- markdown editing: `tn`, `tb`, `tc`, `tt`, `tl`, `<leader>tc`/`tu`, `<leader>h1`-`h6`
- folding: click ``/`` in gutter with mouse, or `za`, `zR`, `zM`
- formatting: `<leader>mp` or format-on-save via Conform (`isort`+`black` for Python, `prettier` for Markdown)
- window control: `<leader>s*` and `<leader>t*`
- git: `<leader>g*`, `<leader>gg`, `<leader>lg`
- LSP: `gd`, `gR`, `gi`, `gt`, `K`, `<leader>rn`, `<leader>vca`
- completion: `blink.cmp` default preset (`<C-y>` accept, `<C-n>`/`<C-p>` move)

## Source

- config root: `~/.config/nvim`
- main mapping file: `lua/pranab/core/keymaps.lua`
- plugin mappings are spread across `lua/pranab/plugins/*`

## Caelestia

- caelestia colorScheme added , it read from ~/.local/state/caelestia/scheme.json and patch the color when theme chages
