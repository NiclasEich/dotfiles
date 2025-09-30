{ pkgs, ... }:
{
  # Let nix-darwin orchestrate Homebrew + casks (GUI apps)
  homebrew.enable = true;
  homebrew.onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "zap";
  };
  #homebrew.greedyCasks = true; # also upgrade self-updating casks

  # GUI/macOS pieces via casks (choose your Docker path below)
  homebrew.casks = [
    "bitwarden"    # Bitwarden desktop app
    #"docker"       # Docker Desktop (GUI + VM)
    # If you prefer NOT to use Docker Desktop, comment the line above
    # and use Colima instead (below) with the docker CLI from Homebrew.
  ];

  # Optional: Colima as an alternative to Docker Desktop
  homebrew.brews = [ "colima" "docker" "docker-compose" ];

  # 2) (Optional) nix-darwin’s fish helpers
  programs.fish = {
    enable = true;

    # Runs for every interactive fish (login and tmux panes).
    shellInit = ''
      if test -f ~/.nix-profile/etc/profile.d/hm-session-vars.fish
        source ~/.nix-profile/etc/profile.d/hm-session-vars.fish
      end

      export SSH_AUTH_SOCK=$HOME/.bitwarden-ssh-agent.sock

      if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end

      for p in \
          $HOME/development/bin \
          $HOME/nvim-macos-arm64/bin \
          /usr/local/opt/openssl@1.1/bin \
          $HOME/.pyenv/bin \
          $HOME/.cargo/bin \
          $HOME/.local/bin
        if test -d $p
          fish_add_path --move --prepend $p
        end
      end

      for p in $HOME/.nix-profile/bin /etc/profiles/per-user/$USER/bin /run/current-system/sw/bin /nix/var/nix/profiles/default/bin
        fish_add_path --move --prepend $p
      end
    '';
  };
  # Make shells valid login shells system-wide (so chsh works cleanly)
  environment.shells = [ pkgs.zsh pkgs.fish ];

  # You can add macOS defaults here later (Dock, Finder, etc.)
}

