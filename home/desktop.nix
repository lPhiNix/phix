#    _  ___        ___          __   __
#   / |/ (_)_ __  / _ \___ ___ / /__/ /____  ___
#  /    / /\ \ / / // / -_|_-</  '_/ __/ _ \/ _ \
# /_/|_/_//_\_\ /____/\__/___/_/\_\\__/\___/ .__/
#                                         /_/
# -----------------------------------------------
# Desktop nix home packages by lPhiNix
#
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.mkIf config.features.desktop (with pkgs; [
    kitty # Terminal

    nautilus # File manager
    brave # Web browser
    pkgs.unstablePkgs.tor-browser # Tor Browser (anonymity)
    pkgs.unstablePkgs.vscode # Code editor (GUI IDE)
    obsidian # Markdown vault
    filen-desktop # Filen cloud desktop app (encrypted drive)
    obs-studio # Screen recording and streaming
    gimp # Image editing (raster/photo)
    inkscape # Vector illustration / SVG
    kdePackages.kdenlive # Video editing (MP4/H.264/AAC, NVENC)
    pkgs.unstablePkgs.lmstudio # Local LLM desktop app
    quickemu # Quick VMs (quickget/quickemu CLI) (Need GUI)
    spice-gtk # VM viewer (SPICE client, spicy)

    libnotify # Desktop notifications
    libsecret # Secret Service client
    wl-clipboard # Wayland clipboard
    cliphist # Clipboard history
    hyprpicker # Screen color picker
    ydotool # Input automation (keyboard/mouse)
    gnome-keyring # Secrets & password keyring

    gammastep # Screen color temperature
    pwvucontrol # Per-app volume control

    papirus-icon-theme # Papirus icons
    papirus-folders # Papirus folder color tool
    adwaita-icon-theme # Adwaita (GNOME) icons
    kdePackages.breeze # KDE Breeze cursor theme (breeze_cursors)
    nerd-fonts.jetbrains-mono # JetBrains Mono with Nerd glyphs
  ]);
}
