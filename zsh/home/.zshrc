export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export RUSTUP_HOME="/opt/rust/rustup"
export CARGO_HOME="/opt/rust/cargo"
export GEM_HOME="/opt/ruby/bundle"
export PATH="${CARGO_HOME}/bin:$GEM_HOME/bin:/opt/ruby/bin:${PATH}"

[[ -n "${terminfo[khome]}" ]] && bindkey "${terminfo[khome]}" beginning-of-line
[[ -n "${terminfo[kend]}"  ]] && bindkey "${terminfo[kend]}"  end-of-line
[[ -n "${terminfo[kich1]}" ]] && bindkey "${terminfo[kich1]}" overwrite-mode
[[ -n "${terminfo[kdch1]}" ]] && bindkey "${terminfo[kdch1]}" delete-char
[[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" up-line-or-history
[[ -n "${terminfo[kcud1]}" ]] && bindkey "${terminfo[kcud1]}" down-line-or-history
[[ -n "${terminfo[kcub1]}" ]] && bindkey "${terminfo[kcub1]}" backward-char
[[ -n "${terminfo[kcuf1]}" ]] && bindkey "${terminfo[kcuf1]}" forward-char

bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

export CDPATH=":..:~"

..() {
  range=$(eval "echo '{1..$1}'");
  toPrint="'../%.0s' $range";
  printfToEval=$(echo "printf $toPrint");
  toCd=$(eval $printfToEval);
  eval "cd $toCd";
  pwd;
}

alias ':q'="exit"
alias 'ls'="exa"
alias 'll'="exa -hal"
alias 'grep'="rg"
alias 'cat'="bat"
alias 'rm'="rm -v"
alias 'cp'="cp -v"
alias 'mv'="mv -v"
alias 'df'="df -h"
alias 'du'="du -h"
alias 'mkdir'="mkdir -p -v"
alias 'ping'="ping -c 3"

alias 'yank'="chirp copy"
alias 'put'="chirp paste"

export KEYTIMEOUT=""
unsetopt nomatch
setopt extendedglob

export HISTFILE="/data/zsh/history"
export HISTSIZE="10000"
export SAVEHIST="10000"
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY

trap exit TERM

command_not_found_handler () {
  d=$(command -v dodo)
  if [ $? = 0 ]; then
    $d run "$@"
    return $?
  fi
  echo "command not found: $0"
  return 127
}

eval "$(starship init zsh)"
