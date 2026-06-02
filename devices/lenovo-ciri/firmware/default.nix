{ lib
, runCommand
, linux-firmware
}:

# The minimum set of firmware files required for the family
runCommand "mt8188-chromeos-firmware" {
  src = linux-firmware;
  meta.license = linux-firmware.meta.license;
  firmware_1002 = ./himax_i2chid_1002.bin;
  firmware_1003 = ./himax_i2chid_1003.bin;
  firmware_1004 = ./himax_i2chid_1004.bin;
} ''
  # Copy all required firmware except mediatek/mt8188/scp*.img (handled separately)
  for firmware in \
    mediatek/sof/sof-mt8188.ldc \
    mediatek/sof/sof-mt8188.ri \
    mediatek/sof-tplg/sof-mt8188.tplg \
    mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin \
    mediatek/WIFI_RAM_CODE_MT7961_1.bin \
    mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin \
  ; do
    mkdir -p "$(dirname "$out/lib/firmware/$firmware")"
    cp -vrf "$src/lib/firmware/$firmware" "$out/lib/firmware/$firmware"
  done

  # Handle scp firmware: prefer scp.img, fallback to scp_c0.img
  src_dir="$src/lib/firmware/mediatek/mt8188"
  dst_dir="$out/lib/firmware/mediatek/mt8188"
  mkdir -p "$dst_dir"

  if [ -f "$src_dir/scp.img" ]; then
    scp_src="$src_dir/scp.img"
  elif [ -f "$src_dir/scp_c0.img" ]; then
    scp_src="$src_dir/scp_c0.img"
  else
    echo "Error: neither scp.img nor scp_c0.img found in $src_dir" >&2
    exit 1
  fi

  cp -v "$scp_src" "$dst_dir/scp.img"
  cp -v "$scp_src" "$dst_dir/scp_c0.img"

  cp -v "$firmware_1002" "$out/lib/firmware/himax_i2chid_1002.bin"
  cp -v "$firmware_1003" "$out/lib/firmware/himax_i2chid_1003.bin"
  cp -v "$firmware_1004" "$out/lib/firmware/himax_i2chid_1004.bin"
''
