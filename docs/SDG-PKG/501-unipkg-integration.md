# Unipkg Integration

## What is Unipkg?

Unipkg is a universal package management wrapper CLI/TUI that allows install scripts to use different package managers automatically. It detects the system's package manager (pacman, apt, etc.) and runs the appropriate commands.

## Relationship with SDG-PKG

- **SDG-PKG** is the core git-based package manager — it clones repositories and runs lifecycle scripts
- **Unipkg** acts as a system-level package helper, integrating SDG-PKG packages alongside other package managers

SDG-PKG is integrated as one of the package managers unipkg can handle, so it is possible to install sdgpkg packages via unipkg.

## Auto-Install During Bootstrap

When SDG-PKG is first installed, it automatically installs unipkg:

```bash
sdgpkg install unipkg
```

This happens at the end of `install.sh`. No manual step is required.

## Manual Installation

If unipkg is not installed (e.g., on a system bootstrapped before this feature was added):

```bash
sdgpkg install unipkg
```
