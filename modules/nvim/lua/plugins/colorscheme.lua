vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_visual = "reverse"

vim.cmd("colorscheme gruvbox-material")

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("VirtualTextError", { ctermfg = 167, fg = "#c14a4a" })
hl("VirtualTextWarning", { ctermfg = 214, fg = "#b47109" })
hl("VirtualTextInfo", { ctermfg = 109, fg = "#45707a" })
hl("VirtualTextHint", { ctermfg = 142, fg = "#6c782e" })
hl("TSField", { link = "Fg" })
hl("TSNamespace", { link = "Fg" })
hl("NvimTreeFolderIcon", { link = "Blue" })
hl("FidgetTask", { link = "Comment" })
hl("Search", { ctermfg = 235, ctermbg = 167, fg = "#282828", bg = "#ea6962" })

for kind, color in pairs({
  IconsFile = "Green",
  IconsModule = "Green",
  IconsNamespace = "Green",
  IconsPackage = "Green",
  IconsClass = "Green",
  IconsMethod = "Green",
  IconsProperty = "Green",
  IconsField = "Green",
  IconsConstructor = "Green",
  IconsEnum = "Green",
  IconsInterface = "Green",
  IconsFunction = "Green",
  IconsVariable = "Green",
  IconsConstant = "Green",
  IconsString = "Green",
  IconsNumber = "Green",
  IconsBoolean = "Green",
  IconsArray = "Green",
  IconsObject = "Green",
  IconsKey = "Green",
  IconsNull = "Green",
  IconsEnumMember = "Green",
  IconsStruct = "Green",
  IconsEvent = "Green",
  IconsOperator = "Green",
  IconsTypeParameter = "Blue",
  Separator = "Grey",
  Text = "Grey"
}) do
  hl("Navic" .. kind, { link = color })
end
