return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
        init = function()
            -- check https://github.com/williamboman/mason.nvim/issues/103
            local ensure_installed = {
                "blackd-client",
                "markdownlint",
                "prettierd",
                "ruff",
            }
            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
            end, { desc = "Ensure required packages are installed" })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "L3MON4D3/LuaSnip" }
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                },
                formatting = lsp_zero.cmp_format(),
                mapping = {
                    ["<tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = "insert" })
                        else
                            fallback()
                        end
                    end),
                    ["<s-tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = "insert" })
                        else
                            fallback()
                        end
                    end),
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()
            lsp_zero.on_attach(
                function(_, bufnr)
                    lsp_zero.buffer_autoformat()
                    lsp_zero.default_keymaps({ buffer = bufnr })
                    local telescope = require("telescope.builtin")
                    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr })
                    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr })
                    vim.keymap.set("n", "gl", function() telescope.diagnostics({ initial_mode = "normal" }) end,
                        { buffer = bufnr })
                    vim.keymap.set("n", "gr", function() telescope.lsp_references({ initial_mode = "normal" }) end,
                        { buffer = bufnr })
                end
            )

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "docker_compose_language_service",
                    "dockerls",
                    "html",
                    "jsonls",
                    "ltex",
                    "lua_ls",
                    "marksman",
                    "pyright",
                    "taplo",
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    },
}
