{
  description = "Svalbard nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self
    , nix-darwin
    , nixpkgs
    , home-manager
    }:
    let
      configuration =
        { pkgs
        , ...
        }: {
          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Necessary to manage nix with Determinate
          nix.enable = false;

          # If we don't declare users at this level, we run into trouble (type of home.homeDirectory) inside home-manager.
          users.users.tobias = {
            name = "tobias";
            home = "/Users/tobias";
          };
          users.users.trons = {
            name = "trons";
            home = "/Users/trons";
          };

          # Our system packages
          environment.systemPackages = with pkgs;
            [
              neovim
              bat
              htop
            ];

          # Packages via Homebrew
          homebrew = {
            enable = true;
            # onActivation.cleanup = "uninstall";

            taps = [ ];
            brews = [
              "cowsay"
            ];
            casks = [
              "kdenlive"
              "libreoffice" # Manually checked, this is for Apple silicon.
              "logitech-options"
            ];
          };

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # My system default overrides
          system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false; # 'natural' scrolling Off!

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ nix run nix-darwin -- switch --flake .
      darwinConfigurations."svalbard" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            # nixpkgs = nixpkgsConfig;
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tobias = import ./home/tobias.nix;
            home-manager.users.trons = import ./home/trons.nix;
          }
        ];
      };

      # Be beautiful:
      formatter."aarch64-darwin" = nixpkgs.legacyPackages."aarch64-darwin".nixpkgs-fmt;
    };
}
