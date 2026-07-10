#!/bin/bash

WORKDIR="$HOME/.cache/SDG-PKG/sdg-pkg"

rm -rf "$HOME/.local/SDG-PKG"
cp -r "$WORKDIR/local/"* "$HOME/.local/"

rm -rf "$HOME/.local/docs/SDG-PKG" "$HOME/.local/tips/SDG-PKG"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

sudo ln -sf "$HOME/.local/SDG-PKG/sdgpkg.sh" /usr/bin/sdgpkg
