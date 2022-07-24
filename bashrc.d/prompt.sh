# If available, extend the prompt when in a git repository.
if [ -e ~/.git_prompt.sh ]; then
  source ~/.git_prompt.sh
  GIT_PS1_SHOWDIRTYSTATE=true 
  GIT_PS1_SHOWCOLORHINTS=true 
  GIT_PS1_UNTRACKEDFILES=true 
  PROMPT_COMMAND="__git_ps1 '[\u@\h \W' ']\\$ '"
else
  PS1="[\u@\h \W]\\$ "
fi

