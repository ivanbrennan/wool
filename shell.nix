{ pkgs ? import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/04f574a1c0fde90b51bf68198e2297ca4e7cccf4.tar.gz";
    sha256 = "sha256:1frf2yspkgy72c5pznjgk8hbla7yyrn78azsf3ypkyb84vml5jnw";
  }) { }
}:

let
  lush-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "lush-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "rktjmp";
      repo = "lush.nvim";
      rev = "b1e8eb1da3fee95ef31515a73c9eff9bf251088d";
      sha256 = "sha256-+M5tPNuL8OtkIZcB3+5+snygocWPhnXoZzen6gjOd2A=";
    };
  };

  shipwright-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "shipwright-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "rktjmp";
      repo = "shipwright.nvim";
      rev = "ab70e80bb67b7ed3350bec89dd73473539893932";
      sha256 = "sha256-Gy0tIqH1dmZgcUvrUcNrqpMXi3gOgHq9X1SbjIZqSns=";
    };
  };

  neovim-wrapped = pkgs.wrapNeovim pkgs.neovim-unwrapped {
    configure = {
      packages.utils = {
        start =
          [ lush-nvim
            shipwright-nvim
          ];
      };
    };
  };

  shipwright = pkgs.writeScriptBin "shipwright" ''
    exec ${neovim-wrapped}/bin/nvim \
        --headless \
        +'Shipwright shipwright_build.lua' \
        +q
  '';

in pkgs.mkShell { buildInputs = [ shipwright ]; }
