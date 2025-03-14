{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Enable emacs service
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Install neovim
  programs.neovim = {
    enable = true;
  };

  # Install git
  programs.git = {
    enable = true;
  };

  # Enable gnupg
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Install fish shell
  programs.fish.enable = true;

  # Install zsh shell
  programs.zsh.enable = true;

  # Install required nerd fonts
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    source-han-sans
    source-han-serif
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
    nerd-fonts.caskaydia-cove
    nerd-fonts.symbols-only
    nerd-fonts.victor-mono
  ];

  # Set Neovim as CLI editor
  environment.variables.EDITOR = "nvim";

  # Set Emacs as Visual editor
  environment.variables.VISUAL = "emacs";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    with pkgs;
    [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      bat
      brightnessctl
      direnv
      discord
      dunst
      emacs
      epy
      eww
      eza
      fd
      fzf
      fastfetch
      gcc_multi
      ghostty
      gnome-tweaks
      gnumake
      go
      grim
      hyprpaper
      hyprcursor
      kitty
      libgcc
      libnotify
      mpv
      networkmanagerapplet
      nixfmt-rfc-style
      nwg-look
      pavucontrol
      rofi-wayland
      ripgrep
      rustup
      shfmt
      shellcheck
      slurp
      swww
      tmux
      unzip
      waybar
      wget
      wl-clipboard
      yazi
      zls
      zoxide
      #...
    ]
    ++ [
      # Required for hyprland cursor
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      inputs.zen-browser.packages."${system}".default
    ];
}
