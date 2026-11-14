#    _  ___        _   ___________
#   / |/ (_)_ __  | | / / __/ ___/
#  /    / /\ \ /  | |/ /\ \/ /__
# /_/|_/_//_\_\   |___/___/\___/
# -----------------------------------
# VSCodium nix home config by lPhiNix
#
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;

  # Extensions from Open VSX, maintained by nix-community.
  openvsx = inputs.nix-vscode-extensions.extensions.${system}.open-vsx;

  # Caelestia's theme extension ships as a VSIX in its dots repository.
  caelestiaDir = "${inputs.caelestia-dots}/vscode/caelestia-vscode-integration";
  caelestiaPkg = builtins.fromJSON (builtins.readFile "${caelestiaDir}/package.json");

  caelestia =
    (pkgs.vscode-utils.buildVscodeExtension {
      pname = caelestiaPkg.name;
      inherit (caelestiaPkg) version;

      vscodeExtPublisher = caelestiaPkg.publisher;
      vscodeExtName = caelestiaPkg.name;
      vscodeExtUniqueId = "${caelestiaPkg.publisher}.${caelestiaPkg.name}";

      src = "${caelestiaDir}/${caelestiaPkg.name}-${caelestiaPkg.version}.vsix";
    }).overrideAttrs (old: {
      # The extension rewrites its own theme file on activation. That path is
      # read-only in the Nix store, so point it at writable user state instead.
      postInstall =
        (old.postInstall or "")
        + ''
          ln -sfn "${config.home.homeDirectory}/.local/state/caelestia/vscode-theme.json" \
            "$out/share/vscode/extensions/${caelestiaPkg.publisher}.${caelestiaPkg.name}/themes/caelestia.json"
        '';
    });
in {
  config = lib.mkIf config.features.desktop {
    programs.vscodium = {
      enable = true;
      mutableExtensionsDir = false;

      package = pkgs.unstablePkgs.vscodium.override {
        commandLineArgs = "--ozone-platform-hint=wayland --gtk-version=4 --ignore-gpu-blocklist --enable-features=TouchpadOverscrollHistoryNavigation --enable-wayland-ime --password-store=gnome-libsecret";
      };

      profiles.default = {
        extensions =
          (with openvsx; [
            bbenoist.nix
            esbenp.prettier-vscode
            formulahendry.code-runner
            miguelsolorio.fluent-icons
            miguelsolorio.symbols
            oracle.oracle-java
            charliermarsh.ruff
            llvm-vs-code-extensions.vscode-clangd
            detachhead.basedpyright
          ])
          ++ lib.optional (config.programs.caelestia.enable or false) caelestia;
      };
    };
  };
}
