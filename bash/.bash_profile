
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_GREEN='\033[38;5;46m'
COLOR_OCHRE='\033[38;5;95m'
COLOR_LIGHT_CYAN='\033[0;96m'
COLOR_DARK_GRAY='\033[38;5;7m'
COLOR_WHITE='\033[0;37m'
BOLD='\[$(tput bold)\]'
RESET='\[$(tput sgr0)\]'

git_color() {
  if [ $# -eq 1 ]; then
    local git_status=$1
  else
    local git_status="$(git status 2> /dev/null)"
  fi
  
  # TODO: Check these strings are actually used
  # TODO: Settle on better color scheme
  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_WHITE
  elif [[ $git_status =~ "untracked files present" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "Changes to be committed" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

parse_git_branch() {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  local paren_color=$COLOR_LIGHT_CYAN

  local branch_start="$paren_color($(git_color git_status)"
  local branch_end="$paren_color) "

  # TODO: Show branch dirtiness
  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo -e "${branch_start}${branch}${branch_end}"
  elif [[ $git_status =~ $on_commit ]]; then 
    local commit=${BASH_REMATCH[1]}
    echo -e "${branch_start}${commit}${branch_end}"
  fi
}

__ps1() {
  RET=$1

  local left_prompt="$BOLD[$RESET"
  left_prompt+="\u@\[${COLOR_GREEN}\]\W${RESET}"
  left_prompt+="${BOLD}]${RESET}"

  local git_info="\$(parse_git_branch)${RESET}"

  input_prompt="\\$"
  if [ $RET -ne 0 ]; then 
    input_prompt="${COLOR_RED}${input_prompt}"
  fi
  
  export PS1="${left_prompt} ${git_info}${input_prompt}${RESET} "
}

export PROMPT_COMMAND='__ps1 $?'

