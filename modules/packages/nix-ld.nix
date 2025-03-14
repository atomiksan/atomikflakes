{ config, pkgs, ... }:

{
  # Enable nix-ld
  programs.nix-ld.enable = true;

  # Set up the nix-ld libraries to load
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
    libtinfo
    gmp
    #...
  ];
}
