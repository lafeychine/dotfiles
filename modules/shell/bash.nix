{ config, options, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.bash;
in {
  options.modules.shell.bash = with types; { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    users.defaultUserShell = pkgs.bash;

    user.packages = with pkgs; [ bat exa fasd fd fzf htop nixfmt ripgrep tree ];
  };
}
