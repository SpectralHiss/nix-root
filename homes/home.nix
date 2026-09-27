{ config, pkgs, ... }:
let
  # evaluates flakes with plain nix
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/NixOS/flake-compat/archive/refs/tags/v1.1.0.tar.gz";
    sha256 = "19d2z6xsvpxm184m41qrpi1bplilwipgnzv9jy17fgw421785q1m";
  };

  # pinned kimi-cli source
  kimi-cli-src = builtins.fetchTarball {
    url = "https://github.com/MoonshotAI/kimi-cli/archive/refs/tags/1.50.0.tar.gz";
    sha256 = "0av5b5ih3liki91jhdcf9d092xwrhzi402c45cjazxsfh0mgibf1";
  };

  kimi-cli =
    (import flake-compat { src = kimi-cli-src; })
    .defaultNix.packages.${pkgs.system}.default;
in
{
  targets.genericLinux.enable = true;
  home.username = "houssem";
  home.homeDirectory = "/home/houssem";
  fonts.fontconfig.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    hugo
    codecrafters-cli
    guake
    git
    xsel
    uv
    vim
    deja-dup
    chromium
    gnumake
    taskwarrior2
    taskwarrior-tui
    kubectl
    istioctl
    openssl
    wget
    wl-clipboard
    xclip
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
    kubebuilder
    kubernetes-helm
    helm-docs
    pandoc
    go
    gotools
    gopls
    golangci-lint
    delve
    yq
    jq
    awscli2
    kind
    kustomize
    silver-searcher
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    opencode
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    docker # this is still not possible to do without modifying user / group , needs script.sh steps
    tmux
    wireshark
    openjdk
    nginx
    zoxide
    zeal
    zed-editor
    kimi-cli
  ];

  home.sessionVariables = {
    ZSH_THEME = "arrow";
    OPENCODE_CONFIG_DIR = "${config.home.homeDirectory}/Desktop/.opencode/";
    GOPATH = "$HOME/go";
    GOBIN  = "$HOME/go/bin";
  };

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
    userEmail = "houssem.elfekih@pm.me";
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
