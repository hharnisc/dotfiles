#!/usr/bin/env sh

shopt -s autocd
shopt -s cdspell
shopt -s checkjobs
shopt -s checkwinsize
shopt -s dirspell
shopt -s globstar
shopt -s nocaseglob

export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR=vim

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -G'
alias fn='find . -name'
alias tmux='TERM=screen-256color-bce tmux'

export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Eternal bash history.
# ---------------------

# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "

# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history

# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

if [ "$(type -P grunt)" ]; then
   eval "$(grunt --completion=bash)"
fi

if which brew >/dev/null 2>&1; then
  if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . "$(brew --prefix)/etc/bash_completion"
    . "$(brew --prefix)/etc/t-completion.sh"
  fi

  if [ -f "$(brew --prefix)/Library/Contributions/brew_bash_completion.sh" ]; then
    . "$(brew --prefix)/Library/Contributions/brew_bash_completion.sh"
  fi

  eval "$(rbenv init -)"
else
  . /etc/bash_completion.d/git
fi

. ~/.shell_prompt.sh
. ~/.git-prompt.sh

# homebrew bashrc stuff
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
export HOMEBREW_CC=gcc-4.4

# check env var YROOT_NAME to see if we are in a yroot
if [ "x$YROOT_NAME" != "x" ]; then
  PS1="\n⚓️ :$YROOT_NAME $PS1"
fi
