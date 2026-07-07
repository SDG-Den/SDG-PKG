#!/bin/bash

rm -rf /home/$(whoami)/.local/SDG-PKG
cp -r /home/$(whoami)/.cache/SDG-PKG/sdg-pkg/local/* /home/$(whoami)/.local
ln -sf /home/$(whoami)/.local/SDG-PKG/sdgpkg.sh /usr/bin/sdgpkg

