{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    initrd.kernelModules = [ ];
    extraModulePackages = [ ];
    kernelModules = [ "kvm-amd" ];
    kernelParams = [
      # HACK Disables fixes for spectre, meltdown, L1TF and a number of CPU
      #      vulnerabilities. This is not a good idea for mission critical or
      #      server/headless builds, but on my lonely home system I prioritize
      #      raw performance over security.  The gains are minor.
      "mitigations=off"
    ];
  };

  # CPU
  nix.maxJobs = lib.mkDefault 5;
  powerManagement.cpuFreqGovernor = "performance";

  hardware.cpu.intel.updateMicrocode = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  # Displays
  services.xserver = {
    monitorSection = ''
      VendorName  "Unknown"
      ModelName   "DELL U2515H"
      HorizSync   30.0 - 113.0
      VertRefresh 56.0 - 86.0
      Option      "DPMS"
    '';
    screenSection = ''
      Option "metamodes" "HDMI-0: nvidia-auto-select +1920+0, DVI-I-1: nvidia-auto-select +0+180, DVI-D-0: nvidia-auto-select +4480+180"
      Option "SLI" "Off"
      Option "MultiGPU" "Off"
      Option "BaseMosaic" "off"
      Option "Stereo" "0"
      Option "nvidiaXineramaInfoOrder" "DFP-1"
    '';
  };

  # Storage
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/0d56edc1-bd1c-4636-bd2b-7ce00040613d";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/98DB-AB90";
      fsType = "vfat";
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/94875cee-331f-4c25-adff-247667bbef11"; }];
}
