
#include <HeckerFunc>

;-------------------------------------------------------

CoordMode, ToolTip, Screen

;-------------------------------------------------------

scriptSectionname := "helperTooltipController"

helperTooltipController_initContent()

mapConfigHotkeyToFunction(iniFile, scriptSectionName, "toggleHelperTooltip")

;-------------------------------------------------------
;-------------------------------------------------------

helperTooltipController_initContent() {
	global iniFile ;Expected to be pre-set
	global helperTooltipContent ;Global value to set here

	helperTooltipContent := ""

	IniRead, sectionNames, %iniFile%
	Loop, Parse, sectionNames, `n
	{
		if (InStr(A_LoopField, "_"))
			Continue
		
		helperTooltipContent .= A_LoopField . ":`n`n"

		IniRead, sectionContent, %iniFile%, %A_LoopField%
		helperTooltipContent .= sectionContent . "`n`n`n"
	}
}

toggleHelperTooltip() {
	global helperTooltipContent ;Set in helperTooltipController_initContent
	global showToolTip ;Keeps local parameter's value across calls

	showToolTip := !showToolTip
	
	if(showToolTip)
		ToolTip % helperTooltipContent, 0, 0, 1
	else
		ToolTip,,,, 1
}
