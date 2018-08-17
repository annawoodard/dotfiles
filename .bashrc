## Parts borrowed from M Wolf, 10 June 2014

ltail() {
  tail ~/tscratch/$1/lobster.log
}

lcat() {
  cat ~/tscratch/$1/lobster.log
}

zcount() {
  zcat $1 | grep "<event>" | wc
}

ccount() {
  cat $1 | grep "<event>" | wc
}

# clean_env() {
# 	local tmprc="$(mktemp)"
# 	cat > "$tmprc" << EOF
# 	PS1="[\h] \w [clean] >"
# 	EOF
# 	env - HOME="$HOME" TERM="$TERM" bash --rcfile "$tmprc"
# 	rm -rf "$tmprc"
# }

renew_ssh_agent() {
  file=~/.bash_ssh_agent_$(hostname -s)
  redo=0
  if [ -f "$file" ]; then
    source "$file" > /dev/null
    [ -r "$SSH_AUTH_SOCK" ] || redo=1
  else
    redo=1
  fi

  if [ $redo == 1 ]; then
    ssh-agent > "$file"
    source "$file" > /dev/null
  fi
}

ulimit -c unlimited

HISTFILE=$HOME/.bash_history
HISTSIZE=800000

export HISTFILE HISTSIZE

HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups

history() {
  _bash_history_sync
  builtin history "$@"
}

_bash_history_sync() {
  builtin history -a         #1
  HISTFILESIZE=$HISTSIZE     #2
  builtin history -c         #3
  builtin history -r         #4
}

PROMPT_COMMAND=_bash_history_sync
renew_ssh_agent

export LANG=en_US.utf-8
export EDITOR FETCH_PACKAGES LC_CTYPE PATH HOME TERM
LC_CTYPE=en_US.UTF-8

export PYTHONSTARTUP=~/.pystartup

set -o vi

unset autologout
# alias tmux="TERM=screen-256color-bce tmux"
alias tailat="ls -1lrt \!:1 | grep ^- | awk '{print $9}' | tail -1"
alias whos_running="condor_q|awk '{if (\$6==\"R\") {stuff[\$2]++}}END{for (u in stuff) print u, stuff[u]}'|sort|uniq"
alias m="cd ~/multileptons; cmsenv"
alias effop="cd ~/effop; cmsenv"
alias checktrees="find ~/effop/TemplateMakers/test/batch_trees/condor_logs/*.stderr -size +0k -print"
alias checkhistos="find ~/effop/DrawPlots/batch_logs/*/*.stderr -size +0k -print"
alias gridinit="voms-proxy-init -voms cms -valid 1000:00"
alias ungrep='grep -v'
alias myps='ps aux | grep -v condor_shadow | grep awoodard'
alias getoutput="condor_ssh_to_job \!^ 'cat worker-*/t.*/cmssw.log'"
alias stuckjobs="condor_q awoodard -constraint 'JobStatus == 2' -goodput | grep 0.0%"
alias emacs='emacs -nw'
alias cred='kserver_init awoodard@CERN.CH'
alias topscram='cmsenv && pushd ${CMSSW_BASE}/src && scram b -j9 && popd'
alias e='vim'
alias rm='rm -v'
alias cp='cp -v -i'
alias mv='mv -v -i'
alias del='rm -v -i'
alias md='mkdir -v -p'
alias rd='rmdir -v'
alias h='history | tail'
alias di='ls -lrthBG'
alias dirs='dirs -v'
alias ll='ls -lhBG'
alias cern='kinit awoodard@CERN.CH'
alias scp='scp -c arcfour'
alias grab='scp \!^ ${REMOTEHOST}:~/'
alias untar='tar -xvf'
alias condorfe='ssh condorfe.crc.nd.edu'
alias hex='ssh -Y hex.crc.nd.edu'
alias earth='ssh -Y earth.crc.nd.edu'
alias ndcms='ssh -Y ndcms.crc.nd.edu'
alias path='readlink -f'
alias csjob='condor_ssh_to_job'
alias killlobster='kill `myps | grep lobster | awk "{ print $2 }"`'
alias lxplus='ssh -Y lxplus.cern.ch'
alias prune="condor_rm -const 'JobStatus == 1'"
alias checkafs="/usr/sbin/vos ex u.awoodard"
alias crabenv="source /cvmfs/cms.cern.ch/crab3/crab.sh"

if ! hash tac 2>/dev/null; then
  alias tac='tail -r'
fi

condorlog() {
  echo $1
  awk '/${$1}/{flag=1}/\.\.\./{flag=0}flag' /tmp/wq-pool-174873/condor.logfile
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

__fzf_history__() (
  local line
  shopt -u nocaseglob nocasematch
  line=$(
    HISTTIMEFORMAT= history |
    tac |
    sort --key=2.1 -bus |
    sort -n |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd) |
    command grep '^ *[0-9]') &&
    if [[ $- =~ H ]]; then
      sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$line"
    else
      sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
    fi
)
