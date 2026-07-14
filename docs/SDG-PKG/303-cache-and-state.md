# Cache and State

SDG-PKG stores all data under `~/.cache/SDG-PKG/`, with configs in `~/.config/` and local files in `~/.local/`.

## Cache Directory

```
~/.cache/SDG-PKG/
  ├── sdg-pkg/       # SDG-PKG itself
  ├── sdg-fetch/     # An installed package
  ├── unipkg/        # Another installed package
  └── ...
```

Each subdirectory is a full git clone of the package repository. Packages are installed and updated from these clones.

## Archive Directory

```
~/.cache/SDG-PKG-OLD/
  ├── sdg-fetch-12345
  └── ...
```

On `uninstall`, the package cache is moved here with a random suffix instead of being deleted. This acts as a backup.

## Config Directory

```
~/.config/SDG-PKG/
  ├── 50-core.repo
  └── ...
```

Copied from `config/SDG-PKG/` during install. Each file contains a URL to a remote package index. See [04-repository-format.md](./04-repository-format.md).

## Local Files

```
~/.local/
  ├── SDG-PKG/
  │   └── sdgpkg.sh          # Main CLI script
  ├── docs/SDG-PKG/           # Documentation (these files)
  └── tips/SDG-PKG/           # Tips
```

`/usr/bin/sdgpkg` is a symlink to `~/.local/SDG-PKG/sdgpkg.sh`.

## Cleanup notes

- **Archive directory** (`~/.cache/SDG-PKG-OLD/`): Safe to clean up at any time. These are old package clones kept as backup after uninstall.
- **Cache directory** (`~/.cache/SDG-PKG/`): Do not wipe this directory manually while packages are installed — it contains the active git clones used for updates.

## Reinstall Behavior

Running `sdgpkg install` on an already-installed package pulls the latest changes and runs `install.sh` again.

Note the difference between removal methods:

| Command | Effect |
|---------|--------|
| `sdgpkg remove <name>` | Deletes the git cache only. Leaves installed files intact. |
| `sdgpkg uninstall <name>` | Runs `uninstall.sh` to remove deployed files, then archives the cache. Only config files are left behind. |

To force a clean reinstall:

```bash
sdgpkg remove <name>
sdgpkg install <name>
```

This is faster than uninstall + install because it skips the uninstall script.

## Related

- See [08-troubleshooting.md](./08-troubleshooting.md) for issues with stale cache
