#    _  ___        ____                    _
#   / |/ (_)_ __  / __/__  _______ ____   (_)__
#  /    / /\ \ / / _// _ \/ __/ _ `/ -_) / / _ \
# /_/|_/_//_\_\ /_/  \___/_/  \_, /\__/_/ /\___/
#                            /___/   |___/
# ----------------------------------------------
# Forgejo nix service module by lPhiNix
#
{
  config,
  lib,
  ...
}: {
  options.modules.services.forgejo.enable =
    lib.mkEnableOption "Forgejo";

  config = lib.mkIf config.modules.services.forgejo.enable {
    services.forgejo = {
      enable = true;
      stateDir = "/var/lib/forgejo"; # NVMe for now
      database.type = "sqlite3";

      settings.server = {
        DOMAIN = config.myConfig.domain;
        ROOT_URL = "http://${config.myConfig.domain}:3000/";
        HTTP_PORT = 3000;

        # HTTP only for now; Git over SSH can be added later.
        DISABLE_SSH = true;
      };

      settings.service.DISABLE_REGISTRATION = true;
    };

    networking.firewall.allowedTCPPorts = [3000];
  };
}
