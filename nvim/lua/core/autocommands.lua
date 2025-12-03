vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.o.softtabstop = 4
        vim.o.shiftwidth = 4
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "json",
        "markdown",
        "sh",
        "yaml",
    },
    callback = function()
        vim.o.softtabstop = 2
        vim.o.shiftwidth = 2
    end,
})
