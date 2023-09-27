return {
    "lervag/vimtex",
    ft = "tex",
    init = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_latexmk = {
            aux_dir = "build",
            out_dir = "build",
        }
    end
}
