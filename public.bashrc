

# some more ls aliases
alias ls='ls --color'
alias ll='ls -l'
alias li='ls -li'
alias la='ls -A'
alias l='ls -CF'
alias c='cat'
alias e='exit'
alias f='tfind'
alias g='grep --color'
alias tg='tgrep --color'

alias ai='sudo -E apt-get install'
alias as='sudo -E apt-cache search'
alias apr='sudo -E apt-get remove'
alias ass='apt-get source'

#alias find='sudo find'
alias vi='vim'
alias grep='grep --color'
alias svi='sudo vi'
alias mount='sudo mount'
alias umount='sudo umount'
alias rmmod='sudo rmmod'
alias insmod='sudo insmod'
alias fdisk='sudo fdisk'
alias dmesg='sudo dmesg'
alias tmsg='while true; do dmesg -c ; sleep 1; done'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Git commands alias
alias gcp='git cherry-pick'
alias ga='git am'
alias gaa='git am --abort'
alias gad='git add'
alias gs='git status'
alias gsw='git show'
alias gb='git branch'
alias gbi='git rebase -i'
alias gc='git checkout'
alias gd='git diff'
#alias gd='dir=.;if ["$1" != ""]; then dir=$1;fi;cd $dir;git diff'
alias gui='git update-index'
alias gp='git pull --tags'
alias gfp='git format-patch'
alias gls='git log --pretty=format:"%h [%an] %s %cd"'
alias tgls='git log --pretty=format:"%h [%an] %s %cd" | grep "Feng Tang"'
alias grh='git reset --hard'
alias gwp='find . -name "$1" | xargs git whatchanged -p '
alias gl='git log'
alias tgp='tsocks git pull'
alias ga='git am'
alias gcm='git commit -m'
alias gcmn='git commit -m --no-verify'
alias gacm='git commit -a -s --no-verify -m'
alias gca='git commit --amend' 
alias grvt='git revert '

alias pcheck='./scripts/checkpatch.pl --strict --codespell'

# Patch
alias p='patch -p1 <'

alias tssh='tsocks ssh'
alias tscp='tsocks scp'

alias mm='make menuconfig'
alias moc='make oldconfig'

alias mj='make bzImage -j 28 || make bzImage'
alias mjc='make bzImage -j 28 || make bzImage ; cp arch/x86/boot/bzImage ~/skl/ '
alias mj28='make bzImage -j 28'


alias bloc='make bzImage -j 28 && ~/local.sh'
alias bloc1c='make bzImage -j 28 && ~/local-1cpu.sh'

alias tdstat='dstat -c --vm -m -d -r --fs -n'
alias tcd='cd ~/ws2/projects/; cd'
alias tps='ps auxH | grep'
alias tka='sudo killall -9'
alias atop='sudo atop'
alias tdmesg='sudo dmesg -c > /dev/null'
alias tindent='indent -npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1 '
alias vt='vim -t'
alias v='tvi'
alias h='head'

alias twget='wget --no-check-certificate '

export softlist="exuberant-ctags git git-gui manpages-dev vsftpd samba vim meld vbindiff tsocks nasm cscope ccache htop git git-email gitk gitg byobu claws-mail sysstat powertop colordiff sshfs scim scim-pinyin im-config sleuthkit dbench iozone3 autoconf libpopt-dev samba vim openssh-server openssh-client tofrodos ccache claws-mail htop atop dstat apache2 libncurses5-dev dpkg-dev tree filezilla quilt qgit smem xchm mpg321 nfs-common mutt fetchmail msmtp procmail ncurses-hexedit hexedit bison flex perl libdw-dev sparse libelf-dev libnewt-dev libgtk2.0-dev  cifs-utils pidgin chromium-codecs-ffmpeg screen binutils-dev acpica-tools acpitool bluez-hcidump build-essential libx11-dev lib32z1-dev libgl1-mesa-dev g++-multilib tofrodos libxml2-utils xsltproc zip curl zlib1g-dev libc6:i386 libncurses5:i386 libstdc++6:i386 tightvncserver"

alias cfggrep='tfind .config | xargs grep '


alias grep='grep --color'

alias kbd='make bzImage -j 32 && make modules -j 32'


export GIT_PROXY_COMMAND=/usr/local/bin/git-proxy.sh

export GPG_TTY=$(tty)


alias pti='cat /proc/pagetypeinfo'

alias c2c='perf c2c report -NN -c iaddr --full-symbols -k vmlinux --stdio > /dev/shm/c2c.log; vi /dev/shm/c2c.log'

alias byo='byobu attach'

alias i386make='make ARCH=i386 -j 30 '
alias mkstripinstall='make INSTALL_MOD_STRIP=1 modules_install && make install'

alias nr_cpu='cat /proc/cpuinfo | grep processor | wc -l'

[ -f ~/bin/bash-inc/test_cmds ] && . ~/bin/bash-inc/test_cmds
[ -f ~/bin/bash-alias ] && . ~/bin/bash-alias

