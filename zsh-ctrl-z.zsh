ZSH_CTRL_Z_HOME="${0:A:h}"

fzf-ctrl-z() {
  setopt localoptions pipefail no_aliases 2>/dev/null

  (( ${#jobstates} == 0 )) && return
  (( ${#jobstates} == 1 )) && {
    BUFFER=""
    zle -I && 'builtin' fg >/dev/null 2>&1
    zle reset-prompt
    return
  }

  while true; do
    (( ${#jobstates} )) || break

    local -a current_jobs=("${(@f)$(jobs -l)}")
    local -a selected=("${(@f)$(printf "%s\n" "${current_jobs[@]}" | fzf \
      --reverse \
      --expect=ctrl-k \
      --bind "ctrl-z:accept" \
      --header "ENTER / CTRL-Z: Foreground job | CTRL-K: Kill job" \
      --prompt="  Search jobs ❯ ")}")

    (( $#selected < 2 )) && break

    local key="${selected[1]}"
    local job_id="${${${selected[2]%% *}#\[}%\]}"
    [[ -z $job_id ]] && break

    case "${key:-accept}" in
      ctrl-k)
        'builtin' kill -KILL %"$job_id" 2>/dev/null
        sleep 0.1
        ;;
      accept)
        BUFFER=""
        zle -I && 'builtin' fg %"$job_id" >/dev/null 2>&1
        break
        ;;
    esac
  done

  zle reset-prompt
}

'builtin' zle -N fzf-ctrl-z

# Init
() {
  'builtin' local keymap
  for keymap in 'emacs' 'viins' 'vicmd'; do
    bindkey -M "$keymap" '^Z' fzf-ctrl-z
  done
}
