return {
  {
    "neanias/everforest-nvim",
    config = function()
      vim.cmd.colorscheme "everforest"
    end
  },
  --
  -- themes I like but don't use atm
  --
  -- {
  --   "rebelot/kanagawa.nvim",
  --   config = function()
  --     require("kanagawa").setup({
  --       colors = {
  --         palette = {},
  --         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  --       },
  --       theme = "lotus",
  --     })
  --     vim.cmd.colorscheme "kanagawa"
  --   end
  -- },
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   config = function()
  --     require("gruvbox").setup({
  --       italic = {
  --         strings = false
  --       },
  --       dim_inactive = false,
  --       transparent_mode = false,
  --     })
  --     vim.cmd.colorscheme "gruvbox"
  --   end
  -- },
}
