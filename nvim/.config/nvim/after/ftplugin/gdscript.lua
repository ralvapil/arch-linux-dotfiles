-- add the following to editor settings:
-- --server /tmp/godot.pipe --remote-send "<C-\><C-N>:n {file}<CR>{line}G{col}|"

local port = tonumber(os.getenv 'GDScript_Port') or 6005
local cmd = vim.lsp.rpc.connect('127.0.0.1', port)
local pipe = '/tmp/godot.pipe'

-- Only start the LSP once
if not vim.lsp.get_clients({ name = 'Godot' })[1] then
  vim.lsp.start {
    name = 'Godot',
    cmd = cmd,
    root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
    on_attach = function(client, bufnr)
      -- ensure old pipe is gone
      if vim.loop.fs_stat(pipe) then
        os.remove(pipe)
      end

      -- start server so Godot can talk to Neovim
      local ok, err = pcall(function()
        vim.api.nvim_command('call serverstart("' .. pipe .. '")')
      end)

      if not ok then
        vim.notify('Godot: failed to start pipe server -> ' .. tostring(err), vim.log.levels.ERROR)
      else
        vim.notify('Godot: listening on ' .. pipe, vim.log.levels.INFO)
      end
    end,
  }
end
