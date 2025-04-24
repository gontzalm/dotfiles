return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    opts = {
        -- provider = "gemini",
        provider = "mistral",
        -- auto_suggestions_provider = "gemini",
        auto_suggestions_provider = "codestral",
        behaviour = {
            -- auto_suggestions = true, -- experimental phase
            enable_cursor_planning_mode = true,
        },
        vendors = {
            mistral = {
                __inherited_from = "openai",
                api_key_name = "MISTRAL_API_KEY",
                endpoint = "https://api.mistral.ai/v1/",
                model = "mistral-large-latest",
                max_tokens = 4096, -- to avoid using max_completion_tokens
            },
            codestral = {
                __inherited_from = "openai",
                api_key_name = "CODESTRAL_API_KEY",
                endpoint = "https://codestral.mistral.ai/v1/",
                model = "codestral-latest",
                max_tokens = 4096, -- to avoid using max_completion_tokens
            },
        },
    },
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
}
