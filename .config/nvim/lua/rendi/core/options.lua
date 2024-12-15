vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.guicursor = ""

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 2      -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2   -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.smarttab = true
opt.cmdheight = 0
opt.breakindent = true
opt.linebreak = true
opt.laststatus = 3

opt.pumheight = 15
opt.pumwidth = 20

opt.wrap = false

-- Set the maximum column for syntax highlighting to 200
-- opt.synmaxcol = 200

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Function to get the Git branch, if available
function GetGitBranch()
    local git_branch = vim.fn.systemlist('git rev-parse --abbrev-ref HEAD 2>/dev/null')[1]
    if vim.fn.empty(git_branch) == 1 then
        return ""
    end
    return git_branch
end

-- Function to build the simplified status line
function StatusLine()
    local mode = vim.fn.mode() -- Get current mode (normal, insert, etc.)
    local file_name = vim.fn.expand('%:t') -- File name
    local git_branch = GetGitBranch() -- Get Git branch, if any
    local line_number = vim.fn.line('.') -- Current line number
    local col_number = vim.fn.col('.') -- Current column number

    -- Build the status line string
    local status = string.format("%s | %s | %d:%d", mode, file_name, line_number, col_number)

    -- Append Git branch if we are in a Git repository
    if git_branch ~= "" then
        status = status .. " | " .. git_branch
    end

    return status
end

-- Set custom statusline function
vim.o.statusline = "%!v:lua.StatusLine()"

-- Optional: Make the background transparent to reduce distraction
vim.cmd([[hi StatusLine guibg=NONE]])  -- Transparent background
vim.cmd([[hi StatusLineNC guibg=NONE]]) -- Transparent background for inactive windows
