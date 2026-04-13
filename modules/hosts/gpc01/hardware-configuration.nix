{ flake.nixosHardware.gpc01 = { config, lib, pkgs, modulesPath, ... }: {
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/2f1e8ef7-aaa8-499b-9645-4dcde87ebca0";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EDD1-070B";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/mnt/data" =
    { device = "/dev/disk/by-uuid/be424645-8e8c-491a-8aca-4c8dafc21bab";
      fsType = "ext4";
    };
  swapDevices =
    [ { device = "/dev/disk/by-uuid/ee1918f0-e662-430c-b2ca-ef06102c1c3b"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
};}

