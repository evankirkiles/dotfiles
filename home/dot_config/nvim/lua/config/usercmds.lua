vim.api.nvim_create_user_command("FoldTests", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  vim.opt_local.foldmethod = "manual"
  vim.cmd("normal! zE") -- erase all existing folds

  local function paren_depth(s)
    local n = 0
    local in_str, str_char = false, nil
    for i = 1, #s do
      local c = s:sub(i, i)
      if in_str then
        if c == str_char then
          in_str = false
        end
      elseif c == '"' or c == "'" or c == "`" then
        in_str, str_char = true, c
      elseif c == "(" then
        n = n + 1
      elseif c == ")" then
        n = n - 1
      end
    end
    return n
  end

  local i = 0
  while i < #lines do
    i = i + 1
    -- matches: it(, it.only(, it.skip(, it.each(, etc.
    if lines[i]:match("^%s*it%s*%(") or lines[i]:match("^%s*it%.%w+%s*%(") then
      local start = i
      local depth = paren_depth(lines[i])
      while depth > 0 and i < #lines do
        i = i + 1
        depth = depth + paren_depth(lines[i])
      end
      if i > start then
        vim.cmd(("%d,%dfold"):format(start, i))
      end
    end
  end

  vim.cmd("normal! zM") -- close all created folds
end, { desc = "Fold all vitest it() blocks" })
