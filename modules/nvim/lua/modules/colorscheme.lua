local lush = require("lush")
local hsluv = lush.hsluv
local p = {
  bg = hsluv("#1d1c19"),
  fg = hsluv("#c5c9c5"),
  red = hsluv("#c4746e"),
  green = hsluv("#8a9a7b"),
  yellow = hsluv("#c4b28a"),
  blue = hsluv("#8ba4b0"),
  pink = hsluv("#a292a3"),
}

lush(lush(function(injected_functions)
  local transparent_background = true
  local sym = injected_functions.sym
  ---@diagnostic disable: undefined-global
  -- stylua: ignore start
  return {
    Normal          { bg = not transparent_background and p.bg or "NONE", fg = p.fg },

    Underlined      { gui = "underline" },
    Bold            { gui = "bold" },
    Italic          { gui = "italic" },

    Error           { fg = p.red },
    ErrorMsg        { Error },
    WarningMsg      { fg = p.yellow },

    Comment         { fg = p.bg.li(38).de(24) }, -- any comment
    Conceal         { fg = p.fg.da(30), gui = "bold,italic" }, -- placeholder characters substituted for concealed text (see 'conceallevel')

    Cursor          { bg = p.fg.li(20), fg = p.bg }, -- character under the cursor
    lCursor         { Cursor, bg = Cursor.bg.da(35)  }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    TermCursor      { Cursor }, -- cursor in a focused terminal
    TermCursorNC    { lCursor }, -- cursor in an unfocused terminal

    CursorLine      { bg = p.bg.li(4) }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorColumn    { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    ColorColumn     { bg = p.yellow.saturation(46).lightness(p.bg.l + 18) }, -- used for the columns set with 'colorcolumn'

    DiffAdd         { bg = p.green.saturation(50).lightness(p.bg.l + 8) }, -- diff mode: Added line |diff.txt|
    DiffChange      { bg = p.blue.saturation(50).lightness(p.bg.l + 8) }, -- diff mode: Changed line |diff.txt|
    DiffDelete      { bg = p.red.saturation(30).lightness(p.bg.l + 8) }, -- diff mode: Deleted line |diff.txt|
    DiffText        { bg = p.blue.saturation(50).lightness(p.bg.l + 20), fg = p.fg }, -- diff mode: Changed text within a changed line |diff.txt|

    LineNr          { fg = p.bg.li(35) }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    SignColumn      { LineNr }, -- column where |signs| are displayed
    FoldColumn      { LineNr, gui = "bold" }, -- 'foldcolumn'
    Folded          { bg = not transparent_background and p.bg.li(14) or "NONE", fg = p.bg.li(64) }, -- line used for closed folds
    CursorLineNr    { LineNr, fg = p.fg, gui = "bold" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.

    MoreMsg         { fg = p.green, gui = "bold" }, -- |more-prompt|
    NormalFloat     { bg = p.bg.li(10) }, -- Normal text in floating windows.
    FloatBorder     { fg = p.bg.li(46) }, -- Normal text in floating windows.

    Pmenu           { bg = p.bg.li(10) }, -- Popup menu: normal item.
    PmenuSel        { bg = p.bg.li(22) }, -- Popup menu: selected item.
    PmenuSbar       { bg = p.bg.li(32) }, -- Popup menu: scrollbar.
    PmenuThumb      { bg = p.bg.li(50) }, -- Popup menu: Thumb of the scrollbar.

    Search          { bg = p.pink.lightness(p.bg.l + 24), fg = p.fg }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    IncSearch       { bg = p.pink.lightness(p.bg.l + 56), fg = p.bg, gui = "bold" }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    -- Substitute   { }, -- |:substitute| replacement text highlighting
    MatchParen      { Search }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    CurSearch       { IncSearch },

    SpellBad        { fg = Error.fg.de(30), gui = "undercurl", guisp = Error.fg }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap        { SpellBad, guisp = Error.fg.da(10) }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal      { SpellCap }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare       { SpellBad, guisp = p.yellow }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.

    StatusLine      { bg = p.bg.li(12), fg = p.fg }, -- status line of current window
    StatusLineNC    { fg = FloatBorder.fg, bg = StatusLine.bg }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine         { StatusLine }, -- tab pages line, not active tab page label
    TabLineFill     { StatusLineNC }, -- tab pages line, where there are no labels
    TabLineSel      { gui = "bold" }, -- tab pages line, active tab page label
    VertSplit       { fg = LineNr.fg }, -- the column separating vertically split windows
    WinSeparator    { VertSplit },

    Visual          { bg = p.fg.de(18).lightness(p.bg.l + 18) }, -- Visual mode selection
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".

    NonText         { fg = p.bg.li(30) }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    SpecialKey      { NonText, gui = "italic" }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    Whitespace      { NonText }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    EndOfBuffer     { NonText }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.

    WildMenu        { bg = p.pink, fg = p.bg }, -- current match in 'wildmenu' completion
    Directory       { gui = "bold" }, -- directory names (and other special names in listings)
    Question        { MoreMsg }, -- |hit-enter| prompt and yes/no questions
    Title           { fg = p.red, gui = "bold" }, -- titles for output from ":set all", ":autocmd" etc.


    Number          { fg = p.blue }, --   a number constant: 234, 0xff
    Boolean         { Number }, --  a boolean constant: TRUE, false
    -- Float        { }, --    a floating point constant: 2.3e10
    Identifier      { fg = p.fg.da(14) }, -- (preferred) any variable name
    Constant        { Identifier }, -- (preferred) any constant
    String          { fg = p.blue }, --   a string constant: "this is a string"
    -- Character    { }, --  a character constant: 'c', '\n'
    Function        { fg = p.green }, -- function name (also: methods for classes)

    Statement       { fg = p.red }, -- (preferred) any statement
    PreProc         { Statement }, -- (preferred) generic Preprocessor

    Type            { fg = p.yellow }, -- (preferred) int, long, char, etc.
    StorageClass    { Statement }, -- static, register, volatile, etc.
    -- Structure    { }, --  struct, union, enum, etc.
    -- Typedef      { }, --  A typedef

    Special         { fg = p.pink }, -- (preferred) any special symbol
    -- SpecialChar  { }, --  special character in a constant
    -- Tag          { }, --    you can use CTRL-] on this
    Delimiter       { fg = p.bg.li(47) }, --  character that needs attention
    SpecialComment  { Comment, gui = "NONE" }, -- special things inside a comment
    -- Debug        { }, --    debugging statements

    -- ("Ignore", below, may be invisible...)
    -- Ignore       { }, -- (preferred) left blank, hidden  |hl-Ignore|

    LspReferenceText           { ColorColumn }, -- used for highlighting "text" references
    LspReferenceRead           { ColorColumn }, -- used for highlighting "read" references
    LspReferenceWrite          { ColorColumn }, -- used for highlighting "write" references
    LspCodeLens                { LineNr },

    DiagnosticError            { Error },
    DiagnosticWarn             { WarningMsg },
    DiagnosticInfo             { fg = p.blue },
    DiagnosticHint             { fg = p.green },

    DiagnosticSignError        { SignColumn, fg = DiagnosticError.fg },
    DiagnosticSignWarn         { SignColumn, fg = DiagnosticWarn.fg },
    DiagnosticSignInfo         { SignColumn, fg = DiagnosticInfo.fg },
    DiagnosticSignHint         { SignColumn, fg = DiagnosticHint.fg },

    DiagnosticVirtualTextError { DiagnosticError, bg = DiagnosticError.fg.saturation(8).lightness(p.bg.l + 8) },
    DiagnosticVirtualTextWarn  { DiagnosticWarn, bg = DiagnosticWarn.fg.saturation(8).lightness(p.bg.l + 8) },
    DiagnosticVirtualTextInfo  { DiagnosticInfo, bg = DiagnosticInfo.fg.saturation(8).lightness(p.bg.l + 8) },
    DiagnosticVirtualTextHint  { DiagnosticHint, bg = DiagnosticHint.fg.saturation(8).lightness(p.bg.l + 8) },

    DiagnosticUnderlineError   { gui = "undercurl", sp = DiagnosticError.fg },
    DiagnosticUnderlineWarn    { gui = "undercurl", sp = DiagnosticWarn.fg },
    DiagnosticUnderlineInfo    { gui = "undercurl", sp = DiagnosticInfo.fg },
    DiagnosticUnderlineHint    { gui = "undercurl", sp = DiagnosticHint.fg },
    DiagnosticUnnecessary      { DiagnosticUnderlineWarn },

    Todo                       { DiagnosticInfo }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    StatusLineError            { fg = DiagnosticError.fg, bg = StatusLine.bg },
    StatusLineWarn             { fg = DiagnosticWarn.fg, bg = StatusLine.bg },
    StatusLineInfo             { fg = DiagnosticInfo.fg, bg = StatusLine.bg },
    StatusLineHint             { fg = DiagnosticHint.fg, bg = StatusLine.bg },

    -- Tree-sitter
    sym "@annotation"            { PreProc },
    sym "@attribute"             { PreProc },
    sym "@boolean"               { Number },
    sym "@character"             { Constant },
    sym "@character.special"     { Special },
    sym "@comment"               { Comment },
    sym "@conditional"           { Statement },
    sym "@constant"              { Constant },
    sym "@constant.builtin"      { Number },
    sym "@constant.macro"        { Number },
    sym "@constructor"           { Function },
    sym "@debug"                 { Special },
    sym "@define"                { PreProc },
    sym "@exception"             { Statement },
    sym "@field"                 { Identifier },
    sym "@float"                 { Number },
    sym "@function"              { Function },
    sym "@function.builtin"      { Function },
    sym "@function.call"         { Function },
    sym "@function.macro"        { Function },
    sym "@include"               { PreProc },
    sym "@keyword"               { Statement },
    sym "@keyword.function"      { Statement },
    sym "@keyword.operator"      { Statement },
    sym "@keyword.return"        { Statement },
    sym "@label"                 { Statement },
    sym "@method"                { Function },
    sym "@method.call"           { Function },
    sym "@namespace"             { Identifier },
    sym "@none"                  { },
    sym "@number"                { Number },
    sym "@operator"              { Statement },
    sym "@parameter"             { Identifier },
    sym "@parameter.reference"   { sym "@parameter" },
    sym "@preproc"               { PreProc },
    sym "@property"              { Identifier },
    sym "@punctuation.bracket"   { Delimiter },
    sym "@punctuation.delimiter" { Delimiter },
    sym "@punctuation.special"   { Delimiter },
    sym "@repeat"                { Statement },
    sym "@string"                { String },
    sym "@string.escape"         { Special },
    sym "@string.regex"          { Special },
    sym "@string.special"        { Special },
    sym "@symbol"                { Identifier },
    sym "@tag"                   { Special },
    sym "@tag.attribute"         { sym "@property" },
    sym "@tag.delimiter"         { Delimiter },
    sym "@text"                  { sym "@none" },
    sym "@text.danger"           { Error },
    sym "@text.emphasis"         { Italic },
    sym "@text.environment"      { PreProc },
    sym "@text.environment.name" { Type },
    sym "@text.literal"          { Constant },
    sym "@text.math"             { Special },
    sym "@text.note"             { DiagnosticInfo },
    sym "@text.reference"        { Constant },
    sym "@text.strike"           { gui = "strikethrough" },
    sym "@text.strong"           { Bold },
    sym "@text.title"            { Title },
    sym "@text.underline"        { Underlined },
    sym "@text.uri"              { Underlined },
    sym "@text.warning"          { WarningMsg },
    sym "@todo"                  { Todo },
    sym "@type"                  { Type },
    sym "@type.builtin"          { Type },
    sym "@type.definition"       { Type },
    sym "@type.qualifier"        { Statement },
    sym "@variable"              { Identifier },
    sym "@variable.builtin"      { Number },

    sym "@punctuation.special.markdown" { Special },
    sym "@string.escape.markdown"       { SpecialKey },
    sym "@text.reference.markdown"      { Identifier, gui = "underline" },
    sym "@text.emphasis.markdown"       { Italic },
    sym "@text.title.markdown"          { Statement },
    sym "@text.literal.markdown"        { Type },
    sym "@text.uri.markdown"            { SpecialComment },

    diffAdded                 { fg = p.green },
    diffRemoved               { fg = p.red },
    diffChanged               { fg = p.blue },
    diffOldFile               { fg = p.red, gui = "italic" },
    diffNewFile               { fg = p.green, gui = "italic" },
    diffFile                  { fg = p.yellow, gui = "bold" },
    diffLine                  { fg = p.pink, gui = "bold" },
    diffIndexLine             { fg = p.yellow },

    sym "@text.diff.add"      { diffAdded },
    sym "@text.diff.delete"   { diffRemoved },

    gitcommitOverflow         { WarningMsg },

    markdownUrl               { SpecialComment },
    markdownCode              { Type },
    markdownLinkText          { Identifier, gui = "underline" },
    markdownLinkTextDelimiter { Delimiter },

    helpHyperTextEntry        { Special },
    helpHyperTextJump         { Constant },
    helpSpecial               { Type },
    helpOption                { Constant },

    GitSignsAdd               { SignColumn, fg = p.green },
    GitSignsChange            { SignColumn, fg = p.blue },
    GitSignsDelete            { SignColumn, fg = p.red },

    LeapMatch                 { gui = "bold,underline,nocombine" },
    LeapLabelPrimary          { Search , gui = "bold,nocombine" },
    LeapLabelSecondary        { DiffText, gui = "bold,nocombine" },
    LeapLabelSelected         { IncSearch },

    NvimTreeNormal            { Normal, bg = not transparent_background and p.bg.li(3) or "NONE" },
    NvimTreeWinSeparator      { WinSeparator },
    NvimTreeCursorLine        { bg = StatusLineNC.bg },
    NvimTreeCursorColumn      { NvimTreeCursorLine  },
    NvimTreeRootFolder        { fg = p.blue, gui = "bold" },
    NvimTreeSymlink           { fg = p.blue },
    NvimTreeGitDirty          { diffChanged },
    NvimTreeGitNew            { diffAdded },
    NvimTreeGitDeleted        { diffRemoved },
    NvimTreeSpecialFile       { fg = p.pink, gui = "underline" },

    CmpItemAbbr               { fg = p.fg.da(14) },
    CmpItemAbbrDeprecated     { fg = p.fg.da(42) },
    CmpItemAbbrMatch          { fg = p.fg, gui = "bold"  },
    CmpItemAbbrMatchFuzzy     { fg = p.fg, gui = "bold" },
    CmpItemKind               { fg = p.fg },
    CmpItemMenu               { fg = p.fg },

    FzfLuaBufFlagCur          { fg = p.red },
    FzfLuaHeaderText          { fg = p.red },
  }
  -- stylua: ignore end
  ---@diagnostic enable: undefined-global
end))
