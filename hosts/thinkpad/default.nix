{ lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  ## Modules
  modules = {
    desktop = {
      sway.enable = true;
      apps = { discord.enable = true; };
      browsers = { firefox.enable = true; };
      media = {
        recording.enable = true;
        recording.video.enable = true;
      };
      term = {
        default = "alacritty";
        alacritty.enable = true;
      };
    };
    editors = {
      default = "emacs";
      emacs = {
        enable = true;
        doom.enable = true;
      };
      vim.enable = true;
    };
    hardware = {
      audio.enable = true;
      bluetooth = {
        enable = true;
        audio.enable = true;
      };
      fs = {
        enable = true;
        ssd.enable = true;
      };
      sensors.enable = true;
    };
    shell = {
      bash.enable = true;
      direnv.enable = true;
      git.enable = true;
      gnupg.enable = true;
      starship.enable = true;
    };
  };

  ## Local config
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  location = {
    latitude = 48.8534;
    longitude = 2.3488;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false
  # here. Per-interface useDHCP will be mandatory in the future, so this
  # generated config replicates the default behaviour.
  networking.useDHCP = false;
  networking.networkmanager.enable = true;

  time.timeZone = lib.mkDefault "Europe/Paris";
}
