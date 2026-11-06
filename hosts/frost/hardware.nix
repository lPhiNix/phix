#  _____              _     _   _               _
# |  ___| __ ___  ___| |_  | | | | __ _ _ __ __| |_      ____ _ _ __ ___
# | |_ | '__/ _ \/ __| __| | |_| |/ _` | '__/ _` \ \ /\ / / _` | '__/ _ \
# |  _|| | | (_) \__ \ |_  |  _  | (_| | | | (_| |\ V  V / (_| | | |  __/
# |_|  |_|  \___/|___/\__| |_| |_|\__,_|_|  \__,_| \_/\_/ \__,_|_|  \___|
# -----------------------------------------------------------------------
# Frost hardware nix configuration by lPhiNix
#
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  # Storage/USB needed by the initrd to reach the LUKS container.
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];

  # AMD KVM module for hardware-accelerated VMs.
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  # AMD CPU microcode updates.
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
