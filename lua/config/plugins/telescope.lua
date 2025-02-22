return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies =
    {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup {
        pickers = {
          lsp_references = {
            theme = "dropdown"
          },
        },
        extensions = {
          fzf = {}
        }
      }

      require('telescope').load_extension('fzf')

      vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<space>fq", require('telescope.builtin').lsp_references)
      vim.keymap.set("n", "<space>nv", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
    end
  }
}
