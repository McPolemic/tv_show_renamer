#!/bin/sh
PATH=$HOME/.rbenv/shims:$PATH

export PROJECT_DIR=$(dirname $(readlink -f $0))
cd $PROJECT_DIR

# Reset file permissions so all members of `users` can move downloaded files
export DOWNLOAD_DIR=$1
chown -R adam $DOWNLOAD_DIR
chmod -R g+w $DOWNLOAD_DIR

ruby organize.rb $@

