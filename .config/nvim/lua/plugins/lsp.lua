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
        cmd = { "Mason", "MasonUpdate" },
        config = true,
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason.nvim"
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()
            lsp_zero.on_attach(
                function(_, bufnr)
                    lsp_zero.default_keymaps({ buffer = bufnr })
                    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr })
                    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr })
                    vim.keymap.set("n", "gl",
                        function() require("telescope.builtin").diagnostics({ initial_mode = "normal" }) end,
                        { buffer = bufnr }
                    )
                    vim.keymap.set("n", "gr",
                        function() require("telescope.builtin").lsp_references({ initial_mode = "normal" }) end,
                        { buffer = bufnr }
                    )
                end
            )

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "basedpyright",
                    "bashls",
                    "docker_compose_language_service",
                    "dockerls",
                    "html",
                    "jsonls",
                    "ltex",
                    "lua_ls",
                    "ruff",
                    "taplo",
                    "yamlls",
                },
                handlers = {
                    require("lsp-zero").default_setup,
                    basedpyright = function()
                        require("lspconfig").basedpyright.setup({})
                    end,
                    lua_ls = function()
                        local lua_opts = require("lsp-zero").nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip"
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
}
