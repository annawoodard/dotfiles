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
export LS_COLORS="no=00:fi=00:di=1;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"

export PATH=/afs/crc.nd.edu/user/a/awoodard/.linuxbrew/bin:${PATH}
export PATH=$HOME/.local/bin:${PATH}
export PYTHONPATH=/afs/crc.nd.edu/user/a/awoodard/.local/lib/python2.6/site-packages/:$PYTHONPATH

if [[ $HOSTNAME == *".crc.nd.edu" ]]; then
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/afs/crc.nd.edu/user/m/mwolf3/lib
	export PATH=${PATH}:/afs/crc.nd.edu/user/m/mwolf3/bin
	export PATH=/afs/crc.nd.edu/user/a/awoodard/scripts:${PATH}
          export PATH=/afs/crc.nd.edu/user/a/awoodard/local/bin:${PATH}
	export CMS_LOCAL_SITE=T3_US_NotreDame
	export PARROT_ALLOW_SWITCHING_CVMFS_REPOSITORIES=TRUE
          # cctools=cctools-079-58019d21-cvmfs-40cf5bba
          cctools=cctools-109-4883ebaf-cvmfs-40cf5bba
          export PYTHONPATH=$PYTHONPATH:/afs/crc.nd.edu/group/ccl/software/$cctools/x86_64/redhat6/lib/python2.6/site-packages
          export PATH=/afs/crc.nd.edu/group/ccl/software/$cctools/x86_64/redhat6/bin:$PATH
          export PYTHONPATH=/afs/crc.nd.edu/x86_64_linux/python/2.7.8/lib/python2.7/site-packages/:${PYTHONPATH}
          if [[ $HOSTNAME != "earth.crc.nd.edu" ]]; then
                  export _CONDOR_APPEND_REQUIREMENTS=
          fi

	[ -r /opt/crc/Modules/current/init/sh ] && source /opt/crc/Modules/current/init/sh && module load gcc/4.6.2
fi

if [[ $HOSTNAME == *"lxplus"* ]]; then
	export PATH=$PATH:~matze/bin
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~matze/lib
fi

if [ "x$PARROT_ENABLED" != "x" ]; then
	export PS1="[parrot] \h \w$ "
else
	export PS1="[\h] \w >"
fi

if [ -d /cvmfs ]; then
	export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
	source $VO_CMS_SW_DIR/cmsset_default.sh
	# source /cvmfs/grid.cern.ch/3.2.11-1/etc/profile.d/grid-env.sh
else
	if [ -d /pscratch/osg/app/cmssoft/cms ]; then
		export VO_CMS_SW_DIR=/pscratch/osg/app/cmssoft/cms
		source $VO_CMS_SW_DIR/cmsset_default.sh
		source /pscratch/ndcms/gLite/gLite-UI/etc/profile.d/grid_env.sh
	fi
fi

unset autologout
alias tmux="TERM=screen-256color-bce tmux"
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
alias ls='ls --color'
alias root='root -l'
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
alias v="vim"
alias crabenv="source /cvmfs/cms.cern.ch/crab3/crab.sh"

echo " === === === Your Kerberos ticket and AFS token status: === === ==="
klist -5 -f | grep -2 krbtgt | grep Flags | xargs echo 'Kerberos:'
tokens | grep AFS | xargs -0 echo 'AFS: '
