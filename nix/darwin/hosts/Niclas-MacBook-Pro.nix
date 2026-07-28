{ pkgs, ... }:
{
  # Let nix-darwin orchestrate Homebrew + casks (GUI apps)
  homebrew.enable = true;
  homebrew.onActivation = {
    # Keep routine nix-darwin activation predictable. Homebrew updates and
    # cleanup are deliberate maintenance commands documented in the README.
    autoUpdate = false;
    upgrade = false;
    cleanup = "none";
  };
  #homebrew.greedyCasks = true; # also upgrade self-updating casks

  # GUI/macOS pieces via casks (choose your Docker path below)
  homebrew.casks = [
    "bitwarden"    # Bitwarden desktop app
    "codex"        # OpenAI Codex CLI
    "super-productivity" # Task/time tracking app
    #"docker"       # Docker Desktop (GUI + VM)
    # If you prefer NOT to use Docker Desktop, comment the line above
    # and use Colima instead (below) with the docker CLI from Homebrew.
  ];

  # Optional: Colima as an alternative to Docker Desktop
  homebrew.brews = [ "colima" "docker" "docker-compose" ];

  # Make shells valid login shells system-wide (so chsh works cleanly)
  environment.shells = [ pkgs.zsh pkgs.fish ];

  # You can add macOS defaults here later (Dock, Finder, etc.)
}
