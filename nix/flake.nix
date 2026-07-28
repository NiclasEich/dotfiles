{
  inputs = {
    # Use the Darwin release channel on macOS:
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nix-darwin,
      home-manager,
      ...
    }:
    let
      # Machine-specific values live in one place. Change these when adding or
      # moving the configuration to another Mac.
      user = "neich";
      host = "Niclas-MacBook-Pro";
      platform = "aarch64-darwin";
      homeDirectory = "/Users/${user}";
    in
    {
      darwinConfigurations.${host} = nix-darwin.lib.darwinSystem {
        system = platform;
        specialArgs = {
          inherit user homeDirectory;
        };

        modules = [
          ./darwin/hosts/${host}.nix
          home-manager.darwinModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit user homeDirectory;
            };

            home-manager.users.${user} = import ./home/users/${user}.nix;
          }

          {
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
            nixpkgs.hostPlatform = platform;
            users.users.${user}.home = homeDirectory;
            system.stateVersion = 6;
            system.primaryUser = user;
          }
        ];
      };
    };
}
