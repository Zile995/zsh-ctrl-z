ZSH_CTRL_Z_HOME="${0:A:h}"

fzf-ctrl-z() {
  setopt localoptions pipefail no_aliases 2> /dev/null

  local current_jobs=("${(@f)$(jobs -l)}")
  [[ -n $current_jobs ]] || return

  if [[ ${#current_jobs} -gt 1 ]]; then
    local selected_job=$(: | fzf \
      --reverse \
      --bind "start:reload(get_jobs)"
      --bind "ctrl-z:accept" \
      --bind "ctrl-k:execute(kill_suspended {})+reload(get_jobs)" \
      --header "CTRL-Z/ENTER: Run job in the foreground" \
      --prompt="  Search jobs ❯ " |
      awk '{ print $1 }' |
      tr -d '[]' \
    )
    [[ -z $selected_job ]] || { BUFFER="fg %$selected_job"; zle accept-line -w }
  else
    BUFFER="fg" && zle accept-line -w
  fi

  redraw_prompt
}

'builtin' zle -N fzf-ctrl-z

# Init
() {
  (( $fpath[(I)${ZSH_CTRL_Z_HOME}/functions] )) ||
    fpath+=(${ZSH_CTRL_Z_HOME}/functions)

  autoload -Uz ${ZSH_CTRL_Z_HOME}/functions/*

  'builtin' local keymap
  for keymap in 'emacs' 'viins' 'vicmd'; do
    bindkey -M "$keymap" '^Z' fzf-ctrl-z
  done
}
