export PATH=$HOME/.local/bin:${PATH}
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$HOME/local/lib
export FZF_DEFAULT_COMMAND='rg --files --hidden --smartcase --glob "!.git/*"'
alias v="vim"

set -o vi

if [[ $HOSTNAME == *".crc.nd.edu" ]]; then
  [ -r /opt/crc/Modules/current/init/sh ] && source /opt/crc/Modules/current/init/sh
  export PATH=/afs/crc.nd.edu/user/a/awoodard/scripts:${PATH}
  export PATH=/afs/crc.nd.edu/user/a/awoodard/local/bin:${PATH}
  export CMS_LOCAL_SITE=T3_US_NotreDame
  export PARROT_ALLOW_SWITCHING_CVMFS_REPOSITORIES=TRUE
  cctools=lobster-148-c1a7ecbd-cvmfs-0941e442
  export PYTHONPATH=$PYTHONPATH:/afs/crc.nd.edu/group/ccl/software/x86_64/redhat6/cctools/$cctools/lib/python2.6/site-packages
  export PATH=/afs/crc.nd.edu/group/ccl/software/x86_64/redhat6/cctools/$cctools/bin:$PATH
  export PATH=${PATH}:/afs/crc.nd.edu/user/a/awoodard/.linuxbrew/bin
  # export SSL_CERT_DIR="/etc/pki/tls/certs:$X509_CERT_DIR"
  echo " === === === Your Kerberos ticket and AFS token status: === === ==="
  klist -5 -f | grep -2 krbtgt | grep Flags | xargs echo 'Kerberos:'
  tokens | grep AFS | xargs -0 echo 'AFS: '
  if [ $HOSTNAME == "condorfe.crc.nd.edu" ] || [ $HOSTNAME == "opteron.crc.nd.edu" ]; then
    export _CONDOR_APPEND_REQUIREMENTS=
    module load python/3.5.2
    export PYTHONPATH=/afs/crc.nd.edu/x86_64_linux/p/python/3.5.2/build-new/lib/python3.5/:${PYTHONPATH}
    export PYTHONPATH=${PYTHONPATH}:$HOME/.local/lib/python3.5/site-packages
    alias v="nvim"
  fi
fi

if [ "x$PARROT_ENABLED" != "x" ]; then
  export PS1="[parrot] \h \w$ "
else
  export PS1="[\h] \w >"
fi

if [ -d /cvmfs/cms.cern.ch ]; then
  export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
  source $VO_CMS_SW_DIR/cmsset_default.sh
fi


if [[ $HOSTNAME == *"MacBook"* ]]; then
  export PATH=$PATH:/usr/local/texlive/2016/bin/x86_64-darwin/
  export PATH=/Users/awoodard/software/anaconda3/bin:$PATH
  export LSCOLORS="exfxcxdxbxegedabagacad"
  defaults write TeXShop BringPdfFrontOnAutomaticUpdate NO
  alias ls="ls -G"
  alias rm="echo Use 'rmtrash', or the full path i.e. '/bin/rm'"
  alias v="nvim"
else
  alias ls='ls --color'
  export LSCOLORS="no=00:fi=00:di=1;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"
fi

if [[ $HOSTNAME == *"midway"* ]]; then
  export PARSL_TESTING=True
  module load Anaconda3/5.0.0.1
  source activate parsl_py36
  export LDFLAGS="-Wl,-rpath -Wl,/software/openmpi-1.6-el6-x86_64/lib"
  MPI_VERSION=2
  MPI_LIB_NAME=mpi
  export PATH=~wozniak/Public/sfw/login/gcc/swift-t-py-3.6.1/stc/bin:~wozniak/Public/sfw/login/gcc/swift-t-py-3.6.1/turbine/bin:$PATH
  export PPN=16
fi
