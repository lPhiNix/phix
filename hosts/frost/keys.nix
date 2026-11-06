#    ____             __    __ __
#   / __/______  ___ / /_  / //_/__ __ _____
#  / _// __/ _ \(_-</ __/ / ,< / -_) // (_-<
# /_/ /_/  \___/___/\__/ /_/|_|\__/\_, /___/
#                                 /___/
# ------------------------------------------
# Frost authorized SSH keys by lPhiNix
#
{config, ...}: {
  users.users.${config.myConfig.username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5u3hCEEc7yx7wqEBUZjGMLnNfli4VMs2Dhzl8PFzvr phinix@noir" # public half of noir's user key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDayb7sHHMBtdv49ApB+ivY85Aod3luFtat9BUmUQ+6z phinix@blizz" # public half of blizz's user key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhikaz2QX8JP+3ImqAYtMkmsuHHLRwbU0FdXIyb9+2t phinix@frost" # public half of frost's user key
  ];
}
