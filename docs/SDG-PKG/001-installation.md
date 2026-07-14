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

## Verify

```bash
sdgpkg list
```

You should see `sdg-pkg` and `unipkg` in the list.
