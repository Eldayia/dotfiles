# ============================================================
# HISTORY
# ============================================================

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"

HISTSIZE=1000000
SAVEHIST=1000000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

setopt EXTENDED_HISTORY

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS

setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

setopt HIST_VERIFY


# ============================================================
# DIRECTORIES
# ============================================================

setopt AUTO_CD

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME


# ============================================================
# COMPLETION
# ============================================================

setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

setopt AUTO_LIST
setopt AUTO_MENU

setopt AUTO_PARAM_KEYS
setopt AUTO_PARAM_SLASH

setopt LIST_AMBIGUOUS


# ============================================================
# GLOBBING
# ============================================================

setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT


# ============================================================
# INPUT
# ============================================================

setopt INTERACTIVE_COMMENTS
setopt RC_QUOTES


# ============================================================
# JOBS
# ============================================================

setopt AUTO_RESUME
setopt LONG_LIST_JOBS
setopt NOTIFY


# ============================================================
# GENERAL
# ============================================================

setopt MULTIOS

unsetopt BEEP
unsetopt HIST_BEEP
unsetopt LIST_BEEP
