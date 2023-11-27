#! /bin/bash 

echo "Setting up vim"

#this is a comment
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
       sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt install vim 
       curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/
       rm ~/.vimrc 
       curl -o ~/.vimrc 'https://raw.githubusercontent.com/supreetsingh10/vimmerman/master/vimrc' 
       ;;
esac


