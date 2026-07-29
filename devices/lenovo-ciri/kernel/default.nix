{
  mobile-nixos
, fetchFromGitHub
, fetchgit
, fetchurl
, python3
, ...
}:

mobile-nixos.kernel-builder {
  version = "7.2.0-rc5";
  configfile = ./config.aarch64;

  src = fetchgit {
    url = "https://mirrors.bfsu.edu.cn/git/linux.git";
    rev = "v7.2-rc5";
    hash = "sha256-p1LRmMz4AHYAtwy0JrFS3Rtpp8oKjTrm8pZIfAo+cRc=";
  };

  patches = [
    # [PATCH] arm64: dts: mediatek: mt8188-geralt: enable touchpad
    (fetchurl {
      url = "https://lore.kernel.org/all/20260504072846.2581096-1-zhengxingda@iscas.ac.cn/raw";
      hash = "sha256-dgVOnNXBsMNOxlkiSImgrAGXw35kITN3nkM2QZSj5Ks=";
    })
    ./PATCH-v6-00-16-arm64-mediatek-Add-M.2-E-key-slot-on-Chromebooks.diff
    ./0001-HID-Add-hid-himax-from-chromiumos-third_party-kernel.patch
    ./0001-HID-hid-himax-master-controller.patch
    ./0001-dts-mediatek-enable-ciri-touch-support.patch
  ];
  nativeBuildInputs = [ python3 ];
  isModular = true;
  isCompressed = false;
}
