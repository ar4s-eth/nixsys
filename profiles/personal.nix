{
  config,
  lib,
  pkgs,
  ...
}: {
  user.name = "ar4s";
  hm = {imports = [./home-manager/personal.nix];};
}
