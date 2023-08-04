-- This file is a configuration for xmonad.
-- It is written in Haskell, by Joseph Krol and Chatgpt on the 4th of august 2023.
-- It adds a bunch of shortcuts, like mod + o to open my browser,
-- mod + f to enter fullscreen-mode and mod + p to open rofi instead of dmenu.
-- It also adds gaps and works with my custom xmobar config.
-- It start my /home/<usr>/.autostart.sh script which runs whenever xmonad is started.
-- File location: /home/<usr>/.xmonad/xmonad.hs

-- After altering this file, xmonad needs to be recompiled and restarted for the changes to be implemented.
-- To do this run: xmonad --recompile; xmonad --restart

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import System.IO
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.SetWMName

mySB = statusBarProp "xmobar" (pure xmobarPP)

myTerminal = "alacritty" -- Replace with your preferred terminal emulator

myModMask = mod1Mask -- Sets the mod key to Alt

main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar" -- Replace with the path to your xmobar config if needed

    xmonad $ withEasySB mySB defToggleStrutsKey def
        { manageHook = manageDocks <+> manageHook def
        , layoutHook = myLayout -- Use the custom layout with gaps and Full modifier
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50 -- Modify colors and length as desired
                        }
        , modMask = myModMask
        , terminal = myTerminal
        , borderWidth = 2
        , normalBorderColor = "#000000" -- Modify as desired
        , focusedBorderColor = "#7222CD" -- Modify as desired
        , startupHook = myStartupHook  -- Specify your custom startup hook
        } `additionalKeys`
        [ ((myModMask, xK_p), spawn "rofi -show run")
        , ((myModMask, xK_o), spawn "firefox")
        , ((myModMask, xK_f), sendMessage ToggleStruts) -- Enable fullscreen mode for focused window
        ]

-- Custom layout with smart spacing (gaps) and fullscreen capability
myLayout = smartSpacing gapSize $ avoidStruts $ layoutHook def
  where
    -- Define the gap size (in pixels)
    gapSize = 8

-- Custom startup hook to execute the autostart script
myStartupHook :: X ()
myStartupHook = do
    spawn "/home/joseph/.autostart.sh"
