local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

vim.keymap.set("n", "<F4>", dap.toggle_breakpoint)
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<F8>", dapui.toggle)

require("modules.languages.go").update_dap(dap)
