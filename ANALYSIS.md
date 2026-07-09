# ANALYSIS - SDG-PKG

## Function

Package manager and bootstrap module for SDG-OS. Clones git-based module repos into `~/.cache/SDG-PKG/`, runs their lifecycle scripts (`install.sh`, `update.sh`, `uninstall.sh`), and manages symlinks to make entrypoints available on `$PATH`. Also provides a bootstrap entry point (`bootstrap.sh`) that clones itself and runs `install.sh` — i.e. it bootstraps the package manager via the package manager.

## Dependencies

| Dependency | File | Line | Notes |
|------------|------|------|-------|
| `bash` | `install.sh:5` | Listed as dependency (must be installed manually) |
| `curl` | `install.sh:4` | Listed as dependency (must be installed manually) |
| `git` | `install.sh:3` | Listed as dependency; used extensively in `sdgpkg.sh` for clone/pull/fetch |
| `sudo` | `install.sh:28` | Required for symlink to `/usr/bin/sdgpkg` |
| `SDG-REPO` (remote) | `config/SDG-PKG/50-core.repo:1` | Points to `https://git.sdgcloud.nl/SDGDen/SDG-REPO/raw/branch/main/SDGOS.repo` |
| `SDG-REPO` (remote) | `config/SDG-PKG/60-containers.repo:1` | Points to `https://git.sdgcloud.nl/SDGDen/SDG-REPO/raw/branch/main/SDG-CONTAINERS.repo` |
| `SDG-REPO` (remote) | `config/SDG-PKG/70-extra.repo:1` | Points to `https://git.sdgcloud.nl/SDGDen/SDG-REPO/raw/branch/main/SDG-EXTRA.repo` |
| `SDG-REPO` (remote) | `config/SDG-PKG/80-projects.repo:1` | Points to `https://git.sdgcloud.nl/SDGDen/SDG-REPO/raw/branch/main/SDG-PROJECTS.repo` |
| `unipkg` (install-time) | `install.sh:35-36` | `sdgpkg install unipkg` is run at end of install |

## Dependents

| Dependent | File | Line | Nature of Reference |
|-----------|------|------|---------------------|
| `SDG-REPO` | `SDGOS.repo:11` | Lists `sdg-pkg` as a registry entry: `sdg-pkg\|https://git.sdgcloud.nl/SDGDen/SDG-PKG` |
| `SDG-REPO-OLD` | `SDGOS.repo:11` | Same entry in old repo |
| `SDG-REPO-OLD` | `migration-plan.md:20,27` | Notes sdg-pkg entry and circular-reference concern |
| `SDG-TERM` | `install.sh:15` | `WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-term` |
| `SDG-TIPS` | `install.sh:3`, `update.sh:3` | `WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-tips` |
| `SDG-GLYPHS` | `install.sh:13,33`, `update.sh:15,21,22,30,31` | Multiple refs to `~/.cache/SDG-PKG/sdg-glyphs/` |
| `SDG-DOCS` | `install.sh:3`, `update.sh:3` | `WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-docs` |
| `SDG-DOCS` | `docs/SDG-DOC-DEVS/04-sdgpkg-reference.md:22-67` | Reference doc describing sdgpkg operation |
| `SDG-DOCS` | `docs/SDG-DOC-DEVS/03-lifecycle-scripts.md:6,21` | Describes lifecycle script contract |
| `SDG-DOCS` | `docs/SDG-DOC-DEVS/02-creating-a-module.md:26,70,127` | Tutorial referencing cache paths |
| `SDG-DOCS` | `docs/SDG-DOC-DEVS/01-architecture-overview.md:12` | Describes SDG-PKG as "Package management and registry" |
| `SDG-DOCS` | `docs/SDG-DOC-TINKERERS/02-configuring-modules.md:22` | Lists SDG-PKG config dir |
| `SDG-DOCS` | `docs/SDG-DOC-NEW-USERS/01-what-is-sdg-os.md:33` | Describes package manager workflow |
| `SDG-FETCH` | `install.sh:10`, `update.sh:4,12,13` | `WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-fetch` |
| `SDG-MANGO-CORE` | `install.sh:43`, `update.sh:3` | `WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-mango` |
| `SDG-MANGO-HELPERS` | `install.sh:10`, `update.sh:3` | `WORKDIR="$HOME/.cache/SDG-PKG/sdg-mango-helpers"` |
| `SDG-OS-THEMES` | `install.sh:5`, `update.sh:3` | `WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-themes` |
| `SDG-UTIL-SCRIPTS` | `install.sh:3`, `update.sh:3`, `update-old.sh:3`, `install-old.sh:3` | Refs to `~/.cache/SDG-PKG/sdg-util*` |
| `SDG-VOX` | `install.sh:12,41`, `update.sh:15,26,27,32` | Refs to `~/.cache/SDG-PKG/sdg-vox/` |
| `SDG-WAYSHELL` | `install.sh:9`, `update.sh:4,11,12` | Refs to `$HOME/.cache/SDG-PKG/sdg-wayshell` |
| `SDG-WAYSHELL-CONFIGS` | `install.sh:7`, `update.sh:7,15,16`, `migration-plan.md:82` | Refs to `~/.cache/SDG-PKG/sdg-wayshell-conf/` |
| `GLOBAL-MIGRATION-GUIDE.md` | `line 23,43` | Lists config/local dir mapping for SDG-PKG |

