vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
-- set path
if vim.fn.has("mac") > 0 then
    -- add c include to path on macos
    if vim.fn.executable("xcrun") > 0 then
        local sdk_path = vim.fn.system("xcrun --show-sdk-path"):gsub("\n", "")
        vim.opt_local.path:append(sdk_path .. "/usr/include")
    end
    -- c makeprg, work with :make command
    vim.opt_local.makeprg =
    "cd build && cmake -DCMAKE_BUILD_TYPE=debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -G Ninja .. && ninja"
end
