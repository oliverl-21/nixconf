{self, ...}: { flake.nixosModules.fonts = { pkgs, config, ... }: {
    imports = with self.nixosModules; [
    ];
    fonts = {
      fontconfig.enable = true;
      fontDir.enable = true;
      packages = with pkgs; [
        nerd-fonts.fira-code
      ];
    };
  };
}

