# Dotfiles

Personal macOS configuration built with Nix flakes, nix-darwin, Home Manager,
Fish, Starship, and Neovim. A small legacy Zsh setup is retained for machines
that do not use Nix or Fish.

## What manages what

- **nix-darwin** manages macOS-level packages, valid login shells, Homebrew
  formulae, and casks.
- **Home Manager** manages CLI packages, Fish, Starship, Git, fzf, zoxide,
  fonts, environment variables, and the npm user prefix.
- **GNU Stow** links the Neovim configuration into `~/.config/nvim`.
- **lazy.nvim** installs Neovim plugins from the committed
  `nvim/lazy-lock.json`.
- The Neovim binary is intentionally not installed by Home Manager. Any
  suitable recent Neovim can be used; `~/nvim-macos-arm64/bin` is added to
  Fish's path when that directory exists.

## Machine settings

The machine-specific values are grouped at the top of the `outputs` block in
`nix/flake.nix`:

```nix
user = "neich";
host = "Niclas-MacBook-Pro";
platform = "aarch64-darwin";
homeDirectory = "/Users/${user}";
```

Change these values and add or rename the corresponding file under
`nix/darwin/hosts/` when deploying to another Mac. Do not change
`home.stateVersion` or `system.stateVersion` merely because the inputs are
updated; those values preserve compatibility with the original installation.

The commands below use a shell variable so the flake output name is specified
only once:

```sh
DOTFILES_HOST=Niclas-MacBook-Pro
```

## Fresh macOS setup

Prerequisites:

1. Install Nix with flakes enabled.
2. Install Homebrew in its standard Apple Silicon location (`/opt/homebrew`).
3. Clone this repository, conventionally as `~/.dotfiles`.

Bootstrap nix-darwin with the release used by `nix/flake.nix`. The current
configuration uses `nix-darwin-25.05`:

```sh
cd ~/.dotfiles
DOTFILES_HOST=Niclas-MacBook-Pro
NIX_DARWIN_RELEASE=nix-darwin-25.05

sudo nix run "github:nix-darwin/nix-darwin/${NIX_DARWIN_RELEASE}#darwin-rebuild" -- \
  switch --flake "./nix#${DOTFILES_HOST}"
```

After the first activation, make Fish the login shell:

```sh
chsh -s "$(command -v fish)"
```

Open a new terminal before continuing so the new environment is active.

## Neovim setup

Home Manager installs Stow but deliberately does not install Neovim itself.
Install a recent Neovim separately and ensure `nvim` is available on `PATH`.
Then link the configuration:

```sh
cd ~/.dotfiles
stow --restow nvim
nvim
```

On first start, lazy.nvim bootstraps itself and installs the plugin revisions
recorded in `nvim/lazy-lock.json`.

An older checkout may already have an unmanaged lock file at
`~/.config/nvim/lazy-lock.json`. Preserve it while converting that file to a
Stow-managed link:

```sh
mv ~/.config/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json.local
cd ~/.dotfiles
stow --restow nvim
diff nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json.local
```

Remove the `.local` backup only after reviewing the diff.

To update plugins, run `:Lazy update` in Neovim, review the resulting
`nvim/lazy-lock.json`, test Neovim, and commit the lock-file change.

## Normal deployment

Run these commands from the repository root:

```sh
DOTFILES_HOST=Niclas-MacBook-Pro

# Evaluate the locked configuration without changing flake.lock.
nix flake check ./nix --no-update-lock-file

# Build without activating.
darwin-rebuild build --flake "./nix#${DOTFILES_HOST}"

# Optional: compare the built system with the active generation.
nix store diff-closures /run/current-system ./result

# Activate the tested build.
sudo darwin-rebuild switch --flake "./nix#${DOTFILES_HOST}"
```

`nix flake check` validates evaluation, while `darwin-rebuild build` realizes
the complete system before it is activated.

## Updating Nix dependencies

Update the three release-matched inputs together:

```sh
cd ~/.dotfiles/nix
nix flake update
nix flake check

DOTFILES_HOST=Niclas-MacBook-Pro
darwin-rebuild build --flake ".#${DOTFILES_HOST}"
nix store diff-closures /run/current-system ./result
sudo darwin-rebuild switch --flake ".#${DOTFILES_HOST}"

git diff -- flake.lock
```

When moving to a new Nixpkgs release, update the `nixpkgs`, `nix-darwin`, and
`home-manager` URLs in `nix/flake.nix` to matching release branches before
updating the lock file. Review upstream release notes and commit the URL and
lock-file changes together.

To update only selected inputs:

```sh
cd ~/.dotfiles/nix
nix flake update nixpkgs nix-darwin home-manager
```

## Homebrew maintenance

Routine nix-darwin activation installs declared formulae and casks but does not
automatically update Homebrew, upgrade installed packages, or remove unmanaged
packages. This keeps deployments reviewable and prevents an unrelated Brew
upgrade from being coupled to every Nix switch.

Run Homebrew maintenance deliberately:

```sh
brew update
brew outdated
brew upgrade
brew upgrade --cask
brew cleanup
```

Review the output before removing packages. Add or remove managed formulae and
casks in `nix/darwin/hosts/Niclas-MacBook-Pro.nix`; do not use automatic
`cleanup = "zap"` during routine activation.

## Generations and rollback

```sh
darwin-rebuild --list-generations
sudo darwin-rebuild switch --rollback
```

After a rollback, revert or repair the repository change that produced the bad
generation before switching again.

## Repository maintenance

Useful checks before committing:

```sh
nix flake check ./nix --no-update-lock-file
find nvim -name '*.lua' -type f -print0 | xargs -0 -n1 luac -p
jq empty nvim/lazy-lock.json
jq empty nvim/snippets/package.json
jq empty nvim/snippets/python.json
git diff --check
```

Neovim plugins are intentionally managed only by lazy.nvim. Do not add them as
Git submodules or under `nvim/pack/`.

## Legacy Zsh setup (without Nix or Fish)

The Bash, Vim, tmux, and Zsh directories are retained for older or minimal
machines. They are independent of the Nix configuration.

For a minimal Zsh environment:

1. Install Zsh, Git, and [Oh My Zsh](https://ohmyz.sh/).
2. Clone this repository as `~/.dotfiles`.
3. Back up any existing `~/.zshrc` and `~/.aliases`.
4. Link the retained configuration and install its optional plugins:

```sh
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/zsh/aliases.symlink ~/.aliases

git clone https://github.com/zsh-users/zsh-autosuggestions.git \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

chsh -s "$(command -v zsh)"
```

The historical `install.sh`, `install/`, and `nvim/install.sh` scripts are kept
for reference and older Vim-based machines. They are not part of the Nix or
current lazy.nvim deployment path; inspect them before running because they
install software and modify files in the home directory.
