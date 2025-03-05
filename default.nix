{ pkgs, ...}:
  pkgs.buildGoModule {
    name = "calyx-device-flasher";
    src = ./device-flasher;
    nativeBuildInputs = [pkgs.android-tools];
    vendorHash = null;
  }
