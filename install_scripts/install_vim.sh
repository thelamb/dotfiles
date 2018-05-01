#!/bin/bash

set -e

# Clone the repo
git clone https://github.com/vim/vim.git /tmp/vim 

cd /tmp/vim 

# We need Python and cscope support. Others are not needed atm
./configure --enable-fail-if-missing --enable-pythoninterp --enable-cscope --disable-netbeans --with-features=huge

cd ./src

make -j4

sudo make install

# Install the Dein package manager
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ./dein_installer.sh

sh ./dein_installer.sh ~/.cache/dein

# Install ripgrep 
wget https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb

sudo dpkg -i ripgrep_0.8.1_amd64.deb

# Clean up
rm -rf /tmp/vim




