return {
    "rcarriga/nvim-notify",
    keys = {
        {
            "<leader>fn",
            function() require("telescope").extensions.notify.notify({ initial_mode = "normal" }) end,
            desc = "List notifications"
        },
    },
    init = function()
        vim.notify = require("notify")
    end,
}
