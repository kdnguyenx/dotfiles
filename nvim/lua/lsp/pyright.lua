vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    -- root_markers = {
    --   "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt",
    --   "Pipfile", "pyrightconfig.json", ".git"
    -- },
    root_dir = vim.fn.getcwd(),
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
            },
        },
    }
})
