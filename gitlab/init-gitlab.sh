#!/bin/bash

runsvdir_proc=`ps ef | grep runsvdir | grep -v grep | awk '{print $1}'`
if [ "$runsvdir_proc" == "" ]; then
    /opt/gitlab/embedded/bin/runsvdir-start &
fi

password_dir="/etc/gitlab/initial_root_password"
password_bak="/root/initial_root_password"
if [ ! -f "$password_bak" ]; then
    gitlab-ctl reconfigure && cp "$password_dir" /root/
fi
