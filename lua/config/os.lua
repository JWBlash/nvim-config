-- Initialize Visual Studio compiler environment for Windows systems
-- This is working on my system now, but only because I ran the following as a batch script:
-- @echo off
-- call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
-- start nvim %*
--
-- If I'm ever setting up on a new windows machine, I might need to do that again
-- I should also probably not hardcode assume I'll have MSVC 2022 on my system,
-- and should search for it instead

local M = {}

M.setup_windows_compiler = function()
  if vim.fn.has('win32') == 1 then
    -- Path to Visual Studio vcvarsall.bat (adjust according to your installation)
    local vs_path = [[C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat]]

    if vim.fn.filereadable(vs_path) == 1 then
      -- Capture environment variables after running vcvarsall.bat
      local handle = io.popen('cmd /c "' .. vs_path .. '" x64 && set')
      if handle then
        local result = handle:read("*a")
        handle:close()

        -- Parse and set environment variables
        for line in result:gmatch("[^\r\n]+") do
          local name, value = line:match("^([^=]+)=(.*)$")
          if name and value then
            vim.fn.setenv(name, value)
          end
        end
      end
    else
      print("Visual Studio vcvarsall.bat not found at: " .. vs_path)
    end
  end
end

return M
