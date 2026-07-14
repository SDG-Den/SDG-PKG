# Forking Repositories

Users can create customized versions of existing packages by forking the package repository, creating their own repo repository, and setting that repo as a higher priority (lower priority number) in `sdgpkg`.

## Step-by-step

### 1. Fork the package repository

Fork the package's git repository on your preferred git host (GitHub, GitLab, etc.). Clone your fork locally, make your changes, and push.

### 2. Create a repository index

Create a `.repo` file that points to your package. The format is:

```
my-custom-package|https://github.com/you/my-custom-package|https://raw.githubusercontent.com/you/my-custom-package/main/info.md
```

Host this file somewhere `curl` can reach, or keep it local.

### 3. Add your repository to sdgpkg

```bash
sdgpkg repo add <url-to-your-repo-file>
```

When prompted, give it a name and a low priority number (e.g. `10`) so it is checked before the default repositories.

### 4. Install your custom version

```bash
sdgpkg install my-custom-package
```

Since your repo has a lower priority number, sdgpkg will find your version first.

## Example: Customizing a theme package

1. Fork `SDG-OS-THEMES`
2. Modify the theme files
3. Push your changes
4. Create a `.repo` file pointing to your fork
5. `sdgpkg repo add <url>` with priority `10`
6. `sdgpkg install sdg-themes` — now pulls from your fork

## Related

- See [10-branches.md](./10-branches.md) for working with branches during development
- See [04-repository-format.md](./04-repository-format.md) for repo index format details
