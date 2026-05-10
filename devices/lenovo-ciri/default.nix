{ config, lib, pkgs, ... }:

{
  imports = [
    ../families/mainline-chromeos
  ];

  mobile.hardware = {
    soc = "mediatek-mt8188";
    ram = lib.mkDefault (1024 * 8);
  };

  mobile.boot.stage-1 = {
    kernel.package = pkgs.callPackage ./kernel {};
  };

  mobile.system.depthcharge.kpart = {
    dtbs = "${config.mobile.boot.stage-1.kernel.package}/dtbs/mediatek";
  };

  # Serial console on ttyS0, using a suzyqable or equivalent.
  mobile.boot.serialConsole = "ttyS0,115200n8";

  systemd.services."serial-getty@ttyS0" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };

  mobile.device.firmware = pkgs.callPackage ./firmware {};
  mobile.boot.stage-1.firmware = [
    config.mobile.device.firmware
  ];
  mobile.kernel.structuredConfig = [
    (helpers: with helpers; {
      # Undeclared dependency needed for some
      # hid-over-i2c trackpads (e.g. acer-juniper)
      HID_RMI = yes;
      SERIO = yes;
    })
  ];

  mobile.device.name = "lenovo-ciri";
  mobile.device.identity = {
    name = "Chromebook Duet 11";
    manufacturer = "Lenovo";
  };
  mobile.device.supportLevel = "supported";
  mobile.hardware = {
    screen = {
      # Panel is portrait CW compared to keyboard attachment.
      width = 1200; height = 1920;
    };
  };

  # Ensure orientation match with keyboard.
  services.udev.extraHwdb = lib.mkBefore ''
    sensor:modalias:platform:*
      ACCEL_MOUNT_MATRIX=0, 1, 0; -1, 0, 0; 0, 0, -1
  '';

  mobile.boot.stage-1.kernel.modules = [ "sbs-battery" ];
}
