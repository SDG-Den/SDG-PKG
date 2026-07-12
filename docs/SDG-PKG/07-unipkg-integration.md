# Unipkg Integration

## What is Unipkg?

Unipkg is a system-level package helper for SDG-OS. It provides an additional layer of package management functionality beyond what SDG-PKG handles directly.

## Auto-Install During Bootstrap

When SDG-PKG is first installed, it automatically runs:

```bash
sdgpkg install unipkg
```

This happens at the end of `install.sh`. No manual step is required.

## Relationship

- **SDG-PKG** is the core git-based package manager — it clones repositories and runs lifecycle scripts
- **Unipkg** builds on top of SDG-PKG to provide higher-level system package management

## Manual Installation

If unipkg is not installed (e.g., on a system that was bootstrapped before this feature was added):

```bash
sdgpkg install unipkg
```
