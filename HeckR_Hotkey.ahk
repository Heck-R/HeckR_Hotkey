
#SingleInstance Force

;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------

SetDefaultMouseSpeed 0
SetBatchLines -1
ListLines Off

;------------------

iniFile := regexreplace(A_ScriptFullPath, "\.[^.]+$",".ini")

; Create a hotkey with the keycombination defined in the global iniFile
; The function name and the ini key has to be the same
iniFunctionConnecter(sectionName, iniFunctionName, paramsToBind := "", threadNum := 1) {
    global

    ; Key combination for the hotkey
    IniRead, toBeHotkey, %iniFile% , %sectionName%, %iniFunctionName%, %A_Space%
    
    ; If a key combination is defined, create the hotkey
    if (toBeHotkey != "") {
        ; Create function reference bor binding
        hotkeyFunction := Func(iniFunctionName)

        ; Bind parameters
        if (paramsToBind != "")
            for paramIndex, paramValue in paramsToBind
                hotkeyFunction := hotkeyFunction.Bind(paramValue)
        
        ; Bind key combination if parameters are still needed
        if (hotkeyFunction.MinParams > 0)
            hotkeyFunction := hotkeyFunction.Bind(toBeHotkey)
        
        ; Create hotkey
        Hotkey %toBeHotkey%, %hotkeyFunction%, T%threadNum%
    }
}

;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------

#include %A_ScriptDir%\components

#include autoClicker.ahk
#include cursorMover.ahk
#include simpleActionRemapper.ahk
#include volumeController.ahk
#include helperTooltipController.ahk
#include uncategorized.ahk
#include scriptFlowController.ahk
