#!/bin/bash

LOCALDIR=SDG-PKG
DOCDIR=SDG-PKG
TIPDIR=SDG-PKG
entrypoint=sdgpkg.sh
command=sdgpkg

WORKDIR=$(pwd)

rm -rf "$HOME/.local/docs/$DOCDIR" "$HOME/.local/tips/$TIPDIR" "$HOME/.local/$LOCALDIR"

mkdir -p "$HOME/.local/$LOCALDIR"
cp -r "$WORKDIR/config/"* "$HOME/.config/" 2>/dev/null || true
cp -r "$WORKDIR/local/"* "$HOME/.local/"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

chmod a+x "$HOME/.local/$LOCALDIR/$entrypoint"

sudo ln -sf "$HOME/.local/$LOCALDIR/$entrypoint" /usr/bin/$command

which $command || echo "INSTALL FAILED!"
