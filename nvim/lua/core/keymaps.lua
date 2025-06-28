-- lua/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>rl", function()
  vim.cmd("Lazy sync")
  vim.notify("Plugins synced successfully ✅", vim.log.levels.INFO, { title = "Lazy.nvim" })
end, { desc = "Lazy: Sync plugins" })

vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<CR>", { desc = "Lazy: Open UI" })
keymap("n", "<leader>ss", ":SessionSave<CR>", { desc = "💾 Save session" })
keymap("n", "<leader>sr", ":SessionRestore<CR>", { desc = "🔄 Restore session" })
vim.keymap.set('n', '<leader>z', function()
  require('auto-session.session-lens').search_session()
end, { desc = "🔍 Search sessions" })

-- Telescope
keymap("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Telescope: Find Files" })
keymap("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Telescope: Live Grep" })
keymap("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Telescope: Buffers" })
keymap("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Telescope: Help Tags" })
keymap("n", "<leader>km", require("telescope.builtin").keymaps, { desc = "Telescope: Keymaps" })
keymap("n", "<leader>H", require("telescope.builtin").command_history, { desc = "Telescope: Command history" })

-- Git terminal
keymap("n", "<leader>gt", function()
  local Terminal = require("toggleterm.terminal").Terminal
  Terminal:new({
    cmd = os.getenv("SHELL"),
    dir = vim.fn.expand("%:p:h"),
    direction = "float",
  }):toggle()
end, { desc = "Git Terminal" })

-- Python Runner
keymap("n", "<leader>py", function()
  local file = vim.fn.expand("%:p")
  vim.ui.input({ prompt = "Run args (blank for none):" }, function(input)
    if input == nil then return end
    local cmd = string.format([[bash -c "python3 '%s' %s; read -p '[Enter to exit]'"]], file, input)
    require("toggleterm.terminal").Terminal:new({ cmd = cmd, hidden = true, direction = "float" }):toggle()
  end)
end, { desc = "Run Python with args" })

-- Bash Runner
keymap("n", "<leader>xs", function()
  local file = vim.fn.expand("%:p")
  vim.ui.input({ prompt = "Bash args (blank for none):" }, function(input)
    if input == nil then return end
    local cmd = string.format([[bash -c "bash '%s' %s; read -p '[Enter to exit]'"]], file, input)
    require("toggleterm.terminal").Terminal:new({ cmd = cmd, hidden = true, direction = "float" }):toggle()
  end)
end, { desc = "Run Bash script" })

-- Truncate file
keymap("n", "<leader>tt", function()
  vim.cmd("!truncate -s 0 %")
  vim.cmd("edit!")
end, { desc = "Truncate current file" })

-- Diagnostics
keymap("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, {
    border = "rounded",
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  })
end, { desc = "Show diagnostics" })

-- Spectre
keymap("n", "<leader>S", "<cmd>lua require('spectre').toggle()<CR>", { desc = "Toggle Spectre" })

-- Terminal splits
keymap("n", "<leader>th", ":split | terminal<CR>", { desc = "Terminal: Horizontal" })
keymap("n", "<leader>tv", ":vsplit | terminal<CR>", { desc = "Terminal: Vertical" })

-- Font resize
keymap("n", "<leader>-", function()
  local current = tonumber(string.match(vim.o.guifont, "h(%d+)") or 10)
  vim.o.guifont = "FiraCode Nerd Font:h" .. (current - 1)
end, { desc = "Font: Decrease" })
keymap("n", "<leader>=", function()
  local current = tonumber(string.match(vim.o.guifont, "h(%d+)") or 10)
  vim.o.guifont = "FiraCode Nerd Font:h" .. (current + 1)
end, { desc = "Font: Increase" })




vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })




vim.keymap.set("n", "<leader>gs", function()
  if vim.fn.isdirectory(".git") == 1 then
    require("telescope.builtin").git_stash()
  else
    vim.notify("Not inside a Git repository", vim.log.levels.WARN)
  end
end, { desc = "Git Stashes" })


-- Resize splits with arrow keys
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Resize up" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Resize down" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize left" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize right" })



vim.keymap.set("n", "<leader>gd", function()
  local file = vim.fn.expand("%:p") -- use full path
  local input = vim.fn.input("Compare (branch1...branch2, leave blank for history): ")

  -- Load Diffview if it's not already
  vim.cmd("packadd diffview.nvim")

  if input == nil or input == "" then
    vim.cmd("DiffviewFileHistory " .. file)
  else
    vim.cmd("DiffviewOpen " .. input .. " -- " .. file)
  end
end, { desc = "Diff current file between branches or history" })

vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })



vim.keymap.set("n", "<leader>mp", function()
  require("render-markdown").toggle()
end, { desc = "Toggle Markdown Preview" })
