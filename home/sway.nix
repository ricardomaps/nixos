{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.meta) getExe;
in
{
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "${getExe pkgs.noctalia} msg panel-toggle launcher";
      bars = [];
      defaultWorkspace = "workspace number 5";
      gaps = {
        inner = 5;
        outer = 5;
        smartBorders = "on";
      };
      input."*" = {
        tap = "enabled";
        click_method = "clickfinger";
        natural_scroll = "enabled";
        dwt = "enabled";
      };
      seat."*" = {
        hide_cursor = "2000";
      };
      startup = [
        { command = "noctalia"; }
      ];
      keybindings = lib.mkOptionDefault {
        "--locked XF86AudioRaiseVolume" = "exec noctalia msg volume-up";
        "--locked XF86AudioLowerVolume" = "exec noctalia msg volume-down";
        "--locked XF86AudioMute" = "exec noctalia msg volume-mute";
        "--locked XF86MonBrightnessUp" = "exec noctalia msg brightness-up";
        "--locked XF86MonBrightnessDown" = "exec noctalia msg brightness-down";
      };
      window.titlebar = false;
      workspaceAutoBackAndForth = true;
    };
    extraConfig = ''
      animation_duration_ms 250
      corner_radius 12
      shadows enable
      blur enable
      blur_xray disable
      for_window [app_id="Alacritty"] opacity 0.85
    '';
  };
  
  xdg.portal = {
    config.sway = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
      "org.freedesktop.impl.portal.Inhibit" = "none";
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };
}
