#Requires AutoHotkey v1

#SingleInstance Force

;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------

SetDefaultMouseSpeed 0
SetBatchLines -1
ListLines Off

;------------------

iniFile := regexreplace(A_ScriptFullPath, "\.[^.]+$", ".ini")

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
