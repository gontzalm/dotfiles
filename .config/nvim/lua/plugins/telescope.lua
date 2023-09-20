return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "<leader>ff",
            function() require("telescope.builtin").find_files() end,
            desc = "Find files"
        },
        {
            "<leader>fg",
            function() require("telescope.builtin").live_grep() end,
            desc = "Grep files"
        },
        {
            "<leader>fb",
            function() require("telescope.builtin").buffers() end,
            desc = "Find buffers"
        },
        {
            "<leader>fh",
            function() require("telescope.builtin").help_tags() end,
            desc = "Find help tags"
        }

    }
}
