# Troubleshooting

## Git Errors

**"Could not resolve host"** or **"Connection refused"**
- Check network connectivity
- Verify the git remote URL is correct (`sdgpkg info <package>` shows the URL in the repo index)
- The package may have moved or the host may be down

**"Permission denied (publickey)"**
- The repository URL may require SSH authentication
- SDG-PKG expects public (HTTPS) clone URLs in the `.repo` index

## Curl Failures

**"Could not resolve host"** or **"Connection refused"**
- Check network connectivity
- Verify the repo config file in `~/.config/SDG-PKG/` contains a valid URL
- Test manually: `curl <repo-url>`

## Permission Issues

**"Permission denied"** when running `sdgpkg`
- The symlink `/usr/bin/sdgpkg` may be missing or broken
- Re-run `install.sh` or `update.sh` to recreate it
- Verify sudo access for symlink creation

## Stale Cache

Package behavior is unexpected or scripts fail to run:

```bash
sdgpkg remove <name>   # Remove cache without affecting installed files
sdgpkg sync <name>     # Re-clone without running install.sh
```

If the entire cache was cleared, run `sdgpkg sync` for each affected package to rebuild it without re-running install scripts.

## Manual Package Update

If `sdgpkg` itself is broken or not functional, you can update a package manually:

```bash
cd ~/.cache/SDG-PKG/<packagename>
git pull
./update.sh
```

This bypasses sdgpkg entirely and is especially useful for updating or reinstalling sdgpkg itself if it is not functional.

## Clearing Everything

To remove SDG-PKG's own files and the package cache (does **not** remove packages' deployed files or configs — only the cache):

```bash
rm -rf ~/.cache/SDG-PKG       # Package cache only (see note below)
rm -rf ~/.cache/SDG-PKG-OLD   # Archived packages
rm -rf ~/.local/SDG-PKG       # sdgpkg CLI binary
rm -rf ~/.local/docs/SDG-PKG  # These docs
rm -rf ~/.local/tips/SDG-PKG  # Tips
sudo unlink /usr/bin/sdgpkg   # Symlink
```

Then reinstall from scratch (see [001-installation.md](./001-installation.md)). The following will **not** be removed — they were deployed by each package's `install.sh`:
- `~/.local/<other-packages>/` — installed package binaries
- `~/.config/<other-packages>/` — installed package configs
- `~/.local/docs/<other-packages>/` — other package docs
- `~/.local/tips/<other-packages>/` — other package tips
