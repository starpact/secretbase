local status_ok, signature = pcall(require, "lsp_signature")
if not status_ok then
  return
end

signature.setup({
  hint_enable = false,
  floating_window_above_cur_line = true,
  doc_lines = 0,
  hi_parameter = "green",
  bind = true,
  handler_opts = {
    border = "none",
  },
})
