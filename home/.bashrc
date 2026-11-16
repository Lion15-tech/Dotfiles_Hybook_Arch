#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

# Reemplazar ls por eza con íconos
alias ls='eza --icons --group-directories-first'
alias ll='eza -lbGF --icons --group-directories-first'
alias tree='eza --tree --icons'

# Prompt Cyberpunk Neón con detección de rama y estado Git
__cyberpunk_prompt() {
    local exit_code=$?
    local c_cyan='\[\e[38;2;0;240;255m\]'
    local c_pink='\[\e[38;2;255;0;85m\]'
    local c_gray='\[\e[38;2;136;136;136m\]'
    local c_green='\[\e[38;2;0;255;102m\]'
    local c_yellow='\[\e[38;2;255;238;0m\]'
    local c_reset='\[\e[0m\]'

    local git_segment=""
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

    if [[ -n "$branch" ]]; then
        local status
        status=$(git status --porcelain 2>/dev/null)
        if [[ -z "$status" ]]; then
            git_segment=" ${c_gray}on ${c_green} ${branch}"
        else
            local flags=""
            [[ "$status" =~ (^|$'\n')[MADRC] ]] && flags+="+"
            [[ "$status" =~ (^|$'\n')(.M|.D|\?\?) ]] && flags+="*"
            [[ -n "$flags" ]] && flags=" ${flags}"
            git_segment=" ${c_gray}on ${c_yellow} ${branch}${flags}"
        fi
    fi

    local arrow_color="$c_cyan"
    [[ $exit_code -ne 0 ]] && arrow_color="$c_pink"

    PS1="${c_cyan}󰣇 ${c_pink}\u ${c_gray}in ${c_green}\w${git_segment} ${arrow_color}❯ ${c_reset}"
}
PROMPT_COMMAND=__cyberpunk_prompt

# Alias para colocar el fondo cyberpunk por si acaso
alias fondo_cyb='feh --bg-fill ~/Imagenes/Wallpapers/cyberpunk_rosa\(2560x1440\).jpg'

alias badapple='~/reproducir_bad_apple.sh'
alias asciiquarium='TERM=xterm-256color asciiquarium'
