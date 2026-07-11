Package Name: sdg-pkg
Descriptive Name: SDG Package Manager
Source: https://git.sdgcloud.nl/SDGDen/SDG-PKG
Maintainer: SDGDen <sdgden@sdgcloud.nl>
Version:0.3

Dependencies: 
git, curl, bash, sudo

Description: 
Custom git-based package manager for SDG-OS, written in pure Bash. Manages packages as git repositories, cloning them from remote URLs listed in .repo index files and executing lifecycle scripts (install.sh, update.sh, uninstall.sh). Commands: install, update, upgrade, uninstall, list, version, info, fetch, upgradable, sync, remove, test, help.
