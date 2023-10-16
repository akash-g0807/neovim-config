-- PDF Viewer:
-- http://manpages.ubuntu.com/manpages/trusty/man5/zathurarc.5.html
vim.g["vimtex_view_method"] = "zathura"
--vim.g["vimtex_quickfix_mode"] = 0
vim.opt.conceallevel = 1
-- Ignore mappings
-- vim.g["vimtex_mappings_enabled"] = 0

-- Auto Indent
vim.g["vimtex_indent_enabled"] = 0

-- Syntax highlighting
vim.g["vimtex_syntax_enabled"] = 1

-- Error suppression:
-- https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt

vim.g["vimtex_log_ignore"] = {
	"Underfull",
	"Overfull",
	"specifier changed to",
	"Token not allowed in a PDF string",
}

vim.g["vimtex_context_pdf_viewer"] = "okular"
-- vim.opt.conceallevel = 1
-- vim.g["vimtex_compiler_method"] = "latexrun"

-- vim.g['vimtex_complete_enabled'] = 1
-- vim.g['vimtex_compiler_progname'] = 'nvr'
-- vim.g['vimtex_complete_close_braces'] i= 1
--
vim.g["vimtex_quickfix_mode"] = 0
-- vim.g["tex_conceal"] = "abdmg"
