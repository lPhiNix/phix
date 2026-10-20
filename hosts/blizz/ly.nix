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
  lightPalette = pkgs.writeText "ly-blizz-light-palette" ''
    #000000
    #aa0000
    #00aa00
    #aa5500
    #0000aa
    #fafafa
    #00aaaa
    #ffffff
    #555555
    #ff5555
    #55ff55
    #ffff55
    #5555ff
    #d0d0d0
    #55ffff
    #ffffff
  '';
in {
  services.displayManager.ly.settings = {
    # Light theme: truecolor white maps to palette index 7 (pure white above),
    # black text uses the black palette index.
    bg = "0x00ffffff";
    fg = "0x20000000";
    border_fg = "0x20000000";
    error_bg = "0x00ffffff";
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
    cmatrix_fg = "0x20000000";
    cmatrix_head_col = "0x20000000";
    colormix_col1 = "0x00ff00ff";
    colormix_col2 = "0x00ff30ff";
    colormix_col3 = "0x00ff60ff";

    # Switch tty1 to the inverted palette right before ly draws, so the
    # inversion applies to ly only and the boot console is left untouched.
    start_cmd = "${pkgs.kbd}/bin/setvtrgb -C /dev/tty1 ${lightPalette}";
  };
}
