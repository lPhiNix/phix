#  _____              _     ____  _     _
# |  ___| __ ___  ___| |_  |  _ \(_)___| | _____
# | |_ | '__/ _ \/ __| __| | | | | / __| |/ / _ \
# |  _|| | | (_) \__ \ |_  | |_| | \__ \   < (_) |
# |_|  |_|  \___/|___/\__| |____/|_|___/_|\_\___/
# ------------------------------------------------
# Frost disko nix configuration by lPhiNix
#
{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/disk/by-id/nvme-Firebat_FETW34-512G_AA0000000000277";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          name = "ESP";
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = ["fmask=0022" "dmask=0022"];
          };
        };
        luks = {
          name = "luks";
          size = "100%";
          content = {
            type = "luks";
            name = "main";
            settings.allowDiscards = true;
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
              subvolumes = {
                "@" = {
                  mountpoint = "/";
                  mountOptions = ["compress=zstd:3" "noatime" "discard=async"];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = ["compress=zstd:3" "noatime" "discard=async"];
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["compress=zstd:3" "noatime" "discard=async"];
                };
              };
            };
          };
        };
      };
    };
  };
}
