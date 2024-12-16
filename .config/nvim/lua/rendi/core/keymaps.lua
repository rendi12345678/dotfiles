vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>xs", ":LspStop<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>as", ":LspStart<CR>", { noremap = true, silent = true })

-- LSP keybindings
local opts = { noremap=true, silent=true, desc = "Go to definition" }
keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

keymap.set("n", "<leader>dcc", [[:%s/\/\/.*//g<CR>]], { noremap = true, silent = true, desc = "Removes all comments in the file." })
keymap.set("n", "<leader>dcl", [[:%s/\n\{3,}/\r\r/e<CR>]], { noremap = true, silent = true, desc = "Collapses multiple consecutive empty lines into a single line." })
keymap.set("n", "<leader>sc", [[:/\/\/.*<CR>]], { noremap = true, silent = true, desc = "Search all comments." })

-- Cursor movements in insert mode
keymap.set('i', '<C-h>', '<Left>', { noremap = true, silent = true, desc = 'Move cursor left' })
keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true, desc = 'Move cursor right' })

-- Delete operations
keymap.set('i', '<C-d>', '<Delete>', { noremap = true, silent = true, desc = 'Delete the character before the cursor' })
keymap.set('i', '<C-w>', '<C-o>db<C-o>x', { noremap = true, silent = true, desc = 'Delete the word before the cursor' })
keymap.set('i', '<C-D>', '<C-o>dw', { noremap = true, silent = true, desc = 'Delete the word after the cursor' })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Select all
keymap.set("n", "<C-t>", "gg<S-v>G", { desc = "Select all" })

-- Keymaps that avoid affecting registers
keymap.set("n", "x", '"_x', { noremap = true, silent = true, desc = "Delete without affecting register" })
keymap.set("n", "<Leader>p", '""0"p', { noremap = true, silent = true, desc = "Paste from register 0" })
keymap.set("n", "<Leader>P", '""0"P', { noremap = true, silent = true, desc = "Paste from register 0 before cursor" })
keymap.set("v", "<Leader>p", '""0"p', { noremap = true, silent = true, desc = "Paste from register 0 in visual mode" })
keymap.set("n", "<Leader>c", '"_c', { noremap = true, silent = true, desc = "Change without affecting register" })
keymap.set("n", "<Leader>C", '"_C', { noremap = true, silent = true, desc = "Change to end of line without affecting register" })
keymap.set("v", "<Leader>c", '"_c', { noremap = true, silent = true, desc = "Change in visual mode without affecting register" })
keymap.set("v", "<Leader>C", '"_C', { noremap = true, silent = true, desc = "Change in visual mode to end of line" })
keymap.set("n", "<Leader>d", '"_d', { noremap = true, silent = true, desc = "Delete without affecting register" })
keymap.set("n", "<Leader>D", '"_D', { noremap = true, silent = true, desc = "Delete to end of line without affecting register" })
keymap.set("v", "<Leader>d", '"_d', { noremap = true, silent = true, desc = "Delete in visual mode without affecting register" })
keymap.set("v", "<Leader>D", '"_D', { noremap = true, silent = true, desc = "Delete to end of line in visual mode" })

-- Managing LazyDocker and Lazy.nvim
keymap.set("n", "<leader>ld", "<cmd>LazyDocker<CR>", { noremap = true, silent = true, desc = "Toggle LazyDocker" })
keymap.set("n", "<leader>ll", ":Lazy<CR>", { desc = "Open Lazy.nvim" })

-- Increment and decrement numbers
keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })

-- Manage marks
keymap.set('n', '<leader>ja', "'a", { noremap = true, silent = true, desc = "Jump to mark 'a'" })
keymap.set('n', '<leader>jA', "'A", { noremap = true, silent = true, desc = "Jump to global mark 'A'" })
keymap.set('n', '<leader>jb', "'b", { noremap = true, silent = true, desc = "Jump to mark 'b'" })
keymap.set('n', '<leader>jB', "'B", { noremap = true, silent = true, desc = "Jump to global mark 'B'" })
keymap.set('n', '<leader>jc', "'c", { noremap = true, silent = true, desc = "Jump to mark 'c'" })
keymap.set('n', '<leader>jC', "'C", { noremap = true, silent = true, desc = "Jump to global mark 'C'" })
keymap.set('n', '<leader>dm', ':delmarks ', { desc = "Delete mark" })
keymap.set('n', '<leader>lm', ':marks<CR>', { noremap = true, silent = true, desc = "List all marks" })

-- Zen Mode toggle
keymap.set("n", "<leader>zm", ":ZenMode<CR>", { desc = "Toggle Zen Mode" })

-- Set wrap/nowrap
keymap.set("n", "[w", ":set wrap<CR>", { desc = "Set wrap" })
keymap.set("n", "]w", ":set nowrap<CR>", { desc = "Set nowrap" })

-- Window management
keymap.set("n", "<leader>sw", "<C-w>w", { desc = "Switch window" })
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

