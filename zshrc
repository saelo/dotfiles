# 
# ZSH Configuration
# See 'man zsh', in particular 'man zshbuiltins' for all zsh specific builtins.
#

# ZSH options. See `man zshoptions`
setopt prompt_subst             # Enable substitutions on prompts. Necessary to render vcs_info
                                # into the prompt.
setopt share_history            # Share history between all zsh sessions.
                                # In practice, this causes history entries to be appended to the
                                # history file immediately (instead of when the shell exits) and
                                # causes any new entries (from other zsh sessions) to be loaded
                                # from the history file at the same time.
setopt hist_ignore_space        # Don't record commands that start with a space into the history.
setopt hist_reduce_blanks       # Remove superfluous blanks from commands in the history.
setopt hist_ignore_all_dups     # When inserting a duplicate entry into the history, delete the
                                # old entry.
setopt hist_save_no_dups        # Remove duplicate entries when saving the history to disk.
setopt hist_verify              # Reload commands with history expansion (e.g. !!) instead of
                                # executing them immediately.
setopt interactive_comments     # Allow comments in interactive sessions (and ignore them).
setopt print_exit_value         # Print exit code of commands if nonzero.
setopt auto_pushd               # Have cd push the old directory onto the directory stack.

# ZSH parameters. See 'man zshparam'
HISTFILE=$HOME/.zsh_history     # Enable persistent history
HISTSIZE=20000                  # Maximum size of the history
SAVEHIST=10000                  # Maximum size of the persistent history on disk

# ZSH modules. See 'man zshmodules'
zmodload zsh/complist           # Load complist module manually so menuselect keymap is loaded

# Use the vi keymap. See 'man zshzle'
bindkey -v

# Enable Shift-Tab in completion menu
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Start incremental backward search on Ctrl-r
bindkey -M viins '^r' history-incremental-search-backward

# Bind up and down key to perform history search with the current input. If this doesn't work, see
# https://zsh.sourceforge.io/FAQ/zshfaq03.html#l25 or https://wiki.archlinux.org/title/Zsh#Key_bindings
# and use $terminfo[kcuu1] and $terminfo[kcud1] instead if available.
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[OA' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search
bindkey -M viins '^[OB' down-line-or-beginning-search

# Enable version control system information.  See 'man zshcontrib'
autoload -Uz vcs_info
precmd_functions+=( vcs_info )
zstyle ':vcs_info:*' enable git                     # Only enable git backend
zstyle ':vcs_info:git:*' formats ' [%b]'            # Configure normal format to only show branch name
zstyle ':vcs_info:git:*' actionformats ' [%b|%a]'   # Configure action format to show branch and action (e.g. rebase)

# Enable zsh completion system. See 'man zshcompsys'
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select      # Enable menu selection everywhere
zstyle ':completion:*' list-colors ''   # Use (the default) colors for the completion menu

# ZSH Prompt. See `man zshmisc`
PROMPT='%F{green}%1m%f %2~${vcs_info_msg_0_} %F{green}%B>%b%f '

#
# User configuration
#
export EDITOR=vim

# V8/Chromium development
export PATH=$HOME/Tools/depot_tools:$PATH
alias gm='./tools/dev/gm.py'

# Set (and possibly overwrite) default locale environment variables
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Use neovim as vim if available
if hash nvim 2>/dev/null; then
  alias vim=nvim
  alias vimdiff='nvim -d'

  # Use neovim as editor and manpager
  export EDITOR=nvim
  export MANPAGER='nvim +Man!'
fi

# Obtain LS_COLORS from dircolors when available
if hash dircolors 2> /dev/null; then
  eval "$(dircolors -b)"

  # and use them for zsh's completion menu as well
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# Use colors in ls
if [[ "$OSTYPE" == darwin* ]]; then
  alias ls='ls -G'
elif [[ "$OSTYPE" == linux* ]]; then
  alias ls='ls --color=auto'
fi

#
# Extract various archive formats
#
# usage: extract <file>
#
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
