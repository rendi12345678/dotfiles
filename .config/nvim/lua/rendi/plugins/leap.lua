return {
  "ggandor/leap.nvim",
  config = function()
    local leap = require('leap')
    -- Disable default mappings
    leap.set_default_keymaps(false)

    -- Add custom mappings with the `z` prefix
    vim.keymap.set({'n', 'x', 'o'}, 'zs', function() leap.leap({}) end, {desc = "Leap forward"})
    vim.keymap.set({'n', 'x', 'o'}, 'zS', function() leap.leap({backward = true}) end, {desc = "Leap backward"})
    vim.keymap.set({'n', 'x', 'o'}, 'zx', '<Plug>(leap-from-window)')
  end,
}