#!/bin/bash

# Script to install and configure applications

# Update && Upgrade Ubuntu
cd ~ && sudo apt-get update
sudo apt upgrade -y

# Make config directory for dotfiles
sudo mkdir .config
sudo touch ~/.config/starship.toml

# The Essentials
sudo apt -y install build-Essential
sudo apt install curl shellcheck fontconfig -y
sudo apt install \
        automake autoconf libreadline-dev \
        libncurses-dev libssl-dev libyaml-dev \
        libxslt-dev libffi-dev libtool unixodbc-dev \
        unzip -y

# Git
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt -y update
sudo apt -y install git

# Configure Git
git config --global user.name <USER.NAME>
git config --global user.email <USER.EMAIL>
git config --global core.editor "code --wait"
git config --global color.ui true


# Installing Python3 Pip
sudo apt-get install python3-pip -y

# Installing getgist to download dotfiles and more from gist
sudo pip3 install getgist
export GETGIST_USER="$(git config user.name)"

# Installing VirtualEnv
sudo -H pip3 install virtualenv
sudo -H pip3 install virtualenvwrapper

# NodeJs
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs npm

# Nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# Installing Golang
wget https://golang.org/dl/go1.16.6.linux-amd64.tar.gz
sudo tar -xvf go1.16.6.linux-amd64.tar.gz
sudo mv go /usr/local

# Configuring Golang
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Installing Golang Linting and Debugger
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.41.1
go get -u github.com/go-delve/delve/cmd/dlv

source ~/.bashrc

# Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt -y update && sudo apt -y install yarn

# Installing Docker


# Zsh and Oh My Zsh
export RUNZSH='no'
sudo apt install -y zsh 
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#  Plugins for Zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions

# CLONING .ZSHRC
getmy .zshrc -y

# Set plugins for Zsh
sed -i 's/plugins=(git)/plugins=(git npm zsh-autosuggestions zsh-syntax-highlighting zsh-completions)/g' ~/.zshrc

# Set Zsh as default shell
chsh -s /bin/zsh

# Add Fonts for Powerline
installed_fonts=$(fc-list : file family | grep -i powerline)
if [ -n "$installed_fonts" ]; then
    echo "Powerline fonts already installed"
else
    echo "Installing powerline fonts"
    git clone https://github.com/powerline/fonts.git --depth=1 "/tmp/fonts"
    /tmp/fonts/install.sh
    rm -rf /tmp/fonts
fi

source ~/.zshrc

# Setup Starship
curl -fsSL https://starship.rs/install.sh | bash
getmy starship.toml -y && mv starship.toml ~/.config/starship.toml 

# Link Github Projects Folder
if [! -f /mnt/c/Users/alexg/.git]; then
    mkdir /mnt/c/Users/alexg/.git    
fi 
ln -s /mnt/c/Users/alexg/.git


