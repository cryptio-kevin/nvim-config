## Neovim config (macOS)

Minimal, modular, and readable Neovim setup using `lazy.nvim`.

### Getting started
- **Prereqs (Homebrew):**
  - `brew install neovim git ripgrep`
  - Recommended for compilers: `xcode-select --install`
- **First launch:**
  - Start Neovim: `nvim`
  - `lazy.nvim` bootstraps automatically and installs plugins on first run
  - Restart Neovim after installation finishes

### Key defaults
- **Leader**: Space (`<Space>`)
- **Splits**: `<leader>sv` vertical, `<leader>sh` horizontal
- **Numbers**: absolute + relative
- **Indent**: 4 spaces, expandtab
- **Search**: ignorecase + smartcase
- **UI**: tokyonight theme, lualine statusline (icons disabled)

### Find and search
- **Files**: `<leader>ff`
- **Live grep**: `<leader>fg` (requires `ripgrep`)

### LSP (Language Server Protocol)
- This config ships with **Lua** support out of the box via `lua_ls`.
- Manage servers: `:Mason`
- Add another server:
  1) Install via `:Mason` (e.g., `tsserver`, `pyright`)
  2) Configure it in `lua/plugins/lsp.lua` using `require('lspconfig').<server>.setup({ ... })`

### Treesitter
- Update grammars: `:TSUpdate`
- Preinstalled: `lua`, `vim`, `vimdoc`
- Add languages: edit `lua/plugins/treesitter.lua` (`ensure_installed`)

### Structure
```text
~/.config/nvim/
├── init.lua                  # entry-point: loads config + lazy
└── lua/
    ├── config/
    │   ├── options.lua       # core editor options
    │   ├── keymaps.lua       # keybindings
    │   ├── autocmds.lua      # autocmds
    │   └── lazy.lua          # lazy.nvim bootstrap + setup
    └── plugins/              # plugin specs (auto-imported by lazy)
        ├── ui.lua
        ├── treesitter.lua
        ├── telescope.lua
        └── lsp.lua
```

### Customize
- **Options**: `lua/config/options.lua`
- **Keymaps**: `lua/config/keymaps.lua`
- **Autocmds**: `lua/config/autocmds.lua`
- **Plugins**: add a small spec file under `lua/plugins/` that returns a table

Example plugin file:
```lua
-- lua/plugins/example.lua
return {
  {
    "author/repo",
    event = "VeryLazy",
    opts = {},
  },
}
```

### Maintenance
- **Update/sync plugins**: `:Lazy sync`
- **Update only**: `:Lazy update`
- **Remove unused**: `:Lazy clean`
- **Health check**: `:checkhealth`
- **Profile startup**: `nvim --startuptime startup.log | cat`

### Troubleshooting
- Live grep not working? Install `ripgrep` (`brew install ripgrep`).
- Treesitter build errors? Install Xcode Command Line Tools: `xcode-select --install`.
- Colors not applying? Ensure `termguicolors` terminals (most macOS terminals do).


