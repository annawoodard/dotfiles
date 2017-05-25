export PATH=${PATH}:$HOME/bin
export PATH=${PATH}:$HOME/.local/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$HOME/local/lib
unset USERNAME

if [[ $HOSTNAME == *".crc.nd.edu" ]]; then
  export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/afs/crc.nd.edu/user/m/mwolf3/lib
  export PATH=${PATH}:/afs/crc.nd.edu/user/m/mwolf3/bin
  export PATH=/afs/crc.nd.edu/user/a/awoodard/scripts:${PATH}
  export PATH=/afs/crc.nd.edu/user/a/awoodard/local/bin:${PATH}
  export CMS_LOCAL_SITE=T3_US_NotreDame
  export PARROT_ALLOW_SWITCHING_CVMFS_REPOSITORIES=TRUE
  cctools=lobster-140-8e7d5576-cvmfs-40cf5bba
  cctools=lobster-148-c1a7ecbd-cvmfs-0941e442
  export PYTHONPATH=$PYTHONPATH:/afs/crc.nd.edu/group/ccl/software/x86_64/redhat6/cctools/$cctools/lib/python2.6/site-packages
  export PATH=/afs/crc.nd.edu/group/ccl/software/x86_64/redhat6/cctools/$cctools/bin:$PATH
  export PATH=${PATH}:/afs/crc.nd.edu/user/a/awoodard/.linuxbrew/bin
  export SSL_CERT_DIR="/etc/pki/tls/certs:$X509_CERT_DIR"
  echo " === === === Your Kerberos ticket and AFS token status: === === ==="
  klist -5 -f | grep -2 krbtgt | grep Flags | xargs echo 'Kerberos:'
  tokens | grep AFS | xargs -0 echo 'AFS: '
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
fi

if [[ $HOSTNAME == *"MacBook"* ]]; then
  export PATH=$PATH:/usr/local/texlive/2016/bin/x86_64-darwin/
fi
