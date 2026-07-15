# Test Checklist — SDG-PKG

## Core Commands
- [ ] `sdgpkg list` — shows installed packages
- [ ] `sdgpkg repo list` — shows configured repos
- [ ] `sdgpkg repo add <name> <url>` — adds repo, then `sdgpkg repo list` shows it
- [ ] `sdgpkg repo remove <name>` — removes repo
- [ ] `sdgpkg repo fetch` — fetches package index from all repos
- [ ] `sdgpkg install <package>` — installs from repo
- [ ] `sdgpkg update <package>` — updates installed package
- [ ] `sdgpkg uninstall <package>` — removes package
- [ ] Bootstrap from clean system using `bootstrap.sh`
- [ ] Install with missing dependencies — graceful error message
- [ ] Network failure during install — clean retry, no partial state
- [ ] `sdgpkg --help` works
