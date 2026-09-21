local map = vim.keymap.set

---------------------------------------------------------------------------
-- SAUVEGARDE
---------------------------------------------------------------------------

map({ "n", "i", "v" }, "<C-s>", "<cmd>write<CR>", {
  desc = "Save file",
})

---------------------------------------------------------------------------
-- AFFICHAGE
---------------------------------------------------------------------------

-- Anciennement Space rn.
-- Déplacé pour libérer Space r pour Run.
map("n", "<leader>tn", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, {
  desc = "Toggle relative numbers",
})

map("n", "<leader>tl", function()
  vim.opt.list = not vim.opt.list:get()
end, {
  desc = "Toggle invisible characters",
})

vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
  eol = "↲",
}

---------------------------------------------------------------------------
-- FENÊTRES
--
-- Navigation rapide : Ctrl + h/j/k/l
-- Redimensionnement : Alt + h/j/k/l
-- Menu Space w : actions sur les fenêtres
---------------------------------------------------------------------------

map("n", "<C-h>", "<C-w>h", { desc = "Window: left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window: down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window: up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window: right" })

map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Window: left" })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Window: down" })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Window: up" })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Window: right" })

map("n", "<A-h>", "<cmd>vertical resize -5<CR>", {
  desc = "Window: narrower",
})

map("n", "<A-l>", "<cmd>vertical resize +5<CR>", {
  desc = "Window: wider",
})

map("n", "<A-j>", "<cmd>resize +3<CR>", {
  desc = "Window: taller",
})

map("n", "<A-k>", "<cmd>resize -3<CR>", {
  desc = "Window: shorter",
})

map("n", "<leader>wv", "<cmd>vsplit<CR>", {
  desc = "Window: vertical split",
})

map("n", "<leader>ws", "<cmd>split<CR>", {
  desc = "Window: horizontal split",
})

map("n", "<leader>wq", "<cmd>close<CR>", {
  desc = "Window: close",
})

map("n", "<leader>wo", "<cmd>only<CR>", {
  desc = "Window: keep only this one",
})

map("n", "<leader>w=", "<C-w>=", {
  desc = "Window: equal sizes",
})

-- Ancien raccourci conservé.
map("n", "<leader>q", "<cmd>close<CR>", {
  desc = "Window: close",
})

---------------------------------------------------------------------------
-- BUFFERS
--
-- Shift+h / Shift+l : buffer précédent / suivant (Bufferline)
-- Space b... : gestion complète des buffers
---------------------------------------------------------------------------

map("n", "<leader>bd", function()
  require("mini.bufremove").delete(0, false)
end, {
  desc = "Buffer: close",
})

map("n", "<leader>bD", function()
  require("mini.bufremove").delete(0, true)
end, {
  desc = "Buffer: force close",
})

map("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= current
      and vim.api.nvim_buf_is_valid(bufnr)
      and vim.bo[bufnr].buflisted
    then
      pcall(require("mini.bufremove").delete, bufnr, false)
    end
  end
end, {
  desc = "Buffer: close others",
})

map("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", {
  desc = "Buffer: next",
})

map("n", "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", {
  desc = "Buffer: previous",
})

map("n", "<leader>bs", "<cmd>BufferLinePick<CR>", {
  desc = "Buffer: pick",
})

map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", {
  desc = "Buffer: pick to close",
})

-- Quitte complètement Neovim.
map("n", "<leader>Q", "<cmd>qa<CR>", {
  desc = "Quit Neovim",
})

---------------------------------------------------------------------------
-- TERMINAL
---------------------------------------------------------------------------

-- Esc Esc permet de sortir facilement du mode terminal.
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], {
  desc = "Terminal normal mode",
})


---------------------------------------------------------------------------
-- DIAGNOSTICS
---------------------------------------------------------------------------

map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, {
  desc = "Next diagnostic",
})

map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, {
  desc = "Previous diagnostic",
})

map("n", "<leader>xd", function()
  vim.diagnostic.open_float(nil, {
    scope = "line",
  })
end, {
  desc = "Line diagnostics",
})

---------------------------------------------------------------------------
-- COMPILATION C
--
-- Space c
--
-- Compile le fichier C courant avec :
--
-- cc -Wall -Wextra -Werror fichier.c -o /tmp/...
---------------------------------------------------------------------------

