{ config, pkgs, ... }:

{
  targets.genericLinux.enable = true;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "houssem";
  home.homeDirectory = "/home/houssem";
  fonts.fontconfig.enable = true;

  home.stateVersion = "24.05"; 

  home.packages = with pkgs; [
    hugo
    guake
    git
    xsel
    vim
    deja-dup
    chromium
    gnumake
    taskwarrior
    taskwarrior-tui
    kubectl
    istioctl
    openssl
    wget
    file
    kubectx
    docker-compose
    xdiskusage
    drawio
    azure-cli
    unzip
    gh
    krew
    k9s
    kubernetes-helm
    helm-docs
    pandoc
    go
    yq
    jq
    vault
    awscli2
    kind
    kustomize
    silver-searcher
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    (pkgs.nerdfonts.override { fonts = [ "DejaVuSansMono" "FiraCode" "DroidSansMono" ]; })
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    docker # this is still not possible to do without modifying user / group , needs script.sh steps
    tmux
    wireshark
    openjdk
    nginx
    zoxide
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

  home.sessionVariables = {
    # EDITOR = "emacs";
    ZSH_THEME = "arrow";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };
  programs.bat.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;  
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      k = "kubectl";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    initExtra = ''
       setopt rc_expand_param
       . ~/.nix-profile/etc/profile.d/hm-session-vars.sh
       export PATH="/home/houssem/.crc/bin/oc:$PATH"
       export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
       export WORKON_HOME=~/Envs
       #source /usr/local/bin/virtualenvwrapper.sh
      '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs;
      [
        tmuxPlugins.better-mouse-mode
      ];
    extraConfig = ''
      unbind C-b
      set -g prefix C-a
      bind -n C-a send-prefix
      set-option -g mouse on
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
    '';
    };

  programs.zoxide.enable = true;
  
  programs.git = {
    enable = true;
    userName = "SpectralHiss";
    userEmail = "houssem.elfekih@jetstack.io";
    aliases = {
      a = "add";
      c = "commit";
      ca = "commit --amend";
      can = "commit --amend --no-edit";
      cl = "clone";
      cm = "commit -m";
      co = "checkout";
      d = "diff";
      f = "fetch";
      fo = "fetch origin";
      fu = "fetch upstream";
      lg = "log --topo-order --all --graph --date=local --pretty=format:'%C(green)%h%C(reset) %><(55,trunc)%s%C(red)%d%C(reset) %C(blue)[%an]%C(reset) %C(yellow)%ad%C(reset)%n'";
      pl = "pull";
      pr = "pull -r";
      ps = "push";
      rb = "rebase";
      rbi = "rebase -i";
      r = "remote";
      ra = "remote add";
      rr = "remote rm";
      rv = "remote -v";
      rs = "remote show";
      st = "status";
    };
  };

  services.copyq.enable = true;

}
