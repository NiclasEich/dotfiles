# flake.nix
{ inputs = {
    # Use the Darwin release channel on macOS:
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    user = "neich";
    host = "Niclas-MacBook-Pro";
  in {
    darwinConfigurations.${host} = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit user; };

      modules = [
        ./darwin/hosts/${host}.nix
        home-manager.darwinModules.home-manager

        {
          # Pass `user` into your HM modules (so you can use it there)
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit user; };

          # Wire HM to your user *without* referencing users.users.<name>
          home-manager.users.${user} = import ./home/users/${user}.nix;
        }

        ({ pkgs, ... }: {
          nix.settings.experimental-features = [ "nix-command" "flakes" ];
          nixpkgs.hostPlatform = "aarch64-darwin";
  	  users.users.${user}.home = "/Users/${user}";
	  system.stateVersion = 6;
	  system.primaryUser = "${user}";
        })
      ];
    };
  };
}

