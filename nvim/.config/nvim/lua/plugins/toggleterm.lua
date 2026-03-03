return {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
        { "<C-\\>" },
        { "<leader>tp" },
        { "<leader>tf" },
    },
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
        open_mapping = [[<c-\>]],
        direction = "float",
        shell = "nu",
        float_opts = { border = "curved", title_pos = "center" },
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)


        -- Navigation
        function _G.set_terminal_keymaps()
            local opts_ = { buffer = 0 }
            vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts_)
            vim.keymap.set("n", "<esc>", "<cmd>bd!<CR>", { buffer = true })
            vim.keymap.set("t", "<C-h>", [[<cmd>wincmd h<CR>]], opts_)
            vim.keymap.set("t", "<C-j>", [[<cmd>wincmd j<CR>]], opts_)
            vim.keymap.set("t", "<C-k>", [[<cmd>wincmd k<CR>]], opts_)
            vim.keymap.set("t", "<C-l>", [[<cmd>wincmd l<CR>]], opts_)
            vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts_)
        end

        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

        -- Custom terminals
        local Terminal = require("toggleterm.terminal").Terminal

        ---------------------------------------------------------
        -- TERMINAL 1: IPython
        ---------------------------------------------------------
        local ipython = Terminal:new({
            cmd = "uv run ipython",
            direction = "vertical",
            hidden = true,
            on_open = function(_)
                vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = true })
                vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = true })
            end
        })
        local function _toggle_ipython()
            ipython:toggle()
        end
        vim.keymap.set("n", "<leader>tp", _toggle_ipython,
            { noremap = true, silent = true, desc = "Toggle IPython (uv)" })

        -- Send motion to terminal
        vim.keymap.set("n", "<leader>ts", function()
            _G.ipython_motion_func = function(motion_type)
                require("toggleterm").send_lines_to_terminal(motion_type, false, { args = ipython.id })
            end
            vim.go.operatorfunc = "v:lua.ipython_motion_func"
            vim.api.nvim_feedkeys("g@", "n", false)
        end, { desc = "Send motion to terminal" })

        ---------------------------------------------------------
        -- TERMINAL 2: FastAPI (Dev Server)
        ---------------------------------------------------------
        local fastapi = Terminal:new({
            cmd = "uv run fastapi dev",
            display_name = " FastAPI Server ",
            direction = "float",
            hidden = true,
            close_on_exit = false,
            on_open = function(_)
                vim.cmd("stopinsert")
            end
        })
        local function _toggle_fastapi()
            fastapi:toggle()
        end
        vim.keymap.set("n", "<leader>tf", _toggle_fastapi,
            { noremap = true, silent = true, desc = "Toggle FastAPI Server" })
    end,
}
