#    _  ___        ____
#   / |/ (_)_ __  / __ \_______  ___
#  /    / /\ \ / / / _ \/ __/ _ \/ _ \
# /_/|_/_//_\_\ /____/\__/\___/\___/
# -----------------------------------
# OBS nix home package by lPhiNix
#
{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.features.desktop {
    home.packages = [
      (pkgs.writeShellScriptBin "obs" ''
        export LD_LIBRARY_PATH="/run/opengl-driver/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
        exec ${pkgs.obs-studio}/bin/obs "$@"
      '')
    ];
  };
}
