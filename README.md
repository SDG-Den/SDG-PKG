# SDG-PKG

The SDG-OS package manager — install, update, and manage modules from the SDG-OS registry.

## Description

SDG-PKG is a custom git-based package manager written in Bash. It manages packages as git repositories, cloning them from remote URLs listed in `.repo` index files and executing lifecycle scripts (`install.sh`, `update.sh`, `uninstall.sh`).

## Features

- **Install packages** — `sdgpkg install <name>` clones repo + runs install.sh
- **Update packages** — `sdgpkg update <name>` git-pulls + runs update.sh
- **Upgrade all** — `sdgpkg upgrade` updates every installed package
- **List packages** — `sdgpkg list` shows cached/installed packages
- **Search registry** — `sdgpkg fetch` lists all available packages
- **Check updates** — `sdgpkg upgradable` detects pending git updates
- **Uninstall** — `sdgpkg uninstall <name>` runs uninstall.sh + archives
- **Package info** — `sdgpkg info <name>` fetches remote README
- **Sync only** — `sdgpkg sync <name>` clones/pulls without running install
- **Automatic unipkg bootstrap** — installs `unipkg` system package helper

## CLI Usage

```bash
sdgpkg install sdg-fetch       # Install a package
sdgpkg update sdg-fetch        # Update a package
sdgpkg upgrade                 # Update all installed
sdgpkg uninstall sdg-fetch     # Remove a package
sdgpkg list                    # List installed
sdgpkg fetch                   # List available
sdgpkg upgradable              # Check for updates
sdgpkg info sdg-fetch          # Show package details
sdgpkg sync sdg-fetch          # Clone without installing
sdgpkg remove sdg-fetch        # Remove cache only
```

## Bootstrap

```bash
git clone https://git.sdgcloud.nl/SDGDen/SDG-PKG ~/.cache/SDG-PKG/sdg-pkg
cd ~/.cache/SDG-PKG/sdg-pkg
bash install.sh
```

Or using the bundled bootstrap script:

```bash
bash bootstrap.sh
```

This creates `/usr/bin/sdgpkg` → `~/.local/SDG-PKG/sdgpkg.sh` and auto-installs `unipkg`.

## Dependencies

- `git` — cloning and updating packages
- `curl` — fetching repo indices and info URLs
- `bash` — runtime environment
- `sudo` — creating `/usr/bin/sdgpkg` symlink

## Package Cache Layout

```
~/.cache/SDG-PKG/
  ├── sdg-pkg/
  ├── sdg-fetch/
  ├── sdg-docs/
  └── ...
~/.cache/SDG-PKG-OLD/       # Archived packages on uninstall
```

## Related Packages

- **SDG-REPO** — provides the `.repo` index files consumed by sdgpkg
- **All SDG-OS packages** — installed and managed via sdgpkg
