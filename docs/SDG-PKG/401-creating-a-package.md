# Creating a Package

This guide walks through packaging software for SDG-PKG.

## Quick start with sdgbuild

The easiest way to create a package is using `sdgbuild init`, which scaffolds the entire structure. It must be run inside a git repository:

```bash
# Create a repository on your remote git host (GitHub, GitLab, etc.)
# then clone it down locally:
git clone https://github.com/you/my-package
cd my-package
sdgbuild init
```

This creates all required directories (`local/`, `config/`, `docs/`, `tips/`), populates `info.md` from your git remote, and copies lifecycle script templates with placeholder variables (`<PKGNAME>`, `<ENTRYPOINT>`, `<DIR>`, `<COMMAND>`, etc.) that get substituted interactively.

## Manual method

### Step 1: Create a git repository

```bash
mkdir my-package
cd my-package
git init
```

### Step 2: Add lifecycle scripts

Lifecycle scripts follow a template format with placeholder variables. Below are the recommended templates matching what `sdgbuild init` generates:

#### `install.sh`

```bash
#!/bin/bash

PKG_INDEX=<PKGNAME>
LOCALDIR=<DIR>
entrypoint=<ENTRYPOINT>
command=<COMMAND>

WORKDIR="$HOME/.cache/SDG-PKG/$PKG_INDEX"

cp -r "$WORKDIR/config/"* "$HOME/.config/"
cp -r "$WORKDIR/local/"* "$HOME/.local/"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

sudo ln -sf "$HOME/.local/$LOCALDIR/$entrypoint" /usr/bin/$command

which $command || echo "INSTALL FAILED!"
```

#### `update.sh`

```bash
#!/bin/bash

PKG_INDEX=<PKGNAME>
LOCALDIR=<DIR>
DOCDIR=<DIR>
TIPDIR=<DIR>
entrypoint=<ENTRYPOINT>
command=<COMMAND>

WORKDIR="$HOME/.cache/SDG-PKG/$PKG_INDEX"

rm -rf "$HOME/.local/$LOCALDIR"
cp -r "$WORKDIR/local/"* "$HOME/.local/"

rm -rf "$HOME/.local/docs/$DOCDIR" "$HOME/.local/tips/$TIPDIR"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

sudo ln -sf "$HOME/.local/$LOCALDIR/$entrypoint" /usr/bin/$command
```

#### `uninstall.sh`

```bash
#!/bin/bash

LOCALDIR=<DIR>
DOCDIR=<DIR>
TIPDIR=<DIR>
command=<COMMAND>

rm -rf $HOME/.local/$LOCALDIR
rm -rf $HOME/.local/docs/$DOCDIR
rm -rf $HOME/.local/tips/$TIPDIR
sudo unlink /usr/bin/$command
```

All three scripts must be executable (`chmod +x`).

### Step 3: Add metadata

Create `info.md` providing package info shown by `sdgpkg info`:

```
Package Name: my-package
Descriptive Name: My Example Package
Source: https://github.com/you/my-package
Maintainer: you@example.com
Version: 1.0.0

Dependencies: git, curl
Description: An example SDG-PKG package
```

### Step 4: Add required directories

```
my-package/
├── local/     # Must contain at least one entrypoint script
├── config/    # Default config files
├── docs/      # Documentation files
└── tips/      # Tip files
```

### Step 5: Add to a repository index

Push your package to a git host, then add an entry to a `.repo` index:

```
my-package|https://github.com/you/my-package|https://raw.githubusercontent.com/you/my-package/main/info.md
```

The `.repo` file can be hosted anywhere `curl` can reach. Add its URL via `sdgpkg repo add <url>`, or place it in `~/.config/SDG-PKG/`.

### Step 6: Test

```bash
sdgpkg fetch          # Should show my-package
sdgpkg info my-package  # Should show metadata
sdgpkg install my-package
```

## Related

- See [301-package-format.md](./301-package-format.md) for package format details
- See [302-repository-format.md](./302-repository-format.md) for repo index format
- See [402-forking-repos.md](./402-forking-repos.md) for customizing existing packages
