{ self, ... }: { flake.nixosModules.desktop = { pkgs, config, ... }: {
    imports = with self.nixosModules; [
      fonts
      desktopsteam
    ];
  };
}

