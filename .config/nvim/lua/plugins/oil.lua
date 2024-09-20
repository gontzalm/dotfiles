return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        { "-", vim.cmd.Oil, desc = "Open parent directory" },
    },
    opts = { view_options = { show_hidden = true } },
}
