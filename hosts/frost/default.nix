#     ______                __
#    / ____/________  _____/ /_
#   / /_  / ___/ __ \/ ___/ __/
#  / __/ / /  / /_/ (__  ) /_
# /_/   /_/   \____/____/\__/
# ---------------------------------------
# Frost host nix configuration by lPhiNix
#
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # Machine
    ./hardware.nix
    inputs.disko.nixosModules.disko
    ./disko.nix

    # Authorized SSH keys (mesh).
    ./keys.nix

    # Services enabled on this host.
    ./services.nix
  ];

  myConfig = {
    username = "phinix";
    profiles = ["server"];
    domain = "frost.local";
    gpu.provider = "amd";
  };

  # Host-specific NixOS options
  time.timeZone = "Europe/Madrid";
  console.keyMap = "es";

  # Trust locally built paths signed by blizz's phix-local signing key.
  nix.settings.trusted-public-keys = [
    "phix-local:qRHMaCyUgx60KnvTfJ6X3t3RxoAMz8pNhZpB920Uy48="
  ];

  # Unlock the root LUKS with the YubiKey FIDO2 token.
  boot.initrd.luks.devices."main".crypttabExtraOpts = ["fido2-device=auto" "token-timeout=60"];

  environment.systemPackages = [pkgs.kitty.terminfo];

  modules.virtualisation.enable = true;
  modules.audio.enable = true;

  system.stateVersion = "26.05";
}
