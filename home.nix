{ config, pkgs, inputs, ... }:

{
  imports = [ ./zsh.nix  ];
  home.username = "degra";
  home.homeDirectory = "/home/degra";

  home.stateVersion = "23.11"; 

  home.packages = with pkgs; [
    
    vim
    rustup
    bat
    python3
    zip
    unzip
    eza
    fzf

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
      core = { whitespace = "trailing-space,space-before-tab"; };
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

  programs.neovim = 
	  let
	    toLua = str: "lua << EOF\n${str}\nEOF\n";
	    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
	  in
	  {
	    enable = true;

	    viAlias = true;
	    vimAlias = true;
	    vimdiffAlias = true;

	    extraPackages = with pkgs; [
	      lua-language-server
	      rnix-lsp

	      xclip
	      wl-clipboard
	    ];

	    plugins = with pkgs.vimPlugins; [

	      {
		plugin = nvim-lspconfig;
		config = toLuaFile ./nvim/plugin/lsp.lua;
	      }

	      {
		plugin = comment-nvim;
		config = toLua "require(\"Comment\").setup()";
	      }

	      {
		plugin = gruvbox-nvim;
		config = "colorscheme gruvbox";
	      }

	      neodev-nvim

	      nvim-cmp 
	      {
		plugin = nvim-cmp;
		config = toLuaFile ./nvim/plugin/cmp.lua;
	      }

	      {
		plugin = telescope-nvim;
		config = toLuaFile ./nvim/plugin/telescope.lua;
	      }
telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets


      lualine-nvim
      nvim-web-devicons

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/plugin/treesitter.lua;
      }

      vim-nix

      # {
      #   plugin = vimPlugins.own-onedark-nvim;
      #   config = "colorscheme onedark";
      # }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';

    # extraLuaConfig = ''
    #   ${builtins.readFile ./nvim/options.lua}
    #   ${builtins.readFile ./nvim/plugin/lsp.lua}
    #   ${builtins.readFile ./nvim/plugin/cmp.lua}
    #   ${builtins.readFile ./nvim/plugin/telescope.lua}
    #   ${builtins.readFile ./nvim/plugin/treesitter.lua}
    #   ${builtins.readFile ./nvim/plugin/other.lua}
    # '';
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
