{inputs, ...}:

{
  imports = [
    inputs.mango.homeModules.mango
  ];

  wayland.windowManager.mango = {
    enable = true;
  };
}
