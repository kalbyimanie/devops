-- lua/plugins/main.lua

return {
  -- UI
  { "folke/tokyonight.nvim" },
  { "olimorris/onedarkpro.nvim", opts = { options = { transparency = true, styles = { comments = "italic", keywords = "bold", functions = "bold", strings = "italic" } } } },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/tokyonight.nvim" },
    config = function()
      require("lualine").setup {
        options = { icons_enabled = true },
        sections = {
          lualine_c = {
            { "filename", path = 2 }
          }
        }
      }
    end
  },
  -- Theme
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            functions = "italic,bold",
          },
        },
        groups = {
          all = {
            Visual = { bg = "#44475a", style = "bold" },
            CursorLine = { bg = "#2a2e3f" },
            CursorLineNr = { fg = "#ffffff", style = "bold" },
            IncSearch = { bg = "#ffb86c", fg = "#000000" },
          },
        },
      })
      vim.cmd("colorscheme nightfox")
    end,
  },


  {
    "ibhagwan/fzf-lua",
    config = function()
      require("fzf-lua").setup({
        winopts = {
          height = 0.85,
          width = 0.85,
          row = 0.15,
          col = 0.15,
          border = "rounded",
          preview = {
            layout = "vertical",
          },
        },
      })

      vim.keymap.set("n", "<leader>gs", "<cmd>FzfLua git_stash<CR>", { desc = "Git Stash (fzf-lua)" })
      vim.keymap.set("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", { desc = "Git Branches (fzf-lua)" })
      vim.keymap.set("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "Git Commits (fzf-lua)" })
    end
  },


  {
    "ahmedkhalf/project.nvim",
    event = "VimEnter",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "Makefile", "package.json", "pyproject.toml" },
        silent_chdir = true, -- prevents messages when switching dirs
        manual_mode = false, -- automatically change cwd
      })
      require("telescope").load_extension("projects")
    end,
  },


  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose" },
    config = function()
      require("diffview").setup()
    end,
  },


  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- Required
      "sindrets/diffview.nvim", -- Optional - Diff integration
      "ibhagwan/fzf-lua",       -- fzf-based picker
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" },
    },
    config = function()
      require("neogit").setup({
        kind = "split", -- or "vsplit", "tab", "replace"
        commit_popup = {
          kind = "vsplit",
        },
        preview_buffer = {
          kind = "split",
        },
        integrations = {
          diffview = true,   -- Use diffview if you like GUI-style diffs
          telescope = false, -- Disable telescope (you use fzf-lua)
        },
        signs = {
          section = { "", "" },
          item = { "", "" },
          hunk = { "", "" },
        },
        disable_commit_confirmation = false,
        disable_builtin_notifications = false,
        use_magit_keybindings = true, -- Optional: Enable Magit-style keys
      })
    end,
  },





  -- Dashboard (Pretty Lazy Home)
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.cmd [[
      highlight DashboardHeader guibg=NONE ctermbg=NONE
      highlight DashboardCenter guibg=NONE ctermbg=NONE
      highlight DashboardFooter guibg=NONE ctermbg=NONE
      highlight DashboardShortCut guibg=NONE ctermbg=NONE
      highlight DashboardKey guibg=NONE ctermbg=NONE
      highlight DashboardIcon guibg=NONE ctermbg=NONE
    ]]

      require("dashboard").setup({
        theme = "doom",
        config = {
          header = {
            "                                                                 ",
            "                                                                 ",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠉⠉⠉⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠁⢴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⣄⣀⣄⣀⣄⡛⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⡿⡛⠭⠂⡲⠇⠈⠉⠶⠾⠿⣮⣛⣛⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡱⠗⢠⠶⠻⠋⢱⠌⢰⢰⠞⢙⠃⣴⠈⡙⠟⠔⣌⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⡀⠺⣷⡆⢀⠃⢠⣈⠠⢈⡚⡈⡀⠄⡁⣸⠋⡑⢰⣹⡆⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢇⠁⠠⣷⣶⣵⢸⠛⠛⠒⠒⠈⡆⡇⡿⡆⠇⠀⡀⠁⠉⢌⢀⠄⠼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢱⠘⢁⠁⠹⡘⡏⡈⠀⢠⡀⣠⠀⠀⡟⠑⠦⠉⣰⠀⠀⠐⠑⢡⡐⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⡐⠲⠉⢂⠀⢀⡙⣄⡇⣧⡸⢗⠇⠀⡀⢁⢰⣀⣛⣡⣇⠀⠤⠆⢋⡑⠄⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⣠⠣⠀⠀⡀⢂⣴⣿⣧⠹⣿⣸⣇⠞⠀⠀⡧⣸⢸⣇⣸⣿⢿⢂⠀⠀⠴⠖⠉⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⣠⠳⡙⠀⡞⢀⣵⣿⣿⣿⣿⣇⠹⢿⣿⡄⠀⠀⣷⣿⣿⣿⣿⡧⠃⠀⠈⡸⡄⠚⠀⠄⠑⡀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⢤⠞⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⡄⠦⣿⠁⠀⢘⢿⣿⣿⣿⠟⡁⠀⠀⢐⠀⢿⣆⠈⣼⣷⡈⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⡿⠋⠠⠂⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣌⢼⣀⡠⠭⣁⠛⠫⣑⠩⠂⡀⠀⡈⠆⠊⣿⣧⡙⢿⣿⡆⠑⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⡿⠋⠀⡄⠂⠀⣀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣦⣉⠉⢥⡂⠙⢓⠒⠁⠐⠓⠰⠷⣾⡈⠘⣿⣿⣦⣝⠣⣇⣄⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⡿⠋⠉⢀⠐⡀⢀⣥⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢉⢭⠁⠤⠀⠢⠤⢤⣭⣵⠿⡏⣄⣔⡓⠖⠐⢹⣿⣿⣿⣷⣌⠻⡖⣄⠀⡈⠙⠟⣛⠋⢉⣉⣿⣿⣿⣿⣿",
            "⣿⠏⠀⠀⠀⠀⣡⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡀⣿⠗⡐⡁⣥⠀⢦⡔⡶⣒⢰⡦⠀⢚⣀⡘⣾⣿⣿⣿⣿⣿⣷⣦⡁⠀⠠⠒⠚⠫⠘⠿⣿⣿⣿⣿⣿⣿",
            "⠇⠀⢀⠀⣰⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢧⣇⣯⣼⠗⢠⡇⡆⡇⡇⣰⠟⣠⡚⢀⡤⠈⠑⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠈⠄⠐⠀⢄⣀⠙⢻⣿⣿⣿",
            "⣄⣀⡎⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣹⣏⢿⣏⣤⠞⠀⡟⡜⢳⡯⠼⠶⢞⣉⢚⡈⠑⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠄⠀⠉⠻⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⡿⢿⢘⣿⡏⣰⡇⣼⡱⠜⢐⣩⠠⡋⠵⠋⣀⣚⢂⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣸⣦⣴⣾⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⢸⡌⢈⠝⣿⣷⣮⣃⠿⣣⣾⣦⠵⡢⠀⠐⣊⣉⡛⠋⣆⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⡜⡸⢿⣦⡑⢮⣝⣛⣿⡄⣉⡩⠀⠈⠀⢀⣭⣝⠕⣠⢾⣿⣆⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡸⣧⣇⢲⢄⠉⢂⣙⣛⣭⡼⠟⠣⠄⣂⠒⢉⠙⢰⢛⣩⠂⢛⣿⡄⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢁⢰⠿⠿⢂⠮⠝⠪⠻⣛⢉⠂⣰⣶⣶⣶⣍⠛⠲⠷⣪⣕⡺⠟⢟⡛⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡈⢉⠽⠃⠀⡿⣿⣿⣿⠏⡐⣴⣿⣿⣿⣿⣿⡆⠁⠨⠁⣂⣬⣤⢀⢴⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⣿⣧⠀⠀⠒⢂⣨⣥⣤⣤⣴⣿⣿⣿⣿⣿⣿⣷⣶⣦⡘⣿⣿⣿⣧⡠⢠⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⣴⣿⡷⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣌⢿⣿⣿⡷⢩⡇⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠚⠿⣟⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡌⠿⠋⠉⠈⠉⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣨⣷⣮⡑⠀⢁⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢠⣴⣾⣧⢳⣦⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⡴⣿⣻⡎⢀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡖⣾⣿⡤⠎⢿⣷⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢑⠛⠙⢿⡿⢁⢢⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢹⣩⣴⣾⡜⣿⣷⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⣼⢏⣶⠌⠁⢢⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⢁⣴⣟⣷⠹⣿⣇⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢣⣿⣿⡟⠁⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣜⢿⣿⣷⣿⣿⡎⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⡾⡛⠏⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠻⣿⣿⣿⣿⡸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣼⠑⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡹⣿⣿⠿⣧⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣱⡛⢀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡜⡵⣓⣹⣮⠻⣿⣿⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⢀⠚⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡙⠉⢭⡉⢡⣝⠻⣿⣿⣿⣿⣿⣿",
            "⣿⣿⣿⣿⣿⣿⠟⠁⠤⢰⢄⠌⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⡀⠀⠀⠁⡈⠀⠀⠉⠐⢀⡹⢿",
            "⣿⣿⣿⣿⣿⣿⣶⣶⣥⣥⣤⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⣙⣀⣀⣀⣀⣀⣀⣀⣀⣈⣈⣁",
            "                                                                 ",
            "                                                                 ",
          },
          center = {
            {
              icon = " ",
              icon_hl = "DashboardIcon",
              desc = "New File",
              desc_hl = "DashboardCenter",
              key = "n",
              key_hl = "DashboardKey",
              key_format = " [%s]",
              action = "enew",
            },
            {
              icon = " ",
              icon_hl = "DashboardIcon",
              desc = "Find File",
              desc_hl = "DashboardCenter",
              key = "f",
              key_hl = "DashboardKey",
              key_format = " [%s]",
              action = "Telescope find_files",
            },
            {
              icon = " ",
              icon_hl = "DashboardIcon",
              desc = "Recent Files",
              desc_hl = "DashboardCenter",
              key = "r",
              key_hl = "DashboardKey",
              key_format = " [%s]",
              action = "Telescope oldfiles",
            },
            {
              icon = " ",
              icon_hl = "DashboardIcon",
              desc = "Load Session",
              desc_hl = "DashboardCenter",
              key = "s",
              key_hl = "DashboardKey",
              key_format = " [%s]",
              action = "lua require('auto-session.session-lens').search_session()",
            },
            {
              icon = " ",
              icon_hl = "DashboardIcon",
              desc = "Rename Session",
              desc_hl = "DashboardCenter",
              key = "Rs",
              key_hl = "DashboardKey",
              key_format = " [%s]",
              action = "lua require('custom.session_rename').rename_session()",
            },
            {
              icon = " ",
              icon_hl = "DashboardIcon",
              desc = "Open Lazy",
              desc_hl = "DashboardCenter",
              key = "l",
              key_hl = "DashboardKey",
              key_format = " [%s]",
              action = "Lazy",
            },
            {
              icon = " ",
              icon_hl = "DashboardIcon",
              desc = "Quit Neovim",
              desc_hl = "DashboardCenter",
              key = "q",
              key_hl = "DashboardKey",
              key_format = " [%s]",
              action = "qa",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
          vertical_center = true,
        },
      })
    end,
  },


  -- Notification UI
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      local notify = require("notify")
      notify.setup({
        background_colour = "#1e1e2e",
        fps = 60,
        level = vim.log.levels.INFO,
        minimum_width = 50,
        render = "compact", -- try "simple", "minimal", "default", "wrapped-compact"
        stages = "slide",   -- try "fade", "slide", "fade_in_slide_out", "static"
        timeout = 5000,
        top_down = false,
      })

      -- vim.notify = notify
      vim.notify = function(msg, ...)
        if type(msg) == "string" and msg:match("vim%.tbl_islist is deprecated") then
          return
        end
        notify(msg, ...)
      end
    end,
  },

  -- Rich UI for messages, cmdline, and LSP (Noice)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          progress = {
            enabled = true,
            format = "lsp_progress",
            throttle = 1000 / 30,
            view = "mini",
          },
          signature = { enabled = true },
          hover = { enabled = true },
          message = { enabled = true },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          lsp_doc_border = true,
        },
        views = {
          mini = {
            win_options = {
              winblend = 20,
            },
          },
          cmdline_popup = {
            position = {
              row = "50%",
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
            border = {
              style = "rounded",
              padding = { 1, 2 },
            },
            win_options = {
              winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
          },
        },
        cmdline = {
          view = "cmdline_popup",
        },
      })

      -- Highlight fixes: force white typing font in cmdline
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local hl = vim.api.nvim_set_hl
          hl(0, "NoiceCmdline", { fg = "#ffffff", bg = "NONE" })
          hl(0, "NoiceCmdlineInput", { fg = "#ffffff", bg = "NONE" })
          hl(0, "NoiceCmdlinePopup", { fg = "#ffffff", bg = "NONE" })
          hl(0, "NoiceCmdlinePopupBorder", { fg = "#ffffff", bg = "NONE" })
          hl(0, "NoiceCmdlinePrompt", { fg = "#ffffff", bg = "NONE" })
          hl(0, "NoiceCmdlineIcon", { fg = "#ffffff", bg = "NONE" })
          hl(0, "NoiceCmdlinePopupTitle", { fg = "#ffffff", bg = "NONE" })
        end,
      })
    end,
  },




  -- Highlight word under cursor
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        delay = 200,
        filetypes_denylist = { "NvimTree", "TelescopePrompt" },
      })
    end
  },


  -- Tree / File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)


        -- Smart open: directories or symlinks expand, files open in vsplit
        local function smart_open()
          local node = api.tree.get_node_under_cursor()
          if not node then return end
          if node.type == "directory" or node.type == "symlink" then
            api.tree.change_root_to_node()
          elseif node.type == "file" then
            api.node.open.vertical() -- open file in vertical split
          else
            api.node.open.edit()
          end
        end



        vim.keymap.set("n", "l", smart_open, opts("Smart Open"))
        vim.keymap.set("n", "<CR>", smart_open, opts("Open in VSplit"))
        vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts("Go up"))
        vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Go up"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))

        vim.keymap.set("n", "s", function()
          local api = require("nvim-tree.api")
          api.node.open.horizontal()
        end, opts("Open in horizontal split"))
      end


      require("nvim-tree").setup({
        on_attach = my_on_attach,
        view = { width = 30, side = "left" },
        renderer = {
          group_empty = true,
          highlight_git = true, -- ✅ enable git highlighting
          icons = {
            show = {
              git = true, -- ✅ show git icons
            },
          },
        },
        update_focused_file = {
          enable = true,
          update_root = false,
          ignore_list = {},
        },
        sync_root_with_cwd = true,
        git = {
          enable = true,  -- ✅ enable git integration
          ignore = false, -- ✅ show .gitignored files too
          timeout = 500,
        },
      })



      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case", "--hidden",
            "--glob", "!**/.git/*", "--glob", "!**/node_modules/*"
          },
          file_ignore_patterns = { "node_modules", ".git", "venv", ".next", "build" }
        },
        pickers = { find_files = { hidden = true } }
      })
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        ensure_installed = {
          "lua", "python", "javascript", "typescript", "bash", "json", "yaml",
          "html", "css", "markdown", "dockerfile", "go", "java", "c", "cpp", "rust", "tsx", "terraform"
        },
        auto_install = true
      }
    end
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        current_line_blame = true,
        current_line_blame_opts = { virt_text = true, virt_text_pos = "eol", delay = 300, ignore_whitespace = false },
        current_line_blame_formatter = "<author> • <author_time:%Y-%m-%d> • <summary>"
      }
    end
  },

  -- Comment
  { "numToStr/Comment.nvim",        config = true },

  -- Spectre
  { "nvim-pack/nvim-spectre",       dependencies = { "nvim-lua/plenary.nvim" }, config = true },

  -- Icons
  { "kyazdani42/nvim-web-devicons", config = true },

  -- ToggleTerm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup { direction = "float", open_mapping = [[<C-\>]] }
      vim.cmd [[autocmd TermOpen * startinsert]]
      vim.cmd [[tnoremap <Esc> <C-\><C-n>]]
    end
  },

  -- UFO folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'v:lua.vim.fold.foldexpr()'
      require("ufo").setup({
        provider_selector = function(_, _, _) return { "treesitter", "indent" } end
      })
    end
  },

  -- LSP / Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim"
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      require("luasnip.loaders.from_vscode").lazy_load()
      require("lspconfig").terraformls.setup({})
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").terraformls.setup({})
    end
  },
  { "williamboman/mason.nvim",      config = true },
  -- { "williamboman/mason-lspconfig.nvim", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "terraformls", "pyright", "gopls", "rust_analyzer", "ts_ls",
          "lua_ls", "bashls", "jsonls", "yamlls", "html", "cssls"
        }
      })
    end
  },

  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({ bind = true, handler_opts = { border = "rounded" } })
    end
  },


  -- Session manager
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_enable_last_session = false,
        auto_session_use_git_branch = false,
        auto_session_root_dir = vim.fn.stdpath("config") .. "/sessions/",
      })
    end
  },

  -- EditorConfig
  { "editorconfig/editorconfig-vim" },


  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    config = function()
      require("windows").setup()
    end
  },


  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('gitsigns').setup({
        signs                        = {
          add          = { hl = "GitSignsAdd", text = '┃', numhl = "GitSignsAddNr" },
          change       = { hl = "GitSignsChange", text = '┃', numhl = "GitSignsChangeNr" },
          delete       = { hl = "GitSignsDelete", text = '_', numhl = "GitSignsDeleteNr" },
          topdelete    = { hl = "GitSignsDelete", text = '‾', numhl = "GitSignsDeleteNr" },
          changedelete = { hl = "GitSignsChange", text = '~', numhl = "GitSignsChangeNr" },
          untracked    = { hl = "GitSignsAdd", text = '┆', numhl = "GitSignsAddNr" },
        },
        signs_staged                 = {
          add          = { hl = "GitSignsAdd", text = '┃' },
          change       = { hl = "GitSignsChange", text = '┃' },
          delete       = { hl = "GitSignsDelete", text = '_' },
          topdelete    = { hl = "GitSignsDelete", text = '‾' },
          changedelete = { hl = "GitSignsChange", text = '~' },
          untracked    = { hl = "GitSignsAdd", text = '┆' },
        },
        signs_staged_enable          = true,
        signcolumn                   = true,
        numhl                        = false,
        linehl                       = false,
        word_diff                    = false,
        watch_gitdir                 = {
          interval = 1000,
          follow_files = true,
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = true,
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 1000,
          ignore_whitespace = true,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        max_file_length              = 40000,
        preview_config               = {
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
          border = 'rounded',
        },
      })
    end
  },



  -- README.md Preview


  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- "echasnovski/mini.nvim", -- or mini.icons
      -- or use this instead if you're using web-devicons
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("render-markdown").setup({
        -- optional: tweak config here
      })
    end,
  },





  -- Auto format on save (Conform)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          terraform = { "terraform_fmt" },
          sh = { "shfmt" },
          python = { "black" },
          html = { "prettier" },
          css = { "prettier" },
        },
      })

      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format file" })
    end,
  },


}
