-- Define path for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Clone lazy.nvim if not already installed
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- Prepend the lazy.nvim path to runtime path
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with configurations
require("lazy").setup({
  { import = "rendi.plugins" },
}, {
  checker = {
    enabled = true,
    notify = false, -- Disable notifications for checker
  },
  change_detection = {
    notify = false, -- Disable notifications for change detection
  },
  performance = {
    rtp = {
      reset = false, -- Reset runtime path to reduce unnecessary paths
    },
  },
})

