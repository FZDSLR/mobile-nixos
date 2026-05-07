{ lib
, runCommand
, linux-firmware
}:

# The minimum set of firmware files required for the family
runCommand "mt8188-chromeos-firmware" {
  src = linux-firmware;
  meta.license = linux-firmware.meta.license;
} ''
  for firmware in \
    mediatek/mt8188/scp.img \
    mediatek/sof/sof-mt8188.ldc \
    mediatek/sof/sof-mt8188.ri \
    mediatek/sof-tplg/sof-mt8188.tplg \
    mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin \
    mediatek/WIFI_RAM_CODE_MT7961_1.bin \
  ; do
    mkdir -p "$(dirname $out/lib/firmware/$firmware)"
    cp -vrf "$src/lib/firmware/$firmware" $out/lib/firmware/$firmware
  done

  cp -v $out/lib/firmware/mediatek/mt8188/scp.img $out/lib/firmware/mediatek/mt8188/scp_c0.img
''
