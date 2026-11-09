#    _  ___        ____  ___  ____
#   / |/ (_)_ __  / __ \/ _ )/ __/
#  /    / /\ \ / / /_/ / _  |\ \
# /_/|_/_//_\_\  \____/____/___/
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
    xdg.desktopEntries."com.obsproject.Studio" = {
      name = "OBS Studio";
      genericName = "Streaming/Recording Software";
      comment = "Free and Open Source Streaming/Recording Software";
      exec = "obs %U";
      icon = "${pkgs.obs-studio}/share/icons/hicolor/256x256/apps/com.obsproject.Studio.png";
      terminal = false;
      categories = ["AudioVideo" "Recorder"];
      startupNotify = true;
    };
  };
}
