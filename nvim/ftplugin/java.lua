vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
-- nvim-jdtls
local jdtls = os.getenv("XDG_DATA_HOME") .. "/jdtls"
local workspace_dir = os.getenv("XDG_CACHE_HOME") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local config = require("me.lsp").make_config()
config["cmd"] = {
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
config["root_dir"] = vim.fn.getcwd()
config["settings"] = {
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
}
require("jdtls").start_or_attach(config)
-- maven test
if vim.fn.executable("mvn") > 0 then
    vim.api.nvim_create_user_command("MvnTest", function(opts)
        local dirs = vim.split(vim.fn.expand("%:p"), "/")
        local module, class, props
        local is_test = false

        for i = #dirs, 1, -1 do
            if dirs[i] == "test" then
                class = table.concat(vim.list_slice(dirs, i + 2, #dirs), "."):gsub("%.java$", "")
                is_test = true
            end

            if dirs[i] == "src" and i - 1 > 0 then
                local mod_path = "/" .. table.concat(vim.list_slice(dirs, 1, i - 1), "/")
                module = vim.fn.system("cd " ..
                    mod_path .. " && mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout")
                props = mod_path .. "/configuration.properties"
            end
        end

        if not is_test then
            print("not a test file!")
            return
        end

        if opts.args and not opts.args:match("^%s*$") then
            class = string.format("%s#%s", class, opts.args:gsub("%s+", ""))
        end

        local cmd = "mvn test -T 1C -pl :" ..
            module .. " -Dtest=" .. vim.fn.fnameescape(class) .. " -DskipTests=false -Dgroups=small,medium"
        if vim.fn.filereadable(props) < 1 then
            cmd = cmd .. " -Dic.configurationFile=" .. vim.fn.getcwd() .. "/configuration.properties"
        end
        vim.fn.execute("terminal " .. cmd)
    end, { nargs = "?" })
end
-- set path and format
vim.cmd([[
    setlocal includeexpr=substitute(v:fname,'\\.','/','g')
    setlocal errorformat=[ERROR]\ %f:[%l\\,%v]\ %m
    setlocal makeprg=mvn\ clean\ install\ -T\ 5
    setlocal path+=src/main/java/**
    setlocal path+=src/main/test/**
    setlocal path+=**/src/main/java/**
    setlocal path+=**/src/main/test/**
]])
