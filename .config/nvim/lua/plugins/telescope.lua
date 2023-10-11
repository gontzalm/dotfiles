return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "<leader>ff",
            function() require("telescope.builtin").find_files() end,
            desc = "Find files."
        },
        {
            "<leader>fg",
            function()
                if vim.loop.fs_stat(".git") then
                    require("telescope.builtin").git_files()
                else
                    require("telescope.builtin").live_grep()
                end
            end,
            desc = "Grep files."
        },
        {
            "<leader>fh",
            function() require("telescope.builtin").help_tags() end,
            desc = "Find help tags."
        }

    }
}
