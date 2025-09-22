require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "kj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local function in_oil() return vim.bo.filetype == "oil" end
local act = function() return require("oil.actions") end

map("n", "<C-s>", function() if in_oil() then act().select.callback({ vertical = true }) else vim.cmd("silent! write") end end,
  { desc = "Oil: Open vsplit  | Save file" })
map("n", "<C-h>", function() if in_oil() then act().select.callback({ horizontal = true }) else vim.cmd("wincmd h") end end,
  { desc = "Oil: Open split   | Window left" })
map("n", "<C-t>", function() if in_oil() then act().select.callback({ tab = true }) else vim.cmd("tabnew") end end,
  { desc = "Oil: Open tab     | New tab" })
map("n", "<C-l>", function() if in_oil() then act().refresh.callback() else vim.cmd("wincmd l") end end,
  { desc = "Oil: Refresh      | Window right" })
map("n", "<C-p>", function() if in_oil() then act().preview.callback() else vim.cmd("bprevious") end end,
  { desc = "Oil: Preview      | Prev buffer" })
map("n", "q", function() if in_oil() then act().close.callback() else vim.cmd("close") end end,
  { desc = "Oil: Close        | Close window" })


