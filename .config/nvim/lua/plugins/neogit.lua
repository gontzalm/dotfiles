return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    keys = {
        { "<leader>gs", function() require("neogit").open() end, desc = "Open Neogit" }
    },
    opts = { commit_editor = { staged_diff_split_kind = "vsplit" } }
}
