#! /bin/bash 

echo "Setting up vim"
. /etc/os-release
echo "The ID is $ID_LIKE"

case $ID_LIKE in 
    "arch")
       echo "Installing vim"
       sudo pacman -Syu vim
       ;;

   "debian")
       echo "Installing vim"
       sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt install vim 
       ;;
esac

rm ~/.vimrc 
curl -o ~/.vimrc 'https://raw.githubusercontent.com/supreetsingh10/vimmerman/master/vimrc' 
vim -c ":PlugInstall"

