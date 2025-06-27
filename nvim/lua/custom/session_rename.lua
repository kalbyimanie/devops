-- ~/.config/nvim/lua/custom/session_rename.lua

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local Path = require("plenary.path")
local scandir = require("plenary.scandir")

local M = {}

local session_dir = vim.fn.stdpath("config") .. "/sessions/"

function M.rename_session()
  local session_files = scandir.scan_dir(session_dir, { depth = 1, add_dirs = false })
  local entries = vim.tbl_map(function(path)
    return Path:new(path):make_relative(session_dir)
  end, session_files)

  if vim.tbl_isempty(entries) then
    vim.notify("No sessions found", vim.log.levels.WARN)
    return
  end

  pickers.new({}, {
    prompt_title = "Rename Session",
    finder = finders.new_table({
      results = entries,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry, -- for fuzzy matching
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        if not selection or not selection.value then
          vim.notify("No session selected or invalid entry", vim.log.levels.WARN)
          return
        end

        actions.close(prompt_bufnr)

        local old_name = selection.value
        vim.ui.input({ prompt = "Rename to: ", default = old_name }, function(new_name)
          if not new_name or new_name == "" or new_name == old_name then
            vim.notify("Invalid new name", vim.log.levels.WARN)
            return
          end

          local old_path = session_dir .. old_name
          local new_path = session_dir .. new_name

          local ok, err = os.rename(old_path, new_path)
          if not ok then
            vim.notify("Rename failed: " .. (err or "unknown error"), vim.log.levels.ERROR)
          else
            vim.notify("Renamed session to: " .. new_name, vim.log.levels.INFO)
          end
        end)
      end)
      return true
    end,
  }):find()
end

return M
