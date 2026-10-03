{ lib, ... }:
{
  environment.defaultPackages = lib.mkForce [];
  programs.nano.enable = lib.mkForce false;
  programs.less.enable = lib.mkForce false;
  # pointless since i don't use bash as my interactive shell
  programs.bash.completion.enable = lib.mkForce false;
  programs.command-not-found.enable = lib.mkForce false;
  services.speechd.enable = lib.mkForce false;
  # i only look up stuff online, sue me, i really dislike man/info pages
  documentation.enable = lib.mkForce false;
}
