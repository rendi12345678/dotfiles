return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")

    substitute.setup()

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>s", substitute.operator, { desc = "Substitute with motion" }) -- Use <leader>s instead of s
    keymap.set("n", "<leader>ss", substitute.line, { desc = "Substitute line" })          -- Use <leader>ss instead of ss
    keymap.set("n", "<leader>S", substitute.eol, { desc = "Substitute to end of line" })   -- Use <leader>S instead of S
    keymap.set("x", "<leader>s", substitute.visual, { desc = "Substitute in visual mode" }) -- Use <leader>s in visual mode instead of s
  end,
}
