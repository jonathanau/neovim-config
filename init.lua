-- init.lua
-- Neovim-native Lua configuration
-- Migrated from jonathanau's .vimrc 
-- (originally forked 2005-05-15 from Lubomir Host's .vimrc)
--
-- Plugin manager: lazy.nvim (auto-bootstrapped below)
-- Replaces: NERDTree → nvim-tree, Syntastic → built-in LSP,
--           BufExplorer/ctrlp → Telescope, Fugitive → kept

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------
local opt = vim.opt

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = false

-- Persistent undo
opt.undofile = true
opt.undolevels = 10000

-- History
opt.history = 10000

-- UI
opt.laststatus = 2
opt.cmdheight = 2
opt.showcmd = true
opt.showmatch = true
opt.showmode = true
opt.number = true
opt.scrolloff = 999         -- cursor stays centered in terminal mode
opt.sidescroll = 5
opt.sidescrolloff = 1
opt.lazyredraw = true
opt.display:append("lastline")
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- Behavior
opt.startofline = false
opt.modeline = true
opt.report = 0
opt.whichwrap = "h,l"
opt.clipboard = "unnamed"
opt.complete:remove("i")    -- don't scan includes for completion
opt.backup = false

-- Tags
opt.tags = "./tags;/"

-- No EOF at end of file
opt.endofline = false

-- Mouse
opt.mousefocus = false
opt.mousehide = true
opt.mousemodel = "popup"

-- Timeouts
opt.timeout = true
opt.timeoutlen = 1000
opt.ttimeoutlen = 100

-- Bells off
opt.errorbells = false
opt.visualbell = true

-- Suffixes / wildignore (carried over from legacy vimrc)
opt.suffixes:remove(".h")
opt.suffixes:append({ ".aux", ".bbl", ".blg", ".log", ".eps", ".ps", ".pdf" })
opt.wildignore:append({ "*.dvi", "*.pdf", "*.o", "*.ko", "*.swp", "*.aux", "*.bbl", "*.blg" })

-- Color column at 81+ in GUI
if vim.fn.has("gui_running") == 1 then
  local cols = {}
  for i = 81, 999 do cols[#cols + 1] = tostring(i) end
  opt.colorcolumn = table.concat(cols, ",")
end

-- Colorscheme (will silently fail if not installed)
pcall(vim.cmd, "colorscheme bluegreen")

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------
-- Set leader to Space (before any keymaps that reference <leader>)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Escape clears search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window navigation (Ctrl-J/K/H/L)
map("n", "<C-J>", "<C-W>j")
map("n", "<C-K>", "<C-W>k")
map("n", "<C-H>", "<C-W>h")
map("n", "<C-L>", "<C-W>l")

-- Home/End in insert and command mode
map("i", "<C-A>", "<Home>")
map("c", "<C-A>", "<Home>")
map("i", "<C-E>", "<End>")

-- Word navigation in insert mode
map("i", "<C-B>", "<S-Left>")

-- Paste toggle
map("n", ",f", ":set paste!<CR>:set paste?<CR>")

-- Safe line delete (black-hole register)
map("i", "<C-D>", '<Esc>"_ddi')

-- Visual search for selection
map("v", "S", 'y/<C-R>=escape(@",\'/\\\')<CR>')

-- Replace selection with register contents
map("v", "p", '<Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>')

-- Fold mappings (Z-prefixed global fold commands)
map("n", "Zo", "mzggvGzo'z")
map("n", "ZO", "zR")
map("n", "Zc", "mzggvGzc'z")
map("n", "ZC", "zM")
map("n", "Zd", "mzggvGzd'z")
map("n", "ZD", "mzggvGzD'z")
map("n", "Za", "mzggvGza'z")
map("n", "ZA", "mzggvGzA'z")
map("n", "Zx", "mzggvGzx'z")
map("n", "ZX", "mzggvGzX'z")

--------------------------------------------------------------------------------
-- Autocommands
--------------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Auto-open quickfix after grep
augroup("QuickfixOpen", { clear = true })
autocmd("QuickFixCmdPost", {
  group = "QuickfixOpen",
  pattern = "*grep*",
  command = "cwindow",
})

-- Auto-close if quickfix is the last window
augroup("QuitLastQF", { clear = true })
autocmd("BufEnter", {
  group = "QuitLastQF",
  callback = function()
    if vim.bo.buftype == "quickfix" and vim.fn.winnr("$") < 2 then
      vim.cmd("quit")
    end
  end,
})

-- Reload init.lua on save
augroup("ReloadConfig", { clear = true })
autocmd("BufWritePost", {
  group = "ReloadConfig",
  pattern = "init.lua",
  callback = function() vim.cmd("source %") end,
})

-- C/C++ indent settings
augroup("CIndent", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "CIndent",
  pattern = { "*.c", "*.h", "*.cc", "*.cpp" },
  callback = function()
    vim.bo.cindent = true
    vim.bo.cinoptions = ">4,e0,n0,f0,{0,}0,^0,:4,=4,p4,t4,c3,+4,(2s,u1s,)20,*30,g4,h4"
    vim.bo.cinkeys = "0{,0},:,0#,!<C-F>,o,O,e"
  end,
})

--------------------------------------------------------------------------------
-- Plugin Manager: lazy.nvim (auto-bootstrap)
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- File tree (replaces NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "NvimTreeToggle",
    keys = { { "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree", silent = true } },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        filters = { dotfiles = false },
      })
    end,
  },

  -- Fuzzy finder (replaces ctrlp and BufExplorer)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", desc = "Find files" },
      { "<leader>fg", desc = "Live grep" },
      { "<leader>fb", desc = "Buffers" },
      { "<leader>fh", desc = "Help tags" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({})
      pcall(telescope.load_extension, "fzf")

      local builtin = require("telescope.builtin")
      map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    end,
  },

  -- Git (Fugitive stays, plus gitsigns for inline hunks)
  { "tpope/vim-fugitive", cmd = { "Git", "G", "Gvdiffsplit", "Glog" } },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- LSP (replaces Syntastic)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "FileType" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      -- Shared on_attach for LSP keymaps
      local on_attach = function(_, bufnr)
        local lsp_map = function(keys, func, desc)
          map("n", keys, func, { buffer = bufnr, desc = desc })
        end
        lsp_map("gd", vim.lsp.buf.definition, "Go to definition")
        lsp_map("gr", vim.lsp.buf.references, "References")
        lsp_map("K", vim.lsp.buf.hover, "Hover docs")
        lsp_map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        lsp_map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        lsp_map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        lsp_map("]d", vim.diagnostic.goto_next, "Next diagnostic")
      end

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",           -- Lua
          "pyright",          -- Python
          "ts_ls",            -- JavaScript
          "jsonls",           -- JSON
          "yamlls",           -- YAML
          "lemminx",          -- XML
          "html",             -- HTML
          "marksman",         -- Markdown
        },
        -- Auto-setup any server installed via Mason (v2 API)
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
            })
          end,
        },
      })
    end,
  },

  -- Treesitter (modern syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile", "FileType" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Status line (replaces legacy custom statusline)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto" },
      })
    end,
  },

})