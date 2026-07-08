#!/bin/bash

rm -rf /home/$(whoami)/.local/SDG-PKG
cp -r /home/$(whoami)/.cache/SDG-PKG/sdg-pkg/local/* /home/$(whoami)/.local
sudo ln -sf /home/$(whoami)/.local/SDG-PKG/sdgpkg.sh /usr/bin/sdgpkg

rm -rf /home/$(whoami)/.local/docs/SDG-PKG
rm -rf /home/$(whoami)/.local/tips/SDG-PKG
mkdir -p /home/$(whoami)/.local/docs
mkdir -p /home/$(whoami)/.local/tips
cp -r /home/$(whoami)/.cache/SDG-PKG/sdg-pkg/docs/* /home/$(whoami)/.local/docs
cp -r /home/$(whoami)/.cache/SDG-PKG/sdg-pkg/tips/* /home/$(whoami)/.local/tips


