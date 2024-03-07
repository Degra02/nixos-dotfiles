{ config, pkgs, inputs, ... }:

{
  imports = [ ./shells/zsh.nix ./editors/nvim.nix ./wm/hyprland.nix ];
  home.username = "degra";
  home.homeDirectory = "/home/degra";

  home.stateVersion = "23.11"; 

  home.packages = with pkgs; [
    
    # editors
    vim
    lunarvim

    # dev
    gcc
    rustup
    python3
    nodejs
    nil


    # cli
    bat
    delta
    zip
    unzip
    eza
    fzf
    neofetch

    # various
    gnupg
    pinentry

  ];

  programs.gh.enable = true;

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userEmail = "filippodegrandi02@gmail.com";
    userName = "Degra02";
    # signing.key = null;
    # signing.signByDefault = true;

    extraConfig = {
      core = { 
        whitespace = "trailing-space,space-before-tab"; 
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
      color = { ui = "auto"; };
      github = { user = "Degra02"; };
     };

     ignores = [
       "*~"
       "*.swp"
       ".ccls-cache"
       "*.pdf"
       "compile_commands.json"
       "shell.nix"
      ];
    };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
