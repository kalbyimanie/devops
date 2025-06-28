-- init.lua

-- Set <leader> before anything else
vim.g.mapleader = " "
-- Increase file descriptor limit for Neovim subprocesses
-- vim.env.LIMIT_NOFILE = "1048576"

vim.o.signcolumn = "yes"
vim.lsp.set_log_level("error")



-- Core options
require("core.options")

-- Lazy plugin manager bootstrapping
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy and load plugins
require("lazy").setup("plugins", {
  change_detection = { enabled = true, notify = true },
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙️",
      keys = "🗝️",
      plugin = "🔌",
      runtime = "💡",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})


-- Defer loading keymaps until all plugins are ready
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("core.keymaps")
  end,
})

-- Optional: load non-plugin Lua code after Lazy is ready
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("plugins.main") -- if this contains non-plugin logic
  end,
})

-- Disable LSP watching too many files (for large codebases)
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
  wf._watchfunc = function() return function() end end
end


-- lsp options
require("lsp.configs")
