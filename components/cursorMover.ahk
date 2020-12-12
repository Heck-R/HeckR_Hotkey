
#include <HeckerFunc>

;-------------------------------------------------------

CoordMode, ToolTip, Screen

;-------------------------------------------------------

scriptSectionname := "cursorMover"

; Possible directions (object keys are used in ini direction naming as well)
directions := {}
directions["Left"] := {axises: {x:-1, y:0}}
directions["Right"] := {axises: {x:1, y:0}}
directions["Up"] := {axises: {x:0, y:-1}}
directions["Down"] := {axises: {x:0, y:1}}

cursorSpeed := 200

prepareContinousMouseControll()
iniFunctionConnecter(scriptSectionname, "setContinousMouseControll")

; 1 pixel movement
for direction, axises in directions {
	iniFunctionConnecter(scriptSectionname, ["moveCursor" . direction, "moveCursor"], axises)
}

;-------------------------------------------------------
;-------------------------------------------------------

moveCursor(x, y) {
	MouseMove, x, y, 0, R
}

;-------------------------------------------------------

#If continousMouseControllOn
#If

prepareContinousMouseControll() {
	global iniFile
	global sectionName
	global directions
	global scriptSectionname
	global cursorMoving ;Set in moveCursorContinously based on cursor is being moved or not
	global continousMouseControllOn ;Set in setContinousMouseControll

	Hotkey If, continousMouseControllOn

	; Set cursor mover hotkeys
	for direction, directionData in directions {
		; Save moving keys to later check their state
		iniKey := "moveCursorContinously" . direction
		IniRead, directionHotkey, %iniFile% , %scriptSectionname%, %iniKey%, %A_Space%
		if (directionHotkey != "")
			directionData["hotkey"] := directionHotkey

		; Set cursor mover hotkey
		iniFunctionConnecter(scriptSectionname, [iniKey, "moveCursorContinously"])
	}

	Hotkey If
}

setContinousMouseControll() {
	global continousMouseControllOn ;Global value to set here
	continousMouseControllOn := !continousMouseControllOn
	
	tmpToolTip("Continous mouse controll: " . (continousMouseControllOn ? "On" : "Off"), 1500)
}

moveCursorContinously() {
	global directions
	global cursorMoving
	global cursorSpeed

	if (cursorMoving) {
		return
	} else
		cursorMoving := true

	lastTime := A_TickCount
	stillMoving := true
	while (stillMoving) {
		stillMoving := false
		directionSum := {x:0, y:0}

		for direction, directionData in directions {
			if (GetKeyState(directionData["hotkey"], "P")) {
				stillMoving := true

				directionSum.x += directionData.axises.x
				directionSum.y += directionData.axises.y
			}
		}

		elapsedMilisecs := A_TickCount - lastTime
		lastTime := A_TickCount
		pixelsToMove := elapsedMilisecs / 1000 * cursorSpeed
		moveCursor(pixelsToMove * directionSum.x, pixelsToMove * directionSum.y)
	}

	cursorMoving := false
}
