-- lua/lsp/configs.lua
-- Required to install the each of the related language servers on your machine
--
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local util = lspconfig.util -- Shorthand for lspconfig.util

-- Define all LSP servers and their specific configurations
local servers = {
  -- Terraform LSP: Specific root_dir pattern for .terraform or .git in a tf project
  terraformls = {
    filetypes = { "terraform", "tf", "hcl" },
    root_dir = util.root_pattern(".terraform", ".git", "*.tf"),
  },
  -- Python LSP: Pyright
  pyright = {},
  -- Go LSP: gopls prefers go.mod for root
  gopls = {
    root_dir = util.root_pattern("go.mod", ".git"),
  },
  ts_ls = {},
  dockerls = {},
  -- Rust LSP: rust_analyzer
  rust_analyzer = {
    -- No specific settings here, can be added if needed, e.g.
    -- settings = {
    --   ['rust-analyzer'] = {
    --     checkOnSave = {
    --       command = "clippy",
    --     },
    --   },
    -- },
  },
  -- Lua LSP: With diagnostics globals for 'vim'
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }, -- Add other globals like "_G", "require", etc., if needed
        },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false }, -- Disable telemetry for privacy
      }
    }
  },
  -- Bash LSP: bashls (Note: If bashls is still crashing, consider adding 'enabled = false' here)
  bashls = {
    -- cmd = { "node", vim.fn.expand("~/.nvm/versions/node/v20.19.3/bin/bash-language-server"), "--stdio" },
    -- -- To disable if crashing: enabled = false,
    -- -- (Only use 'enabled = false' if this fix doesn't work and you want to suppress warnings)
  },
  -- JSON LSP
  jsonls = {},
  -- YAML LSP
  yamlls = {},
  -- HTML LSP
  html = {},
  -- CSS LSP
  cssls = {},
}

-- Loop through all defined servers and set them up
for name, opts in pairs(servers) do
  -- Set common capabilities
  opts.capabilities = capabilities

  -- Set common root_dir if not already specifically defined for a server
  -- This ensures servers without specific root_dir patterns default to .git or current dir
  opts.root_dir = opts.root_dir or
      util.root_pattern(".git", ".vscode", "package.json", "Makefile", "Cargo.toml", "go.mod", ".terraform",
        "pyproject.toml",
        "init.lua", ".git", os.getenv("HOME"))

  -- Setup the LSP server
  lspconfig[name].setup(opts)
end
