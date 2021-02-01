{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.starship;
in {
  options.modules.shell.starship = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    user.packages = [ pkgs.starship ];
  };
}
