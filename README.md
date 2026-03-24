# Neovim Configuration

Lua-based Neovim config migrated from a long-running vimrc (originally forked 2005).

## Requirements

- Neovim 0.9+
- Git (for lazy.nvim plugin manager auto-bootstrap)
- Node.js (required by the JavaScript/TypeScript language server)
- A [Nerd Font](https://www.nerdfonts.com/) (for file icons in nvim-tree and lualine), e.g. JetBrainsMonoNL Nerd Font Mono

## Installation

### 1. Install Neovim

macOS / Linux (Homebrew):
```bash
brew install neovim
```

Windows (winget):
```powershell
winget install Neovim.Neovim
```

### 2. Clone this repo

Clone this repo into the Neovim config directory:

Linux / macOS:
```bash
git clone https://github.com/jonathanau/nvim-config.git ~/.config/nvim
```

Windows (PowerShell):
```powershell
git clone https://github.com/jonathanau/nvim-config.git $env:LOCALAPPDATA\nvim
```

Launch Neovim. On first run, lazy.nvim will auto-install itself and all plugins. Mason will then download the configured language servers.

## Plugins

| Plugin | Purpose | Replaces |
|---|---|---|
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer | NERDTree |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder, buffer list | ctrlp, BufExplorer |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands | (kept from legacy config) |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Inline git hunks and blame | (new) |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [Mason](https://github.com/williamboman/mason.nvim) | Language servers, diagnostics | Syntastic |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting | (new) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line | Custom statusline |

## Key Bindings

Leader key is `Space`.

| Key | Mode | Action |
|---|---|---|
| `<Esc>` | Normal | Clear search highlight |
| `<leader>ff` | Normal | Find files (Telescope) |
| `<leader>fg` | Normal | Live grep (Telescope) |
| `<leader>fb` | Normal | Buffer list (Telescope) |
| `<leader>fh` | Normal | Help tags (Telescope) |
| `<C-n>` | Normal | Toggle file tree |
| `<C-j/k/h/l>` | Normal | Navigate between windows |
| `gd` | Normal | Go to definition (LSP) |
| `gr` | Normal | References (LSP) |
| `K` | Normal | Hover docs (LSP) |
| `<leader>rn` | Normal | Rename symbol (LSP) |
| `<leader>ca` | Normal | Code action (LSP) |
| `[d` / `]d` | Normal | Prev / next diagnostic |
| `,f` | Normal | Toggle paste mode |

## Language Servers

Managed by Mason. Auto-installed on first launch:

- `lua_ls` (Lua)
- `pyright` (Python)
- `ts_ls` (JavaScript)
- `jsonls` (JSON)
- `yamlls` (YAML)
- `lemminx` (XML)
- `html` (HTML)
- `marksman` (Markdown)

Run `:Mason` to manage servers interactively.

## Launching Neovim in Ghostty via Spotlight (macOS)

If you use [Ghostty](https://ghostty.org/) on macOS, you can create a native application bundle to launch Neovim directly from Spotlight (or your Dock) rather than opening a terminal first. 

This creates a lightweight `Neovim.app` wrapper that automatically opens a new Ghostty instance and passes it the Neovim execution flag.

### 1. Create the App Bundle
Open your terminal and run the following commands. This creates the macOS app directory structure and writes the launch script:

```bash
# Create the app bundle structure
mkdir -p /Applications/Neovim.app/Contents/MacOS

# Create the executable script
cat << 'EOF' > /Applications/Neovim.app/Contents/MacOS/Neovim
#!/bin/bash

# Define Homebrew path (handles both Apple Silicon and Intel Macs)
NVIM_PATH="/opt/homebrew/bin/nvim"
if [ ! -f "$NVIM_PATH" ]; then
    NVIM_PATH="/usr/local/bin/nvim"
fi

# Open Ghostty and execute Neovim
open -na Ghostty --args -e "$NVIM_PATH" "$@"
EOF

# Make the script executable
chmod +x /Applications/Neovim.app/Contents/MacOS/Neovim
```
*(Note: If you prefer Neovim to open as a new window inside your already-running Ghostty instance instead of a separate Dock icon, replace the `open` line above with `/Applications/Ghostty.app/Contents/MacOS/ghostty +new-window -e "$NVIM_PATH" "$@"`).*

### 2. Apply a Custom Icon
To make the app look native in your Dock and Spotlight, apply a custom Neovim icon:

1. Download a Neovim logo in `.icns` format (e.g., [this Reddit post](https://www.reddit.com/r/neovim/comments/13713rq/i_made_a_neovim_icon_for_macos_download_link_in/) has a great macOS-style version).
2. Select the downloaded `.icns` file in Finder and copy it (`Cmd + C`).
3. Navigate to your `/Applications` folder, right-click your newly created **Neovim.app**, and click **Get Info** (`Cmd + I`).
4. Click the small app icon in the top-left corner of the Get Info window (it will highlight with a blue outline).
5. Paste the icon (`Cmd + V`).

### 3. Index for Spotlight
macOS needs to register the new app before it shows up in Spotlight searches:
1. Navigate to `/Applications` in Finder.
2. Double-click **Neovim.app** to open it manually for the first time.
3. Once opened, macOS LaunchServices will index it. You can now launch Neovim directly by pressing `Cmd + Space` and typing **Neovim**.