## Use and Configuration

### CLI Commands

Entry point: `/usr/bin/sdgpkg` (symlink to `~/.local/SDG-PKG/sdgpkg.sh`)

Available subcommands (`sdgpkg.sh:44-125`):

| Subcommand | Line | Description |
|------------|------|-------------|
| `install <name>` | `sdgpkg.sh:46-61` | Searches repos for package, clones to `$CACHE_DIR/<name>`, runs `install.sh` |
| `update <name>` | `sdgpkg.sh:62-67` | `git pull` in cache dir, runs `update.sh` |
| `upgrade` | `sdgpkg.sh:68-73` | Iterates all installed modules, pulls + runs `update.sh` for each |
| `uninstall <name>` | `sdgpkg.sh:75-79` | Runs `uninstall.sh`, moves cache to `$OLD_DIR/<name>` |
| `list` | `sdgpkg.sh:80-82` | Lists contents of `$CACHE_DIR` |
| `version` | `sdgpkg.sh:83-85` | Prints `version: 0.1` |
| `info <name>` | `sdgpkg.sh:86-94` | Fetches package info URL from repo and curls it |
| `fetch` | `sdgpkg.sh:95-101` | Lists available packages from all configured repos |
| `upgradable` | `sdgpkg.sh:102-117` | Checks which installed modules have unpulled commits |
| `test` | `sdgpkg.sh:118-121` | Prints repo file list (debug) |

### Config Files

- `~/.config/SDG-PKG/*.repo` — plain-text files containing URLs to remote repo index files
- Repos are read and concatenated by `sdgpkg.sh:19-28`
- Each repo is a URL to a text file like `SDGOS.repo`; each line: `<name>|<git-url>|<info-url>`

### State Files

- `~/.cache/SDG-PKG/` — cloned module repos live here (runtime cache)
- `~/.cache/SDG-PKG-OLD/` — moved here on uninstall (backup)

### Bootstrap

`bootstrap.sh` clones the SDG-PKG repo itself to `~/.cache/SDG-PKG/sdg-pkg/`, then runs `install.sh`.

## Deprecation / Outdated Items

### HIGH — Broken Functionality

1. **`ARG=("$@")` used as scalar** — `sdgpkg.sh:8` declares `ARG` as an array with `ARG=("$@")`, then treats it as a plain string throughout (e.g. `$ARG` on lines 33, 48, 50, 55, etc.). Most critically, line 55 calls `git -C $CACHE_DIR clone $PKGURL $ARG` where `$ARG` is `${ARG[0]}` in bash but `${ARG}` is empty when referenced without index. The array syntax breaks argument passing in `install`, `update`, `info`, etc. (noted in `migration-plan.md:46`).

2. **`runfile()` uses global `$ARG` instead of parameter** — `sdgpkg.sh:30-41` defines `runfile() { local FILENAME=$1; ... }` but then uses `$ARG` (global, line 33) and `$ARG` (line 39) instead of receiving the package name as a parameter. `migration-plan.md:47` flags this.

