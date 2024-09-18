-- Ethan Shoham neovim config
-- 17/09/24

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install Nerd Fonts
-- Cousine Nerd Font: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Cousine.zip
-- Symbols Nerd Font: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/NerdFontsSymbolsOnly.zip
--
-- On Windows Terminal go to:
-- Settings -> Default -> Appearance -> Font Face to Cousine Nerd Font
--
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- Set relative line number
vim.opt.relativenumber = true

-- Enable mouse mode, this is enabled by default on windows
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent (wrapped lines will start on the same indent as the start of the original line)
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 1000

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Make backgound opacity

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit insert mode if j pressed two times in a row
vim.keymap.set('i', 'jj', '<Esc>')

-- Open netrw on <leader>pv
vim.keymap.set('n', '<leader>pv', '<cmd>:Explore<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal and visual mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set('n', '<backspace>', '<cmd>echo "Use h to move!!"<CR>')

vim.keymap.set('v', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('v', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('v', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('v', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set('v', '<backspace>', '<cmd>echo "Use h to move!!"<CR>')

-- Move current line up
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
-- Move current line down
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })

-- Move selected line(s) up
vim.api.nvim_set_keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- Move selected line(s) down
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Move line up in insert mode (Alt + Up Arrow)
vim.api.nvim_set_keymap('i', '<A-Up>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })

-- Move line down in insert mode (Alt + Down Arrow)
vim.api.nvim_set_keymap('i', '<A-Down>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  -- Install color schema catppuccin
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },
  -- Install color schema rose-pine
  {
    'rose-pine/neovim',
    name = 'rose-pine',
  },
  -- Install color shema
  {
    'Mofiqul/vscode.nvim',
    name = 'vscode',
    config = function()
        local vs = require('vscode')
        vs.setup({
        transparent = true,

        italic_comments = true,

        underline_links = true,

        diable_nvimtree_bg = true,

        color_overrides = {
          vscLineNumber = '#EEEEEE',
          vscLeftMid = 'NONE',
          vscCursorDarkDark = 'NONE',
          vscPopupFront = '#EEEEEE',
        },

        })
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      local ll = require('lualine')
      ll.setup({
        options = {
          theme = 'auto',  -- Replace with your preferred theme
          section_separators = {'', ''},
          component_separators = {'', ''},
          icons_enabled = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_diagnostic'}}},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'},
        }
      })
    end,
  },
  -- Install harpoon
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      local mark = require('harpoon.mark')
      local ui = require('harpoon.ui')

      -- Keybindings
      vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Harpoon: Add file' })
      vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { desc = 'Harpoon: Toggle menu' })

      -- Navigate to Harpoon marks
      vim.keymap.set('n', '<A-1>', function()
        ui.nav_file(1)
      end, { desc = 'Harpoon: Go to file 1' })
      vim.keymap.set('n', '<A-2>', function()
        ui.nav_file(2)
      end, { desc = 'Harpoon: Go to file 2' })
      vim.keymap.set('n', '<A-3>', function()
        ui.nav_file(3)
      end, { desc = 'Harpoon: Go to file 3' })
      vim.keymap.set('n', '<A-4>', function()
        ui.nav_file(4)
      end, { desc = 'Harpoon: Go to file 4' })
    end,
  },
  -- LSP Plugins
  {
    'neovim/nvim-lspconfig',
    config = function()

    end,
  }
}

-- Set colorscheme to catppuccin-macchinato
vim.cmd.colorscheme('vscode')
