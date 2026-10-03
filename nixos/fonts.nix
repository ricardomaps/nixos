{ pkgs, ... }:
{
  fonts = {
    # despite being named "default", this is not enabled by default! 
    enableDefaultPackages = false;
    packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.monoid
      nerd-fonts.fira-mono
      nerd-fonts.martian-mono
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
    ];
  };  
}
