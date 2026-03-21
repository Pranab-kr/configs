require "nvchad.options"

-- add yours here!

local o = vim.o

-- Folding settings
o.foldmethod = "indent"  -- Use indent-based folding
o.foldcolumn = "0"       -- Hide fold column (removes extra numbers)
o.foldlevel = 99         -- Start with all folds open
o.foldlevelstart = 99
o.foldenable = true

-- o.cursorlineopt ='both' -- to enable cursorline!
