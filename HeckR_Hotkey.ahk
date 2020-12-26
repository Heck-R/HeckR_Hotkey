
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
; 
; sectionName - Ini section where the hotkey is set
; iniFunctionName - Contains the ini key name for the hotkey, and the name of the function to be used. Can be one of the following formats:
;   - "iniAndFunctionName": In case this is a string, the ini key name and the function name has to be identical.
;   - ["iniKey", "functionName"]: An array can be defined, in which case the ini key name and the function name can be different.
;   - ["iniKey", "functionName", "releaseFunctionName"]: If a non empty third string is also passed in the array, the release of the hotkey will trigger the function with the provided name.
; paramsToBind - Parameters to bind to the hotkey function(s)
; threadNum - Number of max parallel execution of the same hotkey
iniFunctionConnecter(sectionName, iniFunctionName, paramsToBind := "", threadNum := 1) {
    global

    ; Handle iniFunctionName being either a string or an array
    iniKey := iniFunctionName
    functionName := iniFunctionName
    if (isObject(iniFunctionName)) {
        iniKey := iniFunctionName[1]
        functionName := iniFunctionName[2]
    }

    ; Key combination for the hotkey
    IniRead, toBeHotkey, %iniFile% , %sectionName%, %iniKey%, %A_Space%

    ; If a key combination is defined, create the hotkey
    if (toBeHotkey != "") {
        ; Create function reference bor binding
        hotkeyFunction := Func(functionName)
        
        ; Bind parameters
        allParamsToBind := []
        if (paramsToBind != "")
            for paramIndex, paramValue in paramsToBind {
                allParamsToBind.Push(paramValue)
            }
        
        ; Bind key combination if parameters are still needed
        if (hotkeyFunction.MinParams > allParamsToBind.MaxIndex())
            allParamsToBind.Push(toBeHotkey)
        
        ; Create hotkey
        hotkeyFunction := hotkeyFunction.Bind(allParamsToBind*)
        Hotkey %toBeHotkey%, %hotkeyFunction%, T%threadNum%
        
        ; Create release hotkey
        if (iniFunctionName[3] != "") {
            releaseFunction := Func(iniFunctionName[3])
            releaseFunction := releaseFunction.Bind(allParamsToBind*)
            Hotkey %toBeHotkey% up, %releaseFunction%, T%threadNum%
        }
    }
}

;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------

#include %A_ScriptDir%\components

#include autoFire.ahk
#include cursorMover.ahk
#include simpleActionRemapper.ahk
#include volumeController.ahk
#include helperTooltipController.ahk
#include uncategorized.ahk

#include scriptFlowController.ahk
#include fileRunner.ahk
