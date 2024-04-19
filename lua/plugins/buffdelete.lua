return {
    "famiu/bufdelete.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>bd",
            function()
                require("bufdelete").bufdelete(0, true)
            end,
            desc = "Delete buffer",
        },
        {
            "<leader>bD",
            "<cmd>%Bd<CR>",
            desc = "Delete buffer",
        },
    },
}
