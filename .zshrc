## Lines configured by zsh-newuser-install
#HISTFILE=~/.histfile
#HISTSIZE=1000
#SAVEHIST=1000
#bindkey -e
## End of lines configured by zsh-newuser-install
## The following lines were added by compinstall
#zstyle :compinstall filename '/cygdrive/c/Users/andy/.zshrc'
#
#autoload -Uz compinit
#compinit -u
## End of lines added by compinstall
#
#source ~/.prompt
#cygwin_bash_prompt
#
#case $TERM in
#    xterm*)
#        precmd () {print -Pn "\033]0;%~\007"}
#        ;;
#esac
#
#
#case $TERM in
#    cygwin)
#        precmd () {print -Pn "\033];%~\007"}
#	preexec () { print -Pn "\e]0;$1\a" }
#        ;;
#esac
#
#
#unsetopt LIST_BEEP

#
# $Id: zshrc,v 2.0 1996/05/02 22:57:04 hzoli Exp $
#
# Generic .zshrc file for zsh 2.7
# Contains modifications to make WinZsh work better
# these have not been fully tested
#
# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

# Search path for the cd command
#cdpath=(.. ~ ~/src ~/zsh)

# Use hard limits, except for a smaller stack and no core dumps
#unlimit
#limit stack 8192
#limit core 0
#limit -s

#umask 022

# For use as Windows console
# Set up your zsh history
export HISTSIZE=2000
export HISTFILE=~/.zhistory
export SAVEHIST=2000

# Set up aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias grep='egrep --color=auto'
alias ll='ls -l'
alias la='ls -a'

# List only directories and symbolic
# links that point to directories
alias lsd='ls -ld *(-/DN)'

# List only file beginning with "."
alias lsa='ls -ld .*'

# Shell functions
#setenv() { export $1=$2 }  # csh compatibility

# Where to look for autoloaded function definitions
#fpath=(~/.zfunc)

# Autoload all shell functions from all directories
# in $fpath that have the executable bit on
# (the executable bit is not necessary, but gives
# you an easy way to stop the autoloading of a
# particular shell function).
#for dirname in $fpath
#do
#  autoload $dirname/*(.x:t)
#done

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'

# Set up WINNT shares and servers in UNC format?
#shares=(\\\\server1\\share1 \\\\server2\\share2  )
#servers=(\\\\server1 \\\\server2 )

# Set entires so man pages will work
# These should probably be set in a man.config instead of here
# Note: manpath (lowercase) is an array, MANPATH (UPPERCASE) is a string.
#manpath=("$ZSHROOT"/man "$ZSHROOT"/usr/man "$ZSHROOT"/usr/lang/man
#	"$ZSHROOT"/usr/local/man)
#export MANPATH
#export MANSECT=1:1p:8:2:3:3p:4:5:6:7:9:0p:tcl:n:l:p:o

# Filename suffixes to ignore during completion
#fignore=(.o .c~ .old .pro)
#fignore=(.obj .pdb .bsc .ilk .idb  .OBJ .PDB .BSC .ILK .IDB)

# Hosts to use for completion
#hosts=(`hostname` ftp.math.gatech.edu prep.ai.mit.edu wuarchive.wustl.edu)

# Set prompts
#PROMPT='%m%# '    # default prompt
#PROMPT='%3C>' #'%/>' #'%{f9%}%/%{gg%}(%{f2%}%?%{gg%})\>'
#RPROMPT=' %~'     # prompt for right side of screen
#prompt3='%{fc%}Do you mean: %R ?(y|n|e)%{gg%} ' # prompt for spelling correction

# Some environment variables
#export MAIL=/var/spool/mail/$USERNAME
#export LESS=-cex3M
#export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs

#DIRSTACKSIZE=20

# Watch for my friends
#watch=($(cat ~/.friends))      # watch for people in .friends file
#watch=(notme)                   # watch for everybody but me
#LOGCHECK=300                    # check every 5 min for login/logout activity
#WATCHFMT='%n %a %l from %m at %t.'

# Set/unset  shell options
#setopt   notify globdots correct pushdtohome cdablevars autolist
#setopt   correctall autocd recexact longlistjobs
#setopt   autoresume histignoredups pushdsilent noclobber
#setopt   autopushd pushdminus extendedglob rcquotes mailwarning
#unsetopt bgnice autoparamslash

setopt autolist correctall automenu
#setopt pushdtohome pushdsilent #autopushd
setopt nolistbeep nobeep
#setopt notify monitor
setopt noclobber ignoreeof histignoredups autocd
#setopt winntignorecase

