#include <HeckerFunc>

;-------------------------------------------------------

scriptSectionName := "fileRunner"

fileRunner_hotkeyCommandsInit(scriptSectionName)

fileRunner_executeStartupCommands(scriptSectionName . "_startupCommands")

;-------------------------------------------------------
;-------------------------------------------------------

; Read list of hotkey commands, and create the appropriate hotkey
fileRunner_hotkeyCommandsInit(scriptSectionName) {
	global iniFile ;Expected to be pre-set

	IniRead, fileRunner_hotkeyCommandsRaw, %iniFile%, %scriptSectionName%

	Loop, Parse, fileRunner_hotkeyCommandsRaw, `n, %A_Space%`r`t
	{
		commandParts := StrSplit(A_LoopField, "=", " `t")

		commandHotkeyFunction := Func("runWrapper").Bind(commandParts[1])
		Hotkey % commandParts[2], %commandHotkeyFunction%
	}
}

; Read list of startup commands, and execute them
fileRunner_executeStartupCommands(scriptSectionName) {
	global iniFile ;Expected to be pre-set

	IniRead, fileRunner_startupCommandsRaw, %iniFile%, %scriptSectionName%

	Loop, Parse, fileRunner_startupCommandsRaw, `n, %A_Space%`r`t
	{
		runWrapper(A_LoopField)
	}
}

;-------------------------------------------------------

runWrapper(command) {
	Run %command%
}
