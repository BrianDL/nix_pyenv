{
  description = "A flake providing a devshell with pyenv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    
  in {
    packages.${system} = with pkgs; {
      pyenv = pyenv;
      default = pyenv;
    };
    
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.pyenv
        pkgs.coreutils
        pkgs.curl
        pkgs.git
        pkgs.openssl
        pkgs.readline
        pkgs.zlib
        pkgs.bzip2
        pkgs.sqlite
        pkgs.llvm
        pkgs.ncurses
        pkgs.xz
        pkgs.tk
        pkgs.libffi
        pkgs.lzma
      ];
      shellHook = ''
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        if command -v pyenv 1>/dev/null 2>&1; then
          eval "$(pyenv init --path)"
          eval "$(pyenv init -)"
        fi
      '';
    };
  };
}