return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                changedelete = { text = "┃" }
            },
            signs_staged = {
                changedelete = { text = "┃" }
            },
        })
    end
}
