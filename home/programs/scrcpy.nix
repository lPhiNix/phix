#    _  ___        ____
#   / |/ (_)_ __  / __/______________  __ __
#  /    / /\ \ / _\ \/ __/ __/ __/ _ \/ // /
# /_/|_/_//_\_\ /___/\__/_/  \__/ .__/\_, /
#                              /_/   /___/
# ------------------------------------------
# Scrcpy nix home packages by lPhiNix
#
# Bridges the phone to the PC: scrcpy mirrors the device over USB and can
# push its video into the v4l2loopback device (/dev/video10) for OBS.
#
{
  lib,
  pkgs,
  ...
}: let
  # Shared flags: duplicate audio to phone and PC, keep the phone awake.
  flags = [
    "--stay-awake"
    "--max-fps=60"
    "--video-bit-rate=20M"
    "--audio-source=playback"
    "--audio-dup"
  ];

  scrcpy-mirror = pkgs.writeShellScriptBin "scrcpy-mirror" ''
    exec ${pkgs.scrcpy}/bin/scrcpy ${lib.escapeShellArgs flags} "$@"
  '';

  scrcpy-obs = pkgs.writeShellScriptBin "scrcpy-obs" ''
    exec ${pkgs.scrcpy}/bin/scrcpy ${lib.escapeShellArgs flags} \
      --v4l2-sink=/dev/video10 --no-video-playback "$@"
  '';

  scrcpy-record = pkgs.writeShellScriptBin "scrcpy-record" ''
    mkdir -p "$HOME/Videos"
    exec ${pkgs.scrcpy}/bin/scrcpy ${lib.escapeShellArgs flags} \
      --record="$HOME/Videos/scrcpy-$(date +%Y%m%d-%H%M%S).mkv" "$@"
  '';
in {
  home.packages = [
    pkgs.scrcpy
    scrcpy-mirror
    scrcpy-obs
    scrcpy-record
  ];
}
