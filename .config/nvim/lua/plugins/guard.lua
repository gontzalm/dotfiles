return {
    "nvimdev/guard.nvim",
    dependencies = { "nvimdev/guard-collection" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local ft = require("guard.filetype")

        local prettierd = {
            cmd = "prettierd",
            fname = true,
            stdin = true,
        }

        ft("html,json,jsonc,yaml"):fmt(prettierd)

        ft("markdown"):fmt(prettierd):lint({
            cmd = "markdownlint-cli2",
            fname = true,
            -- TODO: add parse function
        })

        ft("sh"):fmt("shfmt"):lint("shellcheck")

        ft("python"):fmt({
            cmd = "blackd-client",
            stdin = true,
        })

        require('guard').setup()
    end,
}
