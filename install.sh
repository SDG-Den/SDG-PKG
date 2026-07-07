#!/bin/bash

### dependencies
# git
# curl
# bash
# must be installed manually.

# set working directory
WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-pkg

# install default configs
cp -r $WORKDIR/config/* /home/$(whoami)/.config

# install binaries
cp -r $WORKDIR/local/* /home/$(whoami)/.local

# install docs and tips
mkdir -p /home/$(whoami)/.local/docs
mkdir -p /home/$(whoami)/.local/tips
cp -r $WORKDIR/docs/* /home/$(whoami)/.local/docs
cp -r $WORKDIR/tips/* /home/$(whoami)/.local/tips

# make entrypoint executable
chmod a+x /home/$(whoami)/.local/SDG-PKG/sdgpkg.sh

# symlink entrypoint
sudo ln -sf /home/$(whoami)/.local/SDG-PKG/sdgpkg.sh /usr/bin/sdgpkg

# verify binary
which sdgpkg || echo "INSTALL FAILED!"

sdgpkg version