3. **`install` subcommand always processes only the first repo** — `sdgpkg.sh:47-60` iterates over repo URLs and does `curl -s $REPO | grep -e "$ARG"` (line 48). If the package IS found, it clones and falls through to `runfile install.sh` + `exit 0` (lines 58-59). If the package is NOT found in the first repo, `runfile install.sh` still runs (will fail because `$CACHE_DIR/$ARG` doesn't exist) and exits — the second repo is never tried.

4. **`install` subcommand runs `runfile install.sh` unconditionally per repo** — `sdgpkg.sh:58-59` places `runfile install.sh` and `exit 0` inside the `for REPO` loop but outside the `if [ "$PACKAGE" != "" ]` block. This means the install script runs (and the whole command exits) on the first repo URL regardless of whether the package was found there.

5. **`bootstrap.sh:7` — unnecessary `bash -c` wrapping** — `bash -c "/home/.../install.sh"` wraps a direct script call in `bash -c`, which is redundant. Also the script itself has `#!/bin/bash`.

6. **`install.sh:35-36` — post-install runs `sdgpkg install unipkg`** but `sdgpkg` is just being symlinked on line 28 and `install.sh` just copied files. This will fail because `sdgpkg` relies on config files copied from `$WORKDIR/config/*` to `~/.config/`, but `$WORKDIR` is the cache dir (populated by bootstrap), not the repo source. If bootstrap already populated cache this works, but as a standalone script it fails.

7. **No error handling in any script** — All scripts (`install.sh`, `uninstall.sh`, `update.sh`, `sdgpkg.sh`) use `cp -r`, `rm -rf`, `mkdir` etc. without checking exit codes or verifying sources exist.

8. **`sdgpkg.sh:107` — `@{u}` upstream tracking** — requires the branch to have a configured upstream. If a module was cloned without upstream tracking (e.g. via `git clone` without `--branch`), `upgradable` crashes.

9. **Hardcoded `/home/$(whoami)/` paths throughout** — Every shell script uses `/home/$(whoami)/` instead of `$HOME`. This breaks on systems where `$HOME` is not `/home/$USER` (e.g. NixOS, non-standard configs). Affected files:
    - `sdgpkg.sh:3,4,5`
    - `install.sh:10,13,16,19,20,21,22,25,28,31,33,35,36`
    - `uninstall.sh:3,4,5`
    - `update.sh:3,4,5,7,8,9,11,12`
    - `bootstrap.sh:3,5,7`

10. **`other/` directory is empty** (0 files) but `install.sh` never references it. Present in repo with no purpose. (`migration-plan.md:64` flags for removal.)

11. **`cache/` directory is empty** (0 files) — runtime cache, not a source directory. (`migration-plan.md:65` flags for removal.)

### MEDIUM — Misleading Docs / Inconsistencies

1. **`README.md` is a stub** — `README.md:1-3` is just `# SDG-PKG` and one sentence. No usage instructions, no subcommand docs, no configuration reference.

2. **`migration-plan.md:25` claims "`bash =c` typo → `bash -c`"** — This was already fixed in the current `bootstrap.sh:7` (it says `bash -c`, not `bash =c`). The plan is stale.

3. **`migration-plan.md:40` says "Root-level `detect.sh` ... needs implementation"** — No `detect.sh` exists in this repo at all. The plan references a file that was never created.

4. **`migration-plan.md:40` says root scripts should delegate to local** — Root-level `install.sh`, `uninstall.sh`, `update.sh` exist but they duplicate logic from `local/SDG-PKG/` rather than delegating. Root scripts perform direct file operations with no delegation to `local/`.

5. **`docs/SDG-PKG/exampledoc` and `tips/SDG-PKG/exampeltips`** — Both are empty files (0 bytes). `migration-plan.md:53-56` says these should be populated.

6. **`install.sh:3-7` lists dependencies as comments** — Dependencies are documented but not verified at runtime. The comment says "must be installed manually" with no error checking.

7. **`sdgpkg.sh:11` — empty todo comment** — `# todo: add verification for unipkg, git and other build dependencies` with no implementation.

### LOW — Cosmetic / Stale

1. **`migration-plan.md` status** — The plan references issues that have been partially fixed (`bash =c`) but mostly remain unfixed. The doc should either be completed or replaced with open bugs.

2. **`migration-plan.md:48` — `upgradable` subcommand typo** — The word `upgradable` is misspelled (should be `upgradeable` or `upgradable` is a valid but uncommon variant). The subcommand in `sdgpkg.sh:102` uses it as-is.

3. **`sdgpkg.sh:124` — `echo "help command"` placeholder** — The `*)` default case prints `help command` but no help text follows. No `help` subcommand exists. (`migration-plan.md:49` notes "No `help` subcommand — add one.")

4. **`sdgpkg.sh:24,26` — commented-out debug echo lines** — Leftover debugging statements.

5. **`sdgpkg.sh:107-108,110,113` — commented-out debug echo lines** — More leftover debugging statements.

6. **`TESTCOMPLETE.md` is an empty file** — 0 bytes. No content.

7. **`install.sh:33` — `sdgpkg version` is run** but `sdgpkg` binary symlink was just created on line 28. If the symlink creation failed (e.g. no sudo), this line errors.

8. **`version` subcommand** — `sdgpkg.sh:84` prints hardcoded `version: 0.1`. No version file or git-tag-based versioning.
