# SDG-PKG Analysis

## Type
Package Manager (Infrastructure)

## Description
SDG-PKG is a custom git-based package manager for SDG-OS, written in pure Bash. It manages packages as git repositories, cloning them from remote URLs listed in `.repo` index files and executing their lifecycle scripts.

## CLI Entry Points
- `/usr/bin/sdgpkg` (symlink to `~/.local/SDG-PKG/sdgpkg.sh`)

### Commands
| Command | Description |
|---------|-------------|
| `sdgpkg install <pkg>` | Search repos, clone package, run install.sh |
| `sdgpkg update <pkg>` | Git-pull package, run update.sh |
| `sdgpkg upgrade` | Update all installed packages |
| `sdgpkg uninstall <pkg>` | Run uninstall.sh, archive to OLD cache |
| `sdgpkg list` | List cached/installed packages |
| `sdgpkg version` | Show version |
| `sdgpkg info <pkg>` | Fetch package info from repo |
| `sdgpkg fetch` | List all available packages from repos |
| `sdgpkg upgradable` | Check for pending git updates |
| `sdgpkg sync <pkg>` | Clone/pull without running install |
| `sdgpkg remove <pkg>` | Remove cached repo without uninstall |
| `sdgpkg help` | Show usage |
| `sdgpkg test` | Debug: show repo file names |

## Usage
Bootstrap SDG-PKG first, then use it to install all other SDG-OS packages.

### Bootstrap
```bash
git clone https://git.sdgcloud.nl/SDGDen/SDG-PKG ~/.cache/SDG-PKG/sdg-pkg
cd ~/.cache/SDG-PKG/sdg-pkg
bash install.sh
```
Or use the bundled bootstrap script:
```bash
bash bootstrap.sh
```
This creates the symlink `/usr/bin/sdgpkg` → `~/.local/SDG-PKG/sdgpkg.sh` and auto-installs `unipkg`.

### Typical Workflow
```bash
# Install a package
sdgpkg install sdg-fetch

# Update a package
sdgpkg update sdg-fetch

# List installed packages
sdgpkg list

# See what's available
sdgpkg fetch

# Check for updates
sdgpkg upgradable

# Upgrade all
sdgpkg upgrade

# Remove a package (runs uninstall.sh)
sdgpkg uninstall sdg-fetch

# Remove cache only (no uninstall)
sdgpkg remove sdg-fetch

# Get info about a package
sdgpkg info sdg-fetch
```

### Package Cache Structure
```
~/.cache/SDG-PKG/           # Installed packages (cloned repos)
  ├── sdg-pkg/              # This package itself
  ├── sdg-fetch/
  ├── sdg-docs/
  ├── sdg-mango/
  └── ...
~/.cache/SDG-PKG-OLD/       # Archived old versions on uninstall
```

## Directory Structure
```
SDG-PKG/
├── README.md                     # Minimal description
├── bootstrap.sh                   # First-time self-installation
├── install.sh / update.sh / uninstall.sh
├── local/SDG-PKG/
│   └── sdgpkg.sh                  # 167-line main CLI (the package manager)
├── config/SDG-PKG/
│   ├── 50-core.repo               # https://git.sdgcloud.nl/.../SDGOS.repo
│   ├── 60-containers.repo         # (stub)
│   ├── 70-extra.repo              # (stub)
│   └── 80-projects.repo           # (stub)
├── docs/SDG-PKG/exampledoc        # Empty placeholder
└── tips/SDG-PKG/exampeltips       # Empty placeholder
```

## Package Format
- A "package" is any git repository containing:
  - `install.sh` — required (first-time deployment)
  - `update.sh` — required (re-deployment)
  - `uninstall.sh` — required (removal)
  - `detect.sh` — optional (dependency checks)
- Packages are cloned to `~/.cache/SDG-PKG/<pkgname>/`
- Old packages moved to `~/.cache/SDG-PKG-OLD/`

## Repository Format (.repo files)
Files contain pipe-delimited lines:
```
package_name|git_clone_url|info_url
```

## Version
0.2

## Required Dependencies
| Dependency | Purpose |
|------------|---------|
| git | Cloning and updating packages |
| curl | Fetching repo indices and info URLs |
| bash | Runtime environment |
| sudo | Creating `/usr/bin/sdgpkg` symlink |

## Optional Dependencies
None

## Required Dependents
- **All SDG-OS packages**: Use SDG-PKG cache path `~/.cache/SDG-PKG/<name>/`
- **SDG-OS-META**: Calls `sdgpkg install` for all child packages
- **SDG-REPO**: Provides the index files that SDG-PKG consumes

## Optional Dependents
None

## Bootstrap Process
1. Run `bootstrap.sh`
2. It clones SDG-PKG repo to `~/.cache/SDG-PKG/sdg-pkg`
3. Runs `install.sh` which creates symlink and copies configs
4. Auto-installs `unipkg` via `sdgpkg install unipkg`
