return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      "SmiteshP/nvim-navic",
      "b0o/schemastore.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local ok_neodev, neodev = pcall(require, "neodev")
      if ok_neodev then neodev.setup({}) end
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Global diagnostics and LSP UI
      vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = false,
        underline = true,
        signs = true,
        virtual_text = false,
        float = { border = "rounded", source = "if_many", focusable = false, header = "", prefix = "" },
      })
      local border = "rounded"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

      require("fidget").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })

      -- Global LSP keymaps (VSCode-like)
      local function on_attach(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gr", vim.lsp.buf.references, "Find references")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        -- Diagnostics UX: float and error-only navigation
        map("n", "gl", function() vim.diagnostic.open_float(nil, { focusable = false, border = "rounded", scope = "line", source = "if_many" }) end, "Line diagnostics")
        map("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "Prev error")
        map("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "Next error")
        -- Inlay hints default on + toggle
        local ih = vim.lsp.inlay_hint
        if ih then
          pcall(function()
            if ih.enable then ih.enable(true, { bufnr = bufnr }) else ih(bufnr, true) end
            vim.b.inlay_hints_enabled = true
          end)
          map("n", "<leader>ui", function()
            local enabled = (ih.is_enabled and ih.is_enabled({ bufnr = bufnr })) or vim.b.inlay_hints_enabled
            if ih.enable then ih.enable(not enabled, { bufnr = bufnr }) else pcall(ih, bufnr, not enabled) end
            vim.b.inlay_hints_enabled = not enabled
          end, "Toggle inlay hints")
        end
        -- Navic breadcrumbs attach when supported
        local ok_navic, navic = pcall(require, "nvim-navic")
        if ok_navic and client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
      end

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      -- JSON/YAML with SchemaStore
      local ok_schemastore, schemastore = pcall(require, "schemastore")
      if ok_schemastore then
        lspconfig.jsonls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            json = {
              schemas = schemastore.json.schemas(),
              validate = { enable = true },
            },
          },
        })
        lspconfig.yamlls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            yaml = {
              schemaStore = { enable = false, url = "" },
              schemas = schemastore.yaml.schemas(),
            },
          },
        })
      end
    end,
  },

  -- TypeScript tooling (better than tsserver via lspconfig alone)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      settings = {
        tsserver_plugins = {},
        separate_diagnostic_server = true,
        tsserver_max_memory = 4096,
        jsx_close_tag = { enable = true },
      },
      on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gr", vim.lsp.buf.references, "Find references")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        map("n", "gl", function() vim.diagnostic.open_float(nil, { focusable = false, border = "rounded", scope = "line", source = "if_many" }) end, "Line diagnostics")
        map("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "Prev error")
        map("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "Next error")
        local ih = vim.lsp.inlay_hint
        if ih then
          pcall(function()
            if ih.enable then ih.enable(true, { bufnr = bufnr }) else ih(bufnr, true) end
            vim.b.inlay_hints_enabled = true
          end)
          map("n", "<leader>ui", function()
            local enabled = (ih.is_enabled and ih.is_enabled({ bufnr = bufnr })) or vim.b.inlay_hints_enabled
            if ih.enable then ih.enable(not enabled, { bufnr = bufnr }) else pcall(ih, bufnr, not enabled) end
            vim.b.inlay_hints_enabled = not enabled
          end, "Toggle inlay hints")
        end
        -- Navic breadcrumbs for TS
        local ok_navic, navic = pcall(require, "nvim-navic")
        if ok_navic and client and client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
      end,
    },
  },

  -- ESLint integration (diagnostics and fixes)
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      local null_ls = require("null-ls")
      local eslint_d_diagnostics = require("none-ls.diagnostics.eslint_d")
      local eslint_d_actions = require("none-ls.code_actions.eslint_d")
      null_ls.setup({
        sources = {
          eslint_d_diagnostics,
          eslint_d_actions,
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", function() require("trouble").toggle("document_diagnostics") end, desc = "Diagnostics (buffer)" },
      { "<leader>xX", function() require("trouble").toggle("workspace_diagnostics") end, desc = "Diagnostics (workspace)" },
      { "<leader>xr", function() require("trouble").toggle("lsp_references") end, desc = "LSP References (list)" },
    },
    opts = {},
  },
}


