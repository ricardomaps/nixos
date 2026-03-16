{
  den.aspects.ricmaps.homeManager =
  {
      programs.waybar = {
        enable = false;
        settings = {
          mainBar = {
            "layer" = "top";
            "position" = "top";
            "height" = 24;
            "spacing" = 5;

            "modules-left"= ["hyprland/workspaces"];
            "modules-center"= ["clock"];
            "modules-right"= ["wireplumber" "battery" "memory" "temperature" "idle_inhibitor" "network" "bluetooth" "tray"];

            "hyprland/workspaces"= {
                "format"= "<span size='larger'>{icon}</span>";
                "on-click"= "activate";
                "format-icons"= {
                    "active"= builtins.fromJSON '' "\uF444" '';
                    "default"= builtins.fromJSON '' "\uF4C3" '';
                };
                "icon-size"= 10;
                "sort-by-number"= true;
                "persistent-workspaces"= {
                    "1"= [];
                    "2"= [];
                    "3"= [];
                    "4"= [];
                    "5"= [];
                };
            };

            "clock"= {
                "format"= "{=%d.%m.%Y | %H=%M}";
            };

            "wireplumber"= {
                "format"= builtins.fromJSON '' "\udb81\udd7e  {volume}%" '';
                "max-volume"= 100;
                "scroll-step"= 5;
            };

            "battery"= {
                "interval"= 60;
                "format"= "{icon}  {capacity}%";
                "format-icons"= [ (builtins.fromJSON '' "\uF244" '') (builtins.fromJSON '' "\uF243" '') (builtins.fromJSON '' "\uF242" '') (builtins.fromJSON '' "\uF241" '') (builtins.fromJSON '' "\uF240" '')];
            };

            "memory"= {
                "interval"= 30;
                "format"= builtins.fromJSON '' "\uF4BC  {percentage}%" '';
            };

            "temperature"= {
                "format"= "{temperatureC}°C";
            };

            "network"= {
                "format"= "";
                "format-ethernet"= builtins.fromJSON '' "\udb83\udc9d" '';
                "format-wifi"= "{icon}";
                "format-disconnected"= builtins.fromJSON '' "\udb83\udc9c" '';
                "format-icons"= [(builtins.fromJSON '' "\uDB82\uDD2F" '') (builtins.fromJSON '' "\uDB82\uDD1F" '') (builtins.fromJSON '' "\uDB82\uDD22" '') (builtins.fromJSON '' "\uDB82\uDD25" '') (builtins.fromJSON '' "\uDB82\uDD28" '')];
                "tooltip-format-wifi"= "{essid} ({signalStrength}%)";
                "tooltip-format-ethernet"= "{ifname}";
                "tooltip-format-disconnected"= "Disconnected";
            };

            "bluetooth"= {
                "format"= builtins.fromJSON '' "\udb80\udcaf" '';
                "format-disabled"= builtins.fromJSON '' "\uDB80\uDCB2" '';
                "format-connected"= builtins.fromJSON '' "\uDB80\uDCB1" '';
                "tooltip-format"= "{controller_alias}\t{controller_address}";
                "tooltip-format-connected"= "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
                "tooltip-format-enumerate-connected"= "{device_alias}\t{device_address}";
            };

            "hyprland/language"= {
                "format"= "{short}";
            };

            "tray"= {
                "icon-size"= 16;
                "spacing"= 16;
            };

            "idle_inhibitor"= {
                "format"= "{icon}";
                "format-icons"= {
                    "activated"= builtins.fromJSON '' "\uDB80\uDD76" '';
                    "deactivated"= builtins.fromJSON '' "\uDB83\uDFAA" '';
                };
            };
          };
        };
       style = ''
          @define-color foreground #FFFFFF;
    
          @define-color foreground-inactive #FFFFFF;
          @define-color background #000000;

          * {
              font-family: JetBrainsMono Nerd Font;
              font-size: 17px;
              padding: 0;
              margin: 0;
          }

          #waybar {
              color: @foreground;
              background-color: @background;
          }

          #workspaces button {
              color: @foreground;
              padding-left: 0.7em;
          }

          #workspaces button.empty {
              color: @foreground-inactive;
          }

          #memory,
          #custom-platform-profile {
              padding-left: 1em
          }

          #wireplumber,
          #battery,
          #idle_inhibitor,
          #language,
          #network,
          #bluetooth,
          #temperature,
          #tray {
              padding-right: 1em 
          }
       '';
      };
    };
}
