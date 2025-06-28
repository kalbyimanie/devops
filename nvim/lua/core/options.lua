-- lua/core/options.lua
vim.opt.mouse = 'a'
vim.opt.title = true
vim.opt.titlestring = "%F"
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.guifont = "FiraCode Nerd Font:h10"
vim.opt.guicursor = "n-v-c-i-r:ver25,r:hor25"
vim.opt.equalalways = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 10
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NormalNC guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NormalFloat guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight FloatBorder guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight TelescopeNormal guibg=NONE ctermbg=NONE]])
vim.cmd([[highlight NvimTreeNormal guibg=NONE ctermbg=NONE]])
-- Show diagnostics in a floating window automatically when hovering
vim.o.updatetime = 200 -- Trigger CursorHold quicker

-- Show diagnostics in Normal mode
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = "● ",
      scope = "cursor",
    })
  end
})

-- Show diagnostics in Insert mode
vim.api.nvim_create_autocmd("CursorHoldI", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertLeave", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = "● ",
      scope = "cursor",
    })
  end
})


-- Set global diagnostic configuration to show all severities
vim.diagnostic.config({
    virtual_text = {
        -- Show all severities (errors, warnings, info, hints) as virtual text
        min_severity = vim.diagnostic.severity.HINT, -- IMPORTANT: Set to HINT to see all messages
        spacing = 4,
        prefix = "●",
        update_in_insert = true, -- Update diagnostics while in insert mode
    },
    signs = true, -- Show signs in the sign column for diagnostics
    float = {
        border = "rounded",
        focusable = false,
        -- Show all severities in floating windows (on CursorHold)
        min_severity = vim.diagnostic.severity.HINT, -- IMPORTANT: Set to HINT to see all messages
    },
    underline = true, -- Underline problematic code
    update_in_insert = true, -- Update diagnostics while in insert mode
})



vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("lsp.configs")
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("core.cmp")
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      border = "rounded",
      source = "always",
      prefix = "● ",
      scope = "cursor",
    })
  end,
})


vim.filetype.add({
  extension = {
    tf = "terraform",
    tfvars = "terraform",
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})
