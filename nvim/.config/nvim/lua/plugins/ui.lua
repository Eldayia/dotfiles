return {
  {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,

  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,

      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
        },

        telescope = true,
        nvimtree = true,
        cmp = true,
        gitsigns = true,
        which_key = true,
        mason = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "auto", globalstatus = true },
    },
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "neo-tree",
            text = "Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
    },
    keys = {
      { "<S-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Buffer: next" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Buffer: previous" },
    },
  },

  {
    "nvim-mini/mini.bufremove",
    version = false,
    opts = {},
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",

      -- Affiche l'aide après 3 secondes d'attente sur un préfixe.
      delay = 300,

      -- Which-Key connaît aussi les grandes familles de raccourcis natifs.
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },

      -- Organisation du menu principal Space.
      spec = {
        { "<leader>b", group = "Buffers" },
        { "<leader>f", group = "Find / Search" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>s", group = "Symbols" },
        { "<leader>t", group = "Toggle / Terminal" },
        { "<leader>w", group = "Windows" },
        { "<leader>x", group = "Diagnostics" },

        { "<leader>c", desc = "42: compile current C file" },
        { "<leader>r", desc = "42: run compiled program" },
        { "<leader>n", desc = "42: Norminette project" },

        { "g", group = "Go / LSP / native" },
        { "z", group = "Fold / spelling / native" },
        { "]", group = "Next" },
        { "[", group = "Previous" },
        { "<C-w>", group = "Native windows" },
      },
    },

    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Show all available keymaps",
      },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
    },
    opts = {},
  },
}
