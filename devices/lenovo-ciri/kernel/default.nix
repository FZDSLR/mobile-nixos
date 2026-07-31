{
  mobile-nixos
, fetchFromGitHub
, fetchurl
, python3
, ...
}:

mobile-nixos.kernel-builder {
  version = "7.1.0-rc4";
  configfile = ./config.aarch64;

  src = fetchFromGitHub {
    owner = "torvalds";
    repo = "linux";
    rev = "v7.1-rc4";
    sha256 = "sha256-gPDxpJjCMFJI/yF9LRFdyI17ABkwANlWU4Tmu4Mb5xs=";
  };

  patches = [
    # [PATCH 1/2] dt-bindings: pinctrl: mediatek: mt8188: allow gpio hogs
    (fetchurl {
      url = "https://lore.kernel.org/all/20260504072748.2580172-1-zhengxingda@iscas.ac.cn/raw";
      hash = "sha256-30d961Dcsey2kzgkkthJ2p5GB2hQnUqt8f9DGDtnhcc=";
    })
    # [PATCH] arm64: dts: mediatek: mt8188-geralt: enable touchpad
    (fetchurl {
      url = "https://lore.kernel.org/all/20260504072846.2581096-1-zhengxingda@iscas.ac.cn/raw";
      hash = "sha256-dgVOnNXBsMNOxlkiSImgrAGXw35kITN3nkM2QZSj5Ks=";
    })
    # [PATCH v3 3/4] HID: multitouch: use __free(kfree) to clean up
    (fetchurl {
      url = "https://lore.kernel.org/linux-input/20260504-wip-fix-core-v3-3-ce1f11f4968f@kernel.org/raw";
      hash = "sha256-WFhmmvHn1wtdC5m2I73GaWkEF75aY0JeyFSFTdJ2+7w=";
    })
    # [PATCH v3 4/4] HID: wacom: use __free(kfree) to clean up temporary
    (fetchurl {
      url = "https://lore.kernel.org/linux-input/20260504-wip-fix-core-v3-4-ce1f11f4968f@kernel.org/raw";
      hash = "sha256-iNIFE3Lvip24hTv5ftRBGrHaNZSrG9zUEUvIb3QbZMM=";
    })
    # [PATCH] Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
    (fetchurl {
      url = "https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/raw";
      hash = "sha256-mwSnx1mV1b81xENbK9YQMlu8phzwKU0743QfUMky3jM=";
    })
    # [PATCH] media: mtk-jpeg: cancel workqueue on release for supported platforms only
    (fetchurl {
      url = "https://lore.kernel.org/all/20260401-mtk-jpeg-release-issue-v1-1-2271a1779340@collabora.com/raw";
      hash = "sha256-YLhgGbVxcrlnbcSMrcbSFNMnnbiVhApRbUzaJzoedIU=";
    })
    # [PATCH 1/3] wifi: mt76: mt7921: drop TXRX_NOTIFY on non-mmio buses
    (fetchurl {
      url = "https://lore.kernel.org/all/20260627191336.20223-2-lucid_duck@justthetip.ca/raw";
      hash = "sha256-O/KDOa5uboNZedOgd5OZ+hfbB5l29gE/Uubk1UvzKSY=";
    })
    ./pcie_wifi_bt.diff
    ./0001-HID-Add-hid-himax-from-chromiumos-third_party-kernel.patch
    ./0001-HID-hid-himax-master-controller.patch
    ./0001-dts-mediatek-enable-ciri-touch-support.patch
  ];
  nativeBuildInputs = [ python3 ];
  isModular = true;
  isCompressed = false;
}
