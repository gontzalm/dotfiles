return {
    "gontzalm/guard.nvim",
    dependencies = { "nvimdev/guard-collection" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local ft = require("guard.filetype")
        local lint = require("guard.lint")

        local prettierd = {
            cmd = "prettierd",
            fname = true,
            stdin = true,
        }

        ft("html,json,jsonc,yaml"):fmt(prettierd)

        -- ft("lua"):fmt("lsp")

        ft("markdown"):fmt(prettierd):lint({
            cmd = "markdownlint",
            args = { "--json" },
            fname = true,
            valid_exit_codes = { 0, 1 },
            source = "markdownlint",
            parse = lint.from_json({
                source = "markdownlint",
                attributes = {
                    lnum = "lineNumber",
                    col = "lineNumber",
                    message = "ruleDescription",
                    code = function(d) return d["ruleNames"][1] end,
                    severity = function(_) return "warning" end,
                }
            })
        })

        ft("sh"):fmt("shfmt"):lint("shellcheck")

        ft("python"):fmt({
            cmd = "blackd-client",
            stdin = true,
        })

        require('guard').setup()
    end,
}
