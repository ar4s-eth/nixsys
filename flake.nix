{
  description = "nix system configurations";

  nixConfig = {
    substituters = ["https://cache.nixos.org" "https://ar4s.cachix.org"];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "ar4s.cachix.org-1:kqfT6BHhZ+HUzqWY2wDyhVOlTafqqQKHhK+TM5smie4="
    ];
  };

  inputs = {
    # package repos
    # devshell.url = "github:numtide/devshell"; # from gh/yqrashawn
    # flake-utils.url = "github:numtide/flake-utils"; # from gh/yqrashawn
    stable.url = "github:nixos/nixpkgs/nixos-22.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    small.url = "github:nixos/nixpkgs/nixos-unstable-small";

    # system management
    nixos-hardware.url = "github:nixos/nixos-hardware";
    darwin = {
      url = "github:ar4s/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # shell stuff
    flake-utils.url = "github:numtide/flake-utils";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";    
    small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    sops-nix.url = "github:Mic92/sops-nix";

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    comma = {
      url = "github:nix-community/comma";
      flake = false;
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    clojure-deps-edn = {
      url = "github:practicalli/clojure-deps-edn";
      flake = false;
    };

    spacehammer = {
      url = "github:agzam/spacehammer";
      flake = false;
    };

    forgit = {
      url = "github:wfxr/forgit";
      flake = false;
    };
    zsh-f-sy-h = {
      url = "github:z-shell/F-Sy-H";
      flake = false;
    };
    zsh-abbrev-alias = {
      url = "github:momo-lab/zsh-abbrev-alias";
      flake = false;
    };
    zsh-alias-tips = {
      url = "github:djui/alias-tips";
      flake = false;
    };
    tmux-conf = {
      url = "github:gpakosz/.tmux";
      flake = false;
    };
    zsh-autoquoter = {
      url = "github:ianthehenry/zsh-autoquoter";
      flake = false;
    };
    asdf-java = {
      url = "github:halcyon/asdf-java";
      flake = false;
    };
    asdf-clojure = {
      url = "github:halcyon/asdf-clojure";
      flake = false;
    };
    asdf-nodejs = {
      url = "github:asdf-vm/asdf-nodejs";
      flake = false;
    };
    asdf-python = {
      url = "github:danhper/asdf-python";
      flake = false;
    };
    asdf-ruby = {
      url = "github:asdf-vm/asdf-ruby";
      flake = false;
    };
    asdf-golang = {
      url = "github:kennyp/asdf-golang";
      flake = false;
    };
    # https://github.com/smashedtoatoms/asdf-sbcl
    asdf-sbcl = {
      url = "github:smashedtoatoms/asdf-sbcl";
      flake = false;
    };
    asdf-deno = {
      url = "github:asdf-community/asdf-deno";
      flake = false;
    };
    asdf-crystal = {
      url = "github:asdf-community/asdf-crystal";
      flake = false;
    };
    asdf-elixir = {
      url = "github:asdf-vm/asdf-elixir";
      flake = false;
    };
    asdf-haskell = {
      url = "github:asdf-community/asdf-haskell";
      flake = false;
    };
    asdf-janet = {
      url = "github:Jakski/asdf-janet";
      flake = false;
    };
    asdf-lua = {
      url = "github:Stratus3D/asdf-lua";
      flake = false;
    };
    asdf-ocaml = {
      url = "github:asdf-community/asdf-ocaml";
      flake = false;
    };
    asdf-chezscheme = {
      url = "github:asdf-community/asdf-chezscheme";
      flake = false;
    };
    asdf-bun = {
      url = "github:cometkim/asdf-bun";
      flake = false;
    };
    asdf-pnpm = {
      url = "github:jonathanmorley/asdf-pnpm";
      flake = false;
    };
    asdf-racket = {
      url = "github:asdf-community/asdf-racket";
      flake = false;
    };
    asdf-scala = {
      url = "github:asdf-community/asdf-scala";
      flake = false;
    };
    asdf-hashicorp = {
      url = "github:asdf-community/asdf-hashicorp";
      flake = false;
    };
    asdf-solidity = {
      url = "github:diegodorado/asdf-solidity";
      flake = false;
    };
    asdf-nim = {
      url = "github:asdf-community/asdf-nim";
      flake = false;
    };
    asdf-v = {
      url = "github:ndac-todoroki/asdf-v";
      flake = false;
    };
    asdf-yarn = {
      url = "github:twuni/asdf-yarn";
      flake = false;
    };
    asdf-zig = {
      url = "github:cheetah/asdf-zig";
      flake = false;
    };
    asdf-ninja = {
      url = "github:asdf-community/asdf-ninja";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    darwin,
    home-manager,
    flake-utils,
    treefmt-nix,
    ...
  }: let
    inherit (flake-utils.lib) eachSystemMap;

    isDarwin = system: (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);
    homePrefix = system:
      if isDarwin system
      then "/Users"
      else "/home";
    defaultSystems = ["aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux"];

    # generate a base darwin configuration with the
    # specified hostname, overlays, and any extraModules applied
    mkDarwinConfig = {
      system ? "aarch64-darwin",
      nixpkgs ? inputs.nixpkgs,
      stable ? inputs.stable,
      baseModules ? [
        home-manager.darwinModules.home-manager
        ./modules/darwin
      ],
      extraModules ? [],
    }:
      inputs.darwin.lib.darwinSystem {
        inherit system;
        modules = baseModules ++ extraModules;
        specialArgs = {inherit self inputs nixpkgs;};
      };

    # generate a base nixos configuration with the
    # specified overlays, hardware modules, and any extraModules applied
    mkNixosConfig = {
      system ? "x86_64-linux",
      nixpkgs ? inputs.nixos-unstable,
      stable ? inputs.stable,
      hardwareModules,
      baseModules ? [
        home-manager.nixosModules.home-manager
        ./modules/nixos
      ],
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = baseModules ++ hardwareModules ++ extraModules;
        specialArgs = {inherit self inputs nixpkgs;};
      };

    # generate a home-manager configuration usable on any unix system
    # with overlays and any extraModules applied
    mkHomeConfig = {
      username,
      system ? "x86_64-linux",
      nixpkgs ? inputs.nixpkgs,
      stable ? inputs.stable,
      baseModules ? [
        ./modules/home-manager
        {
          home = {
            inherit username;
            homeDirectory = "${homePrefix system}/${username}";
            sessionVariables = {
              NIX_PATH = "nixpkgs=${nixpkgs}:stable=${stable}\${NIX_PATH:+:}$NIX_PATH";
            };
          };
        }
      ],
      extraModules ? [],
    }:
      inputs.home-manager.lib.homeManagerConfiguration rec {
        pkgs = import nixpkgs {
          inherit system;
          overlays = builtins.attrValues self.overlays;
        };
        extraSpecialArgs = {inherit self inputs nixpkgs;};
        modules = baseModules ++ extraModules;
      };

    mkChecks = {
      arch,
      os,
      username ? "ar4s",
    }: {
      "${arch}-${os}" = {
        "${username}_${os}" =
          (
            if os == "darwin"
            then self.darwinConfigurations
            else self.nixosConfigurations
          )
          ."${username}@${arch}-${os}"
          .config
          .system
          .build
          .toplevel;
        "${username}_home" =
          self.homeConfigurations."${username}@${arch}-${os}".activationPackage;
        devShell = self.devShells."${arch}-${os}".default;
      };
    };
  in {
    checks =
      {}
      // (mkChecks {
        arch = "aarch64";
        os = "darwin";
      })
      // (mkChecks {
        arch = "x86_64";
        os = "darwin";
      })
      // (mkChecks {
        arch = "aarch64";
        os = "linux";
      })
      // (mkChecks {
        arch = "x86_64";
        os = "linux";
      });

    darwinConfigurations = {
      "ar4s@aarch64-darwin" = mkDarwinConfig {
        system = "aarch64-darwin";
        extraModules = [./profiles/personal.nix ./modules/darwin/apps.nix];
      };
      "ar4s@x86_64-darwin" = mkDarwinConfig {
        system = "x86_64-darwin";
        extraModules = [./profiles/personal.nix ./modules/darwin/apps.nix];
      };
      "lejeukc1@aarch64-darwin" = mkDarwinConfig {
        system = "aarch64-darwin";
        extraModules = [./profiles/work.nix];
      };
      "lejeukc1@x86_64-darwin" = mkDarwinConfig {
        system = "aarch64-darwin";
        extraModules = [./profiles/work.nix];
      };
    };

    nixosConfigurations = {
      "ar4s@x86_64-linux" = mkNixosConfig {
        system = "x86_64-linux";
        hardwareModules = [
          ./modules/hardware/phil.nix
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t460s
        ];
        extraModules = [./profiles/personal.nix];
      };
      "ar4s@aarch64-linux" = mkNixosConfig {
        system = "aarch64-linux";
        hardwareModules = [./modules/hardware/phil.nix];
        extraModules = [./profiles/personal.nix];
      };
    };

    homeConfigurations = {
      "ar4s@x86_64-linux" = mkHomeConfig {
        username = "ar4s";
        system = "x86_64-linux";
        extraModules = [./profiles/home-manager/personal.nix];
      };
      "ar4s@aarch64-linux" = mkHomeConfig {
        username = "ar4s";
        system = "aarch64-linux";
        extraModules = [./profiles/home-manager/personal.nix];
      };
      "ar4s@x86_64-darwin" = mkHomeConfig {
        username = "ar4s";
        system = "x86_64-darwin";
        extraModules = [./profiles/home-manager/personal.nix];
      };
      "ar4s@aarch64-darwin" = mkHomeConfig {
        username = "ar4s";
        system = "aarch64-darwin";
        extraModules = [./profiles/home-manager/personal.nix];
      };
      "lejeukc1@x86_64-linux" = mkHomeConfig {
        username = "lejeukc1";
        system = "x86_64-linux";
        extraModules = [./profiles/home-manager/work.nix];
      };
    };

    devShells = eachSystemMap defaultSystems (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues self.overlays;
      };
    in {
      default = pkgs.devshell.mkShell {
        packages = [
          pkgs.nixfmt
          pkgs.pre-commit
          pkgs.rnix-lsp
          self.packages.${system}.pyEnv
          (treefmt-nix.lib.mkWrapper pkgs (import ./treefmt.nix))
        ];
        commands = [
          {
            name = "sysdo";
            package = self.packages.${system}.sysdo;
            category = "utilities";
            help = "perform actions on this repository";
          }
        ];
      };
    });

    packages = eachSystemMap defaultSystems (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues self.overlays;
      };
    in rec {
      pyEnv =
        pkgs.python3.withPackages
        (ps: with ps; [black typer colorama shellingham]);
      sysdo = pkgs.writeScriptBin "sysdo" ''
        #! ${pyEnv}/bin/python3
        ${builtins.readFile ./bin/do.py}
      '';
      cb = pkgs.writeShellScriptBin "cb" ''
        #! ${pkgs.lib.getExe pkgs.bash}
        # universal clipboard, stephen@niedzielski.com

        shopt -s expand_aliases

        # ------------------------------------------------------------------------------
        # os utils

        case "$OSTYPE$(uname)" in
          [lL]inux*) TUX_OS=1 ;;
         [dD]arwin*) MAC_OS=1 ;;
          [cC]ygwin) WIN_OS=1 ;;
                  *) echo "unknown os=\"$OSTYPE$(uname)\"" >&2 ;;
        esac

        is_tux() { [ ''${TUX_OS-0} -ne 0 ]; }
        is_mac() { [ ''${MAC_OS-0} -ne 0 ]; }
        is_win() { [ ''${WIN_OS-0} -ne 0 ]; }

        # ------------------------------------------------------------------------------
        # copy and paste

        if is_mac; then
          alias cbcopy=pbcopy
          alias cbpaste=pbpaste
        elif is_win; then
          alias cbcopy=putclip
          alias cbpaste=getclip
        else
          alias cbcopy='${pkgs.xclip} -sel c'
          alias cbpaste='${pkgs.xclip} -sel c -o'
        fi

        # ------------------------------------------------------------------------------
        cb() {
          if [ ! -t 0 ] && [ $# -eq 0 ]; then
            # no stdin and no call for --help, blow away the current clipboard and copy
            cbcopy
          else
            cbpaste ''${@:+"$@"}
          fi
        }

        # ------------------------------------------------------------------------------
        if ! return 2>/dev/null; then
          cb ''${@:+"$@"}
        fi
      '';
    });

    apps = eachSystemMap defaultSystems (system: rec {
      sysdo = {
        type = "app";
        program = "${self.packages.${system}.sysdo}/bin/sysdo";
      };
      cb = {
        type = "app";
        program = "${self.packages.${system}.cb}/bin/cb";
      };
      default = sysdo;
    });

    overlays = {
      channels = final: prev: {
        # expose other channels via overlays
        stable = import inputs.stable {system = prev.system;};
        small = import inputs.small {system = prev.system;};
      };
      extraPackages = final: prev: {
        sysdo = self.packages.${prev.system}.sysdo;
        pyEnv = self.packages.${prev.system}.pyEnv;
        cb = self.packages.${prev.system}.cb;
      };
      devshell = inputs.devshell.overlay;
    };
  };
}
