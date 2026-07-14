# Command Reference

All commands follow the form `sdgpkg <command> [arguments]`.

## Information Commands

| Command | Description |
|---------|-------------|
| `sdgpkg help` | Show the help menu with all commands and examples |
| `sdgpkg version` | Display the installed sdgpkg version |
| `sdgpkg list` | List all installed (cached) packages |
| `sdgpkg fetch` | List all available packages from all configured repositories |
| `sdgpkg info <package>` | Fetch and display info.md metadata for a package |
| `sdgpkg changelog <package>` | Show the recent changelog for a package |
| `sdgpkg upgradable` | List packages with pending git updates behind their remote |

## Install Commands

| Command | Description |
|---------|-------------|
| `sdgpkg install <package>` | Search repos, clone package, run `install.sh` |
| `sdgpkg update <package>` | Git-pull package, run `update.sh` |
| `sdgpkg upgrade` | Git-pull and run `update.sh` for every installed package |
| `sdgpkg uninstall <package>` | Run `uninstall.sh`, archive cache to `~/.cache/SDG-PKG-OLD/` |
| `sdgpkg sync <package>` | Clone or pull the repository without running any lifecycle script |
| `sdgpkg remove <package>` | Remove the cached repository without running `uninstall.sh` |

## Utility Commands

### branch

Manage git branches for a cached package.

| Subcommand | Description |
|------------|-------------|
| `sdgpkg branch list <package>` | List all branches in the cached repository |
| `sdgpkg branch switch <package> <branch>` | Switch the cached repository to a different branch |

### repo

Manage package repository sources.

| Subcommand | Description |
|------------|-------------|
| `sdgpkg repo list` | List configured repositories with their priorities |
| `sdgpkg repo fetch` | Fetch available repositories from the remote repolist |
| `sdgpkg repo add <name>` | Add a repository from the repolist or from a URL |
| `sdgpkg repo remove <name>` | Remove a configured repository |

## Examples

```bash
sdgpkg install sdgos-meta
sdgpkg update unipkg
sdgpkg info sdg-pkg
sdgpkg branch switch sdg-vox dev
sdgpkg repo list
sdgpkg repo add core
```
