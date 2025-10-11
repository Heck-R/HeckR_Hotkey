#include <HeckerFunc>

;-------------------------------------------------------

DetectHiddenWindows On
SetTitleMatchMode RegEx

;-------------------------------------------------------

scriptSectionname := "scriptFlowController"
scriptFlowController_sectionName := scriptSectionname

mapConfigHotkeyToFunction(iniFile, scriptSectionName, "runAnyScriptWindow")

mapConfigHotkeyToFunction(iniFile, scriptSectionName, "reloadThisScript")
mapConfigHotkeyToFunction(iniFile, scriptSectionName, "reloadOtherAhkScripts")
mapConfigHotkeyToFunction(iniFile, scriptSectionName, "reloadAllAhkScripts")

mapConfigHotkeyToFunction(iniFile, scriptSectionName, "suspendThisScript")
mapConfigHotkeyToFunction(iniFile, scriptSectionName, "suspendOtherAhkScripts")
mapConfigHotkeyToFunction(iniFile, scriptSectionName, "suspendAllAhkScripts")

mapConfigHotkeyToFunction(iniFile, scriptSectionName, "exitThisScript")
mapConfigHotkeyToFunction(iniFile, scriptSectionName, "exitOtherAhkScripts")
mapConfigHotkeyToFunction(iniFile, scriptSectionName, "exitAllAhkScripts")

;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------

reloadThisScript() {
	Suspend permit

	Reload
}

reloadOtherAhkScripts() {
	Suspend permit

	WinGet, AHKWindows, List, .ahk - AutoHotkey,, %A_ScriptName%
	Loop %AHKWindows% {
		currID := AHKWindows%A_Index%
		PostMessage, 0x111, 65303,,, ahk_id %currID% ;Reload
	}
}

reloadAllAhkScripts() {
	Suspend permit

	reloadOtherAhkScripts()
	reloadThisScript()
}

;-------------------------------------------------------

suspendThisScript() {
	Suspend permit

	Suspend, Toggle
	Pause, Toggle
}

suspendOtherAhkScripts() {
	Suspend permit

	WinGet, AHKWindows, List, .ahk - AutoHotkey,, %A_ScriptName%
	Loop %AHKWindows% {
		currID := AHKWindows%A_Index%
		PostMessage, 0x111, 65305,,, ahk_id %currID% ;Suspend
		PostMessage, 0x111, 65306,,, ahk_id %currID% ;Pause
	}
}

suspendAllAhkScripts() {
	Suspend permit

	suspendOtherAhkScripts()
	suspendThisScript()
}

;-------------------------------------------------------

exitThisScript() {
	ExitApp
}

exitOtherAhkScripts() {
	Suspend permit

	WinGet, AHKWindows, List, .ahk - AutoHotkey,, %A_ScriptName%
	Loop %AHKWindows% {
		currID := AHKWindows%A_Index%
		WinClose ahk_id %currID% ;Exit
	}
}

exitAllAhkScripts() {
	Suspend permit

	exitOtherAhkScripts()
	exitThisScript()
}

;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------

runAnyScriptWindow() {
	global iniFile ;Expected to be pre-set
	global scriptFlowController_sectionName ;Set at the beginning of the script
	global scriptFlowController_runnableScriptsRoot ;Global value to set here
	global scriptFlowController_categoryFolders ;Global value to set here
	global scriptFlowController_categoryFoldersContents ;Global value to set here

	scriptFlowController_runnableScriptsRoot=%A_ScriptDir%\

	IniRead, customscriptFlowController_runnableScriptsRoot, %iniFile%, %scriptFlowController_sectionName%_options, runnableScriptsRoot, %A_Space%
	if(customscriptFlowController_runnableScriptsRoot != ""){
		scriptFlowController_runnableScriptsRoot := regexreplace(customscriptFlowController_runnableScriptsRoot, "^\.(\\|/)", A_ScriptDir . "\")
	}

	scriptFlowController_categoryFoldersContents:=Object()
	scriptFlowController_categoryFolders := ""

	Loop Files, %scriptFlowController_runnableScriptsRoot%\*, D
	{
		currFolder:=A_LoopFileName
		filePaths:=[]
		fileNames:=""

		Loop Files, %scriptFlowController_runnableScriptsRoot%\%currFolder%\*, DF
		{
			if(A_LoopFileExt == "ahk"){
				filePaths.Push(A_LoopFileName)
				fileNames=%fileNames%|%A_LoopFileName%
			} else{
				folderedFile=%A_LoopFileName%\%A_LoopFileName%.ahk
				folderedFilePath=%scriptFlowController_runnableScriptsRoot%\%currFolder%\%folderedFile%
				if(FileExist(folderedFilePath)){
					filePaths.Push(folderedFile)
					fileNames=%fileNames%|%A_LoopFileName%.ahk
				}
			}
		}

		if(0<strlen(fileNames)) {
			scriptFlowController_categoryFoldersContents[currFolder]:=Object()
			scriptFlowController_categoryFoldersContents[currFolder]["fileNames"]:=fileNames
			scriptFlowController_categoryFoldersContents[currFolder]["filePaths"]:=filePaths
			if(scriptFlowController_categoryFolders!="")
				scriptFlowController_categoryFolders.="|"
			scriptFlowController_categoryFolders.=currFolder
		}
	}

	createRunAnyScriptWindow()
}

;------------------------------------------------

createRunAnyScriptWindow() {
	global scriptFlowController_categoryFolders ;Set in runAnyScriptWindow
	global scriptFlowController_categoryFolderChoice ;Global value to set by GUI created here
	global scriptFlowController_categoryFileChoice ;Global value to set by GUI created here

	Gui Destroy

	Gui Add, DropDownList, gSetFileList vscriptFlowController_categoryFolderChoice x24 y12 w128,%scriptFlowController_categoryFolders%
	Gui Add, DropDownList, vscriptFlowController_categoryFileChoice x24 y42 w128 AltSubmit

	Gui Add, Button, x48 y75 w80 h23, &OK

	Gui Show, w177 h106, RunAnyScript
}

;------------------------------------------------

SetFileList() {
	global scriptFlowController_categoryFoldersContents ;Set in runAnyScriptWindow
	global scriptFlowController_categoryFolderChoice ;Set in createRunAnyScriptWindow
	global scriptFlowController_categoryFileChoice ;Set in createRunAnyScriptWindow

	Gui Submit, NoHide
	fold:=scriptFlowController_categoryFoldersContents[scriptFlowController_categoryFolderChoice]["fileNames"]
	GuiControl,, scriptFlowController_categoryFileChoice, %fold%
}

;------------------------------------------------

ButtonOK() {
	global scriptFlowController_runnableScriptsRoot ;Set in runAnyScriptWindow
	global scriptFlowController_categoryFoldersContents ;Set in runAnyScriptWindow
	global scriptFlowController_categoryFolderChoice ;Set in createRunAnyScriptWindow
	global scriptFlowController_categoryFileChoice ;Set in createRunAnyScriptWindow

	Gui submit
	filePath := scriptFlowController_categoryFoldersContents[scriptFlowController_categoryFolderChoice]["filePaths"][scriptFlowController_categoryFileChoice]
	Run %scriptFlowController_runnableScriptsRoot%\%scriptFlowController_categoryFolderChoice%\%filePath%

	Gui Destroy
}

GuiEscape() {
	Gui Destroy
}

GuiClose() {
	Gui Destroy
}
