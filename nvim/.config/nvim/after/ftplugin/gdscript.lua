-- set the following in godot:
-- --server /tmp/godot.pipe --remote-send "<esc>:e {file}<CR>:call cursor({line},{col})<CR>"
-- then just start nvim looking at one of the files in the directory

local pipe = '/tmp/godot.pipe'
local port = tonumber(os.getenv 'GDScript_Port') or 6005

-- Start Neovim message server if not already running
if not vim.g.godot_server_started then
  if vim.uv.fs_stat(pipe) then
    os.remove(pipe)
  end
  vim.fn.serverstart(pipe)
  vim.g.godot_server_started = true
  vim.notify('Godot: listening on ' .. pipe, vim.log.levels.INFO)
end

-- Reuse existing Godot client if running
for _, client in ipairs(vim.lsp.get_clients()) do
  if client.name == 'Godot' then
    vim.lsp.buf_attach_client(0, client.id)
    return
  end
end

-- Optional: check if the port is open before connecting
local function is_port_open(host, port)
  local tcp = vim.uv.new_tcp()
  local ok, err = pcall(function()
    tcp:connect(host, port)
  end)
  tcp:shutdown()
  tcp:close()
  return ok
end

if not is_port_open('127.0.0.1', port) then
  vim.notify('Godot LSP: editor not detected on port ' .. port, vim.log.levels.WARN)
  return
end

-- Directly assign cmd to the result of rpc.connect()
local cmd = vim.lsp.rpc.connect('127.0.0.1', port)

vim.lsp.start {
  name = 'Godot',
  cmd = cmd,
  root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
}
