return {
  "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").toggle({
      window = {
        width = 1
      }
    })
  end
}