# Setup some basic programmable completions.  To see more examples
# of these, check Misc/compctl-examples in the zsh distribution.
compctl -g '*(-/)' cd pushd
compctl -g '*(/)' rmdir dircmp
compctl -j -P % -x 's[-] p[1]' -k signals -- kill
compctl -j -P % fg bg wait jobs disown
compctl -A shift
compctl -caF type whence which
compctl -F unfunction
compctl -a unalias
compctl -v unset typeset declare vared readonly export integer
compctl -e disable
compctl -d enable

# Some nice key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|

# bindkey -v             # vi key bindings

bindkey -e               # emacs key bindings
bindkey ' ' magic-space  # also do history expansion on space


#bindkey ^W backward-delete-word

autoload -Uz compinit
compinit -u
# End of lines added by compinstall
# The following lines were added by compinstall
#
#zstyle ':completion:*' completer _complete _ignored
#zstyle ':completion:*' matcher-list '' '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
#zstyle :compinstall filename '/c/Users/andy/.zshrc'
#
#autoload -Uz compinit
#compinit
# End of lines added by compinstall

source ~/.prompt
cygwin_bash_prompt

case $TERM in
    xterm*)
        precmd () {print -Pn "\033]0;%m: %~\007"}
        ;;
esac


case $TERM in
    cygwin)
        precmd () {print -Pn "\033];%m: %~\007"}
	preexec () { print -Pn "\e]0;$1\a" }
        ;;
esac

#bindkey "^[[1~" beginning-of-line
#bindkey "^[[4~" end-of-line

bindkey  "^[[1~"    beginning-of-line
bindkey  "^[[4~"     end-of-line
bindkey  "^[[2~"  overwrite-mode
bindkey  "^[[3~"  delete-char
bindkey  "^[[5~"      up-line-or-history
bindkey  "^[[6~"    down-line-or-history
bindkey  "^[[D"    backward-char
bindkey  "^[[C"   forward-char

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

alias start='cygstart'

zstyle ':completion:*' list-colors ''

# list of completers to use
 zstyle ':completion:*::::' completer _expand _complete _ignored
#
# # allow one error for every three characters typed in approximate completer
 zstyle -e ':completion:*:approximate:*' max-errors \
         'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
         
         # insert all expansions for expand completer
         zstyle ':completion:*:expand:*' tag-order all-expansions

         # formatting and messages
         zstyle ':completion:*' verbose yes
         zstyle ':completion:*:descriptions' format '%B%d%b'
         zstyle ':completion:*:messages' format '%d'
         #zstyle ':completion:*:warnings' format 'No matches for: %d'
         #zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
         zstyle ':completion:*' group-name ''
         zstyle ':completion:*' menu select=long-list select=0
         zstyle ':completion:*' list-colors ''

         # match uppercase from lowercase
         zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

         # offer indexes before parameters in subscripts
         zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

         # command for process lists
         zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'

         # ssh hosts matching style
         zstyle -e ':completion:*:hosts' hosts 'reply=($(cat $HOME/.ssh/known_hosts $HOME/.ssh/known_hosts2 /{usr/local/,}etc/ssh/ssh_known_hosts 2>/dev/null | sed -e "/^#/d" -e "s/ .*\$//" -e "s/,/ /g"))'


#alias vim='mintty vim'
vim() {
    (mintty vim "$*" &) 2> /dev/null
}

gvim() {
    (/cygdrive/c/Program\ Files\ \(x86\)/Vim/vim73/gvim.exe "$*" &) 2> /dev/null
}

python() {
        (/cygdrive/c/python27/python `cygpath -w $1` $argv[2,-1])
}

export CYGWIN="nodosfilewarning"

#{{{ Completion Stuff

bindkey -M viins '\C-i' complete-word

# Faster! (?)
zstyle ':completion::complete:*' use-cache 1

# case insensitive completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
#zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
#zstyle ':completion:*:default' menu 'select=0'

# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse

# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

# Egomaniac!
#zstyle ':completion:*' list-separator 'fREW'

# complete with a menu for xwindow ids
zstyle ':completion:*:windows' menu on=0
zstyle ':completion:*:expand:*' tag-order all-expansions

# more errors allowed for large words and fewer for small words
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'

# Errors format
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'

# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true

# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd

zstyle ':completion::approximate*:*' prefix-needed false

#}}}

stty stop undef

autoload -U select-word-style
select-word-style bash

alias ls='ls --color'
