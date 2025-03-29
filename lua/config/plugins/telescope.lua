local M = {}

M.setup = function()
  local x = ""
  if vim.fn.has("win32") == 1 then
    x = "windows"
  end

  local os_dependencies = {
    'nvim-lua/plenary.nvim',
  }

  -- disable fzf on windows
  if (x ~= "windows") then
    os_dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
  end

  return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = os_dependencies,
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

      -- disable fzf on windows
      if (x ~= "windows")
      then
        require('telescope').load_extension('fzf')
      else
        print("not loading fzf")
      end

      vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<space>fq", require('telescope.builtin').lsp_references)
      vim.keymap.set("n", "<space>nv", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
    end
  }
end

return M.setup()
