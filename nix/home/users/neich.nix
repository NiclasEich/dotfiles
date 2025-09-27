{ config, pkgs, lib, user, ... }: {
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  # Ensure Cargo/uv user bins are in PATH
  home.sessionPath = [ "$HOME/.cargo/bin" "$HOME/.local/bin" ];

  home.username = user;
  home.homeDirectory = "/Users/${user}";

  fonts.fontconfig.enable = true;

  # ---- Packages (CLI) ----
  home.packages = with pkgs; [
    # lua version 5.1
    fd
    fish
    hyperfine
    lua5_1
    lua-language-server
    luarocks
    nodejs
    ripgrep
    starship
    stow
    ffmpeg_4
    tree
    tree-sitter
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
    mupdf
    texliveFull
    texlab
    (if pkgs ? ltex-ls-plus then pkgs.ltex-ls-plus else pkgs.ltex-ls)
    # Optional: TeXpresso (live render + popups)
    texpresso
    # ---- Development ----
    #neovim
    #zoxide
    #fzf
    # (We install rustup from the official script below)
  ];

  # ---- Shells, prompt & integrations ----
  programs.zsh = {
	  enable = false;
	  autosuggestion.enable = true;
	  syntaxHighlighting.enable = true;
	};
  programs.fish.enable = false;
  programs.starship.enable = false;

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

}

