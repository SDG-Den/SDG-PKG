#!/bin/bash

rm -rf /home/$(whoami)/.local/SDG-PKG
rm -rf /home/$(whoami)/.local/docs/SDG-PKG
rm -rf /home/$(whoami)/.local/tips/SDG-PKG
sudo unlink /usr/bin/sdgpkg
