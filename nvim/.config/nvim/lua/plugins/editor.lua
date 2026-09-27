return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files({ hidden = true }) end, desc = "Find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Search text" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
      { "<leader>fr", function() require("telescope.builtin").oldfiles() end, desc = "Recent files" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help" },
      { "<leader>fk", function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" },
      { "<leader>/", function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Search current buffer" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({ defaults = { layout_strategy = "horizontal", sorting_strategy = "ascending" } })
      pcall(telescope.load_extension, "fzf")
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle left<CR>", desc = "File explorer" },
    },
    opts = {
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        bind_to_cwd = true,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<space>"] = "none",
          ["<CR>"] = "open",
          ["l"] = "open",
          ["h"] = "close_node",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["a"] = { "add", config = { show_path = "relative" } },
          ["d"] = "delete",
          ["r"] = "rename",
          ["c"] = "copy",
          ["m"] = "move",
          ["R"] = "refresh",
          ["?"] = "show_help",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.schedule(function()
            local argc = vim.fn.argc()

            if argc == 0 then
              require("neo-tree.command").execute({
                action = "show",
                source = "filesystem",
                position = "left",
                dir = vim.fn.getcwd(),
              })
              return
            end

            local first_arg = vim.fn.argv(0)
            if vim.fn.isdirectory(first_arg) == 1 then
              local dir = vim.fn.fnamemodify(first_arg, ":p")
              vim.cmd("cd " .. vim.fn.fnameescape(dir))
              require("neo-tree.command").execute({
                action = "show",
                source = "filesystem",
                position = "left",
                dir = dir,
              })
            end
          end)
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.install({ "c", "lua", "vim", "vimdoc", "bash", "json", "markdown", "markdown_inline", "python" })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "lua", "vim", "bash", "json", "markdown", "python" },
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- GIT
  ---------------------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },

    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },

      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      current_line_blame = false,

      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            silent = true,
            desc = desc,
          })
        end

        -- Navigation entre les modifications Git.
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Git: next hunk")

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Git: previous hunk")

        -- Voir / stage / restaurer la modification courante.
        map("n", "<leader>gp", gs.preview_hunk, "Git: preview hunk")
        map("n", "<leader>gs", gs.stage_hunk, "Git: stage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Git: reset hunk")

        -- Actions sur le fichier entier.
        map("n", "<leader>gS", gs.stage_buffer, "Git: stage buffer")
        map("n", "<leader>gR", gs.reset_buffer, "Git: reset buffer")

        -- Informations Git.
        map("n", "<leader>gb", gs.toggle_current_line_blame, "Git: toggle blame")
        map("n", "<leader>gd", gs.diffthis, "Git: diff file")
      end,
    },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    keys = {
      {
        "<leader>gg",
        "<cmd>LazyGit<CR>",
        desc = "Git: LazyGit",
      },
    },
  },

  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal" },
      { "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal" },
    },
    opts = {
      size = 15,
      direction = "horizontal",
      shell = vim.fn.executable("zsh") == 1 and "zsh" or vim.o.shell,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      shade_terminals = true,
      close_on_exit = true,
    },
  },

  {
  "numToStr/Comment.nvim",
  event = "VeryLazy",

  opts = {
    mappings = {
      basic = true,
      extra = true,
      },
    },
  },
}
