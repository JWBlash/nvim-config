require("config.lazy")
local os_config = require("config.os")

-- compile on windows if we haven't yet already
if vim.fn.has("win32") == 1 then
  -- this didn't even work for me so don't bother doing it right now
  -- os_config.setup_windows_compiler()
end

-- general settings
local set = vim.opt
set.shiftwidth = 4
set.number = true
set.relativenumber = true
-- set.wildmode = "longest:full" <-- bash-like autocomplete for wildmenu

-- general binds
local binds = vim.keymap
binds.set("n", "<space><space>x", "<cmd>source %<CR>")
binds.set("n", "<space>x", ":.lua<CR>")
binds.set("v", "<space>x", ":lua<CR>")
binds.set("n", "<space>o", ":Oil --float<CR>")
binds.set("n", "grn", vim.lsp.buf.rename)
binds.set("n", "gra", vim.lsp.buf.code_action)
binds.set("n", "grr", vim.lsp.buf.references)

-- quickfix binds
binds.set("n", "<C-n>", "<cmd>cnext<CR>")
binds.set("n", "<C-p>", "<cmd>cprev<CR>")

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- diagnostics on hover
local ns = vim.api.nvim_create_namespace('CurlineDiag')
vim.opt.updatetime = 100
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.api.nvim_create_autocmd('CursorHold', {
      buffer = args.buf,
      callback = function()
        pcall(vim.api.nvim_buf_clear_namespace, args.buf, ns, 0, -1)
        local hi = { 'Error', 'Warn', 'Info', 'Hint' }
        local curline = vim.api.nvim_win_get_cursor(0)[1]
        local diagnostics = vim.diagnostic.get(args.buf, { lnum = curline - 1 })
        local virt_texts = { { (' '):rep(4) } }
        for _, diag in ipairs(diagnostics) do
          virt_texts[#virt_texts + 1] = { diag.message, 'Diagnostic' .. hi[diag.severity] }
        end
        vim.api.nvim_buf_set_extmark(args.buf, ns, curline - 1, 0, {
          virt_text = virt_texts,
          hl_mode = 'combine'
        })
      end
    })
  end
})

-- this won't work because it checks the current dir,
-- not the dir that has our config. I'll need to fix that
-- local check_sync = function()
--   os.execute("git fetch")
--   local handle = io.popen("git rev-list HEAD..origin/main --count")
--   if handle then
--     local result = handle:read("*a"):gsub("%s$", "")
--     handle:close()
--     if tonumber(result) > 0 then
--       print("WARN:")
--       print("   Your nvim-config is behind by " .. result .. " commits!")
--       print("   Consider running a `git pull`.")
--     end
--   else
--     print("ERR: Failed to check upstream status. Are you in a git repo?")
--   end
-- end
--
-- check_sync()
