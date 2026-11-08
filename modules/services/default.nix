#  _   _ _        ____                  _
# | \ | (_)_  __ / ___|  ___ _ ____   _(_) ___ ___  ___
# |  \| | \ \/ / \___ \ / _ \ '__\ \ / / |/ __/ _ \/ __|
# | |\  | |>  <   ___) |  __/ |   \ V /| | (_|  __/\__ \
# |_| \_|_/_/\_\ |____/ \___|_|    \_/ |_|\___\___||___/
# ------------------------------------------------------
# Nix services configuration by lPhiNix
#
{lib, ...}: {
  imports =
    builtins.filter
    (f: lib.hasSuffix ".nix" (toString f) && toString f != toString ./default.nix)
    (lib.filesystem.listFilesRecursive ./.);
}
