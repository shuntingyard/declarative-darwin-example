{ config
, pkgs
, lib
, ...
}: {
  home.stateVersion = "22.11";

  home.packages = with pkgs;
    [
      ripgrep
    ];

  # This is Ok according to home-managers's manual, but fails to work here so far.
  programs.git = {
    enable = true;
    userName = "shuntingyard";
    userEmail = "shuntingyard@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
