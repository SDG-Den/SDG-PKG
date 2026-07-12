# Repository Format

SDG-PKG uses two levels of indirection to discover packages: local `.repo` config files and remote package indices.

## Local Repo Config Files

Stored in `~/.config/SDG-PKG/` (copied from `config/SDG-PKG/` at install time). Each file contains a single URL pointing to a remote package index:

```
https://raw.githubusercontent.com/SDG-Den/SDG-REPO/refs/heads/main/SDGOS.repo
```

Files are named with a numeric prefix for ordering, e.g. `50-core.repo`, `60-containers.repo`.

## Remote Package Index Format

The remote file at each URL is a list of pipe-delimited lines:

```
package_name|git_clone_url|info_url
```

| Field | Description |
|-------|-------------|
| `package_name` | Name used with `sdgpkg install <name>` |
| `git_clone_url` | Git remote URL for cloning the package repository |
| `info_url` | URL to the package's `info.md` metadata file |

### Example

```
sdg-fetch|https://github.com/SDG-Den/sdg-fetch|https://raw.githubusercontent.com/SDG-Den/sdg-fetch/main/info.md
unipkg|https://github.com/SDG-Den/unipkg|https://raw.githubusercontent.com/SDG-Den/unipkg/main/info.md
```

## How It Works

1. `sdgpkg` reads all `.repo` files from `~/.config/SDG-PKG/`
2. For each file, it fetches the remote index via `curl`
3. Searches the combined index for matching package names
4. Uses the pipe-delimited fields to clone the repo or fetch info

## Related

- See [05-creating-a-package.md](./05-creating-a-package.md) for adding your own packages to a repository
