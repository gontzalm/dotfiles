return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        { "-", vim.cmd.Oil, desc = "Open parent directory" },
    },
    opts = {
        keymaps = {
            ["<CR>"] = "actions.select",
            ["-"] = "actions.parent",
            ["gs"] = "actions.change_sort",
            ["g."] = ""

        },
        use_default_keymaps = false,
        view_options = { show_hidden = true }
    },
}
