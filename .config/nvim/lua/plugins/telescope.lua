return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        -- File pickers
        {
            "<leader>ff",
            function()
                if vim.fn.isdirectory(".git") ~= 0 then
                    require("telescope.builtin").git_files()
                else
                    require("telescope.builtin").find_files()
                end
            end,
            desc = "Find files."
        },
        {
            "<leader>fg",
            require("telescope.builtin").live_grep,
            desc = "Grep files."
        },
        -- Vim pickers
        {
            "<leader>fb",
            function() require("telescope.builtin").buffers({ initial_mode = "normal" }) end,
            desc = "List open buffers."
        },
        {
            "<leader>fc",
            require("telescope.builtin").commands,
            desc = "Find commands."
        },
        {
            "q:",
            require("telescope.builtin").command_history,
            desc = "Find help tags."
        },
        {
            "<leader>fh",
            require("telescope.builtin").help_tags,
            desc = "Find help tags."
        }
    }
}
