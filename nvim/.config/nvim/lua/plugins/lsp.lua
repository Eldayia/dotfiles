return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "mason-org/mason-lspconfig.nvim" },
      { "saghen/blink.cmp" },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--header-insertion=iwyu",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_markers = {
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "compile_commands.json",
          "compile_flags.txt",
          "Makefile",
          ".git",
        },
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            telemetry = { enable = false },
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls" },
        automatic_enable = true,
      })

      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
              buffer = bufnr,
              silent = true,
              desc = desc,
            })
          end

          map("n", "K", vim.lsp.buf.hover, "LSP documentation")
          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gT", vim.lsp.buf.type_definition, "Go to type definition")
          map("n", "gr", function() require("telescope.builtin").lsp_references() end, "Find references")
          map("n", "<leader>ss", function() require("telescope.builtin").lsp_document_symbols() end, "Document symbols")
          map("n", "<leader>sS", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, "Workspace symbols")
          map("n", "<leader>lr", vim.lsp.buf.rename, "Rename symbol")
          map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>ld", vim.diagnostic.open_float, "Show diagnostic")
          map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
          map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
          map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
        end,
      })
    end,
  },

  {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets" },

  opts = {
    keymap = {
      preset = "none",

      -- Afficher manuellement l'autocomplétion
      ["<C-Space>"] = {
        "show",
        "show_documentation",
        "hide_documentation",
      },

      -- Fermer le menu
      ["<C-e>"] = { "hide", "fallback" },

      -- Naviguer dans les propositions
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },

      -- Entrée accepte UNIQUEMENT la proposition sélectionnée.
      -- Si rien n'est sélectionné, Entrée fait simplement une nouvelle ligne.
      ["<CR>"] = { "accept", "fallback" },

      ---------------------------------------------------------------------
      -- TABULATION NORMALE
      --
      -- Très important pour la norme 42 :
      -- Tab ne touche plus au menu d'autocomplétion.
      ---------------------------------------------------------------------
      ["<Tab>"] = { "fallback" },
      ["<S-Tab>"] = { "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      ---------------------------------------------------------------------
      -- Ne sélectionne PAS automatiquement la première proposition.
      ---------------------------------------------------------------------
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },

      menu = {
        auto_show = true,
        border = "rounded",
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,

        window = {
          border = "rounded",
        },
      },

      ghost_text = {
        enabled = true,
      },
    },

    signature = {
      enabled = true,

      window = {
        border = "rounded",
      },
    },

    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
      },
    },

    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
  },

  opts_extend = {
    "sources.default",
  },
},
}
