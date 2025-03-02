{ config
, pkgs
, lib
, ...
}: {
  home.stateVersion = "22.11";

  home.packages = with pkgs;
    [
      git
      ripgrep
    ];

  programs.git = {
    enable = true;
    userName = "shuntingyard";
    userEmail = "shuntingyard@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
