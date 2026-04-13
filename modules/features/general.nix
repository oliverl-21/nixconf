{self, ...}: { flake.nixosModules.general = { pkgs, config, ... }: {
    imports = with self.nixosModules; [
      nix
      security
    ];

    users.users.${config.preferences.user.name} = {
      isNormalUser = true;
      description = "${config.preferences.user.name}'s account";
      extraGroups = ["wheel" "networkmanager"];
      # shell = self.packages.${pkgs.system}.environment;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPFiz8aR3ta7KRuoxEDYaqj7Cu0aOVKVJbYCB4u3xJqH oliver@laue.family"
      ];
    };
    nix.settings.trusted-users = [
      "${config.preferences.user.name}"
    ];
  };
}

