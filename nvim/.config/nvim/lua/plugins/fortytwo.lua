return {
  ---------------------------------------------------------------------------
  -- HEADER 42
  ---------------------------------------------------------------------------
  {
  "42Paris/42header",

  event = {
    "BufReadPre",
    "BufNewFile",
  },

  init = function()
    vim.g.user42 = vim.env.USER42 or vim.env.USER

    vim.g.mail42 = vim.env.MAIL42
      or ((vim.env.USER42 or vim.env.USER) .. "@learner.42.tech")
  end,

  keys = {
    {
      "<F1>",
      "<cmd>Stdheader<CR>",
      desc = "42 Header",
    },
  },
},
  ---------------------------------------------------------------------------
  -- OUTILS 42 + NORMINETTE NATIVE NEOVIM
  ---------------------------------------------------------------------------
  {
    "nvim-lua/plenary.nvim",

    config = function()
      local namespace = vim.api.nvim_create_namespace("norminette")

      local function strip_ansi(text)
        return (text or ""):gsub("\27%[[0-9;]*m", "")
      end

      local function parse_norminette(output)
        local diagnostics = {}

        for line in strip_ansi(output):gmatch("[^\r\n]+") do
          -------------------------------------------------------------------
          -- Sortie brute Norminette v3 :
          -- Error: CODE (line: 17, col: 8): Message
          -------------------------------------------------------------------
          local severity_name, code, lnum, col, message = line:match(
            "^(%a+):%s*(.-)%s*%(line:%s*(%d+),%s*col:%s*(%d+)%)%s*:%s*(.*)$"
          )

          if lnum then
            local severity = vim.diagnostic.severity.ERROR

            if severity_name:lower() == "warning" then
              severity = vim.diagnostic.severity.WARN
            end

            table.insert(diagnostics, {
              lnum = tonumber(lnum) - 1,
              col = math.max(tonumber(col) - 1, 0),
              severity = severity,
              source = "Norminette",
              code = vim.trim(code),
              message = vim.trim(message),
            })
          else
            -----------------------------------------------------------------
            -- Format type quickfix, gardé comme secours :
            -- |17 col 8 error| Message
            -----------------------------------------------------------------
            local q_lnum, q_col, q_severity, q_message = line:match(
              "^|?(%d+)%s+col%s+(%d+)%s+(%a+)|?%s*(.*)$"
            )

            if q_lnum then
              local severity = vim.diagnostic.severity.ERROR

              if q_severity:lower() == "warning" then
                severity = vim.diagnostic.severity.WARN
              end

              table.insert(diagnostics, {
                lnum = tonumber(q_lnum) - 1,
                col = math.max(tonumber(q_col) - 1, 0),
                severity = severity,
                source = "Norminette",
                message = vim.trim(q_message),
              })
            end
          end
        end

        return diagnostics
      end

      local function run_norminette(bufnr, notify_success, open_list)
        bufnr = bufnr or vim.api.nvim_get_current_buf()
        local source_win = vim.api.nvim_get_current_win()

        if not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end

        local file = vim.api.nvim_buf_get_name(bufnr)

        if file == "" then
          return
        end

        if not file:match("%.c$") and not file:match("%.h$") then
          vim.diagnostic.reset(namespace, bufnr)
          return
        end

        if vim.fn.executable("norminette") ~= 1 then
          vim.notify(
            "norminette introuvable dans le PATH",
            vim.log.levels.ERROR
          )
          return
        end

        vim.system(
          {
            "norminette",
            file,
          },
          {
            text = true,
          },
          function(result)
            local output = (result.stdout or "") .. "\n" .. (result.stderr or "")
            local diagnostics = parse_norminette(output)

            vim.schedule(function()
              if not vim.api.nvim_buf_is_valid(bufnr) then
                return
              end

              vim.diagnostic.set(namespace, bufnr, diagnostics, {
                signs = {
                  text = {
                    [vim.diagnostic.severity.ERROR] = "✗",
                    [vim.diagnostic.severity.WARN] = "▲",
                  },
                },
                underline = true,
                severity_sort = true,
                virtual_text = {
                  spacing = 2,
                  prefix = "●",
                  source = false,
                  format = function(diagnostic)
                    return diagnostic.message
                  end,
                },
              })

              -----------------------------------------------------------------
              -- Liste détaillée en bas, façon ancien plugin Norminette.
              -- La location list reste attachée à la fenêtre du fichier.
              -----------------------------------------------------------------
              if vim.api.nvim_win_is_valid(source_win) then
                local items = {}

                for _, diagnostic in ipairs(diagnostics) do
                  local kind = diagnostic.severity == vim.diagnostic.severity.WARN
                      and "W"
                    or "E"

                  local text = diagnostic.message

                  if diagnostic.code and diagnostic.code ~= "" then
                    text = string.format("[%s] %s", diagnostic.code, text)
                  end

                  table.insert(items, {
                    bufnr = bufnr,
                    lnum = diagnostic.lnum + 1,
                    col = diagnostic.col + 1,
                    text = text,
                    type = kind,
                  })
                end

                vim.fn.setloclist(source_win, {}, "r", {
                  title = "Norminette",
                  items = items,
                })

                if open_list then
                  if #items > 0 then
                    vim.api.nvim_win_call(source_win, function()
                      vim.cmd("botright lopen 12")
                    end)
                  else
                    pcall(vim.api.nvim_win_call, source_win, function()
                      vim.cmd("lclose")
                    end)
                  end
                end
              end

              if notify_success then
                if #diagnostics == 0 and result.code == 0 then
                  vim.notify(
                    "Norminette : OK",
                    vim.log.levels.INFO
                  )
                else
                  vim.notify(
                    string.format(
                      "Norminette : %d erreur%s",
                      #diagnostics,
                      #diagnostics > 1 and "s" or ""
                    ),
                    vim.log.levels.WARN
                  )
                end
              end
            end)
          end
        )
      end

      vim.api.nvim_create_user_command("Norminette", function()
        run_norminette(0, true, true)
      end, {
        desc = "Run Norminette on current file",
      })

      local group = vim.api.nvim_create_augroup("Norminette42", {
        clear = true,
      })

      vim.api.nvim_create_autocmd({
        "BufReadPost",
        "BufWritePost",
      }, {
        group = group,
        pattern = {
          "*.c",
          "*.h",
        },
        callback = function(args)
          run_norminette(args.buf, false, false)
        end,
      })
    end,

    keys = {
      -----------------------------------------------------------------------
      -- F2 : FORMATTER 42
      -----------------------------------------------------------------------
      {
        "<F2>",

        function()
          if vim.fn.executable("c_formatter_42") ~= 1 then
            vim.notify(
              "c_formatter_42 introuvable dans le PATH",
              vim.log.levels.ERROR
            )
            return
          end

          vim.cmd("write")

          local file = vim.fn.expand("%:p")

          if file == "" then
            vim.notify(
              "Aucun fichier ouvert",
              vim.log.levels.ERROR
            )
            return
          end

          local result = vim.fn.system({
            "c_formatter_42",
            file,
          })

          if vim.v.shell_error ~= 0 then
            vim.notify(
              "Échec c_formatter_42:\n" .. result,
              vim.log.levels.ERROR
            )
            return
          end

          vim.cmd("edit!")
          vim.cmd("Norminette")

          vim.notify(
            "Fichier formaté avec c_formatter_42",
            vim.log.levels.INFO
          )
        end,

        desc = "Format current file (42)",
      },

      -----------------------------------------------------------------------
      -- F3 : NORMINETTE DU FICHIER COURANT
      -----------------------------------------------------------------------
      {
        "<F3>",

        function()
          vim.cmd("write")
          vim.cmd("Norminette")
        end,

        desc = "Norminette current file",
      },

      -----------------------------------------------------------------------
      -- SPACE+n : NORMINETTE DU PROJET
      -----------------------------------------------------------------------
      {
        "<leader>n",

        function()
          vim.cmd("wall")

          if vim.fn.executable("norminette") ~= 1 then
            vim.notify(
              "norminette introuvable dans le PATH",
              vim.log.levels.ERROR
            )
            return
          end

          local cwd = vim.fn.getcwd()

          local command =
            "cd "
            .. vim.fn.shellescape(cwd)
            .. " && find . -type f \\( "
            .. "-name '*.c' -o -name '*.h' "
            .. "\\) -exec norminette {} +"

          vim.cmd(
            "botright 15split | terminal "
              .. command
          )
        end,

        desc = "Norminette entire project",
      },
    },
  },
}
