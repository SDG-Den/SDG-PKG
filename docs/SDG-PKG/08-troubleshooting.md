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
sdgpkg remove <name>   # Remove cache without uninstalling
sdgpkg install <name>  # Fresh clone + install
```

## Known Bugs

### Install runs install.sh even without a match

The `install` subcommand runs `install.sh` for every repo entry it checks, even when no matching package is found. This can result in unexpected script execution. Always verify that the package name is correct before running install.

## Clearing Everything

To completely remove SDG-PKG and all packages:

```bash
rm -rf ~/.cache/SDG-PKG
rm -rf ~/.cache/SDG-PKG-OLD
rm -rf ~/.local/SDG-PKG
rm -rf ~/.local/docs/SDG-PKG
rm -rf ~/.local/tips/SDG-PKG
sudo unlink /usr/bin/sdgpkg
```

Then reinstall from scratch (see [01-quick-start.md](./01-quick-start.md)).
