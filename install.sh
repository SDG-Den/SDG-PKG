#!/bin/bash

### dependencies (must be installed manually)
# git
# curl
# bash

WORKDIR="$HOME/.cache/SDG-PKG/sdg-pkg"

cp -r "$WORKDIR/config/"* "$HOME/.config/"
cp -r "$WORKDIR/local/"* "$HOME/.local/"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

chmod a+x "$HOME/.local/SDG-PKG/sdgpkg.sh"

sudo ln -sf "$HOME/.local/SDG-PKG/sdgpkg.sh" /usr/bin/sdgpkg

which sdgpkg || echo "INSTALL FAILED!"

sdgpkg version

echo "installing unipkg"
sdgpkg install unipkg
