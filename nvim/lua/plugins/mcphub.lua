return {
    "ravitemer/mcphub.nvim",
    build = "npm install -g mcp-hub@latest",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = { "MCPHub" },
    opts = { auto_approve = true }
}
