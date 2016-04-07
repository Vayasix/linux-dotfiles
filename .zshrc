#-------------------------- PATH Settings ------------------------------
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
#export PATH="/bin:/usr/bin:/usr/local/bin:/usr/sbin:/sbin"
# brew cask alias, ~/Applications --> /Applications (Added on 12/25,2015)
# export HOMEBREW_CASK_OPTS="--appdir=/Applications"

#zsh-completions 
fpath=(/usr/local/share/zsh-completions $fpath)
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# export MANPATH="/usr/local/man:$MANPATH"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#anyenv (12/25, 2015) 

if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    #path to shims
    for env in `ls $HOME/.anyenv/envs`
    do
        export PATH="$HOME/.anyenv/envs/$env/shims:$PATH"
        for ver in `ls $HOME/.anyenv/envs/$env/versions`
            do
                export PATH="$HOME/.anyenv/envs/$env/versions/$ver/bin:$PATH"
            done
    done
    
fi

#anaconda
#export PATH="$HOME/anaconda/bin:$PATH"

# gnu gcc
export PATH="$PATH:/usr/gcc_4_9/bin"
export LD_LIBRARY_PATH="/usr/gcc_4_9/lib:/usr/gcc_4_9/lib64"
export LIBRARY_PATH="/usr/lib/x86_64-linux-gnu/"
export C_INCLUDE_PATH="/usr/include/x86_64-linux-gnu"
export CPLUS_INCLUDE_PATH="/usr/include/x86_64-linux-gnu"

alias gcc='gcc-4.9.3'
alias g++='g++-4.9.3'
alias c++='c++-4.9.3'
alias cpp='cpp-4.9.3'

export TERM="xterm-256color"
#------------------------- /PATH Settings ------------------------------

#-------------------------- alias -----------------------------------
alias ls='ls -aF'
alias ll='ls -l'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# 現在 mongodb と redisを自動起動する設定にしている 
#mongo server起動
#alias mongodrun='mongod --fork --config /usr/local/etc/mongod.conf &'
#alias mongodon='mongod --dbpath /usr/local/var/db/mongo --journal'
#alias mongodrepair='mongod --dbpath /usr/local/var/db/mongo --repair'

#mongo 起動確認
#ps -ef | grep mongod

#redis 停止
#alias redisoff='launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.redis.plist'

#-------------------------- /alias -----------------------------------

# -------------------  zsh (12/25, 2015) ----------------------------------

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

# ---------------------- /zsh --------------------------------------------

# ------------------ oh-my-zsh setting (12/25, 2015)-----------------------

# Set the theme: -->  ~/.oh-my-zsh/themes/
# Theme:==> https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="random" <-- change everytime
#ZSH_THEME="robbyrussell"
#ZSH_THEME="blinks"
#ZSH_THEME="af-magic"
ZSH_THEME="norm"

# ZSH_CUSTOM=/path/to/new-custom-folder

#plugins ->  ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git bundler brew)

# User configuration
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ------------------ /oh-my-zsh setting ------------------------------

#remote file editing
#vim scp://ユーザ名@リモートホスト(IPアドレス)//編集対象のファイル
export xsrv="lifexme@lifexme.xsrv.jp:10022//home/lifexme"
