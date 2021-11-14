
#include <HeckerFunc>

;-------------------------------------------------------

scriptSectionname := "fileRunner"

fileRunner_hotkeyedCommandsInit(scriptSectionname)

fileRunner_executeStartupCommands(scriptSectionname . "_startupCommands")

;-------------------------------------------------------
;-------------------------------------------------------

; Read list of hotkeyed commands, and create the appropriate hotkey
fileRunner_hotkeyedCommandsInit(scriptSectionname) {
	global iniFile ;Expected to be pre-set

	IniRead, fileRunner_hotkeyedCommandsRaw, %iniFile%, %scriptSectionname%
	
	Loop, Parse, fileRunner_hotkeyedCommandsRaw, `n, %A_Space%`r`t
	{
		commandParts := StrSplit(A_LoopField, "=", " `t")

		commandHotkeyFunction := Func("runWrapper").Bind(commandParts[1])
		Hotkey % commandParts[2], %commandHotkeyFunction%
	}
}

; Read list of startup commands, and execute them
fileRunner_executeStartupCommands(scriptSectionname) {
	global iniFile ;Expected to be pre-set

	IniRead, fileRunner_startupCommandsRaw, %iniFile%, %scriptSectionname%
	
	Loop, Parse, fileRunner_startupCommandsRaw, `n, %A_Space%`r`t
	{
		runWrapper(A_LoopField)
	}
}

;-------------------------------------------------------

runWrapper(command) {
	Run %command%
}