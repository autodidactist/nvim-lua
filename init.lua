-- Helpful vars
local g              = vim.g        -- global variables vim.g.mapleader = ','
local opt            = vim.opt      -- vim options 1 opt to rule all scope.
local keymap         = vim.keymap   -- Keybinds

local map            = vim.api.nvim_set_keymap
local cmd            = vim.cmd      -- cmd mode commands like (:set ft=lua)
local api            = vim.api      -- vim api
local o              = vim.o        -- General settings like vim.o.background = 'light'
local wo             = vim.wo       -- Window scope, for instance vim.wo.colorcolumn = '80'
local bo             = vim.bo       -- buffer scope, for instance vim.bo.filetype = 'lua'

-- Some shortcuts to make the conf file more clean
--
local map            = vim.api.nvim_set_keymap
local opts           = { noremap = true, silent = true }
local expr           = { noremap = true, silent = true, expr = true }

-- Global Vars
g.loaded_netrw       = 1
g.loaded_netrwPlugin = 1

-- Mapping
map("n", "<C-l>", ":noh<Cr>", opts)  -- Clear matches with Ctrl+l

-- YY/XX Copy/Cut into the system clipboard
vim.cmd([[
noremap YY "+y<CR>
noremap XX "+x<CR>
]])


-- Enable folds (zc and zo) on functions and classes but not by default
vim.cmd([[
  set nofoldenable
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
]])


-- Loading Libs
-- require('statusline')  -- lua/statusline.lua

opt.mouse            = 'a'
opt.number           = true
opt.ignorecase       = true
opt.smartcase        = true
opt.hlsearch         = false
opt.wrap             = true
opt.breakindent      = true
opt.tabstop          = 2
opt.shiftwidth       = 2
opt.expandtab        = false
opt.clipboard        = "unnamedplus"
opt.encoding         = "utf-8"
opt.termguicolors    = true
opt.relativenumber   = true
opt.showmode         = false        -- Do not need to show the mode. We use the statusline instead.
opt.swapfile         = false
opt.showmatch        = true         -- highlight matching brackets
opt.cursorline       = true         -- show cursor line
--opt.cursorcolumn     = true         -- show cursor column
opt.joinspaces       = false        -- No double spaces with join after a dot
opt.list             = true         -- show space and tabs chars
-- opt.cmdheight		     = 2            -- Shows better messages
-- opt.listchars        = "eol:⏎,tab:▸·,trail:×,nbsp:⎵"  -- make tab, etc visible
--opt.listchars        = "tab:▸·,nbsp:⎵"  -- make tab, etc visible
opt.spelllang        = "en_us"
opt.sessionoptions   = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Statusbar
opt.laststatus       = 0
opt.showcmd          = false

-- Global Vars
vim.g.mapleader      = ','


-- Lazy Plugin Manager
local lazy           = {}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print('Installing lazy.nvim....')
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable', -- latest stable release
			path,
		})
	end
end

function lazy.setup(plugins)
	-- You can "comment out" the line below after lazy.nvim is installed
	 lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)
	require('lazy').setup(plugins, lazy.opts)
end

lazy.path            = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts            = {}

lazy.setup({

	{'folke/tokyonight.nvim'},
	--{'nvim-lualine/lualine.nvim'},
	{'nvim-treesitter/nvim-treesitter'},
	{"nvim-neo-tree/neo-tree.nvim"},
	{'nvim-tree/nvim-tree.lua'},
	{"nvim-lua/plenary.nvim"},
	{"nvim-tree/nvim-web-devicons"},
	{"MunifTanjim/nui.nvim"},
	{'tpope/vim-commentary'}

})

--require('lualine').setup({
  --options            = {
    --icons_enabled    = false,
  --}
--})


-- Keymap
keymap.set({'n', 'x'}, 'x', '"_x')
keymap.set('n', 'ca', ':keepjumps normal! ggVG<cr>')
keymap.set('n', '<space>e', '<cmd>NvimTreeToggle<CR>')
keymap.set('n', 'Q', '<cmd>q!<CR>')


-- Vim CMD
cmd(':command! WQ wq')
cmd(':command! WQ wq')
cmd(':command! Wq wq')
cmd(':command! Wqa wqa')
cmd(':command! W w')
cmd(':command! Q q')


-- Plugin Configs
cmd.colorscheme('tokyonight')
require("nvim-treesitter").setup()

-- Resize windows with Shift+<arrow>
map("n", "<S-Up>", ":resize +2<CR>", opts)
map("n", "<S-Down>", ":resize -2<CR>", opts)
map("n", "<S-Left>", ":vertical resize -2<CR>", opts)
map("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Move line up and down with J/K
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Modify j and k when a line is wrapped. Jump to next VISUAL line
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr)

-- Keep search matches in the middle of the window
map("n", "n", "nzzzv", opts)	 
map("n", "N", "Nzzzv", opts)

-- Reselect visual block after indent/outdent
map("v", "<", "<gv", opts)           
map("v", ">", ">gv", opts)



function map(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


map("n", "H", ":bp<CR>")
map("n", "L", ":bn<CR>")

map("n", "<tab>", ":tabnext<CR>")
map("n", "<S-tab>", ":tabprevious<CR>")

map("n", "<C-h>", ":wincmd h<CR>")
map("n", "<C-j>", ":wincmd j<CR>")
map("n", "<C-k>", ":wincmd k<CR>")
map("n", "<C-l>", ":wincmd l<CR>")

--require "statusline"
--
--vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()
