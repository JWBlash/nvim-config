local function start_godot_lsp()
  -- Check if the LSP is already running

  for _, client in pairs(vim.lsp.get_clients()) do
    if client.name == 'Godot' then
      return
    end
  end

  local port = os.getenv('GDScript_Port') or '6005'
  -- TODO(james) ncat is a dependency... check for it
  local cmd = { 'ncat', '127.0.0.1', port }
  local pipe = [[\\.\pipe\godot.pipe]]

  vim.lsp.start({
    name = 'Godot',
    cmd = cmd,
    root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
    on_attach = function(client, bufnr)
      print("Godot LSP attached to buffer: " .. bufnr)
      vim.api.nvim_command([[echo serverstart(']] .. pipe .. [[')]])
    end
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      require("lspconfig").lua_ls.setup {}
      require("lspconfig").basedpyright.setup {}
      require("lspconfig").gopls.setup {}
      require("lspconfig").clangd.setup {}
      require("lspconfig").bashls.setup {}
      require("lspconfig").zls.setup {}

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          print(table.concat(args, '\n'))
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          ---@diagnostic disable-next-line: missing-parameter
          if client.supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = args.buf,
                  id = client.id
                })
              end,
            })
          end
        end,
      })
    end
  }
}
