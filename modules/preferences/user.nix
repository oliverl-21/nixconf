{
  flake.nixosModules.preferences = {lib, ...}: {
    options.preferences = {
      user.name = lib.mkOption {
        type = lib.types.str;
        default = "oliver";
      };
    };
  };
}

