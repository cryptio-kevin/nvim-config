# Neovim config (macOS) – React/TypeScript, VSCode-like

Minimal, modular, and readable Neovim setup using `lazy.nvim`, tuned for React/TypeScript with familiar VSCode-style shortcuts.

## Getting started

- **Prereqs (Homebrew):**
  - `brew install neovim git ripgrep node`
  - Recommended for compilers: `xcode-select --install`

- **First launch:**
  - Start Neovim: `nvim`
  - `lazy.nvim` bootstraps automatically and installs plugins on first run
  - Restart Neovim after installation finishes

## Key defaults

- **Leader**: Space (`<Space>`)
- **Numbers**: absolute + relative
- **Indent**: 4 spaces, expandtab | **Search**: ignorecase + smartcase
- **UI**: Nightfox (Dayfox) theme, lualine statusline, which-key, gitsigns
  - Theme repo: [`EdenEast/nightfox.nvim`](https://github.com/EdenEast/nightfox.nvim)

## Find and search

- **Files**: `<C-p>` (VSCode-like) or `<leader>ff`
- **Live grep**: `<leader>fg` (requires `ripgrep`)
- **Explorer**: `<C-b>` toggles Neo-tree

## LSP (Language Server Protocol)

- Out of the box: **Lua** (`lua_ls`) and **TypeScript/React** via `typescript-tools.nvim`.
- Manage servers/tools: `:Mason` (auto-installs prettierd, eslint_d, stylua)
- Common LSP keys (VSCode-like):
  - `gd` go to definition, `gr` references, `gi` implementation, `K` hover
  - `<leader>rn` rename, `<leader>ca` code action, `[d`/`]d` diagnostics

## Treesitter

- Update grammars: `:TSUpdate`
- Preinstalled: `lua`, `vim`, `vimdoc`, `javascript`, `typescript`, `tsx`, `json`, `css`, `html`, `markdown`...
- Add languages: edit `lua/plugins/treesitter.lua` (`ensure_installed`)

## Formatting and linting (Prettier + ESLint)

- Auto-format on save via `conform.nvim` using `prettierd` (fallback `prettier`)
- Toggle autoformat per-session: `:let g:disable_autoformat = 1` (set to `0` to re-enable)
- ESLint diagnostics/actions via `none-ls` (`eslint_d`)

## Completion, snippets, autopairs

- `nvim-cmp` completion with `<CR>` to accept, `<Tab>`/`<S-Tab>` navigate
- `LuaSnip` + `friendly-snippets` for React/TS snippets
- `nvim-autopairs` auto-inserts pairs

## Structure

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
        ├── lsp.lua
        ├── cmp.lua
        ├── formatting.lua
        ├── which-key.lua
        ├── neo-tree.lua
        ├── git.lua
        ├── comment.lua
        ├── autopairs.lua
        └── terminal.lua
```

## Customize

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

## Maintenance

- **Update/sync plugins**: `:Lazy sync`
- **Update only**: `:Lazy update`
- **Remove unused**: `:Lazy clean`
- **Health check**: `:checkhealth`
- **Profile startup**: `nvim --startuptime startup.log | cat`

## Packages used (1-liners)

- [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim): fast, modern plugin manager with lazy-loading.
- [`EdenEast/nightfox.nvim`](https://github.com/EdenEast/nightfox.nvim): highly customizable theme suite (using Dayfox).
- [`nvim-lualine/lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim): lightweight statusline.
- [`folke/which-key.nvim`](https://github.com/folke/which-key.nvim): shows available keybindings on demand.
- [`nvim-neo-tree/neo-tree.nvim`](https://github.com/nvim-neo-tree/neo-tree.nvim): file explorer with git/status integration.
- [`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim): fuzzy finder for files, grep, and more.
- [`nvim-telescope/telescope-fzf-native.nvim`](https://github.com/nvim-telescope/telescope-fzf-native.nvim): native fzf sorter for Telescope.
- [`lewis6991/gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim): inline git signs and hunk actions.
- [`numToStr/Comment.nvim`](https://github.com/numToStr/Comment.nvim): easy line/block commenting.
- [`akinsho/toggleterm.nvim`](https://github.com/akinsho/toggleterm.nvim): integrated terminal toggled from within Neovim.
- [`nvim-treesitter/nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter): fast syntax highlighting and parsing.
- [`neovim/nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig): quick configs for LSP servers.
- [`pmizio/typescript-tools.nvim`](https://github.com/pmizio/typescript-tools.nvim): enhanced TypeScript LSP features.
- [`nvimtools/none-ls.nvim`](https://github.com/nvimtools/none-ls.nvim): integrate linters/code actions (e.g., eslint_d).
- [`stevearc/conform.nvim`](https://github.com/stevearc/conform.nvim): formatter runner with format-on-save.
- [`williamboman/mason.nvim`](https://github.com/williamboman/mason.nvim): install/manage LSPs and tools.
- [`WhoIsSethDaniel/mason-tool-installer.nvim`](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim): ensure dev tools are installed.
- [`hrsh7th/nvim-cmp`](https://github.com/hrsh7th/nvim-cmp): completion engine.
- [`L3MON4D3/LuaSnip`](https://github.com/L3MON4D3/LuaSnip): snippets engine.
- [`rafamadriz/friendly-snippets`](https://github.com/rafamadriz/friendly-snippets): community snippet collection.
- [`saadparwaiz1/cmp_luasnip`](https://github.com/saadparwaiz1/cmp_luasnip): LuaSnip source for nvim-cmp.
- [`hrsh7th/cmp-nvim-lsp`](https://github.com/hrsh7th/cmp-nvim-lsp): LSP source for nvim-cmp.
- [`hrsh7th/cmp-buffer`](https://github.com/hrsh7th/cmp-buffer): buffer words source for nvim-cmp.
- [`hrsh7th/cmp-path`](https://github.com/hrsh7th/cmp-path): filesystem paths source for nvim-cmp.
- [`windwp/nvim-autopairs`](https://github.com/windwp/nvim-autopairs): auto insert matching pairs.
- [`echasnovski/mini.icons`](https://github.com/echasnovski/mini.icons): fallback icons for plugins.
- [`j-hui/fidget.nvim`](https://github.com/j-hui/fidget.nvim): minimal LSP status UI.
- [`nvim-lua/plenary.nvim`](https://github.com/nvim-lua/plenary.nvim): utility library used by many plugins.
- [`nvim-tree/nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons): filetype icons.
- [`MunifTanjim/nui.nvim`](https://github.com/MunifTanjim/nui.nvim): UI components for Neovim plugins.

## VSCode-style shortcuts

- Files: `<C-p>`
- Explorer: `<C-b>`
- Split horizontal: `<C-\\>`
- Split vertical: `<C-=>`
- Next/Prev buffer: `<C-Tab>` / `<C-S-Tab>`
- Jump back/forward (after `gd`): `<C-o>` / `<C-i>`
- Last buffer: `<C-^>` (Control + 6)
- LSP: `gd` definition, `gr` references, `gi` implementation, `K` hover
- LSP: rename `<leader>rn>`, code actions `<leader>ca>`, diagnostics `[d` `]d`
- Comment toggle: `gc` (line) / `gb` (block)
- Terminal toggle: Ctrl + backtick

## Troubleshooting

- Live grep not working? Install `ripgrep` (`brew install ripgrep`).
- Treesitter build errors? Install Xcode Command Line Tools: `xcode-select --install`.
- Colors not applying? Ensure `termguicolors` terminals (most macOS terminals do).

