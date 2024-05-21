FROM nixos/nix:2.9.0

RUN nix-channel --update
RUN nix-build -A colmena '<nixpkgs>'
