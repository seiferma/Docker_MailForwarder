#!/bin/bash

USER_ID=${LOCAL_USER_ID:-9001}

# Create new user
echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
export HOME=/home/user
chown user:user $HOME
chown user $(dirname $DATA_DIR)

# Ensure that configuration directory exists, i.e. is mounted
if [ ! -d "$INIT_DIR" ] ; then
	echo "The configuration dir has to exist."
	exit 1
fi

# Copy initial configuration files
copy_cfg_file() {
        ORIG=$1
        NEW=$2
        cp $INIT_DIR/$ORIG $HOME/$NEW
        chown user $HOME/$NEW
        chmod 400 $HOME/$NEW
}
copy_cfg_file msmtprc .msmtprc
copy_cfg_file netrc .netrc
copy_cfg_file fdm.conf .fdm.conf
copy_cfg_file imapnotify.conf .imapnotify.conf

# Run actual command
exec /usr/sbin/gosu user "$@"
