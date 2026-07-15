# Installation

## Dependencies

- `git` — for cloning packages
- `curl` — for fetching repository indices
- `bash` — runtime
- `sudo` — for creating the `/usr/bin/sdgpkg` symlink

## Bootstrap

```bash
git clone https://github.com/SDG-Den/SDG-PKG ~/.cache/SDG-PKG/sdg-pkg
bash ~/.cache/SDG-PKG/sdg-pkg/install.sh
```

Or use the bundled script:

```bash
bash bootstrap.sh
```

This creates `/usr/bin/sdgpkg` pointing to the main script and auto-installs `unipkg`.

## Install your first package

```bash
sdgpkg install sdg-fetch
```

This clones the package repository to `~/.cache/SDG-PKG/sdg-fetch/` and runs its `install.sh`.

## Verify

```bash
sdgpkg list
```

You should see `sdg-fetch` (and `sdg-pkg` and `unipkg` if auto-installed).

## Next steps

- See [201-command-reference.md](./201-command-reference.md) for all commands
- See [301-package-format.md](./301-package-format.md) for the package format spec
- See [401-creating-a-package.md](./401-creating-a-package.md) to create your own package
