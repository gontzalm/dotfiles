return {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost" },
    config = function()
        require("lint").linters_by_ft = {
            markdown = { "markdownlint" }
        }
    end,
    init = function()
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
