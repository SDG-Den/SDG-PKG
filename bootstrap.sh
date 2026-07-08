#!/bin/bash

mkdir -p /home/$(whoami)/.cache/SDG-PKG

git clone -C /home/$(whoami)/.cache/SDG-PKG https://git.sdgcloud.nl/SDGDen/SDG-PKG

bash =c "/home/$(whoami)/.cache/SDG-PKG/sdg-pkg/install.sh"

