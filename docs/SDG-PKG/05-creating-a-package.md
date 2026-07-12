# Creating a Package

This guide walks through packaging software for SDG-PKG.

## Step 1: Create a git repository

```bash
mkdir my-package
cd my-package
git init
```

## Step 2: Add lifecycle scripts

### `install.sh`

Deploy your software to the system:

```bash
#!/bin/bash
cp -r "$PWD/bin" /usr/local/bin/my-package
```

### `update.sh`

Re-deploy after a git pull:

```bash
#!/bin/bash
cp -r "$PWD/bin" /usr/local/bin/my-package
```

### `uninstall.sh`

Remove everything `install.sh` placed:

```bash
#!/bin/bash
rm -rf /usr/local/bin/my-package
```

All three scripts must be executable (`chmod +x`).

## Step 3: Add metadata (optional)

Create `info.md` to provide info shown by `sdgpkg info`:

```
name: my-package
version: 1.0.0
description: An example SDG-PKG package
dependencies: git, curl
```

## Step 4: Add dependency detection (optional)

Create `detect.sh` to check prerequisites:

```bash
#!/bin/bash
which python3 || echo "python3 is required"
```

## Step 5: Add to a repository index

Push your package to a git host, then add an entry to a `.repo` index:

```
my-package|https://github.com/you/my-package|https://raw.githubusercontent.com/you/my-package/main/info.md
```

The `.repo` file can be hosted anywhere `curl` can reach. Add its URL to `~/.config/SDG-PKG/` (or a new numbered config file).

## Step 6: Test

```bash
sdgpkg fetch          # Should show my-package
sdgpkg info my-package  # Should show metadata
sdgpkg install my-package
```

## Related

- See [03-package-format.md](./03-package-format.md) for package format details
- See [04-repository-format.md](./04-repository-format.md) for repo index format
