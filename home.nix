{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "loid";
  home.homeDirectory = "/home/loid";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/atomik/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.git = {
    enable = true;
    userName = "atomiksan";
    userEmail = "25588579+atomiksan@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./dotfiles/starship.toml;
    enableFishIntegration = true;
    enableTransience = true;
  };
  
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    escapeTime = 10;
    prefix = "C-Space";
    keyMode = "vi";
    sensibleOnTop = true;
    #customPaneNavigationAndResize = false;
    extraConfig = ''
    set-option -sa terminal-overrides ",xterm*:Tc"
    set-option -g focus-events on

    # Vim style key binds for panes
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R
    
    # Resize panes using Alt + arrow keys
    bind -n M-Left resize-pane -L 5    # Shrink pane by 5 cells to the left
    bind -n M-Right resize-pane -R 5   # Expand pane by 5 cells to the right
    bind -n M-Up resize-pane -U 5      # Shrink pane by 5 cells upwards
    bind -n M-Down resize-pane -D 5    # Expand pane by 5 cells downwards

    # Shift arrow to switch windows
    bind -n S-Left  previous-window
    bind -n S-Right next-window

    # Shift Alt vim keys to switch windows
    bind -n M-H previous-window
    bind -n M-L next-window

    # Set split panes to open in same directory
    bind '"' split-window -v -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"
    bind c new-window -c "#{pane_current_path}"

    # Set split panes to follow vim-motions
    set-window-option -g mode-keys vi 
    '';
    disableConfirmationPrompt = true;
    mouse = true;
    newSession = true;
    baseIndex = 1;
    shell = "/home/atomik/.nix-profile/bin/fish";
    plugins =  with pkgs; [
      # {
      #   plugin = tmuxPlugins.resurrect;
      #   extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      # }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      {
        plugin = tmuxPlugins.tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_show_path 1
          set -g @tokyo-night-tmux_path_format relative
          set -g @tokyo-night-tmux_window_id_style roman
          set -g @tokyo-night-tmux_pane_id_style hsquare
          set -g @tokyo-night-tmux_zoom_id_style dsquare
          set -g @tokyo-night-tmux_show_datetime 0
          set -g @tokyo-night-tmux_show_git 0
          set -g @tokyo-night-tmux_transparent 1
        '';
      }
      tmuxPlugins.yank
      tmuxPlugins.battery
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left "C-h"
          set -g @vim_navigator_mapping_right "C-l"
          set -g @vim_navigator_mapping_up "C-k"
          set -g @vim_navigator_mapping_down "C-j"
          set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding
        '';
      }  
      # { 
      #   plugin = tmuxPlugins.rose-pine;
      #   extraConfig = ''
      #     set -g @rose_pine_variant 'main'
      #     set -g @rose_pine_user 'on'
      #     set -g @rose_pine_bar_bg_disable 'on'
      #     set -g @rose_pine_bar_bg_disabled_color_option 'default'
      #   '';
      # }
      {
        plugin = tmuxPlugins.online-status;
        extraConfig = ''
          set -g @online_icon "ok"
          set -g @offline_icon "nok"
        '';
      }
    ]; 
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      set -U fish_greeting
      set -x COLORTERM truecolor
      set -gx PATH $HOME/.local/bin $PATH
      set -gx PATH (go env GOPATH)/bin $PATH
      set -gx PATH $HOME/.config/emacs/bin $PATH
      set -gx PATH $HOME/zig $PATH
      fish_config theme choose 'Rosé Pine'
    '';
    interactiveShellInit = ''
      set -x TERM xterm-256color
    '';
    shellAliases = {
      ll = "eza -l --icons --no-permissions";
      ls = "eza --icons";
      tree = "eza -T --icons";
      la = "eza -la --icons";
      lo = "eza -l -o --icons";
      vim = "nvim";
    };
    shellInitLast = ''
      fzf --fish | source
      zoxide init --cmd cd fish |source
      direnv hook fish | source
    '';
  };

  xdg.configFile."fish/themes/Rosé Pine.theme".source = "${
    pkgs.fetchFromGitHub {
      owner = "rose-pine";
      repo = "fish";
      rev = "38aab5baabefea1bc7e560ba3fbdb53cb91a6186";
      sha256 = "bSGGksL/jBNqVV0cHZ8eJ03/8j3HfD9HXpDa8G/Cmi8=";
    }
  }/themes/Rosé Pine.theme";

  programs.zsh = {
    enable = true;
    antidote = {
      enable = true;
      plugins = [
        "Aloxaf/fzf-tab"
        #"romkatv/powerlevel10k"
        "zsh-users/zsh-syntax-highlighting"
      ];
      useFriendlyNames = true;
    };
    initExtraBeforeCompInit = ''
      EDITOR=nvim
      export GPG_TTY=$(tty)
      export PATH=$HOME/.config/emacs/bin:$PATH
      export PATH=$(go env GOPATH)/bin:$PATH
      export PATH=$HOME/zig:$PATH
    '';
    completionInit = ''
      autoload -U compinit && compinit
    '';
    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' menu no
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --icons $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always --icons $realpath'
      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"
      eval "$(direnv hook zsh)"
    '';
    autosuggestion = {
      enable = true;
    };
    defaultKeymap = "emacs";
    enableCompletion = true;
    history = {
      append = true;
      expireDuplicatesFirst = true;
      extended = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 5000;
      share = true;
      size = 5000;
      path = "$HOME/.histfile";
    };
    sessionVariables = {
      COLORTERM = "24bit";
      TERM = "xterm-256color";
    };
    shellAliases = {
      ll = "eza -l --icons --no-permissions";
      ls = "eza --icons";
      tree = "eza -T --icons";
      la = "eza -la --icons";
      lo = "eza -l -o --icons";
      vim = "nvim";
    };
  };

  xdg.configFile."fastfetch/images/logo.png".source = ./dotfiles/logo.png;

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "~/.config/fastfetch/images/logo.png";
        type = "kitty";
        height = 12;
        padding =  {
          top = 2;
      };
    };
    display = {
        separator = " ";
    };
    modules = [
        "break"
        "break"
        "break"
        {
            type = "title";
            keyWidth = 10;
        }
        {
            type = "os";
            key = " ";
            keyColor = "34";  # = color4
        }
        {
            type = "kernel";
            key = " ";
            keyColor = "34";
        }
        {
            type = "packages";
            format = "{} (nix)";
            key = " ";
            keyColor = "34";
        }
        {
            type = "shell";
            key = " ";
            keyColor = "34";
        }
        {
            type = "terminal";
            key = " ";
            keyColor = "34";
        }
        {
            type = "wm";
            key = " ";
            keyColor = "34";
        }
        {
            type = "cursor";
            key = " ";
            keyColor = "34";
        }
        {
            type = "terminalfont";
            key = " ";
            keyColor = "34";
        }
        {
            type = "uptime";
            key = " ";
            keyColor = "34";
        }
        {
            type = "datetime";
            format = "{1}-{3}-{11}";
            key = " ";
            keyColor = "34";
        }
        {
            type = "media";
            key = "󰝚 ";
            keyColor = "34";
        }
        {
            type = "player";
            key = " ";
            keyColor = "34";
        }
        "break"
        "break"
      ];
    };
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./dotfiles/omp.json));
  };

  programs.wezterm = {
    #enable = true;
    extraConfig = builtins.readFile ./dotfiles/wezterm.lua;
  };

  programs.eza = {
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
