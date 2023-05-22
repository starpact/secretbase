local lush = require("lush")
local hsluv = lush.hsluv

local function generate(p, opt)
  local p1 = {
    bg = p.bg,
    fg1 = p.fg.da(10),
    fg2 = p.fg.da(14),
    fg3 = p.fg.da(20),
    fg4 = p.fg.da(24),
    fg5 = p.fg.da(30),
    fg6 = p.fg.da(42),
  }

	---@diagnostic disable: undefined-global
	-- stylua: ignore start
	return lush(function(injected_functions)
		local sym = injected_functions.sym
		return {
			Normal          { bg = not opt.transparent_background and p1.bg or "NONE", fg = p.fg }, -- normal text

			Underlined      { gui = "underline" }, -- (preferred) text that stands out, HTML links
			Bold            { gui = "bold" },
			Italic          { gui = "italic" },

			Error           { fg = p.rose }, -- (preferred) any erroneous construct
			ErrorMsg        { Error }, -- error messages on the command line
			WarningMsg      { fg = p.wood }, -- warning messages

			Comment         { fg = p1.bg.li(38).de(24) }, -- any comment
			Conceal         { fg = p1.fg5, gui = "bold,italic" }, -- placeholder characters substituted for concealed text (see 'conceallevel')

			Cursor          { bg = p.fg.li(20), fg = p1.bg }, -- character under the cursor
			lCursor         { Cursor, bg = Cursor.bg.da(35)  }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
			-- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
			TermCursor      { Cursor }, -- cursor in a focused terminal
			TermCursorNC    { lCursor }, -- cursor in an unfocused terminal

			CursorLine      { bg = p1.bg.li(4) }, -- Screen-line at the cursor, when 'cursorline' is set.	Low-priority if foreground (ctermfg OR guifg) is not set.
			CursorColumn    { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
			ColorColumn     { bg = p.wood.saturation(46).lightness(p1.bg.l + 18) }, -- used for the columns set with 'colorcolumn'

			DiffAdd         { bg = p.leaf.saturation(50).lightness(p1.bg.l + 8) }, -- diff mode: Added line |diff.txt|
			DiffChange      { bg = p.water.saturation(50).lightness(p1.bg.l + 8) }, -- diff mode: Changed line |diff.txt|
			DiffDelete      { bg = p.rose.saturation(30).lightness(p1.bg.l + 8) }, -- diff mode: Deleted line |diff.txt|
			DiffText        { bg = p.water.saturation(50).lightness(p1.bg.l + 20), fg = p.fg }, -- diff mode: Changed text within a changed line |diff.txt|

			LineNr          { fg = p1.bg.li(35) }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
			SignColumn      { LineNr }, -- column where |signs| are displayed
			FoldColumn      { LineNr, gui = "bold" }, -- 'foldcolumn'
			Folded          { bg = not opt.transparent_background and p1.bg.li(14) or "NONE", fg = p1.bg.li(64) }, -- line used for closed folds
			CursorLineNr    { LineNr, fg = p.fg, gui = "bold" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.

			-- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
			-- MsgArea      { }, -- Area for messages and cmdline
			-- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
			MoreMsg         { fg = p.leaf, gui = "bold" }, -- |more-prompt|
			NormalFloat     { bg = p1.bg.li(10) }, -- Normal text in floating windows.
			FloatBorder     { fg = p1.bg.li(46), bg = opt.solid_float_border and NormalFloat.bg or "NONE" }, -- Normal text in floating windows.

			Pmenu           { bg = p1.bg.li(10) }, -- Popup menu: normal item.
			PmenuSel        { bg = p1.bg.li(22) }, -- Popup menu: selected item.
			PmenuSbar       { bg = p1.bg.li(32) }, -- Popup menu: scrollbar.
			PmenuThumb      { bg = p1.bg.li(50) }, -- Popup menu: Thumb of the scrollbar.

			Search          { bg = p.blossom.lightness(p1.bg.l + 24), fg = p.fg }, -- Last search pattern highlighting (see 'hlsearch').	Also used for similar items that need to stand out.
			IncSearch       { bg = p.blossom.lightness(p1.bg.l + 56), fg = p1.bg, gui = "bold" }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
			-- Substitute   { }, -- |:substitute| replacement text highlighting
			MatchParen      { Search }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
			-- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
			CurSearch       { IncSearch },

			SpellBad        { fg = Error.fg.de(30), gui = "undercurl", guisp = Error.fg }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
			SpellCap        { SpellBad, guisp = Error.fg.da(10) }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
			SpellLocal      { SpellCap }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
			SpellRare       { SpellBad, guisp = p.wood }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.

			StatusLine      { bg = p1.bg.li(12), fg = p.fg }, -- status line of current window
      StatusLineNC    { fg = FloatBorder.fg, bg = StatusLine.bg }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
			TabLine         { StatusLine }, -- tab pages line, not active tab page label
			TabLineFill     { StatusLineNC }, -- tab pages line, where there are no labels
			TabLineSel      { gui = "bold" }, -- tab pages line, active tab page label
			VertSplit       { fg = LineNr.fg, bg = opt.solid_vert_split and StatusLineNC.bg or "NONE" }, -- the column separating vertically split windows
			WinSeparator    { VertSplit },

			Visual          { bg = p.fg.de(18).lightness(p1.bg.l + 18) }, -- Visual mode selection
			-- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".

			NonText         { fg = p1.bg.li(opt.lighten_non_text or 30) }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
			SpecialKey      { NonText, gui = "italic" }, -- Unprintable characters: text displayed differently from what it really is.	But not 'listchars' whitespace. |hl-Whitespace|
			Whitespace      { NonText }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
			EndOfBuffer     { NonText }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.

			WildMenu        { bg = p.blossom, fg = p1.bg }, -- current match in 'wildmenu' completion
			Directory       { gui = "bold" }, -- directory names (and other special names in listings)
			Question        { MoreMsg }, -- |hit-enter| prompt and yes/no questions
			Title           { fg = p.rose, gui = "bold" }, -- titles for output from ":set all", ":autocmd" etc.


			-- These groups are not listed as default vim groups,
			-- but they are defacto standard group names for syntax highlighting.
			-- commented out groups should chain up to their "preferred" group by
			-- default,
			-- Uncomment and edit if you want more specific syntax highlighting.

			Number          { fg = p.water }, --   a number constant: 234, 0xff
			Boolean         { Number }, --  a boolean constant: TRUE, false
			-- Float        { }, --    a floating point constant: 2.3e10
			Identifier      { fg = p1.fg2 }, -- (preferred) any variable name
			Constant        { Identifier }, -- (preferred) any constant
			String          { fg = p.water }, --   a string constant: "this is a string"
			-- Character    { }, --  a character constant: 'c', '\n'
			Function        { fg = p.leaf }, -- function name (also: methods for classes)

			Statement       { fg = p.rose }, -- (preferred) any statement
			-- Conditional  { }, --  if, then, else, endif, switch, etc.
			-- Repeat       { }, --   for, do, while, etc.
			-- Label        { }, --    case, default, etc.
			-- Operator     { }, -- "sizeof", "+", "*", etc.
			-- Keyword      { }, --  any other keyword
			-- Exception    { }, --  try, catch, throw

			PreProc         { Statement }, -- (preferred) generic Preprocessor
			-- Include      { }, --  preprocessor #include
			-- Define       { }, --   preprocessor #define
			-- Macro        { }, --    same as Define
			-- PreCondit    { }, --  preprocessor #if, #else, #endif, etc.

			Type            { fg = p.wood }, -- (preferred) int, long, char, etc.
			StorageClass    { Statement }, -- static, register, volatile, etc.
			-- Structure    { }, --  struct, union, enum, etc.
			-- Typedef      { }, --  A typedef

			Special         { fg = p.blossom }, -- (preferred) any special symbol
			-- SpecialChar  { }, --  special character in a constant
			-- Tag          { }, --    you can use CTRL-] on this
			Delimiter       { fg = p1.bg.li(47) }, --	character that needs attention
			SpecialComment  { Comment, gui = "NONE" }, -- special things inside a comment
			-- Debug        { }, --    debugging statements

			-- ("Ignore", below, may be invisible...)
			-- Ignore       { }, -- (preferred) left blank, hidden	|hl-Ignore|

			Todo            { gui = "bold,underline" }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

			LspReferenceText           { ColorColumn }, -- used for highlighting "text" references
			LspReferenceRead           { ColorColumn }, -- used for highlighting "read" references
			LspReferenceWrite          { ColorColumn }, -- used for highlighting "write" references
			LspCodeLens                { LineNr },

			DiagnosticError            { Error },
			DiagnosticWarn             { WarningMsg },
			DiagnosticInfo             { fg = p.water },
			DiagnosticHint             { fg = p.blossom },
			-- DiagnosticDeprecated       { DiagnosticWarn },
			-- DiagnosticUnnecessary      { DiagnosticWarn },

			DiagnosticSignError        { SignColumn, fg = DiagnosticError.fg },
			DiagnosticSignWarn         { SignColumn, fg = DiagnosticWarn.fg },
			DiagnosticSignInfo         { SignColumn, fg = DiagnosticInfo.fg },
			DiagnosticSignHint         { SignColumn, fg = DiagnosticHint.fg },

			DiagnosticVirtualTextError { DiagnosticError, bg = DiagnosticError.fg.saturation(8).lightness(p1.bg.l + 4) },
			DiagnosticVirtualTextWarn  { DiagnosticWarn, bg = DiagnosticWarn.fg.saturation(8).lightness(p1.bg.l + 4) },
			DiagnosticVirtualTextInfo  { DiagnosticInfo, bg = DiagnosticInfo.fg.saturation(8).lightness(p1.bg.l + 4) },
			DiagnosticVirtualTextHint  { DiagnosticHint, bg = DiagnosticHint.fg.saturation(8).lightness(p1.bg.l + 4) },

			DiagnosticUnderlineError   { fg = opt.colorize_diagnostic_underline_text and DiagnosticError.fg or "NONE", gui = "undercurl", sp = DiagnosticError.fg },
			DiagnosticUnderlineWarn    { fg = opt.colorize_diagnostic_underline_text and DiagnosticWarn.fg or "NONE", gui = "undercurl", sp = DiagnosticWarn.fg },
			DiagnosticUnderlineInfo    { fg = opt.colorize_diagnostic_underline_text and DiagnosticInfo.fg or "NONE", gui = "undercurl", sp = DiagnosticInfo.fg },
			DiagnosticUnderlineHint    { fg = opt.colorize_diagnostic_underline_text and DiagnosticHint.fg or "NONE", gui = "undercurl", sp = DiagnosticHint.fg },

      StatusLineError { fg = DiagnosticError.fg, bg = StatusLine.bg },
      StatusLineWarn { fg = DiagnosticWarn.fg, bg = StatusLine.bg },
      StatusLineInfo { fg = DiagnosticInfo.fg, bg = StatusLine.bg },
      StatusLineHint { fg = DiagnosticHint.fg, bg = StatusLine.bg },

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
			-- sym "@namespace"             { Identifier },
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
			-- sym "@string"                { String },
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

			-- Syntax
			diffAdded                 { fg = p.leaf },
			diffRemoved               { fg = p.rose },
			diffChanged               { fg = p.water },
			diffOldFile               { fg = p.rose, gui = "italic" },
			diffNewFile               { fg = p.leaf, gui = "italic" },
			diffFile                  { fg = p.wood, gui = "bold" },
			diffLine                  { fg = p.blossom, gui = "bold" },
			diffIndexLine             { fg = p.wood },

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

			-- Other plugins
			GitSignsAdd                      { SignColumn, fg = p.leaf },
			GitSignsChange                   { SignColumn, fg = p.water },
			GitSignsDelete                   { SignColumn, fg = p.rose },

			LeapMatch                        { gui = "bold,underline,nocombine" },
			LeapLabelPrimary                 { Search , gui = "bold,nocombine" },
			LeapLabelSecondary               { DiffText, gui = "bold,nocombine" },
			LeapLabelSelected                { IncSearch },

			NvimTreeNormal                   { Normal, bg = not opt.transparent_background and p1.bg.li(3) or "NONE" },
			NvimTreeWinSeparator             (opt.transparent_background and { WinSeparator } or { fg = "bg" }),
			NvimTreeCursorLine               { bg = StatusLineNC.bg },
			NvimTreeCursorColumn             { NvimTreeCursorLine	},
			NvimTreeRootFolder               { fg = p.water, gui = "bold" },
			NvimTreeSymlink                  { fg = p.water },
			NvimTreeGitDirty                 { diffChanged },
			NvimTreeGitNew                   { diffAdded },
			NvimTreeGitDeleted               { diffRemoved },
			NvimTreeSpecialFile              { fg = p.blossom, gui = "underline" },

			CmpItemAbbr			             { fg = p1.fg2 },
			CmpItemAbbrDeprecated            { fg = p1.fg6 },
			CmpItemAbbrMatch	             { fg = p.fg, gui = "bold"  },
			CmpItemAbbrMatchFuzzy            { fg = p1.fg1, gui = "bold" },
			CmpItemKind                      { fg = p1.fg4 },
			CmpItemMenu                      { fg = p1.fg5 },
		}
	end)
  -- stylua: ignore end
  ---@diagnostic enable: undefined-global
end

local palette = {
  bg = hsluv("#1d1c19"),
  fg = hsluv("#c5c9c5"),
  rose = hsluv("#c4746e"),
  leaf = hsluv("#8a9a7b"),
  wood = hsluv("#c4b28a"),
  water = hsluv("#8ba4b0"),
  blossom = hsluv("#a292a3"),
  sky = hsluv("#8ea4a2"),
}

local specs = generate(palette, {
  transparent_background = true,
  italic_comments = false,
})

lush(specs)
