#!/bin/bash

### dependencies
# git
# curl
# bash

# set working directory
WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-pkg

# install default configs
cp -r $WORKDIR/config/* /home/$(whoami)/.config

# install binaries
cp -r $WORKDIR/local/* /home/$(whoami)/.local

# make entrypoint executable
chmod a+x /home/$(whoami)/.local/SDG-PKG/sdgpkg.sh

# symlink entrypoint
sudo ln -sf /home/$(whoami)/.local/SDG-PKG/sdgpkg.sh /usr/bin/sdgpkg
