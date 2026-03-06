{
  stdenv,
  fetchFromCodeberg,
  pixman,
  libdrm,
  wayland,
	libinput,
	libudev-zero,
	libxkbcommon,
	libxcb,
	libxcb-wm,
  zig,
  neuswc,
  neuwld,
  lib,
}:

stdenv.mkDerivation {
  pname = "shko";
  version = "0.1.0";
  src = fetchFromCodeberg {
    owner = "chld";
    repo = "shko";
    rev = "4b895b42a22be7aa918fbc5f2cd01eb0424fc7cf";
    hash = lib.fakeHash;
  };

  nativeBuildInputs = [ zig.hook ];
  dontSetZigDefaultFlags = true;

  buildInputs = [
  	libdrm
  	libinput
  	pixman
  	neuswc
  	neuwld
  	libudev-zero
  	wayland
  	libxkbcommon
  	libxcb
  	libxcb-wm
  ];
}

