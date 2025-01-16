return {
  "ggandor/leap.nvim",
  config = function()
    local leap = require("leap")

    leap.set_default_keymaps()

    -- Add custom mappings with the `z` prefix to avoid conflicts
    -- vim.keymap.set({'n', 'x', 'o'}, 's', function() leap.leap({}) end, {desc = "Leap forward"})
    -- vim.keymap.set({'n', 'x', 'o'}, 'S', function() leap.leap({backward = true}) end, {desc = "Leap backward"})
    -- vim.keymap.set({'n', 'x', 'o'}, 'zx', '<Plug>(leap-from-window)')
  end,
}
