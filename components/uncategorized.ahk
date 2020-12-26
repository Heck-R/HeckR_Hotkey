
#include <HeckerFunc>

;-------------------------------------------------------

CoordMode, ToolTip, Screen

;-------------------------------------------------------

scriptSectionname := "uncategorized"

mitmInput(Func("holdKeyDown"), true)

iniFunctionConnecter(scriptSectionname, "soundBeep")
iniFunctionConnecter(scriptSectionname, "setWindowOnTop")
iniFunctionConnecter(scriptSectionname, "holdKeyDown")

;-------------------------------------------------------
;-------------------------------------------------------

soundBeep() {
	SoundBeep 500, 1000
}

;-------------------------------------------------------

setWindowOnTop() {
	Winset Alwaysontop, , A
}

;-------------------------------------------------------

holdKeyDown() {
	keyToHold := readSingleKey(true, 0)
	;Sleep 250
	
	Send {%keyToHold% down}

	tmpToolTip(keyToHold . " is being held down", 2000, 0, 0)
}
