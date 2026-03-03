-- return {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {
--         style = "moon",
--         transparent = true,
--         on_colors = function(colors)
--             colors.fg_gutter = colors.blue5
--         end,
--         on_highlights = function(hl, c)
--             local prompt = "#2d3149"
--             hl.TelescopeNormal = {
--                 bg = c.bg_dark,
--                 fg = c.fg_dark,
--             }
--             hl.TelescopeBorder = {
--                 bg = c.bg_dark,
--                 fg = c.bg_dark,
--             }
--             hl.TelescopePromptNormal = {
--                 bg = prompt,
--             }
--             hl.TelescopePromptBorder = {
--                 bg = prompt,
--                 fg = prompt,
--             }
--             hl.TelescopePromptTitle = {
--                 bg = prompt,
--                 fg = prompt,
--             }
--             hl.TelescopePreviewTitle = {
--                 bg = c.bg_dark,
--                 fg = c.bg_dark,
--             }
--             hl.TelescopeResultsTitle = {
--                 bg = c.bg_dark,
--                 fg = c.bg_dark,
--             }
--         end,
--     },
--     init = function()
--         vim.cmd.colorscheme("tokyonight")
--     end,
-- }
return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
        transparent_background = true,
        integrations = {
            notify = true,
        },
    },
    init = function() vim.cmd.colorscheme("catppuccin-macchiato") end,
}
