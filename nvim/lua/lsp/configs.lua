local lspconfig = require("lspconfig")

-- Setup capabilities for nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Terraform LSP
lspconfig.terraformls.setup({
    capabilities = capabilities,
    filetypes = { "terraform", "tf", "hcl" },
    root_dir = lspconfig.util.root_pattern(".terraform", ".git", "*.tf"),
})


-- Helper to set up multiple servers
local servers = {
    terraformls = { filetypes = { "terraform", "tf", "hcl" } },
    pyright = {},
    gopls = {},
    ts_ls = {},
    rust_analyzer = {},
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
        }
      }
    },
    bashls = {},
    jsonls = {},
    yamlls = {},
    html = {},
    cssls = {},
  }

  for name, opts in pairs(servers) do
    opts.capabilities = capabilities
    opts.root_dir = opts.root_dir or lspconfig.util.root_pattern(".git", ".")
    lspconfig[name].setup(opts)
  end