import System.IO
import XMonad
import qualified XMonad.StackSet as W

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.Grid

import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Dmenu

myManageHooks = composeAll [ isFullscreen --> (doF W.focusDown <+> doFullFloat) 
                            , className =? "google-chrome" --> doShift "1" 
                            , isDialog		--> doFloat
                            , className =? "Gvim" --> doShift "2" 
                            , className =? "Xmessage"  --> doFloat 
                            , manageDocks ]

myLayoutHooks = smartBorders( avoidStruts  $  myLayouts )

myLayouts = Full  ||| tall ||| Mirror tall ||| Grid |||  tabbed shrinkText defaultTheme
tall = Tall 1 (3/100) (1/2)

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar.hs"
    xmonad $ defaultConfig
        { manageHook = myManageHooks <+> manageDocks <+> manageHook defaultConfig
        , layoutHook = layoutHintsToCenter $ myLayoutHooks 
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 100
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , terminal = "xterm -bg black -fg white zsh"
        , focusFollowsMouse = False
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
		, ((mod4Mask .|. shiftMask, xK_s), spawn "~/.xmonad/single.sh")
		, ((mod4Mask .|. shiftMask, xK_d), spawn "~/.xmonad/dual.sh")
		, ((mod4Mask .|. shiftMask, xK_g), spawn "google-chrome")
        , ((0, xK_Print), spawn "scrot")
        -- XF86AudioLowerVolume
        , ((0            , 0x1008ff11), spawn "aumix -v -2")
        -- XF86AudioRaiseVolume
        , ((0            , 0x1008ff13), spawn "aumix -v +2")
        -- XF86AudioMute
        , ((0            , 0x1008ff12), spawn "amixer -q set PCM toggle")
        ]
