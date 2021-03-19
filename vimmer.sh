#! /bin/bash 

echo "Setting up vim"

. /etc/os-release

echo "The ID is $ID_LIKE"

case $ID_LIKE in 

    "arch")
       echo "Installing vim"
       sudo pacman -Syu vim
       curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
       rm ~/.vimrc 
       curl -o ~/.vimrc 'https://raw.githubusercontent.com/supreetsingh10/vimmerman/master/vimrc' 
       ;;

   "debian")
       echo "Installing vim"
       sudo apt update && sudo apt upgrade && sudo apt install vim
       curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/
       rm ~/.vimrc 
       curl -o ~/.vimrc 'https://raw.githubusercontent.com/supreetsingh10/vimmerman/master/vimrc' 
       ;;
esac


