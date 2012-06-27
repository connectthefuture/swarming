#!/bin/sh

# Bootstrap a set of swarm-coding dotfiles.

set -e

if [ "$USER" != "swarm" ]; then
    echo "$ Create a swarm user and run this script as that user."
    echo "  sudo adduser swarm --gecos \"\" # set password to swarm"
    echo "  sudo -u swarm -i"
    echo "  wget git.io/swarmup.sh"
    echo "  sh swarmup.sh"
    exit 1
fi

# Add swarm pubkey
mkdir -p ~/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDdFRaOxKTu8bDqyG5VAEl7a+muODX6Ja0Qic/3/+ZdsUQvKRPAxRFLpDG34GS2ROaPplNuSOub/tZqYFWETCb3aRXhf3RGXODseRHckrWjbDy5n4whmrevNHBhHYWBWFjQSodvk/9hjmxA50OrNwEa4zGjiM6J50NdauzTmRB/AfBeGlxjr843HyNCpP+Clt8dvU46jsPsAS+ndye09ZJ2pYtbAOxNTNAy7dv4GCDO/PtPdXb4p4rUsMXxuidgaJIY1OyIDtlUhDQNDnDyOa1HDQJPVTiBQO/zQq0pmpXYAV7Hd+Q3u1mi0+tRUru4Ji9SgfLXCD/OJdJkfDaXr9hj swarm@enigma" >> ~/.ssh/authorized_keys

mkdir -p ~/.emacs.d ~/.lein ~/bin

cp dotfiles/.profile ~
cp dotfiles/.tmux.conf ~
cp dotfiles/.emacs.d/* ~/.emacs.d
cp dotfiles/.lein/* ~/.lein

if type -p curl >/dev/null 2>&1; then
    HTTP_CLIENT="curl -f -L -o"
else
    HTTP_CLIENT="wget -O"
fi

$HTTP_CLIENT ~/bin/lein https://raw.github.com/technomancy/leiningen/preview/bin/lein
chmod 755 ~/bin/lein

git config --global user.name "Swarm Coders"
git config --global user.email "seajure@googlegroups.com"

echo "\nSweet; launch \"TERM=xterm-256color tmux\""
echo "... and you'll be ready to host a swarm coding session."
echo "\nHave people log in as $USER@$(hostname).local using the swarm keypair"
echo "available at http://git.io/id_swarm or the password \"swarm\"."
