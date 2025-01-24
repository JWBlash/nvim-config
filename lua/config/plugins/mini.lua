-- lua/config/plugins/mini.lua
return {
  {
    'echasnovski/mini.nvim',
    enabled = true, -- you can use this to disable plugins on the fly
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true }
    end
  }
}
