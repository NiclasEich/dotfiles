{
  config,
  pkgs,
  lib,
  user,
  homeDirectory,
  ...
}:
{
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  # Ensure Cargo/uv user bins are in PATH
  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/.npm-global/bin"
  ];

  home.username = user;
  home.homeDirectory = homeDirectory;

  fonts.fontconfig.enable = true;

  # ---- Packages (CLI) ----
  home.packages = with pkgs; [
    # lua version 5.1
    bat # enhanced cat command
    delta # git diff viewer
    jq # command-line JSON processor
    fd # simple, fast and user-friendly alternative to 'find'
    fish
    hyperfine # command-line benchmarking tool
    lua-language-server
    lua5_1
    luarocks
    nodejs
    pandoc
    ripgrep # line-oriented search tool
    starship # cross-shell prompt
    stow # symlink manager
    tree
    tree-sitter
    typst # modern typesetting system
    uv       # Astral's fast Python tool
    watch
    zsh      # backup shell
    zsh-autosuggestions
    zsh-syntax-highlighting
     nerd-fonts.fira-code
     nerd-fonts.droid-sans-mono
     nerd-fonts.jetbrains-mono
     nerd-fonts.roboto-mono
    tmux
    # ---- LaTeX ----
    ffmpeg_4
    mupdf
    texlab
    texliveFull
    (if pkgs ? ltex-ls-plus then pkgs.ltex-ls-plus else pkgs.ltex-ls)
    # Optional: TeXpresso (live render + popups)
    texpresso
    # ---- Development ----
    #neovim
    #zoxide
    #fzf
    # (We install rustup from the official script below)
  ];

  # Provide a user-local npm prefix so global npm installs are isolated
  home.file.".npmrc".text = "prefix = ${config.home.homeDirectory}/.npm-global\n";
  home.activation.createNpmGlobalDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.npm-global"
  '';

  programs.zsh = {
    enable = false;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.fish = {
    enable = true;

    shellInit = ''
      set -gx SSH_AUTH_SOCK "$HOME/.bitwarden-ssh-agent.sock"

      if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end

      for path_entry in \
          "$HOME/development/bin" \
          "$HOME/nvim-macos-arm64/bin" \
          "/Applications/Obsidian.app/Contents/MacOS" \
          "/usr/local/opt/openssl@1.1/bin" \
          "$HOME/.pyenv/bin"
        if test -d "$path_entry"
          fish_add_path --move --prepend "$path_entry"
        end
      end
    '';

    # Concise abbreviations expand on space or Enter.
    shellAbbrs = {
      n = "nvim";
      g = "git";
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gcm = "git commit -m";
      gp = "git push";
      gs = "git status";
      gl = "git log --oneline --graph --decorate";
    };
  };

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ../../configs/starship-tokyonight.toml);
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  # ---- tmux ----
  #programs.tmux.enable = true;

  # Use Neovim as default editor without managing it via HM
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_EDITOR = "nvim";
  };

  # ---- Git (delta pager + nvim editor/mergetool) ----
  programs.git = {
    enable = true;
    extraConfig = {
      core = {
        pager = "delta";
        editor = "nvim";
      };
      interactive = { diffFilter = "delta --color-only"; };
      delta = {
        navigate = true; # use n and N to move between diff sections
        dark = true;
      };
      merge = {
        conflictStyle = "zdiff3";
        tool = "nvimdiff";
      };
      mergetool = {
        keepBackup = false;
      };
      "mergetool.nvimdiff" = {
        cmd = "nvim -d \"$BASE\" \"$LOCAL\" \"$REMOTE\" \"$MERGED\" -c 'wincmd J'";
        trustExitCode = true;
      };
    };
  };

}
