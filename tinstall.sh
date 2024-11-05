#!/bin/sh

# Config files
cp .bashrc ~/
cp .vimrc ~/
cp .vim -r ~/
cp .gitconfig ~/
~/.bashrc

echo 11111

# Make sudo easier
sudo cp sudoers /etc/

mkdir -p ~/.ssh
cp authorized_keys ~/.ssh/

echo 22222
sudo cp smb.conf /etc/

sudo cp bin/* /usr/local/bin/*

# install softwares
export http_proxy="http://proxy.pd.intel.com:911"
sudo apt-get update

echo 33333
export softlist="nfs-kernel-server manpages-dev vsftpd samba ctags vim xchat meld vbindiff tsocks nasm cscope ccache htop git-core git-email gitk gitg bluez-compat bluez claws-mail sysstat powertop colordiff sshfs dstat procps chkconfig"

sudo apt-get install $softlist

# Install ccache
./iccache.sh

# Setup smb passwd


