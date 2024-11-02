{
  description = "Jose's Nix flake for Mac configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.vim pkgs.fzf
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Enable zsh settings
      programs.zsh.enable = true;
      programs.zsh.enableSyntaxHighlighting = true;
      programs.zsh.enableFzfHistory = true;
      programs.zsh.enableFzfGit = true;

      # MacOS System configuration
      system.defaults = {

        # Dock settings
        dock.orientation = "right";
        dock.autohide = true;
        dock.minimize-to-application = true;
        dock.show-recents = "false";

        # Finder settings
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";

      }


      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Air-Ze
    darwinConfigurations."Air-Ze" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Air-Ze".pkgs;
  };
}
