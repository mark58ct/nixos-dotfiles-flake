{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    alacritty = "alacritty";
  };
in

{
  home.username = "me";
  home.homeDirectory = "/home/me";
  # programs.git.enable = true;
  programs.git = {
    enable = true;
    userName = "mark58ct";
     userEmail = "mark58ct@gmail.com";
  };

  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use nixos, btw.";
    };
    initExtra = ''
                                export PS1='\[\e[92m\]\u\[\e[0m\] in \[\e[38;5;32m\]\W\[\e[0m\]  \\$ '
      	   '';
  };
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;

    })
    configs;

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    pcmanfm
    rofi
    bat
  ];
}
