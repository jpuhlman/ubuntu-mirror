#!/bin/bash

if [ -n "$EXTRA_PACKAGES" ] ; then
   yum install -y $EXTRA_PACKAGES
fi

groupadd -g $USERGID engr 
useradd -s /bin/bash -d $HOME -M -u $USERID -g $USERGID $USERNAME
echo "$USERNAME  ALL=(ALL)       NOPASSWD: ALL" | tee -a /etc/sudoers > /dev/null
echo
echo "Welcome to $RELEASE_DISTRO $RELEASE_VERSION mirror"
echo
sudo --preserve-env="CURRENTPATH" -u $USERNAME apt-mirror
