
#include <HeckerFunc>

;-------------------------------------------------------

CoordMode, ToolTip, Screen

;-------------------------------------------------------

; Possible directions (object keys are used in ini direction naming as well)
cursorMover_directions := {}
cursorMover_directions["Left"] := {axises: {x:-1, y:0}}
cursorMover_directions["Right"] := {axises: {x:1, y:0}}
cursorMover_directions["Up"] := {axises: {x:0, y:-1}}
cursorMover_directions["Down"] := {axises: {x:0, y:1}}

cursorMover_cursorSpeed := 200

cursorMover_cursorMoving := false
cursorMover_continousMouseControllOn := false

;-------------------------------------------------------

scriptSectionname := "cursorMover"

prepareContinousMouseControll()
iniFunctionConnecter(scriptSectionname, "setContinousMouseControll")

; 1 pixel movement
for direction, axises in cursorMover_directions {
	iniFunctionConnecter(scriptSectionname, ["moveCursor" . direction, "moveCursor"], axises)
}

;-------------------------------------------------------
;-------------------------------------------------------

moveCursor(x, y) {
	MouseMove, x, y, 0, R
}

;-------------------------------------------------------

#If cursorMover_continousMouseControllOn
#If

prepareContinousMouseControll() {
	global iniFile
	global scriptSectionname
	global cursorMover_continousMouseControllOn ;Set in setContinousMouseControll
	global cursorMover_cursorMoving ;Set in moveCursorContinously based on cursor is being moved or not
	global cursorMover_directions ;Set at top of the script

	Hotkey If, cursorMover_continousMouseControllOn

	; Set cursor mover hotkeys
	for direction, directionData in cursorMover_directions {
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
	global cursorMover_continousMouseControllOn ;Global value to set here
	cursorMover_continousMouseControllOn := !cursorMover_continousMouseControllOn

	tmpToolTip("Continous mouse controll: " . (cursorMover_continousMouseControllOn ? "On" : "Off"), 1500)
}

moveCursorContinously() {
	global cursorMover_cursorMoving
	global cursorMover_cursorSpeed
	global cursorMover_directions

	if (cursorMover_cursorMoving) {
		return
	} else
		cursorMover_cursorMoving := true

	lastTime := A_TickCount
	stillMoving := true
	while (stillMoving) {
		stillMoving := false
		directionSum := {x:0, y:0}

		for direction, directionData in cursorMover_directions {
			if (GetKeyState(directionData["hotkey"], "P")) {
				stillMoving := true

				directionSum.x += directionData.axises.x
				directionSum.y += directionData.axises.y
			}
		}

		elapsedMilisecs := A_TickCount - lastTime
		lastTime := A_TickCount
		pixelsToMove := elapsedMilisecs / 1000 * cursorMover_cursorSpeed
		moveCursor(pixelsToMove * directionSum.x, pixelsToMove * directionSum.y)
	}

	cursorMover_cursorMoving := false
}
