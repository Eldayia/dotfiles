vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

---------------------------------------------------------------------------
-- AFFICHAGE GÉNÉRAL
---------------------------------------------------------------------------

opt.number = true
opt.relativenumber = false

opt.mouse = "a"

opt.cursorline = true

opt.scrolloff = 6
opt.sidescrolloff = 8

opt.wrap = false

opt.signcolumn = "yes"

opt.termguicolors = true


---------------------------------------------------------------------------
-- DIAGNOSTICS NEOVIM
---------------------------------------------------------------------------

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✗",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.INFO] = "●",
      [vim.diagnostic.severity.HINT] = "◆",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = {
    spacing = 2,
    prefix = "●",
    source = "if_many",
  },
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

---------------------------------------------------------------------------
-- CARACTÈRES INVISIBLES
---------------------------------------------------------------------------

-- Affiche les tabs, espaces de fin de ligne, etc.
opt.list = true

opt.listchars = {
  -- Une vraie tabulation
  tab = "» ",

  -- Espaces en fin de ligne
  trail = "·",

  -- Fin de ligne
  eol = "↲",

  -- Texte qui dépasse à droite
  extends = "›",

  -- Texte qui dépasse à gauche
  precedes = "‹",

  -- Espace insécable
  nbsp = "␣",
}

-- Si tu réactives wrap manuellement
opt.showbreak = "↪ "

---------------------------------------------------------------------------
-- RECHERCHE
---------------------------------------------------------------------------

opt.ignorecase = true
opt.smartcase = true

---------------------------------------------------------------------------
-- SPLITS
---------------------------------------------------------------------------

opt.splitright = true
opt.splitbelow = true

---------------------------------------------------------------------------
-- SAUVEGARDE / UNDO
---------------------------------------------------------------------------

opt.swapfile = false
opt.backup = false
opt.undofile = true

---------------------------------------------------------------------------
-- RÉACTIVITÉ
---------------------------------------------------------------------------

opt.updatetime = 250
opt.timeoutlen = 500

---------------------------------------------------------------------------
-- AUTOCOMPLÉTION
---------------------------------------------------------------------------

opt.completeopt = {
  "menu",
  "menuone",
  "noselect",
}

---------------------------------------------------------------------------
-- NORME 42
---------------------------------------------------------------------------

-- Repère visuel de la limite de ligne
opt.colorcolumn = "80"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },

  callback = function()
    local local_opt = vim.opt_local

    -----------------------------------------------------------------------
    -- TABULATIONS
    -----------------------------------------------------------------------

    -- Utilise de vraies tabulations, pas des espaces
    local_opt.expandtab = false

    -- Une tabulation occupe 4 colonnes
    local_opt.tabstop = 4

    -- >> et << déplacent de 4 colonnes
    local_opt.shiftwidth = 4

    -- Tab en insertion travaille sur 4 colonnes
    local_opt.softtabstop = 4

    -----------------------------------------------------------------------
    -- INDENTATION
    -----------------------------------------------------------------------

    -- Reprend l'indentation de la ligne précédente
    local_opt.autoindent = true

    -- Désactivé pour éviter certaines indentations automatiques
    -- peu adaptées au style 42
    local_opt.smartindent = false

    -----------------------------------------------------------------------
    -- COMMENTAIRES / FORMATAGE AUTOMATIQUE
    -----------------------------------------------------------------------

    -- Évite que Neovim continue automatiquement les commentaires
    -- quand tu fais Entrée ou 'o'
    local_opt.formatoptions:remove({
      "c",
      "r",
      "o",
    })
  end,
})
