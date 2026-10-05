#    ___  ___          __
#   / _ )/ (_)_____   / /  __ __
#  / _  / / /_ /_ /  / /__/ // /
# /____/_/_//__/__/ /____/\_, /
#                        /___/
# -----------------------------------------------
# Blizz ly (display manager) nix theme by lPhiNix
#
{pkgs, ...}: let
  # Inverted (complemented) palette, applied to tty1 only when ly starts.
  # On the Linux VT the kernel quantizes ly's colors to palette indices, so
  # keeping noir's ly colors and flipping the palette yields the full
  # inversion (white background, black text) without touching the boot.
  lyPalette = pkgs.writeText "ly-blizz-palette" ''
    #ffffff
    #55ffff
    #ff55ff
    #55aaff
    #ffff55
    #55ff55
    #ff5555
    #555555
    #e5e5e5
    #00aaaa
    #aa00aa
    #0000aa
    #aaaaaa
    #00aa00
    #aa0000
    #000000
  '';
in {
  services.displayManager.ly.settings = {
    # Same as noir: the kernel maps these to palette indices and lyPalette
    # inverts them at startup.
    bg = "0x000a0f0f";
    fg = "0x00dce8e6";
    border_fg = "0x009bd0cc";
    error_fg = "0x01fa746f";

    # Card
    blank_box = true;
    box_title = "caelestia";
    text_in_center = true;

    # Clocks
    bigclock = "en";
    bigclock_12hr = false;
    clock = "%a %H:%M";

    # Hidden info
    hide_version_string = true;
    hide_key_hints = true;
    hide_keyboard_locks = true;

    # Input
    clear_password = true;

    # Colormix animation (noir); the inverted palette makes it read light.
    animation = "colormix";
    cmatrix_fg = "0x006d7876";
    cmatrix_head_col = "0x00a2adac";
    colormix_col1 = "0x20000000";
    colormix_col2 = "0x00010101";
    colormix_col3 = "0x00020202";

    # Switch tty1 to the inverted palette right before ly draws, so the
    # inversion applies to ly only and the boot console is left untouched.
    start_cmd = "${pkgs.kbd}/bin/setvtrgb -C /dev/tty1 ${lyPalette}";
  };
}
