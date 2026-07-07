# SDG-PKG Migration Plan

## 1. Bug Fixes (Critical)

### 1.1 `bootstrap.sh` line 7 — typo
- `bash =c "/home/$(whoami)/..."` should be `bash -c "/home/$(whoami)/..."`
- The `=` instead of `-` breaks the bootstrap entirely.

### 1.2 `sdgpkg.sh` — ARG array vs scalar
- Line 8: `ARG=("$@")` creates an array, but all references use `$ARG` (scalar).
- Change to `ARG="${1}"` or use proper array indexing `"${ARG[0]}"`.

### 1.3 `runfile()` uses global `$ARG`
- `runfile()` reads `$ARG` instead of accepting the package name as `$1`.
- Refactor to: `runfile() { local PKG=$1; ... cat $CACHE_DIR/$PKG/$FILENAME; ... }`.

### 1.4 No error handling
- `git clone`, `curl`, `cp`, etc. are unchecked — can silently fail.
- Add `|| exit 1` or proper `if ! cmd; then ... fi`.

## 2. Path Cleanup

### 2.1 All scripts use `/home/$(whoami)/` pattern
- Replace `/home/$(whoami)/` with `$HOME` throughout.
- Affected files: `bootstrap.sh`, `install.sh`, `uninstall.sh`, `update.sh`, `sdgpkg.sh`.

| Line | Current | Should be |
|------|---------|-----------|
| bootstrap.sh:3 | `/home/$(whoami)/.cache/SDG-PKG` | `$HOME/.cache/SDG-PKG` |
| install.sh:9 | `WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-pkg` | `WORKDIR="$HOME/.cache/SDG-PKG/sdg-pkg"` |
| sdgpkg.sh:3 | `CACHE_DIR=/home/$(whoami)/.cache/SDG-PKG` | `CACHE_DIR="$HOME/.cache/SDG-PKG"` |
| sdgpkg.sh:5 | `OLD_DIR=/home/$(whoami)/.cache/SDG-PKG-OLD` | `OLD_DIR="$HOME/.cache/SDG-PKG-OLD"` |

### 2.2 `install.sh` references old cache structure
- `install.sh` copies from `$WORKDIR/config/*` and `$WORKDIR/local/*`.
- Needs alignment with the sdgpkg.sh cache clone path (`$CACHE_DIR/$ARG/`).

## 3. Empty Stub Scripts
- Root-level `detect.sh` (empty) — implement or remove.
- Root-level `docs/` (empty) — populate or remove.
- Root-level `tips/` (empty) — populate or remove.
- Root-level `other/` (empty) — populate or remove.
- Root-level `cache/` (empty) — runtime-only, should not be in repo.

## 4. Missing Features

### 4.1 `help` subcommand
- The fallthrough `*)` only prints "help command" — needs real usage docs.

### 4.2 Dependency verification
- TODO comment exists: `add verification for unipkg, git and other build dependencies`.
- Implement `pre_install()` that checks `git`, `curl`, `bash` are available.

### 4.3 `install` idempotency
- TODO comment: `dont allow install if program is already installed`.
- Add check before cloning: `if [ -e $CACHE_DIR/$ARG ]; then echo "already installed"; exit 0; fi`.

### 4.4 Module lifecycle scripts
- Before running a module's `install.sh`/`update.sh`/`uninstall.sh`, the manager should ensure the scripts are executable (`chmod +x`).

## 5. Modular Docs/Tips/Help System

### 5.1 Contribution mechanism
- Add a `docs/` directory convention: each module can place docs under `docs/SDG-<MODULE>/` that get deployed to `~/.config/sdgos/docs/<module>/`.
- Add a `tips/` directory convention: each module can place `tips.list` snippets that get concatenated or sourced into the central `~/.config/sdgos/tips/tips.list`.
- Update `sdgpkg.sh`'s `install` subcommand to merge tips from `$CACHE_DIR/$ARG/tips/*` into the global tips list during installation.

### 5.2 sdgpkg.sh help integration
- Add `sdgpkg help` that reads from `~/.config/sdgos/help/cmd-help.sh` or prints inline usage.
- Add `sdgpkg --version` flag alongside existing `version` subcommand.

## 6. Security
- `sudo` is used for symlink — should verify user has sudo access.
- `runfile()` runs `bash -c` on user-prompted files — ensure file exists and is not empty.
- No TLS/SSL verification options on `curl` — consider `curl -fsSL`.

## 7. Naming
- `upgradable` is misspelled (should be `upgradable`). Fix to `upgradable` and deprecate old.

## 8. Install Path Convention
After migration, the sdgpkg install path structure should be:
```
~/.config/sdgos/<module>/        # config files
~/.local/share/sdgos/<module>/   # binaries/scripts
~/.cache/sdgos/<module>/         # generated/cached data
~/.config/sdgos/tips/tips.list   # aggregated tips
~/.config/sdgos/help/topics/     # aggregated help topics
~/.config/sdgos/help/cmds.list   # aggregated command references
```
