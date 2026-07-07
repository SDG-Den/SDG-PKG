# SDG-PKG Migration Plan

## Directory Mapping

| Source | Installed to |
|--------|-------------|
| `config/SDG-PKG/` | `~/.config/SDG-PKG/` |
| `local/SDG-PKG/sdgpkg.sh` | `~/.local/SDG-PKG/sdgpkg.sh` |
| `docs/` | `~/.local/docs/SDG-PKG/` |
| `tips/` | `~/.local/tips/SDG-PKG/` |

## Path Rewrites

No internal scripts reference `~/.config/sdgos/` — SDG-PKG is the **package manager** and doesn't reference other modules by path. It references them via its git-based module system (`sdgpkg install <name>` clones repos to cache and runs their lifecycle scripts).

However, SDG-PKG's own install scripts need fixing:

1. **`sdgpkg.sh` — all path variables** use `/home/$(whoami)/` pattern:
   - `CACHE_DIR=/home/$(whoami)/.cache/SDG-PKG` → `CACHE_DIR="$HOME/.cache/SDG-PKG"`
   - `CONF_DIR=/home/$(whoami)/.config/SDG-PKG` → `CONF_DIR="$HOME/.config/SDG-PKG"`
   - `OLD_DIR=/home/$(whoami)/.cache/SDG-PKG-OLD` → `OLD_DIR="$HOME/.cache/SDG-PKG-OLD"`

2. **`bootstrap.sh`** — same pattern:
   - `mkdir -p /home/$(whoami)/.cache/SDG-PKG` → `mkdir -p "$HOME/.cache/SDG-PKG"`
   - `bash =c` typo → `bash -c`

3. **`install.sh`**:
   - `WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-pkg` → `WORKDIR="$HOME/.cache/SDG-PKG/sdg-pkg"`
   - Copies to `~/.config/` and `~/.local/` which is correct, but needs to handle:
     - Configs: `cp -r $WORKDIR/config/* ~/.config/`
     - Locals: `cp -r $WORKDIR/local/* ~/.local/`
     - Symlink: `sudo ln -sf ~/.local/SDG-PKG/sdgpkg.sh /usr/bin/sdgpkg`

4. **`uninstall.sh`**:
   - `rm -rf /home/$(whoami)/.local/SDG-PKG` → `rm -rf "$HOME/.local/SDG-PKG"`

5. **`update.sh`**:
   - Same path fixes as install.sh

## Lifecycle Scripts

Root-level `detect.sh`, `install.sh`, `uninstall.sh`, `update.sh` need implementation. See existing scripts in `local/` for the actual logic — root scripts should delegate.

## Bug Fixes

- `sdgpkg.sh` line 8: `ARG=("$@")` is an array but used as scalar → change to `ARG="${1}"`
- `runfile()` uses global `$ARG` instead of parameter → `runfile() { local PKG=$1; ... }`
- `upgradable` subcommand typo (should be `upgradable`)
- No `help` subcommand — add one

## Modular Tips/Docs

- Create `tips/` directory with tips about sdgpkg commands
- Create `docs/` content documenting the package manager
- `install.sh` should copy `tips/` → `~/.local/tips/SDG-PKG/`
- `install.sh` should copy `docs/` → `~/.local/docs/SDG-PKG/`

## Empty Dir Cleanup

| Dir | Action |
|-----|--------|
| `docs/` | Populate or remove |
| `tips/` | Populate or remove |
| `other/` | Remove |
| `cache/` | Remove (runtime only) |
