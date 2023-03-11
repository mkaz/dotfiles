
-- Python
vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = '*.py',
    command = "Black"
})
