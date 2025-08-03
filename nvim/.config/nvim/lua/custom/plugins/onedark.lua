return {
  'navarasu/onedark.nvim',
  lazy = false, -- Load the plugin immediately (optional, based on your preference)
  priority = 1000, -- Set a high priority if it's your main colorscheme
  config = function()
    require('onedark').setup {
      style = 'warmer', -- Example configuration (optional)
      transparent = true,
      colors = {
        grey = '#71737a',
      },
    }
    require('onedark').load()
  end,
}
