return {
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonUpdate" },
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = {
                "basedpyright",
                "bashls",
                "docker_compose_language_service",
                "dockerls",
                "html",
                "jsonls",
                "ltex_plus",
                "lua_ls",
                "ruff",
                "taplo",
                "yamlls",
            },
            handlers = {
                function(server_name)
                    vim.lsp.config(
                        server_name,
                        { capabilities = require("cmp_nvim_lsp").default_capabilities() }
                    )
                end,
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "mason-org/mason-lspconfig.nvim",
            {
                "ray-x/lsp_signature.nvim",
                opts = { hint_enable = false, handler_opts = { border = "none" } }
            },
        },
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr",
                        function() require("telescope.builtin").lsp_references({ initial_mode = "normal" }) end,
                        opts
                    )
                    vim.keymap.set("n", "gl",
                        function()
                            require("telescope.builtin").diagnostics({
                                initial_mode = "normal",
                                wrap_results = true,
                                line_width = "full"
                            })
                        end,
                        opts
                    )
                end,
            })

            vim.lsp.enable("nushell")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
        },
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            local cmp = require("cmp")

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            cmp.setup({
                mapping = {
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif has_words_before() then
                            cmp.complete()
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                },
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" }
                }, {
                    { name = "cmdline" }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })

            -- Insert `(` after confirming function or method item
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')

            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end,
    },
}
