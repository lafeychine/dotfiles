{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.v4l2;
in {
  options.modules.hardware.v4l2 = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    boot.extraModulePackages = with unstable;
      [ config.boot.kernelPackages.v4l2loopback ];

    # Register a v4l2loopback device at boot
    boot.kernelModules = [ "v4l2loopback" ];

    boot.extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 video_nr=9 card_label=a7III
    '';
  };
}
