# Package Format

Every SDG-PKG package is a **git repository** that provides lifecycle scripts and a standard directory layout.

## Required Structure

```
<package-root>/
├── info.md           # Package metadata (required)
├── install.sh        # Installation script (executable)
├── update.sh         # Update script (executable)
├── uninstall.sh      # Uninstall script (executable)
├── local/            # Deployed to ~/.local/<MODULE>/ — must contain an entrypoint
├── config/           # Deployed to ~/.config/<MODULE>/
├── docs/             # Deployed to ~/.local/docs/<MODULE>/
└── tips/             # Deployed to ~/.local/tips/<MODULE>/
```

## Required Files

### `info.md`

Package metadata consumed by `sdgpkg info`:

```
Package Name: <package-name>
Descriptive Name: <Human Readable Name>
Source: <git_repository_url>
Maintainer: <email>
Version: <version_number>

Dependencies: <comma-separated list>
Description: <short description>
```

### `install.sh`

Runs on first install (`sdgpkg install <name>`). Responsible for deploying files to the system — copying binaries, creating symlinks, setting up configs.

### `update.sh`

Runs on update (`sdgpkg update <name>`) and upgrade (`sdgpkg upgrade`). Replaces local files from the updated cache. Typically mirrors `install.sh` but may skip first-time setup.

### `uninstall.sh`

Runs on uninstall (`sdgpkg uninstall <name>`). Removes files deployed by `install.sh` and cleans up.

## Required Directories

- **`local/`** — must contain at least one executable entrypoint script
- **`config/`** — default configuration files for the package
- **`docs/`** — documentation files (one subdirectory per module)
- **`tips/`** — tip files (one tips.list per module)

## Cache Layout

Packages are cloned to `~/.cache/SDG-PKG/<name>/`. The directory name matches the package name as it appears in the `.repo` index.

On uninstall, the cache is moved to `~/.cache/SDG-PKG-OLD/<name>-<random>/` (a random suffix prevents name collisions).
