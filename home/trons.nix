{ config
, pkgs
, lib
, ...
}: {
  home.stateVersion = "22.11";
  home.packages = with pkgs;
    [
    ];
}
