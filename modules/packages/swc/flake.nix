{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    wld = {
      url = "path:../wld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, wld, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system}.default =
      pkgs.stdenv.mkDerivation {
        pname = "swc";
        version = "0-unstable-2026-03-02";

        src = pkgs.fetchFromSourcehut {
          owner = "~shrub900";
          repo = "neuswc";
          rev = "f0147d3d9b84f5d81ad14260f08808afc563e54d";
          hash = "sha256-2y7nKZKKWQaxJSuz5ia4VIcR4ibsAt/M6oqDy5jRpg4=";
        };

        nativeBuildInputs = with pkgs; [
          bmake
          pkg-config
          wayland-scanner
          libdrm
        ];

        buildInputs = with pkgs; [
          wld.packages.${system}.default
          wayland
          wayland-protocols
          pixman
          libdrm
          libudev0-shim
        	libxkbcommon
        	fontconfig
        	libinput
        	libxcb
        	libxcb-wm
        ];

        patchPhase = ''
          substituteInPlace Makefile \
            --replace "4755" "755"
        '';

        CFLAGS = "-I${pkgs.libdrm.dev}/include/libdrm"; # Uncomment this line to fix compilation error

        makeFlags = ["PREFIX=$(out)"];
      };
  };
}
