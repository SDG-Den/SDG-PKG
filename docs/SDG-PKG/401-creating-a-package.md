# Creating a Package

This guide walks through packaging software for SDG-PKG.

## Quick start with sdgbuild

The easiest way to create a package is using `sdgbuild init`, which scaffolds the entire structure:

```bash
sdgbuild init
```

This creates all required directories (`local/`, `config/`, `docs/`, `tips/`), populates `info.md` from your git remote, and copies lifecycle script templates.

## Manual method

### Step 1: Create a git repository

```bash
mkdir my-package
cd my-package
git init
```

### Step 2: Add lifecycle scripts

#### `install.sh`

Deploy your software to the system:

```bash
#!/bin/bash
cp -r "$PWD/bin" /usr/local/bin/my-package
```

#### `update.sh`

Re-deploy after a git pull:

```bash
#!/bin/bash
cp -r "$PWD/bin" /usr/local/bin/my-package
```

#### `uninstall.sh`

Remove everything `install.sh` placed:

```bash
#!/bin/bash
rm -rf /usr/local/bin/my-package
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

- See [03-package-format.md](./03-package-format.md) for package format details
- See [04-repository-format.md](./04-repository-format.md) for repo index format
- See [09-forking-repos.md](./09-forking-repos.md) for customizing existing packages
