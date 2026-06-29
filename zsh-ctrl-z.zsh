ZSH_CTRL_Z_HOME="${0:A:h}"

fzf-ctrl-z() {
  setopt localoptions pipefail no_aliases 2> /dev/null

  local current_jobs=("${(@f)$(jobs -l)}")
  [[ -n "${current_jobs[1]}" ]] || return

  if [[ ${#current_jobs} -eq 1 ]]; then
    BUFFER="fg" && zle accept-line -w
    return
  fi

  local selected
  while true; do
    local current_jobs=("${(@f)$(jobs -l)}")
		[[ -n "${current_jobs[1]}" ]] || break

    selected=$(printf "%s\n" "${current_jobs[@]}" | fzf \
      --reverse \
      --bind "ctrl-z:accept" \
      --bind "ctrl-k:become(echo kill:{})" \
      --header "ENTER / CTRL-Z: Foreground job | CTRL-K: Kill job" \
      --prompt="  Search jobs ❯ ")

    [[ -z $selected ]] && break

    if [[ "$selected" =~ "^kill:\[" ]]; then
	  	local job_id=$(echo "$selected" | sed 's/kill://' | awk '{print $1}' | tr -d '[]')
    	if [[ -n $job_id ]]; then
    		kill -KILL %"$job_id" 2>/dev/null
    		sleep 0.1
  		fi
    else
      local job_id=$(echo "$selected" | awk '{print $1}' | tr -d '[]')
      BUFFER="fg %$job_id"
      zle accept-line -w
      break
    fi
  done

  zle reset-prompt
}

'builtin' zle -N fzf-ctrl-z

# Init
() {
  (( $fpath[(I)${ZSH_CTRL_Z_HOME}/functions] )) ||
    fpath+=(${ZSH_CTRL_Z_HOME}/functions)

  'builtin' local keymap
  for keymap in 'emacs' 'viins' 'vicmd'; do
    bindkey -M "$keymap" '^Z' fzf-ctrl-z
  done
}
