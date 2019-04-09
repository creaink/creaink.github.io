# https://www.v2ex.com/t/514417

# prepare
sudo apt-get update
sudo apt-get install openssh-server
sshd


# change apt source
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo touch /etc/apt/sources.list

cat > /etc/apt/sources.list << EOF
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
EOF

sudo apt-get update


# install package
sudo apt-get install -y git vim tmux zsh wget curl htop

## install ohmyzsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

sudo chsh -s `which zsh`

## config tmux
touch ~/tmux.conf
cat > ~/tmux.conf << EOF
set -g history-limit 65535
bind r source ~/.tmux.conf \; display "Configuration reloaded!"

# select is copy and use alt or option to use system cursor to copy
set-option -g mouse on
setw -g automatic-rename off
EOF

## config vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
touch ~/.vimrc
cat > ~/.vimrc << EOF
" Ctl-n complete, \+ci comment
set nocompatible

" use vim-plug
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
map <C-n> :NERDTreeToggle<CR>
Plug 'kien/ctrlp.vim'

call plug#end()

set wildmenu
set laststatus=2
set ruler

" line number
set number
set relativenumber

" search
set incsearch
set hlsearch
set smartcase
set ignorecase

set paste
set autoindent
set cindent
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set mouse=c

set cursorline
set cursorcolumn
highlight CursorLine   cterm=NONE ctermbg=black guibg=NONE guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=black guibg=NONE guifg=NONE

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set backspace=2
set clipboard=unnamed
filetype plugin indent on
syntax on

set noeb
set vb t_vb=

command W w !sudo tee % > /dev/null
EOF






# install docker
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo groupadd docker
sudo usermod -aG docker ${USER}

## add usrc mirror
sudo touch /etc/docker/daemon.json
cat > /etc/docker/daemon.json << EOF
{
  "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
}
EOF

sudo systemctl daemon-reload
systemctl restart docker

## install docker-compose, https://github.com/docker/compose/releases
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

## install docker-machine, https://github.com/docker/machine/releases
curl -L https://github.com/docker/machine/releases/download/v0.16.1/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
    chmod +x /tmp/docker-machine &&
    sudo cp /tmp/docker-machine /usr/local/bin/docker-machine


# install vgrant and virtual box
## vb https://www.virtualbox.org/wiki/Linux_Downloads
sudo apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt-get update
sudo apt-get install virtualbox-6.0

## vagrant
sudo apt-get install vagrant


# python
## change source for python
mkdir ~/.pip && touch ~/.pip/pip.conf
cat > /etc/docker/daemon.json << EOF
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
EOF

# golang
# https://golang.org/doc/install
wget https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.12.1.linux-amd64.tar.gz
## add to /etc/zsh/zshenv
export PATH=$PATH:/usr/local/go/bin

# JDK
## https://java.com/en/download/help/linux_x64_install.xml
## sudo mkdir /usr/local/java
## sudo tar xzf ....
## add to /etc/zsh/zshenv
JAVA_HOME=/usr/local/java/jdkXXXXXX
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
PATH=$PATH:$JAVA_HOME/bin
export JAVA_HOME CLASSPATH


# samba
sudo apt install samba
sudo smbpasswd -a "$USER"

sudo vim /etc/samba/smb.conf
[work]
  comment = For file copy
  path = /home/creaink
  browseable = yes
  writable = yes
  create mask = 775

sudo systemctl restart smbd
# then in windows mount as disk, path is \\ip-of-server\work






# for desktop version

## remove some package
sudo apt-get remove libreoffice-common unity-webapps-common
sudo apt-get remove thunderbird transmission-common totem rhythmbox empathy brasero simple-scan gnome-mahjongg \
	aisleriot gnome-mines cheese gnome-orca webbrowser-app gnome-sudoku landscape-client-ui-install
sudo apt-get install adobe-flashplugin


# theme, /usr/share/theme
sudo add-apt-repository ppa:noobslab/themes
sudo add-apt-repository ppa:noobslab/icons
sudo apt-get update    sudo apt-get remove thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese gnome-orca webbrowser-app gnome-sudoku  landscape-client-ui-install

sudo apt-get install ultra-flat-icons
sudo apt-get install flatabulous-theme


## timezone
export LANG=en_US
xdg-user-dirs-gtk-update
export LANG=zh_CN


# 关闭客人会话
sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'

# 双系统切换时间不同问题
sudo apt-get install ntpdate
sudo ntpdate time.windows.com
sudo hwclock --localtime --systohc


# vnc install
sudo apt-get install x11vnc -y
sudo x11vnc -storepasswd /etc/x11vnc.pass

sudo touch /lib/systemd/system/x11vnc.service
cat > /lib/systemd/system/x11vnc.service << EOF
[Unit]
Description=Start x11vnc at startup.
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth /etc/x11vnc.pass -rfbport 5900 -shared

[Install]
WantedBy=multi-user.target
EOF

echo "Configure firewall at :5900"
sudo ufw allow 5900
echo "Configure Services"
sudo systemctl enable x11vnc.service
sudo systemctl daemon-reload


# clean

sudo rm -rf /var/cache/apt/*
sudo rm -rf /var/lib/apt/lists/*

# TODO

xcfe
xrdp
x11vnc

samba
