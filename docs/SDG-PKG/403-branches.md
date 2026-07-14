# Branches and Dev Workflows

SDG-PKG supports git branch management through the `sdgpkg branch` subcommand, allowing users to switch between different versions of a package.

## Branch Commands

```bash
sdgpkg branch list <package>          # List all branches in the cached repository
sdgpkg branch switch <package> <name>  # Switch to a different branch
```

## Use Cases

### Testing development versions

If a package maintainer publishes a development branch, you can test it:

```bash
sdgpkg branch switch sdg-vox dev
sdgpkg update sdg-vox
```

The `update` command pulls from the currently checked-out branch and runs `update.sh`.

### Staying on a stable branch

Switch back to the default branch at any time:

```bash
sdgpkg branch switch sdg-vox main
sdgpkg update sdg-vox
```

### Custom branches

You can add your own remote and checkout any branch available in the repository:

```bash
cd ~/.cache/SDG-PKG/<package>
git remote add myfork https://github.com/you/<package>
git fetch myfork
sdgpkg branch switch <package> myfork/custom-branch
```

## Notes

- Branch state is persistent across updates — `sdgpkg update` will pull from the currently checked-out branch
- To reset to the default branch, switch back explicitly
- Branch switching only modifies the local cache; it does not affect installed files until you run `update.sh`

## Related

- See [09-forking-repos.md](./09-forking-repos.md) for creating custom package forks
