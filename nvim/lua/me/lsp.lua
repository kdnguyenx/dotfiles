-- default for all servers
vim.lsp.config("*", {
    on_attach = function(client, bufnr)
        -- enable inlay hint
        vim.lsp.inlay_hint.enable(true)
        -- mappings.
        -- see `:help vim.lsp.*` for documentation on any of the below functions
        -- lsp navigation keymaps
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "single" }) end, { buffer = bufnr })
        vim.keymap.set("i", "<C-s>", function()
            vim.lsp.buf.signature_help({ border = "single", title = "help" })
        end, { buffer = bufnr })
        -- lsp actions
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = bufnr })
        vim.keymap.set("v", "ga", vim.lsp.buf.code_action, { buffer = bufnr })
        vim.keymap.set("n", "gR", vim.lsp.buf.rename, { buffer = bufnr })
        -- diagnostics keymaps
        vim.keymap.set("n", "<C-p>", function() vim.diagnostic.jump({ count = -1, float = false }) end)
        vim.keymap.set("n", "<C-n>", function() vim.diagnostic.jump({ count = 1, float = false }) end)
        -- diagnostics list
        vim.keymap.set("n", "<leader>xx", function()
            vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
        end)
        -- diagnostic signs
        vim.diagnostic.config({ virtual_text = true, underline = true, float = { border = "single", } })
        -- completion
        vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
    end,
    detached = true,
})
-- clang
vim.lsp.config("clangd", {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_markers = {
        ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json",
        "compile_flags.txt", "configure.ac", ".git"
    }
})
-- lua
vim.lsp.config("luals", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml",
        "stylua.toml", "selene.toml", "selene.yml", ".git"
    }
})
-- python
vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt",
        "Pipfile", "pyrightconfig.json", ".git"
    },
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
-- javascript and typescript
vim.lsp.config("tsserver", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx",
        "typescript", "typescriptreact", "typescript.tsx"
    },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    init_options = { hostInfo = "neovim" },
})
-- java
local jdtls = os.getenv("XDG_DATA_HOME") .. "/jdtls"
local workspace_dir = os.getenv("XDG_CACHE_HOME") .. "/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
vim.lsp.config("jdtls", {
    cmd = {
        os.getenv("JDK21") .. "/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx2g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", vim.fn.glob(jdtls .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration", jdtls .. "/config_mac_arm",
        "-data", workspace_dir,
    },
    filetypes = { "java" },
    settings = {
        java = {
            references = {
                includeDecompiledSources = true,
            },
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true,
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            completion = {
                importOrder = { "java", "javax", "com", "org" },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = false,
                    useInstanceOf = true,
                },
                useBlocks = true,
                addFinalForNewDeclaration = "fields",
            },
            configuration = {
                runtimes = {
                    { name = "JavaSE-11", path = os.getenv("JDK11"), default = true },
                    { name = "JavaSE-17", path = os.getenv("JDK17") },
                    { name = "JavaSE-21", path = os.getenv("JDK21") },
                }
            }
        }
    },
    root_dir = vim.fn.getcwd(),
})
-- enabled servers
-- can be disabled by `:lua vim.lsp.enable("jdtls", false)` for example
vim.lsp.enable({ "clangd", "jdtls", "luals", "pyright", "tsserver" })
