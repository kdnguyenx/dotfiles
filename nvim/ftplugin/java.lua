vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

vim.opt_local.includeexpr=vim.v.fname:gsub('.', '/')
vim.opt_local.errorformat = '[ERROR] %f:[%l\\,%v] %m'
vim.opt_local.makeprg = 'mvn clean install -T 5'
vim.opt_local.path:append('*/src/main/java/**')
vim.opt_local.path:append('*/src/main/test/**')
vim.opt_local.path:append('*/src/main/resources/**')

local data_home = os.getenv('XDG_DATA_HOME')
local workspace_dir = data_home .. '/jdtls/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local jdtls = data_home .. '/nvim/mason/packages/jdtls'
local config = require('lsp').make_cfg()
config['name'] = 'jdtls'
config['cmd'] = {
  os.getenv('JDK21') .. '/bin/java',
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xmx2g',
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  '-jar', vim.fn.glob(jdtls .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
  '-configuration', jdtls .. '/config_mac_arm',
  '-data', workspace_dir,
}
config['root_dir'] = vim.fn.getcwd() -- or vim.fs.root(0, {'pom.xml', '.git', 'mvnw', 'gradlew'}),
config['settings'] = {
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
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    configuration = {
      runtimes = {
        {
          name = 'JavaSE-11',
          path = os.getenv('JDK11'),
          default = true,
        },
        {
          name = 'JavaSE-17',
          path = os.getenv('JDK17'),
        },
      }
    }
  }
}
config['init_options'] = {
  bundles = {},
  extendedClientCapabilities = {
    classFileContentsSupport = true,
    advancedOrganizeImportsSupport = true,
  }
}
require('jdtls').start_or_attach(config)

if vim.fn.executable('mvn') > 0 then
   vim.api.nvim_create_user_command('MvnTest', function(opts)
      local dirs = vim.split(vim.fn.expand('%:p'), '/')
      local module, class, props
      local is_test = false

      for i = #dirs, 1, -1 do
         if dirs[i] == 'test' then
            class = table.concat(vim.list_slice(dirs, i + 2, #dirs), '.'):gsub('%.java$', '')
            is_test = true
         end

         if dirs[i] == 'src' and i - 1 > 0 then
            local mod_path = '/' .. table.concat(vim.list_slice(dirs, 1, i - 1), '/')
            module = vim.fn.system('cd ' .. mod_path .. ' && mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout')
            props = mod_path .. '/configuration.properties'
         end
      end

      if not is_test then
         print('not a test file!')
         return
      end

      if opts.args and not opts.args:match('^%s*$') then
         class = string.format('%s#%s', class, opts.args:gsub('%s+', ''))
      end

      local cmd = 'mvn test -T 1C -pl :' .. module .. ' -Dtest=' .. vim.fn.fnameescape(class) .. ' -DskipTests=false -Dgroups=small,medium'
      if vim.fn.filereadable(props) < 1 then
         cmd = cmd .. ' -Dic.configurationFile=' .. vim.fn.getcwd() .. '/configuration.properties'
      end
      vim.fn.execute('terminal ' .. cmd)
   end, { nargs = '?' })
end