map("n", "<leader>c", function()
  -------------------------------------------------------------------------
  -- Vérifie qu'on est bien dans un fichier C
  -------------------------------------------------------------------------
  if vim.bo.filetype ~= "c" then
    vim.notify(
      "Le fichier courant n'est pas un fichier C",
      vim.log.levels.WARN
    )

    return
  end

  -------------------------------------------------------------------------
  -- Sauvegarde avant compilation
  -------------------------------------------------------------------------
  vim.cmd("write")

  local file = vim.fn.expand("%:p")

  if file == "" then
    vim.notify(
      "Aucun fichier à compiler",
      vim.log.levels.ERROR
    )

    return
  end

  -------------------------------------------------------------------------
  -- Nom unique pour le binaire temporaire
  --
  -- Ça évite de créer des exécutables dans tes dossiers 42.
  -------------------------------------------------------------------------
  local hash = vim.fn.sha256(file):sub(1, 12)

  local binary =
    "/tmp/nvim42_"
    .. hash

  -------------------------------------------------------------------------
  -- On mémorise le binaire pour Space r
  -------------------------------------------------------------------------
  vim.g.nvim42_last_binary = binary
  vim.g.nvim42_last_source = file

  -------------------------------------------------------------------------
  -- Commande de compilation
  -------------------------------------------------------------------------
  local command =
    "cc -Wall -Wextra -Werror "
    .. vim.fn.shellescape(file)
    .. " -o "
    .. vim.fn.shellescape(binary)
    .. " && printf '\\n\\033[32mCompilation OK\\033[0m\\n'"

  -------------------------------------------------------------------------
  -- Terminal de compilation en bas
  -------------------------------------------------------------------------
  vim.cmd(
    "botright 12split | terminal "
      .. command
  )
end, {
  desc = "Compile current C file",
})

---------------------------------------------------------------------------
-- EXECUTION
--
-- Space r
---------------------------------------------------------------------------

map("n", "<leader>r", function()
  local binary = vim.g.nvim42_last_binary

  if not binary then
    vim.notify(
      "Aucun programme compilé. Fais d'abord Space c.",
      vim.log.levels.WARN
    )

    return
  end

  if vim.fn.executable(binary) ~= 1 then
    vim.notify(
      "Le dernier binaire n'existe pas ou la compilation a échoué.",
      vim.log.levels.ERROR
    )

    return
  end

  -------------------------------------------------------------------------
  -- Exécution dans un terminal en bas
  -------------------------------------------------------------------------
  vim.cmd(
    "botright 15split | terminal "
      .. vim.fn.shellescape(binary)
  )
end, {
  desc = "Run compiled C program",
})

---------------------------------------------------------------------------
-- GIT CLONE
---------------------------------------------------------------------------

map("n", "<leader>gc", function()
  vim.ui.input({
    prompt = "Git URL: ",
  }, function(url)
    if not url or url == "" then
      return
    end

    vim.ui.input({
      prompt = "Destination (vide = nom du repo): ",
    }, function(destination)
      local target = destination

      if not target or target == "" then
        target = url
          :gsub("/$", "")
          :match("([^/:]+)%.git$")
          or url
            :gsub("/$", "")
            :match("([^/:]+)$")
      end

      if not target or target == "" then
        vim.notify(
          "Impossible de déterminer le dossier destination",
          vim.log.levels.ERROR
        )
        return
      end

      local cwd = vim.fn.getcwd()
      local full_path = vim.fs.joinpath(cwd, target)

      if vim.fn.isdirectory(full_path) == 1 then
        vim.notify(
          "Le dossier existe déjà : " .. full_path,
          vim.log.levels.ERROR
        )
        return
      end

      vim.notify(
        "Clonage de " .. url .. "...",
        vim.log.levels.INFO
      )

      vim.system({
        "git",
        "clone",
        url,
        target,
      }, {
        cwd = cwd,
        text = true,
      }, function(result)
        vim.schedule(function()
          if result.code ~= 0 then
            vim.notify(
              "Échec du clone Git:\n"
                .. (result.stderr or result.stdout or ""),
              vim.log.levels.ERROR
            )
            return
          end

          vim.cmd("cd " .. vim.fn.fnameescape(full_path))

          pcall(function()
            require("neo-tree.command").execute({
              action = "show",
              source = "filesystem",
              position = "left",
              dir = full_path,
            })
          end)

          vim.cmd("enew")

          vim.notify(
            "Repo cloné dans " .. full_path,
            vim.log.levels.INFO
          )
        end)
      end)
    end)
  end)
end, {
  desc = "Git clone repository",
})
