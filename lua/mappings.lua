require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- transform previous mapping to use map function
map("n", "<leader>tn", "<cmd>lua require('neotest').run.run()<CR>", { desc = "Run nearest test" })
map("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "Run file tests" })
map("n", "<leader>to", "<cmd>lua require('neotest').output.open()<CR>", { desc = "Open test output" })
map("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", { desc = "Toggle test summary" })
