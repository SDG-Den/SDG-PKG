# SDG-PKG Documentation Plan

## Current Status
No docs or tips exist (both have empty placeholder files: exampledoc, exampeltips).

## Docs System (`docs/`)
**Deploy location**: `~/.local/docs/SDG-PKG/`

### Planned Doc Topics
| # | Topic | Description | Priority |
|---|-------|-------------|----------|
| 1 | Quick Start | Bootstrap process: running bootstrap.sh or manual install | High |
| 2 | Command Reference | Full documentation for all sdgpkg subcommands | High |
| 3 | Package Format Specification | Required files (install.sh, update.sh, uninstall.sh), lifecycle contracts | High |
| 4 | Repository Format | .repo file format, configuring custom repositories | High |
| 5 | Creating a Package | Step-by-step guide to creating a package for sdgpkg | High |
| 6 | Cache and State | Understanding the cache layout, package state management | Medium |
| 7 | Unipkg Integration | How unipkg is auto-installed and how it relates to sdgpkg | Low |
| 8 | Troubleshooting | Common issues: git errors, curl failures, broken packages | Medium |

### Implementation
- Create `docs/SDG-PKG/` directory with numbered markdown files
- Follow SDG-DOCS naming convention
- Register in `install.sh` for deployment to `~/.local/docs/`

## Tips System (`tips/`)
**Deploy location**: `~/.local/tips/SDG-PKG/`

### Planned Tips
| # | Tip | Description | Priority |
|---|-----|-------------|----------|
| 1 | Install a package | `sdgpkg install <name>` — clone and install from registry | High |
| 2 | List packages | `sdgpkg list` — see all installed packages | High |
| 3 | Update all | `sdgpkg upgrade` — pull latest and update all packages | High |
| 4 | Search available | `sdgpkg fetch` — list all installable packages | High |
| 5 | Check updates | `sdgpkg upgradable` — see which packages have pending updates | Medium |
| 6 | Package info | `sdgpkg info <name>` — show package details from registry | Medium |
| 7 | Remove package | `sdgpkg uninstall <name>` — runs uninstall.sh and archives | Medium |
| 8 | Unipkg | `unipkg install any <pkg>` — install system packages via sdg-pkg | Low |

### Implementation
- Create `tips/SDG-PKG/tips.list` with the above tips
- Register in `install.sh` for deployment to `~/.local/tips/`
