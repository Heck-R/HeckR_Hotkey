
CoordMode, ToolTip, Screen

;-------------------------------------------------------

scriptSectionname := "uncategorized"

prepareKeyPressCapturing()

iniFunctionConnecter(scriptSectionname, "soundBeep")
iniFunctionConnecter(scriptSectionname, "setWindowOnTop")
iniFunctionConnecter(scriptSectionname, "setKeyPressCapturing")

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

#If keyPressCapturingIsOn()
#If

prepareKeyPressCapturing(initalizeCapturing := false) {
	global keyPressCapturingOn ;Set in setKeyPressCapturing

	firstHexList := ["", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
	secondHexList := ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]

	Hotkey If, keyPressCapturingIsOn()

	loop 16 {
		firstChar := firstHexList[A_Index]
		loop 16 {
			secondChar := secondHexList[A_Index]
			virtualNum=%firstChar%%secondChar%
			
			if(virtualNum != "0"){
				Hotkey, ~vk%virtualNum%, holdKeyDown
			}
		}
	}

	Hotkey If
}

setKeyPressCapturing() {
	global keyPressCapturingOn ;Global value to set here
	keyPressCapturingOn := !keyPressCapturingOn
}

keyPressCapturingIsOn() {
	global keyPressCapturingOn ;Set in setKeyPressCapturing
	return keyPressCapturingOn
}

holdKeyDown() {
	Sleep 250
	
	keyToHold := SubStr(A_ThisHotkey, 2)
	Send {%keyToHold% down}

	setKeyPressCapturing()

	ToolTip % keyToHold . " is being held down", 0, 0
	SetTimer TurnOffKeyPressCapturingTooltip, -2000
	return

	TurnOffKeyPressCapturingTooltip:
	ToolTip
	return
}

