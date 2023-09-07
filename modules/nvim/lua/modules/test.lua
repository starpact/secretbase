vim.g["test#custom_strategies"] = {
  tmux_pane = function(cmd)
    local function send_command()
      vim.fn.jobstart({ "tmux", "send-key", "-t", ".2", cmd .. "\n" })
    end
    vim.fn.jobstart({ "tmux", "list-panes" }, {
      stdout_buffered = true, -- get all stdout rather than line by line
      on_stdout = function(_, data)
        if #data >= 3 then -- at least 2 lines for pane info and 1 empty string for EOF
          send_command()
        else
          vim.fn.jobstart({ "tmux", "split-window" }, {
            on_stdout = send_command,
          })
        end
      end,
    })
  end,
}

vim.g["test#strategy"] = "tmux_pane"

vim.g["test#go#runner"] = "gotest"
vim.g["test#go#gotest#options"] = "-v -race -failfast --count=1"

vim.g["test#rust#runner"] = "cargotest"
vim.g["test#rust#cargotest#options"] = "-- --nocapture --include-ignored"

vim.g["test#python#runner"] = "pyunit"

vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<CR>")
vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<CR>")
