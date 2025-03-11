{ config, pkgs, ... }:

{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # default /boot
    };
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
      theme = pkgs.fetchFromGitHub{
        owner = "semimqmo";
        repo = "sekiro_grub_theme";
        rev = "1affe05f7257b72b69404cfc0a60e88aa19f54a6";
        sha256 = "02gdihkd2w33qy86vs8g0pfljp919ah9c13cj4bh9fvvzm5zjfn1";
        } + "/Sekiro";
    };
    # systemd-boot = {
    #   enable = true;
    #   configurationLimit = 5; # bootmenu items
    #  # consoleMode = "max";
    # };
    # grub = {
    #   enable = false;
    #   device = "nodev";
    #   efiSupport = true;
    #   gfxmodeEfi = "1920x1080";
    #   default = "1";
    #   # extraEntriesBeforeNixOS = true;
    #   extraEntries = ''
    #     menuentry "Windows" {
    #      search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
    #      chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
    #     }
    #     menuentry "Firmware" {
    #      fwsetup
    #     }
    #     menuentry "Shutdown" {
    #      halt
    #     }
    #   '';
      # theme = pkgs.fetchzip {
      # https://github.com/AdisonCavani/distro-grub-themes
      #   url = "https://raw.githubusercontent.com/AdisonCavani/distro-grub-themes/master/themes/freeBSD.tar";
      #   hash = "sha256-oTrh+5g73y/AXSR+MPz6a25KyCKCPLL8mZCDup/ENZc=";
      #   stripRoot=false;
      # };
  #   };
  };
}
