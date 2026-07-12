# Quick Start

## Dependencies

- `git` — cloning and updating packages
- `curl` — fetching repo indices and info URLs
- `bash` — runtime environment
- `sudo` — creating `/usr/bin/sdgpkg` symlink

## Bootstrap

Clone SDG-PKG and run the installer:

```bash
git clone https://github.com/SDG-Den/SDG-PKG ~/.cache/SDG-PKG/sdg-pkg
bash ~/.cache/SDG-PKG/sdg-pkg/install.sh
```

Or use the bundled bootstrap script:

```bash
bash bootstrap.sh
```

This creates `/usr/bin/sdgpkg` → `~/.local/SDG-PKG/sdgpkg.sh` and auto-installs `unipkg`.

## Install your first package

```bash
sdgpkg install sdg-fetch
```

This clones the package repository to `~/.cache/SDG-PKG/sdg-fetch/` and runs its `install.sh`.

## Verify

```bash
sdgpkg list
```

Should show `sdg-fetch` (and `sdg-pkg` and `unipkg` if auto-installed).

## Next steps

- See [02-command-reference.md](./02-command-reference.md) for all commands
- See [05-creating-a-package.md](./05-creating-a-package.md) to create your own package
