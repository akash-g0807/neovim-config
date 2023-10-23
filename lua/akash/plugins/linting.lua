local linting_status, linting = pcall(require, "lint")
if not linting_status then
  return
end

linting.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  svelte = { "eslint_d" },
  python = { "pylint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    linting.try_lint()
  end,
})

vim.keymap.set("n", "<leader>l", function()
  linting.try_lint()
end, { desc = "Trigger linting for current file" })
