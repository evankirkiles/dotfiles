-- Use the in-repo tsserver / TypeScript SDK when working inside a notion-next
-- checkout (including any git worktree of it). We detect the project by walking
-- upward from cwd looking for src/cli/tsserverNode -- the same file we'd point
-- vtsls at -- so the override only activates when it can actually do something.
local function find_notion_next_root(start)
  local dir = start
  while dir and dir ~= "" do
    if vim.uv.fs_stat(dir .. "/src/cli/tsserverNode") then
      return dir
    end
    local parent = vim.fs.dirname(dir)
    if parent == dir then
      return nil
    end
    dir = parent
  end
end

local root = find_notion_next_root(vim.uv.cwd() or "")
if not root then
  return {}
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              tsserver = { nodePath = root .. "/src/cli/tsserverNode" },
              tsdk = root .. "/node_modules/typescript/lib",
            },
          },
        },
      },
    },
  },
}
