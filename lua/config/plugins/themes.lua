return {
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        italic = {
          strings = false
        },
        dim_inactive = false,
        transparent_mode = false,
      })
      vim.cmd.colorscheme "gruvbox"
    end
  },
}
