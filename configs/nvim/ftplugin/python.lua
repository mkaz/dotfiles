
-- Python
vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = '*.py',
    command = "Black"
})

-- No confirmation messages
vim.g['black_quiet'] = 1
