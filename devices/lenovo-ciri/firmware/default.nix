{ lib
, runCommand
, linux-firmware
}:

# The minimum set of firmware files required for the family
runCommand "mt8183-chromeos-firmware" {
  src = linux-firmware;
  meta.license = linux-firmware.meta.license;
} ''
  for firmware in \
    mediatek/mt8188/scp_c0.img \
  ; do
    mkdir -p "$(dirname $out/lib/firmware/$firmware)"
    cp -vrf "$src/lib/firmware/$firmware" $out/lib/firmware/$firmware
  done
''
