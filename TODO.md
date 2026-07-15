# TODO — SDG-PKG

## Documentation
- [x] Verify `sdgpkg repo` subcommands documented (list, fetch, add, remove)
- [x] Verify package format spec matches current implementation
- [x] Verify repository format doc covers `.repo` index files
- [x] Remove any remaining `detect.sh` references
- [x] Check all command references use `sdgpkg` not old names

## Testing
- [ ] Core lifecycle tests (install/update/uninstall)
- [ ] Repo management tests (add/remove/list/fetch)
- [ ] Edge cases (missing deps, partial clones, network failures)
- [ ] Bootstrap from clean system

## Changes
- [ ] Clean up any legacy code paths
