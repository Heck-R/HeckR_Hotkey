
#include <HeckerFunc>

;-------------------------------------------------------

CoordMode, ToolTip, Screen

;-------------------------------------------------------

cursorMover_toolTipTimeout := 1500

; Possible directions (object keys are used in ini direction naming as well)
cursorMover_directions := {}
cursorMover_directions["Left"] := {axises: {x:-1, y:0}}
cursorMover_directions["Right"] := {axises: {x:1, y:0}}
cursorMover_directions["Up"] := {axises: {x:0, y:-1}}
cursorMover_directions["Down"] := {axises: {x:0, y:1}}

cursorMover_cursorMoving := false
cursorMover_continousMouseControllOn := false

;-----------------------

scriptSectionName := "cursorMover"
scriptOptionSectionName := scriptSectionName . "_options"

IniRead, cursorMover_cursorSpeedOptions, %iniFile% , %scriptOptionSectionName%, cursorSpeedOptions, %A_Space%
IniRead, cursorMover_cursorSpeedIndex, %iniFile% , %scriptOptionSectionName%, initalSpeedOptionIndex, %A_Space%

; cursorMover_cursorSpeedIndex - Describes which speed option is set at the moment from cursorMover_cursorSpeedOptions
; By default 0, if the options are default as well, then 2.
cursorMover_cursorSpeedIndex := cursorMover_cursorSpeedIndex == "" ? (cursorMover_cursorSpeedOptions == "" ? 2 : 0) : cursorMover_cursorSpeedIndex
; cursorMover_cursorSpeedOptions - The possible cursor speed options to switch from
cursorMover_cursorSpeedOptions := cursorMover_cursorSpeedOptions == "" ? [50, 100, 250, 500, 1000, 2500, 5000, 10000] : StrSplit(cursorMover_cursorSpeedOptions, ",", " ")

;-------------------------------------------------------

prepareContinousMouseControll()
iniFunctionConnecter(scriptSectionName, "setContinousMouseControll")
iniFunctionConnecter(scriptSectionName, ["changeCursorSpeedUp", "changeCursorSpeed"], [1])
iniFunctionConnecter(scriptSectionName, ["changeCursorSpeedDown", "changeCursorSpeed"], [-1])

; 1 pixel movement
for direction, axises in cursorMover_directions {
	iniFunctionConnecter(scriptSectionName, ["moveCursor" . direction, "moveCursor"], axises)
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
	global scriptSectionName
	global cursorMover_continousMouseControllOn ;Set in setContinousMouseControll
	global cursorMover_cursorMoving ;Set in moveCursorContinously based on cursor is being moved or not
	global cursorMover_directions ;Set at top of the script

	Hotkey If, cursorMover_continousMouseControllOn

	; Set cursor mover hotkeys
	for direction, directionData in cursorMover_directions {
		; Save moving keys to later check their state
		iniKey := "moveCursorContinously" . direction
		IniRead, directionHotkey, %iniFile% , %scriptSectionName%, %iniKey%, %A_Space%
		if (directionHotkey != "")
			directionData["hotkey"] := directionHotkey

		; Set cursor mover hotkey
		iniFunctionConnecter(scriptSectionName, [iniKey, "moveCursorContinously"])
	}

	iniFunctionConnecter(scriptSectionName, ["leftClick", "mouseActionDown", "mouseActionUp"], ["LButton"])
	iniFunctionConnecter(scriptSectionName, ["rightClick", "mouseActionDown", "mouseActionUp"], ["RButton"])
	iniFunctionConnecter(scriptSectionName, ["middleClick", "mouseActionDown", "mouseActionUp"], ["MButton"])
	iniFunctionConnecter(scriptSectionName, ["macro1", "mouseActionDown", "mouseActionUp"], ["XButton1"])
	iniFunctionConnecter(scriptSectionName, ["macro2", "mouseActionDown", "mouseActionUp"], ["XButton2"])
	iniFunctionConnecter(scriptSectionName, ["scrollUp", "mouseScroll"], ["WheelUp"])
	iniFunctionConnecter(scriptSectionName, ["scrollDown", "mouseScroll"], ["WheelDown"])
	iniFunctionConnecter(scriptSectionName, "doubleClick")
	iniFunctionConnecter(scriptSectionName, "tripleClick")

	Hotkey If
}

setContinousMouseControll() {
	global cursorMover_continousMouseControllOn ;Global value to set here
	global cursorMover_toolTipTimeout ;Set at top of the script
	cursorMover_continousMouseControllOn := !cursorMover_continousMouseControllOn

	tmpToolTip("Continous mouse controll: " . (cursorMover_continousMouseControllOn ? "On" : "Off"), cursorMover_toolTipTimeout)
}

moveCursorContinously() {
	global cursorMover_cursorMoving
	global cursorMover_directions

	if (cursorMover_cursorMoving) {
		return
	} else
		cursorMover_cursorMoving := true

	lastTime := A_TickCount
	stillMoving := true
	remainder := 0
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

		pixelsToMove := (elapsedMilisecs / 1000 * getCursorSpeed()) + remainder
		remainder := mathMod(pixelsToMove, 1)
		pixelsToMove := Floor(pixelsToMove)
		moveCursor(pixelsToMove * directionSum.x, pixelsToMove * directionSum.y)
	}

	cursorMover_cursorMoving := false
}

changeCursorSpeed(step) {
	global cursorMover_cursorSpeedIndex ;Set at top of the script
	global cursorMover_cursorSpeedOptions ;Set at top of the script
	global cursorMover_toolTipTimeout ;Set at top of the script
	cursorMover_cursorSpeedIndex := mathMod(cursorMover_cursorSpeedIndex + step, cursorMover_cursorSpeedOptions.MaxIndex())

	tmpToolTip("Cursor speed: " . getCursorSpeed() . "px / sec", cursorMover_toolTipTimeout)
}

getCursorSpeed() {
	global cursorMover_cursorSpeedIndex ;Set in changeCursorSpeed
	global cursorMover_cursorSpeedOptions ;Set at top of the script
	return cursorMover_cursorSpeedOptions[cursorMover_cursorSpeedIndex + 1]
}

mouseActionDown(keyToSend, triggerKey) {
	SendInput, {%keyToSend% down}
	while (GetKeyState(triggerKey, "P")) {
		Sleep, 50
	}
}

mouseActionUp(keyToSend, triggerKey) {
	SendInput, {%keyToSend% up}
	while (GetKeyState(triggerKey, "P")) {
		Sleep, 50
	}
}

mouseScroll(keyToSend, triggerKey) {
	while GetKeyState(triggerKey, "P"){
		SendInput, {%keyToSend%}
		Sleep, 100
	}
}

doubleClick() {
	SendInput, {LButton}
	Sleep, 100
	SendInput, {LButton}
}

tripleClick() {
	SendInput, {LButton}
	Sleep, 100
	SendInput, {LButton}
	Sleep, 100
	SendInput, {LButton}
}
