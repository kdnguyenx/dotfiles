local M = {}
function M.make_cfg()
    return {
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
            vim.keymap.set("n", "<leader>k", function() vim.diagnostic.jump({ count = -1, float = false }) end)
            vim.keymap.set("n", "<leader>j", function() vim.diagnostic.jump({ count = 1, float = false }) end)
            -- diagnostics list
            vim.keymap.set("n", "<leader>xl", vim.diagnostic.setloclist)
            vim.keymap.set("n", "<leader>xw", function()
                vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
            end)
            vim.keymap.set("n", "<leader>xx", function()
                vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
            end)
            -- diagnostic signs
            vim.diagnostic.config({ virtual_text = true, underline = true, float = { border = "single", } })
            -- completion
            -- vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        detached = true,
    }
end

function M.jdtls_cmd()
    local jdtls = os.getenv("XDG_DATA_HOME") .. "/nvim/mason/packages/jdtls"
    local workspace_dir = os.getenv("XDG_CACHE_HOME") .. "/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    return {
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
    }
end

function M.jdtls_settings()
    return {
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
                importOrder = {
                    "java",
                    "javax",
                    "com",
                    "org",
                },
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
                    {
                        name = "JavaSE-11",
                        path = os.getenv("JDK11"),
                        default = true,
                    },
                    {
                        name = "JavaSE-17",
                        path = os.getenv("JDK17"),
                    },
                    {
                        name = "JavaSE-21",
                        path = os.getenv("JDK21"),
                    },
                }
            }
        }
    }
end

return M
