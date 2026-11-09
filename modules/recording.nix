#  _   _ _        ____                        _ _
# | \ | (_)_  __ |  _ \ ___  ___ ___  _ __ __| (_)_ __   __ _
# |  \| | \ \/ / | |_) / _ \/ __/ _ \| '__/ _` | | '_ \ / _` |
# | |\  | |>  <  |  _ <  __/ (_| (_) | | | (_| | | | | | (_| |
# |_| \_|_/_/\_\ |_| \_\___|\___\___/|_|  \__,_|_|_| |_|\__, |
#                                                       |___/
# ------------------------------------------------------------
# Nix recording module by lPhiNix
#
# Provides the kernel-side pieces for recording: a virtual V4L2 camera
# (v4l2loopback) that scrcpy can write to and OBS can read from.
#
{
  config,
  lib,
  ...
}: {
  options.modules.recording.enable =
    lib.mkEnableOption "Recording (v4l2loopback virtual camera)";

  config = lib.mkIf config.modules.recording.enable {
    # Load the out-of-tree module and create /dev/video10 on boot.
    boot.kernelModules = ["v4l2loopback"];
    boot.extraModulePackages = [config.boot.kernelPackages.v4l2loopback];

    # video_nr=10 avoids clashing with webcams/IR cameras on laptops.
    # exclusive_caps=1 makes OBS/Chromium see it as a capture device.
    boot.extraModprobeConfig = "options v4l2loopback video_nr=10 card_label=scrcpy exclusive_caps=1";
  };
}
