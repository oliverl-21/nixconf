{inputs, ...}: {
  flake.nixosModules.nix = {pkgs, ...}: {
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];
    programs.nix-index-database.comma.enable = true;

    programs = {
      direnv = {
        enable = true;
        silent = false;
        loadInNixShell = true;
        direnvrcExtra = "";
        nix-direnv = {
          enable = true;
        };
      };
      nix-ld.enable = true;
      zsh = {
        enable = true;
        enableBashCompletion = true;
        autosuggestions = {
          enable = true;
          strategy = [
            "history"
            "completion"
          ];
          highlightStyle = "fg=#818181,bold,underline";
        };
        syntaxHighlighting.enable = true;
        setOptions = [ "HIST_IGNORE_SPACE" "HIST_IGNORE_DUPS" "SHARE_HISTORY" "extended_glob" "null_glob"];
        histFile = "$HOME/.local/state/.zsh_history";
      };
      nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 7d --keep 5";
        flake = "$HOME/.config/nix";
      };
      starship = {
        enable = true;
	settings = {
	  add_newline = true;
	  scan_timeout = 50;
	  format = "$os$username[at ](dimmed)$hostname[in ](dimmed)$directory\n$character";
	  right_format = "$all$line_break$time";
	  username = {
	    show_always = true;
	    format = "[$user]($style) ";
	  };
	  hostname = {
	    ssh_only = false;
	    format = "[$ssh_symbol$hostname]($style) ";
	  };
	  time = {
	    disabled = false;
	    style = "bold dimmed white";
	    format = "[$time]($style) ";
	  };
	  os = {
	    disabled = false;
	    symbols = {
	      NixOS = "";
	    };
	  };
	  line_break = {
	    disabled = false;
	  };
        };
      };
    };
    systemd.tmpfiles.rules = [
    
    ];
    systemd.tmpfiles.settings = {
      "custom-user-folders" = {
        "users.users.username.home/.config/zsh" = {
          d = { mode = "0700";
          };
        };
      };
    };   
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        trusted-users = ["@wheel"];
      };
      optimise = {
        automatic = true;
        dates = "01:00";
        randomizedDelaySec = "30min";
      };
      gc = {
        automatic = false;
        dates = "00:14";
        randomizedDelaySec = "30min";
        options = "--delete-old";
      };
    };
    system = {
      autoUpgrade = {
        enable = true;
        dates = "23:00";
        flake = inputs.self.outPath;
        upgrade = true;
        runGarbageCollection = true;
        allowReboot = true;
        randomizedDelaySec = "30min";
      };
    };

    nixpkgs.config.allowUnfree = true;
    users.defaultUserShell = pkgs.zsh; 

    environment = {
      systemPackages = with pkgs; [
        # Nix tooling
        nil
        nixd
        statix
        alejandra
        manix
        nix-inspect
        vim
        curl
        wget
        eza
        bat
        nixfmt
      ];
      shellAliases = {
        ls = "eza -ah --git --icons=auto";
        ll = "eza -alh --git --icons=auto";
        ".." = "cd ..";
        cat = "bat";
      };
      sessionVariables = rec {
        ZDOTDIR = "$HOME/.config/zsh";
        OS_LOGO = "";
        XDG_CACHE_HOME  = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME   = "$HOME/.local/share";
        XDG_STATE_HOME  = "$HOME/.local/state";
      };
    };
  };
}

