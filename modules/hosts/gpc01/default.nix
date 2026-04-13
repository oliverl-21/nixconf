{ self, inputs, ... }: {
  flake.nixosConfigurations.gpc01 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.gpc01Configuration
    ];
  };
}

