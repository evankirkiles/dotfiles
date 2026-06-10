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
        graphql = { enabled = false },
        tailwindcss = { enabled = false },
        biome = {},
        eslint = {},
        oxc = {
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
              if result and result.diagnostics then
                result.diagnostics = vim.tbl_filter(function(diag)
                  return diag.code ~= "typescript(tsconfig-error)"
                end, result.diagnostics)
              end
              vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
            end,
          },
        },
        vtsls = {
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
            },
            typescript = {
              format = {
                enable = false,
              },
              tsserver = {
                nodePath = root .. "/src/cli/tsserverNode",
                maxTsServerMemory = 24576,
              },
              tsdk = root .. "/node_modules/typescript/lib",
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.typescript = { "biome" }
      opts.formatters_by_ft.typescriptreact = { "biome" }
      opts.formatters_by_ft.javascript = { "biome" }
      opts.formatters_by_ft.javascriptreact = { "biome" }
    end,
  },
}
