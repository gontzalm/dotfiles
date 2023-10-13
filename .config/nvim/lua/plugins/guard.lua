return {
    "nvimdev/guard.nvim",
    dependencies = { "nvimdev/guard-collection" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local ft = require("guard.filetype")
        -- local lint = require("guard.lint")

        ft("html,json,jsonc,yaml,markdown"):fmt({
            cmd = "prettierd",
            fname = true,
            stdin = true,
            env = { PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/linter-config/.prettierrc.toml") },
        })

        ft("lua"):fmt("lsp")

        -- ft("markdown"):lint({
        --     cmd = "markdownlint",
        --     args = { "--json" },
        --     fname = true,
        --     valid_exit_codes = { 0, 1 },
        --     source = "markdownlint",
        --     parse = lint.from_json({
        --         source = "markdownlint",
        --         attributes = {
        --             lnum = "lineNumber",
        --             col = "lineNumber",
        --             message = "ruleDescription",
        --             code = function(d) return d["ruleNames"][1] end,
        --             severity = function(_) return "warning" end,
        --         }
        --     })
        -- })

        ft("python"):fmt({
            cmd = "blackd-client",
            stdin = true,
        })

        ft("sh"):fmt({
            cmd = "shfmt",
            args = { "-i", "2", "-ci", "-bn" },
            stdin = "true"
        }):lint("shellcheck")

        ft("toml"):fmt("lsp")

        require('guard').setup()
    end,
}
