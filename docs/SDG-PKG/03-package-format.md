# Package Format

Every SDG-PKG package is a **git repository** that provides lifecycle scripts. There is no required directory structure beyond the scripts listed below.

## Required Files

### `install.sh`

Runs on first install (`sdgpkg install <name>`). Responsible for deploying files to the system — copying binaries, creating symlinks, setting up configs.

### `update.sh`

Runs on update (`sdgpkg update <name>`) and upgrade (`sdgpkg upgrade`). Replaces local files from the updated cache. Typically mirrors `install.sh` but may skip first-time setup.

### `uninstall.sh`

Runs on uninstall (`sdgpkg uninstall <name>`). Removes files deployed by `install.sh` and cleans up.

## Optional Files

### `info.md`

Package metadata consumed by `sdgpkg info`. Format:

```
name: <package-name>
version: <version>
description: <short description>
dependencies: <comma-separated list>
```

### `detect.sh`

Optional dependency detection script. Run before install to verify required tools are available on the system.

## Cache Layout

Packages are cloned to `~/.cache/SDG-PKG/<name>/`. The directory name matches the package name as it appears in the `.repo` index.

On uninstall, the cache is moved to `~/.cache/SDG-PKG-OLD/<name>-<random>/` (a random suffix prevents name collisions).
