export PATH=$HOME/bin:$PATH

if [ "$SSH_CLIENT" != "" ] ; then
  echo "Want to join the swarm coding session?"
  echo "Just run \"TERM=xterm-256color tmux attach\"!"
fi
