{inputs, ...}: {
  flake.nixosModules.desktop-apps = {pkgs, ...}: {
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];
    environment = {
      systemPackages = with pkgs; [
        ghostty
        bitwarden-desktop   
        solaar
      ];
    };
  };
}

