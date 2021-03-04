#! /bin/bash

echo "Setting up vim" 

. /etc/os-release

sudo apt update && sudo apt upgrade 

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
rm ~/.vimrc 
curl -o ~/.vimrc 'https://raw.githubusercontent.com/supreetsingh10/vimmerman/master/vimrc' 
