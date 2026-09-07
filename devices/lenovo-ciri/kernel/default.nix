{
  mobile-nixos
, fetchgit
, fetchurl
, python3
, ...
}:

mobile-nixos.kernel-builder {
  version = "7.3.0-rc2";
  configfile = ./config.aarch64;

  src = fetchgit {
    url = "https://mirrors.bfsu.edu.cn/git/linux.git";
    rev = "df2908090cda368b01ff43709f51890076c56157";
    hash = "sha256-y/K7PDeY36Rq9T1dJ/FUjvWQ54rm6ZZYZM2/NxK7Wvs=";
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
    # [PATCH] arm64: dts: mediatek: mt8188-geralt: Enlarge SCP core0 memory region
    (fetchurl {
      url = "https://lore.kernel.org/all/20260824090409.203230-1-justin.yeh@mediatek.com/raw";
      hash = "sha256-Q10FwG/IX5Gn4GS47EmvIwRUW/V3awmnsCmQMoYlfCI=";
    })
    # [PATCH v3] arm64: dts: mediatek: Add #{address,size}-cells to Chromium-based /firmware
    (fetchurl {
      url = "https://lore.kernel.org/all/20260904163143.v3.1.I33d1d66d4724587a981f706243cdc2f264670a40@changeid/raw";
      hash = "sha256-DeQhpA+E56aUUZTrt7d7oFdyRoJ9d43tVykTUJSGkGc=";
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
