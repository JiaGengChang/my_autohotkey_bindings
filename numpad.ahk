; CapslockNumpad 1.1.0 (2019-12-30)
; Desi Quintans
; https://github.com/DesiQuintans/CapslockNumpad

; An Autohotkey script for Windows that lets you emulate a numeric keypad
; (numpad) on a keyboard that doesn't have it. Both NumLock modes are usable.

; Press Ctrl + CapsLock to toggle the numpad on and off.
; Press \ (above Enter) to toggle NumLock.

; 789  ->  789
; uio  ->  456
; jkl  ->  123
; 0./  ->  0./
; *-=  ->  *-+



; ======================================

#NoEnv
#SingleInstance force
SetWorkingDir %A_ScriptDir%



; - Global vars and other setup ------------------------------

SetNumLockState, On
Suspend, On

numlock_on()
{
    return GetKeyState("NumLock", "T")
}

update_traytip()
{
    tray_text := "CapsLock Numpad`nToggle with Ctrl + CapsLock"

    if (numlock_on() == true) {
        numlock_state := "NumLock is ON"
    } else {
        numlock_state := "NumLock is OFF"
    }

    Menu, Tray, Tip, %tray_text%`n`n%numlock_state%
}

update_traytip()

; - Ctrl + CapsLock toggling ---------------------------------

!CapsLock::
    Suspend, Toggle
    SoundPlay, *48
    update_traytip()
    Return



; - Rebinds --------------------------------------------------

;; Common to both numlock states:
k::Numpad5
/::NumpadDiv
=::NumpadAdd
-::NumpadSub
+8::NumpadMult
h::Numpad0
0::Numpad0
n::NumpadDot  ; Period/Greater-Than key

SC02B::           ; Backslash/Pipe
    Send {NumLock}
    SoundPlay, *64
    update_traytip()
    Return



#If (numlock_on() == true)
    u::Numpad7
    i::Numpad8
    o::Numpad9

    j::Numpad4
    l::Numpad6

    m::Numpad1
    ,::Numpad2
    .::Numpad3


#If (numlock_on() == false)
    u::NumpadHome
    i::NumpadUp
    o::NumpadPgUp

    j::NumpadLeft
    l::NumpadRight

    m::NumpadEnd
    ,::NumpadDown
    .::NumpadPgDn