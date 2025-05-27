vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
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
-- workspace clean
vim.api.nvim_create_user_command("LspClean", function(_)
    local workspace_dir = os.getenv("XDG_CACHE_HOME") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    vim.fn.system("rm -rf " .. workspace_dir)
    vim.notify_once(workspace_dir .. " cleaned", vim.log.levels.INFO)
end, { nargs = 0 })
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
