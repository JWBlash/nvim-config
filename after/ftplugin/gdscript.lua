-- local function start_godot_lsp()
--   -- Check if the LSP is already running
--   for _, client in pairs(vim.lsp.get_active_clients()) do
--     if client.name == 'Godot' then
--       return
--     end
--   end
--
--   local port = os.getenv('GDScript_Port') or '6005'
--   -- TODO(james) ncat is a dependency... check for it
--   local cmd = { 'ncat', '127.0.0.1', port }
--   local pipe = [[\\.\pipe\godot.pipe]]
--
--   vim.lsp.start({
--     name = 'Godot',
--     cmd = cmd,
--     root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
--     on_attach = function(client, bufnr)
--       print("Godot LSP attached to buffer: " .. bufnr)
--       vim.api.nvim_command([[echo serverstart(']] .. pipe .. [[')]])
--     end
--   })
-- end
--
-- start_godot_lsp()
