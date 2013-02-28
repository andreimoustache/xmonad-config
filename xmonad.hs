import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import Solarized

myDmenuSolarized = ""
        ++ " -nb '" ++ solarizedBase03 ++ "'"
        ++ " -nf '" ++ solarizedBase00 ++ "'"
        ++ " -sb '" ++ solarizedBase02 ++ "'"
        ++ " -sf '" ++ solarizedOrange ++ "'"
--
main = do
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , modMask = mod4Mask      -- rebind Mod to Winkey
        , handleEventHook = fullscreenEventHook
        , normalBorderColor = solarizedBase01
        , focusedBorderColor = solarizedRed
        , terminal = "xterm"
        , startupHook = do
                startupHook defaultConfig
                spawn "killall xflux; xflux -l 55 -g 4"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock") -- Mod+Shift+L = lock screen
        , ((mod4Mask, xK_p), spawn $ "dmenu_run " ++ myDmenuSolarized)
        , ((0, xF86XK_AudioMute), spawn "amixer -D pulse set Master toggle")
        , ((0, xF86XK_AudioLowerVolume), spawn "amixer -D pulse set Master 5%- unmute")
        , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -D pulse set Master 5%+ unmute ")
        ]
