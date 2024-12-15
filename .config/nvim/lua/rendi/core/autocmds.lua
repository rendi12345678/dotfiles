-- Filetype detection for Dockerfiles
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = { "Dockerfile", "DockerFile*" },
  command = "set filetype=dockerfile"
})

-- Automatically set filetype for .jsx files to javascript
-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--   pattern = "*.jsx",
--   callback = function()
--     vim.bo.filetype = "javascript"
--   end
-- })
--
-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--   pattern = "*.tsx",
--   callback = function()
--     vim.bo.filetype = "typescript"
--   end
-- })
--

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste"
})

-- Disable concealing in specific file formats
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end
})



