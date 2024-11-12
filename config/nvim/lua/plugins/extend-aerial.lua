return {
  {
    "stevearc/aerial.nvim",
    opts = {
      autojump = true,
      layout = {
        max_width = { 40, 0.2 },
        width = 30,
        min_width = 20,
      },
      post_parse_symbol = function(_, item, ctx)
        -- In typescript, don't include nested variables
        -- This doesn't seem to work, unfortunately
        if ctx.lang == "tsx" then
          if item.kind == "Variable" and item.parent ~= nil then
            return false
          end
        end
        return true
      end,
    },
  },
}
