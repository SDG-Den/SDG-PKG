# SDG-PKG Documentation Plan

## Current Status
Docs directory is empty (only `.placeholder`). Tips directory is empty (only `.placeholder`).
A 74-line README.md exists at root level with basic usage. The built-in help text in `sdgpkg.sh` lists 13 subcommands.

## Source-Verified Inventory
**Components:**
- 1 CLI script: `local/SDG-PKG/sdgpkg.sh` (167 lines) — the entire package manager
- 13 subcommands: install, update, upgrade, uninstall, list, version, info, fetch, upgradable, test (debug), sync, remove, help
- 4 repo config files under `config/SDG-PKG/`: 50-core.repo, 60-containers.repo, 70-extra.repo, 80-projects.repo
- Repo format: pipe-delimited text files on remote servers (`name|clone_url|info_url`)
- Lifecycle scripts: install.sh, update.sh, uninstall.sh (each package must provide these)
- Cache: ~/.cache/SDG-PKG/<name>/ (git clones)
- Archive: ~/.cache/SDG-PKG-OLD/<name>-<random> (on uninstall)
- Bootstrap: bootstrap.sh + install.sh for first-time setup
- Auto-installs unipkg after bootstrap

## Docs System (`docs/`)
**Deploy location**: `~/.local/docs/SDG-PKG/`

### Planned Doc Topics
| # | Topic | Description | Priority |
|---|-------|-------------|----------|
| 1 | Quick Start | Bootstrap and first package install | High |
| 2 | Command Reference | All 13 subcommands with examples and options | High |
| 3 | Package Format | What a valid package looks like: install.sh/update.sh/uninstall.sh lifecycle | High |
| 4 | Repository Format | .repo file format (pipe-delimited: name|clone_url|info_url) | High |
| 5 | Creating a Package | Step-by-step guide to packaging software for SDG-PKG | High |
| 6 | Cache and State | Where everything is stored, cache layout, reinstall behavior | Medium |
| 7 | Unipkg Integration | What unipkg is, why it's auto-installed, how it relates | Low |
| 8 | Troubleshooting | Git errors, curl failures, permission issues, stale cache | Medium |

### Existing Content
None in `docs/`. Root README.md covers quick start and a few commands at a high level.

## Tips System (`tips/`)
**Deploy location**: `~/.local/tips/SDG-PKG/`

### Planned Tips
| # | Tip | Priority |
|---|-----|----------|
| 1 | Install a package with `sdgpkg install <name>` | High |
| 2 | List installed packages with `sdgpkg list` | High |
| 3 | Update all packages with `sdgpkg upgrade` | High |
| 4 | Search available packages with `sdgpkg fetch` | High |
| 5 | Check for updates with `sdgpkg upgradable` | Medium |
| 6 | View package info with `sdgpkg info <name>` | Medium |
| 7 | Remove a package with `sdgpkg uninstall <name>` | Medium |
| 8 | Clone without installing with `sdgpkg sync <name>` | Low |

## Implementation Notes
- Docs in `nn-topic-name.md` format under `docs/SDG-PKG/`
- Tips in `tips/SDG-PKG/tips.list` (one tip per line)
- The `sdgpkg.sh` source code is the authoritative reference for command behavior and format spec
- Known bug: install subcommand may attempt to run install.sh even when no matching package is found (document as known issue in troubleshooting)
