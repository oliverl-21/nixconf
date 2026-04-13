{self, ...}: { flake.nixosModules.desktopsteam = { pkgs, config, ... }: {
    imports = with self.nixosModules; [
    ];
    programs = {
      steam = {
        enable = true;
      };
    };
  };
}

