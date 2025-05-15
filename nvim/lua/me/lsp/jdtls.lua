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
