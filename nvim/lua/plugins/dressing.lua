local ok, dressing = pcall(require, 'dressing')
if not ok then return end

local telescope, themes
ok, themes = pcall(require, "telescope.themes")
if ok then
  telescope = themes.get_cursor({ initial_mode = "normal" })
end

dressing.setup({
  select = {
    telescope = telescope
  },
})
