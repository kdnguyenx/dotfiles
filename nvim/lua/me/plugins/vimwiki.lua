return {
    "vimwiki/vimwiki",
    init = function()
        vim.g.vimwiki_list = { { path = "~/notes/", syntax = "markdown", ext = "md" } }
        vim.g.vimwiki_global_ext = 0
        vim.g.vimwiki_ext2syntax = vim.empty_dict()
    end
}
