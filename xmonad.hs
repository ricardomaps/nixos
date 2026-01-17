import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Operations (unGrab)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Gaps


main :: IO ()
main = xmonad
       . ewmhFullscreen
       . ewmh
       . docks
       . xmobarProp
       . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
       $ myConfig

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

myConfig = def
  { modMask = mod4Mask
   ,terminal = "kitty"
   ,manageHook = myManageHook
   ,layoutHook = myLayout
   ,workspaces = myWorkspaces
   ,borderWidth = myBorderWidth
  }
  `additionalKeysP` myKeys

myStartupHook = do
  spawnOnce "feh --bg-fill --no-fehbg ~/Pictures/Wallpapers/nord/nord_mountains.png"

myBorderWidth = 2

myKeys =
  [ ("M-C-s", unGrab *> spawn "scrot -s")
   ,("<XF86MonBrightnessUp>", spawn "brightnessctl set +5%")
   ,("<XF86MonBrightnessDown>", spawn "brightnessctl set 5%-")
   ,("<XF86AudioRaiseVolume>", spawn "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
   ,("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
   ,("<XF86AudioMute>",  spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
   ,("<XF86AudioNext>", spawn "playerctl next")
   ,("<XF86AudioPause>", spawn "playerctl play-pause")
   ,("<XF86AudioPlay>", spawn "playerctl play-pause")
   ,("<XF86AudioPrev>", spawn "playerctl previous")
   ,("M-b", spawn "librewolf")
  ]

myWorkspaces = ["1:web", "2:term", "3:code"] ++ map show [4..9]

myLayout = avoidStruts . smartBorders . gaps [(U, 5), (R, 5), (L, 5), (D, 5)] $ layouts

layouts = tiled ||| Mirror tiled ||| Full
  where
    tiled   = renamed [Replace "Tall"] . spacing 5 $ Tall nmaster delta ratio
    nmaster = 1      -- Default number of windows in the master pane
    ratio   = 1/2    -- Default proportion of screen occupied by master pane
    delta   = 3/100  -- Percent of screen to increment by when resizing panes

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
     ,isDialog                 --> doFloat
    ]

