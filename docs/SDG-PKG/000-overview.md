# What is a Package Manager?

A package manager installs, updates, and removes software on your computer. SDG-PKG is the package manager for SDG-OS modules — it handles everything related to installing and maintaining SDG-OS itself.

SDG-OS uses two package managers that work together:

| Tool | What it manages |
|------|----------------|
| **sdgpkg** | SDG-OS modules (the desktop environment, tools, and extensions) |
| **unipkg** | System packages from your Linux distribution (wraps pacman, apt, or dnf) |

When you run `sdgpkg install`, it clones the module's repository and runs its install script. When you run `sdgpkg update`, it pulls the latest version and re-applies it.

## Typical workflow

```sh
sdgpkg fetch              # See what packages are available
sdgpkg install sdg-vox    # Install a package
sdgpkg list               # See what's installed
sdgpkg update sdg-vox     # Update a package
sdgpkg uninstall sdg-vox  # Remove a package
```
