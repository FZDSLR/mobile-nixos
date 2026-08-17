{
  mobile-nixos
, fetchgit
, fetchurl
, python3
, ...
}:

mobile-nixos.kernel-builder {
  version = "7.2";
  configfile = ./config.aarch64;

  src = fetchurl {
    url = "mirror://kernel/linux/kernel/v7.x/linux-7.2.tar.xz";
    hash = "sha256-+f7z0UwN9TgZAm9L50RZg1wqCw3L9bW72eoZ8IKUArM=";
  };

  patches = [
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
    # [PATCH wireless] wifi: mt76: mt7921: check drv_pmctrl return in the PCIe reset path
    (fetchurl {
      url = "https://lore.kernel.org/all/20260809012309.43657-1-lucid_duck@justthetip.ca/raw";
      hash = "sha256-cpIh+ZJOldp7sMRgpdLz5ou2UbexNLAfAdBNIB1Pbto=";
    })
    # [PATCH wireless] wifi: mt76: mt7921: fix array-index-out-of-bounds in mt7921_load_clc()
    (fetchurl {
      url = "https://lore.kernel.org/all/20260815103312.34080-1-mikhail.v.gavrilov@gmail.com/raw";
      hash = "sha256-BeqFpNaGZhwp4bxLEicFqW4dh0TA1iaO5P/7UKNJwrE=";
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
