#     ______                __
#    / ____/________  _____/ /_
#   / /_  / ___/ __ \/ ___/ __/
#  / __/ / /  / /_/ (__  ) /_
# /_/   /_/   \____/____/\__/
# ---------------------------------------
# Frost host nix configuration by lPhiNix
#
{inputs, ...}: {
  imports = [
    # Machine
    ./hardware.nix
    inputs.disko.nixosModules.disko
    ./disko.nix

    # Authorized SSH keys (mesh).
    ./keys.nix
  ];

  myConfig = {
    username = "phinix";
    profiles = ["server"];
    gpu.provider = "amd";
  };

  # Host-specific NixOS options
  time.timeZone = "Europe/Madrid";
  console.keyMap = "es";

  # Unlock the root LUKS with the YubiKey FIDO2 token; passphrase fallback.
  boot.initrd.luks.devices."main".crypttabExtraOpts = ["fido2-device=auto" "token-timeout=5"];

  modules.virtualisation.enable = true;
  modules.audio.enable = true;

  system.stateVersion = "26.05";
}
