{
  mobile-nixos
, fetchFromGitHub
, fetchurl
, python3
, ...
}:

mobile-nixos.kernel-builder {
  version = "7.1.0-rc3";
  configfile = ./config.aarch64;

  src = fetchFromGitHub {
    owner = "torvalds";
    repo = "linux";
    rev = "v7.1-rc3";
    sha256 = "sha256-tfOQHlMoej2pBYqDp8MxXx0yoIj43juH8f8DhBg08z8=";
  };

  patches = [
    # [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after sending disable cmds
#     (fetchurl {
#       url = "https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2d4e80271f784aa0c7b17676e9762c7e8156be1c.patch";
#       hash = "sha256-/O7hozbml8pGkL7KrtvemEFR/FtWazSbCLIro213ojQ=";
#     })
    # [PATCH 1/2] dt-bindings: pinctrl: mediatek: mt8188: allow gpio hogs
#    (fetchurl {
#      url = "https://lore.kernel.org/all/20260504072748.2580172-1-zhengxingda@iscas.ac.cn/raw";
#      hash = "sha256-30d961Dcsey2kzgkkthJ2p5GB2hQnUqt8f9DGDtnhcc=";
#    })
#    # [PATCH 2/2] arm64: dts: mediatek: mt8188-geralt: enable Wi-Fi card
#    (fetchurl {
#      url = "https://lore.kernel.org/all/20260504072748.2580172-2-zhengxingda@iscas.ac.cn/raw";
#      hash = "sha256-j9Tvil4axAd29umg9yBmVOJD2jUkEDPbXXvuntXOXmQ=";
#    })
#    # [PATCH] arm64: dts: mediatek: mt8188-geralt: enable touchpad
#    (fetchurl {
#      url = "https://lore.kernel.org/all/20260504072846.2581096-1-zhengxingda@iscas.ac.cn/raw";
#      hash = "sha256-dgVOnNXBsMNOxlkiSImgrAGXw35kITN3nkM2QZSj5Ks=";
#    })
#    # [PATCH v3 1/4] HID: pass the buffer size to hid_report_raw_event
#    (fetchurl {
#      url = "https://lore.kernel.org/linux-input/20260504-wip-fix-core-v3-1-ce1f11f4968f@kernel.org/raw";
#      hash = "sha256-Mjbneg9r4Dy5dN10Xj9qd0Aw80rMCnSrwzP0nQQYYoM=";
#    })
#    # [PATCH v3 2/4] HID: core: introduce hid_safe_input_report()
#    (fetchurl {
#      url = "https://lore.kernel.org/linux-input/20260504-wip-fix-core-v3-2-ce1f11f4968f@kernel.org/raw";
#      hash = "sha256-UFJvDebPPDI325pmohunRPXF3CrF9IefwO4WM4DiK5c=";
#    })
#    # [PATCH v3 3/4] HID: multitouch: use __free(kfree) to clean up
#    (fetchurl {
#      url = "https://lore.kernel.org/linux-input/20260504-wip-fix-core-v3-3-ce1f11f4968f@kernel.org/raw";
#      hash = "sha256-WFhmmvHn1wtdC5m2I73GaWkEF75aY0JeyFSFTdJ2+7w=";
#    })
#    # [PATCH v3 4/4] HID: wacom: use __free(kfree) to clean up temporary
#    (fetchurl {
#      url = "https://lore.kernel.org/linux-input/20260504-wip-fix-core-v3-4-ce1f11f4968f@kernel.org/raw";
#      hash = "sha256-iNIFE3Lvip24hTv5ftRBGrHaNZSrG9zUEUvIb3QbZMM=";
#    })
#    ./0001-HID-Add-hid-himax-from-chromiumos-third_party-kernel.patch
#    ./0001-HID-hid-himax-master-controller.patch
#    ./0001-dts-mediatek-enable-ciri-touch-support.patch
  ];
  nativeBuildInputs = [ python3 ];
  isModular = true;
  isCompressed = false;
}
