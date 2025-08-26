return {
    "yetone/avante.nvim",
    version = false,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        -- "echasnovski/mini.pick",     -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
        -- "ibhagwan/fzf-lua",          -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
        -- "zbirenbaum/copilot.lua",    -- for providers='copilot'
        "ravitemer/mcphub.nvim",         --for MCP support
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
    cmd = { "AvanteAsk", "AvanteChat", "AvanteChatNew", "AvanteModels", "AvanteToggle" },
    keys = {
        { "<leader>at", vim.cmd.AvanteToggle, desc = "Toggle the Avante sidebar" }
    },
    opts = {
        provider = "gemini",
        behaviour = {
            -- auto_suggestions = true, -- experimental phase
            enable_cursor_planning_mode = true,
        },
        disabled_tools = {
            "list_files", -- Built-in file operations
            "search_files",
            "read_file",
            "create_file",
            "rename_file",
            "delete_file",
            "create_dir",
            "rename_dir",
            "delete_dir",
            "bash",       -- Built-in terminal access
            "web_search", -- API key required
        },
        providers = {
            gemini = {
                endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
                model = "gemini-2.5-flash",
                timeout = 30000, -- Timeout in milliseconds
                use_ReAct_prompt = true,
                extra_request_body = {
                    generationConfig = {
                        temperature = 0.75,
                    },
                },
            },
            mistral = {
                __inherited_from = "openai",
                api_key_name = "MISTRAL_API_KEY",
                endpoint = "https://api.mistral.ai/v1/",
                model = "mistral-large-latest",
            },
            codestral = {
                __inherited_from = "openai",
                api_key_name = "CODESTRAL_API_KEY",
                endpoint = "https://codestral.mistral.ai/v1/",
                model = "codestral-latest",
            },
        },
        -- system_prompt as function ensures LLM always has latest MCP server state
        -- This is evaluated for every message, even in existing chats
        system_prompt = function()
            local hub = require("mcphub").get_hub_instance()
            return hub and hub:get_active_servers_prompt() or ""
        end,
        -- Using function prevents requiring mcphub before it's loaded
        custom_tools = function()
            return {
                require("mcphub.extensions.avante").mcp_tool(),
            }
        end,
    },
}
