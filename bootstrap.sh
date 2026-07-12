#!/bin/bash

mkdir -p /home/$(whoami)/.cache/SDG-PKG

git -C /home/$(whoami)/.cache/SDG-PKG clone https://github.com/SDG-Den/SDG-PKG sdg-pkg

bash -c "/home/$(whoami)/.cache/SDG-PKG/sdg-pkg/install.sh"

