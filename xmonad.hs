import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import Solarized

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
        ]
