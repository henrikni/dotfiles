# Note that this bash script is meant to be sourced and not executed.

# Prints the branch and status of any active git repository.
function git_prompt() {
  local branch_status=""
  local branch_name=""

  # Verify that git is available and check if the current directory is in a
  # git repository.
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    return
  fi

  # Check if the current directory is in .git before running git checks.
  if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == "false" ]; then
    # Ensure index is up to date.
    git update-index --really-refresh  -q &>/dev/null

    # Check for uncommitted changes.
    if ! git diff --quiet --ignore-submodules --cached; then
      branch_status+="+"
    fi

    # Check for unstaged changes.
    if ! git diff-files --quiet --ignore-submodules --; then
      branch_status+="!"
    fi

    # Check for untracked files.
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
      branch_status+="?"
    fi

    # Check for stashed files.
    if git rev-parse --verify refs/stash &>/dev/null; then
      branch_status+="$"
    fi
    
    # Wrap any status in braces. 
    [ -n "${branch_status}" ] && branch_status=" [${branch_status}]"
  fi

  # Get the short symbolic ref. If HEAD isn't a symbolic ref, get the short
  # SHA. Otherwise, just give up.
  branch_name="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
                 git rev-parse --short HEAD 2> /dev/null || \
                 printf "(unknown)")"

  printf '%s' "$1${branch_name}${branch_status}"
}

# Print the relative path to any active pution environment.
function python_prompt() {
  if [ -z "${VIRTUAL_ENV}" ]; then
    return 
  fi
  
  env_name=$(realpath --relative-to=. ${VIRTUAL_ENV})
  printf '%s' "$1(${env_name}) "
}

# Assign a new prompt that 
function set_prompts() {
  local user_style=""
  local host_style=""

  tput sgr0 # reset colors
  bold=$(tput bold)
  reset=$(tput sgr0)
  black=$(tput setaf 0)
  red=$(tput setaf 1)
  green=$(tput setaf 2)
  yellow=$(tput setaf 3)
  blue=$(tput setaf 4)
  violet=$(tput setaf 5)
  cyan=$(tput setaf 6)
  gray=$(tput setaf 8)
  white=$(tput setaf 15)

  # Highlight the user name when logged in as root.
  if [[ "${USER}" == "root" ]]; then
    user_style="${red}"
  else
    user_style="${blue}"
  fi;

  # Set the terminal title to the current working directory.
  PS1="\\[\\033]0;\\w\\007\\]"

  # Build the main prompt.
  PS1+="\\[${user_style}\\]\\u@\\h" # username@hostname
  PS1+="\\[${white}\\] in "
  PS1+="\\[${green}\\]\\w" # working directory
  PS1+="\$(git_prompt \"${white} on ${violet}\")" # git details

  # Build the second line used for shell input.
  PS1+="\\n" # newline
  PS1+="\$(python_prompt \"${yellow}\")" # python details
  PS1+="\\[${gray}\\]> \\[${reset}\\]" # `>` (and reset color)

  # Line used for continuations.
  PS2="\\[${yellow}\\]> \\[${reset}\\]"

  export PS1
  export PS2

  # Disable the default python prompt extension as we will add our own.
  VIRTUAL_ENV_DISABLE_PROMPT=1
  export VIRTUAL_ENV_DISABLE_PROMPT
}

set_prompts

# Avoid exporting unnecessary symbols.
unset set_prompts

