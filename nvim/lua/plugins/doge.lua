return {
    "kkoomen/vim-doge",
    ft = "python",
    build = ":call doge#install()",
    init = function()
        vim.g.doge_doc_standard_python = "google"
    end,
}
