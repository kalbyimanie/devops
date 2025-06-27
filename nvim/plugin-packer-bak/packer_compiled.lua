-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/kalbyimanie/.cache/nvim/packer_hererocks/2.1.1748459687/share/lua/5.1/?.lua;/Users/kalbyimanie/.cache/nvim/packer_hererocks/2.1.1748459687/share/lua/5.1/?/init.lua;/Users/kalbyimanie/.cache/nvim/packer_hererocks/2.1.1748459687/lib/luarocks/rocks-5.1/?.lua;/Users/kalbyimanie/.cache/nvim/packer_hererocks/2.1.1748459687/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/kalbyimanie/.cache/nvim/packer_hererocks/2.1.1748459687/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["HighStr.nvim"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/HighStr.nvim",
    url = "https://github.com/Pocco81/HighStr.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\nH\0\0\4\0\5\0\t6\0\0\0009\0\1\0009\0\2\0006\2\0\0009\2\1\0029\2\3\2B\2\1\2'\3\4\0D\0\3\0\a:t\vgetcwd\16fnamemodify\afn\bvimP\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\19search_session\30auto-session.session-lens\frequire”\6\1\0\n\0&\1:6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\18\3\0\0009\1\4\0'\4\5\0B\1\3\2\14\0\1\0X\1\3Ä\18\1\0\0'\2\6\0&\0\2\0016\1\a\0'\3\b\0\18\4\0\0&\3\4\3B\1\2\0016\1\t\0'\3\n\0B\1\2\0029\1\v\0015\3\f\0=\0\r\0035\4\14\0=\4\15\0035\4\16\0005\5\18\0005\6\17\0=\6\19\0055\6\20\0=\6\21\0055\6\22\0=\6\23\5=\5\24\4=\4\25\0035\4\27\0006\5\0\0009\5\1\0059\5\2\5'\a\26\0B\5\2\2=\5\28\4=\4\29\0033\4\30\0=\4\31\0036\4\0\0009\4 \0049\4!\4'\6\"\0'\a#\0003\b$\0005\t%\0B\4\5\0?\4\0\0B\1\2\1K\0\1\0\1\0\1\tdesc\25üîç Search sessions\0\14<leader>z\6n\bset\vkeymap\22auto_session_name\0\20session_control\16control_dir\1\0\1\16control_dir\0\29~/.config/nvim/sessions/\17session_lens\rmappings\17copy_session\1\3\0\0\6i\n<C-Y>\22alternate_session\1\3\0\0\6i\n<C-S>\19delete_session\1\0\3\19delete_session\0\17copy_session\0\22alternate_session\0\1\3\0\0\6i\n<C-D>\1\0\3\rmappings\0\16picker_opts\0\18load_on_setup\2\20suppressed_dirs\1\5\0\0\a~/\15~/Projects\16~/Downloads\6/\rroot_dir\1\0\6\22auto_session_name\0\14log_level\nerror\rroot_dir\0\20session_control\0\17session_lens\0\20suppressed_dirs\0\nsetup\17auto-session\frequire%Auto-session config: root_dir = \nprint\6/\a/$\nmatch\28~/.config/nvim/sessions\vexpand\afn\bvim\3ÄÄ¿ô\4\0" },
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nï\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\28current_line_blame_opts\1\0\4\22ignore_whitespace\1\18virt_text_pos\beol\14virt_text\2\ndelay\3¨\2\1\0\3\23current_line_blame\2!current_line_blame_formatter6<author> ‚Ä¢ <author_time:%Y-%m-%d> ‚Ä¢ <summary>\28current_line_blame_opts\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-spectre"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fspectre\frequire\0" },
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/nvim-spectre",
    url = "https://github.com/nvim-pack/nvim-spectre"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ufo"] = {
    config = { "\27LJ\2\n%\0\3\4\0\1\0\0025\3\0\0L\3\2\0\1\3\0\0\15treesitter\vindent∞\2\1\0\4\0\17\0!6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1c\0=\1\4\0006\0\0\0009\0\1\0)\1c\0=\1\5\0006\0\0\0009\0\1\0+\1\2\0=\1\6\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0006\0\v\0'\2\f\0B\0\2\0029\0\r\0005\2\15\0003\3\14\0=\3\16\2B\0\2\1K\0\1\0\22provider_selector\1\0\1\22provider_selector\0\0\nsetup\bufo\frequire\30v:lua.vim.fold.foldexpr()\rfoldexpr\texpr\15foldmethod\15foldenable\19foldlevelstart\14foldlevel\0061\15foldcolumn\6o\bvim\0" },
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/nvim-ufo",
    url = "https://github.com/kevinhwang91/nvim-ufo"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["onedarkpro.nvim"] = {
    config = { "\27LJ\2\n\1\0\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0\29colorscheme onedark_dark\bcmd\bvim\foptions\1\0\1\foptions\0\vstyles\1\0\4\fstrings\vitalic\rkeywords\tbold\rcomments\vitalic\14functions\tbold\1\0\2\17transparency\2\vstyles\0\nsetup\15onedarkpro\frequire\0" },
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/onedarkpro.nvim",
    url = "https://github.com/olimorris/onedarkpro.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["promise-async"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\nb\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14direction\nfloat\17open_mapping\n<C-\\>\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/kalbyimanie/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nï\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\28current_line_blame_opts\1\0\4\22ignore_whitespace\1\18virt_text_pos\beol\14virt_text\2\ndelay\3¨\2\1\0\3\23current_line_blame\2!current_line_blame_formatter6<author> ‚Ä¢ <author_time:%Y-%m-%d> ‚Ä¢ <summary>\28current_line_blame_opts\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\nH\0\0\4\0\5\0\t6\0\0\0009\0\1\0009\0\2\0006\2\0\0009\2\1\0029\2\3\2B\2\1\2'\3\4\0D\0\3\0\a:t\vgetcwd\16fnamemodify\afn\bvimP\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\19search_session\30auto-session.session-lens\frequire”\6\1\0\n\0&\1:6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\18\3\0\0009\1\4\0'\4\5\0B\1\3\2\14\0\1\0X\1\3Ä\18\1\0\0'\2\6\0&\0\2\0016\1\a\0'\3\b\0\18\4\0\0&\3\4\3B\1\2\0016\1\t\0'\3\n\0B\1\2\0029\1\v\0015\3\f\0=\0\r\0035\4\14\0=\4\15\0035\4\16\0005\5\18\0005\6\17\0=\6\19\0055\6\20\0=\6\21\0055\6\22\0=\6\23\5=\5\24\4=\4\25\0035\4\27\0006\5\0\0009\5\1\0059\5\2\5'\a\26\0B\5\2\2=\5\28\4=\4\29\0033\4\30\0=\4\31\0036\4\0\0009\4 \0049\4!\4'\6\"\0'\a#\0003\b$\0005\t%\0B\4\5\0?\4\0\0B\1\2\1K\0\1\0\1\0\1\tdesc\25üîç Search sessions\0\14<leader>z\6n\bset\vkeymap\22auto_session_name\0\20session_control\16control_dir\1\0\1\16control_dir\0\29~/.config/nvim/sessions/\17session_lens\rmappings\17copy_session\1\3\0\0\6i\n<C-Y>\22alternate_session\1\3\0\0\6i\n<C-S>\19delete_session\1\0\3\19delete_session\0\17copy_session\0\22alternate_session\0\1\3\0\0\6i\n<C-D>\1\0\3\rmappings\0\16picker_opts\0\18load_on_setup\2\20suppressed_dirs\1\5\0\0\a~/\15~/Projects\16~/Downloads\6/\rroot_dir\1\0\6\22auto_session_name\0\14log_level\nerror\rroot_dir\0\20session_control\0\17session_lens\0\20suppressed_dirs\0\nsetup\17auto-session\frequire%Auto-session config: root_dir = \nprint\6/\a/$\nmatch\28~/.config/nvim/sessions\vexpand\afn\bvim\3ÄÄ¿ô\4\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: onedarkpro.nvim
time([[Config for onedarkpro.nvim]], true)
try_loadstring("\27LJ\2\n\1\0\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0\29colorscheme onedark_dark\bcmd\bvim\foptions\1\0\1\foptions\0\vstyles\1\0\4\fstrings\vitalic\rkeywords\tbold\rcomments\vitalic\14functions\tbold\1\0\2\17transparency\2\vstyles\0\nsetup\15onedarkpro\frequire\0", "config", "onedarkpro.nvim")
time([[Config for onedarkpro.nvim]], false)
-- Config for: nvim-spectre
time([[Config for nvim-spectre]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fspectre\frequire\0", "config", "nvim-spectre")
time([[Config for nvim-spectre]], false)
-- Config for: nvim-ufo
time([[Config for nvim-ufo]], true)
try_loadstring("\27LJ\2\n%\0\3\4\0\1\0\0025\3\0\0L\3\2\0\1\3\0\0\15treesitter\vindent∞\2\1\0\4\0\17\0!6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1c\0=\1\4\0006\0\0\0009\0\1\0)\1c\0=\1\5\0006\0\0\0009\0\1\0+\1\2\0=\1\6\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0006\0\v\0'\2\f\0B\0\2\0029\0\r\0005\2\15\0003\3\14\0=\3\16\2B\0\2\1K\0\1\0\22provider_selector\1\0\1\22provider_selector\0\0\nsetup\bufo\frequire\30v:lua.vim.fold.foldexpr()\rfoldexpr\texpr\15foldmethod\15foldenable\19foldlevelstart\14foldlevel\0061\15foldcolumn\6o\bvim\0", "config", "nvim-ufo")
time([[Config for nvim-ufo]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\nb\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14direction\nfloat\17open_mapping\n<C-\\>\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
