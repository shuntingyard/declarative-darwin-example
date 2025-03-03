{ config
, pkgs
, lib
, ...
}: {
  home.stateVersion = "22.11";

  home.packages = with pkgs;
    [
      # cmdl
      fastfetch
      ripgrep

      # productivity
      mdcat
      warp-terminal

      # office
    ];

  # This is Ok according to home-managers's manual, but fails to work here so far.
  programs.git = {
    enable = true;
    userName = "shuntingyard";
    userEmail = "shuntingyard@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      # Next 2 lines generate correct entries for signing, but are switched off for now.
      # commit.gpgsign = true;
      # user.signingkey = "A68234966D2DAE48BDC2EA8D02989E9A57EF79D5";
    };
  };
}
