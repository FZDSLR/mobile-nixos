{
  mobile-nixos
, fetchFromGitHub
, fetchpatch
, python3
, ...
}:

mobile-nixos.kernel-builder {
  version = "7.0.0";
  configfile = ./config.aarch64;

  src = fetchFromGitHub {
    owner = "torvalds";
    repo = "linux";
    rev = "v7.0";
    sha256 = "sha256-7TjYHhJdD67P3lquusrjjVtUIUzhLPtA5Oy7tc82gYA=";
  };

  patches = [

  ];
  nativeBuildInputs = [ python3 ];
  isModular = true;
  isCompressed = false;
}
