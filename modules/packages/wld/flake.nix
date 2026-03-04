{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  outputs = { nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system}.default =
      pkgs.stdenv.mkDerivation {
        pname = "wld";
        version = "0.0";
        src = pkgs.fetchFromSourcehut {
          owner = "~shrub900";
          repo = "neuwld";
          rev = "534372ea862c933f0e614a9dd77c5b44ddb18d10";
          hash = "sha256-fyCHP3rEeoUr+pWEebLaPW0bmgoVGlb7yzU281+yOSg=";
        };

        nativeBuildInputs = with pkgs; [
          bmake
          pkg-config
          wayland-scanner
        ];

        buildInputs = with pkgs; [
          fontconfig
          pixman
          freetype
          libdrm
          wayland
        ];

        makeFlags = ["PREFIX=$(out)"];
        outputs = ["out" "dev"];
    };
  };
}
