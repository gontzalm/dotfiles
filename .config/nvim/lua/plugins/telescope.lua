return {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        "nvim-tree/nvim-web-devicons",
    },
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
            desc = "Find files"
        },
        {
            "<leader>fg",
            require("telescope.builtin").live_grep,
            desc = "Grep files"
        },
        -- Vim pickers
        {
            "<leader>b",
            function() require("telescope.builtin").buffers({ initial_mode = "normal" }) end,
            desc = "List open buffers"
        },
        {
            "<leader>fc",
            require("telescope.builtin").commands,
            desc = "Find commands"
        },
        {
            "q:",
            function() require("telescope.builtin").command_history({ initial_mode = "normal" }) end,
            desc = "Show command history"
        },
        {
            "<leader>fh",
            require("telescope.builtin").help_tags,
            desc = "Find help tags"
        }
    }
}
