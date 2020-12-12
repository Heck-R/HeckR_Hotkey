
scriptSectionname := "cursorMover"

directions := {}
directions["Left"] := [-1, 0]
directions["Right"] := [1, 0]
directions["Up"] := [0, -1]
directions["Down"] := [0, 1]

prepareContinousMouseControll()
iniFunctionConnecter(scriptSectionname, "setContinousMouseControll")

for direction, axises in directions {
	iniFunctionConnecter(scriptSectionname, ["moveCursor" + direction, "moveCursor"], axises)
}

;-------------------------------------------------------
;-------------------------------------------------------

moveCursor(x, y) {
	MouseMove, x, y, 0, R
}

;-------------------------------------------------------

#If continousMouseControllIsOn()
#If

prepareContinousMouseControll() {
	global directions
	global scriptSectionname
	global continousDirection := {} ;Set in setContinousDirection
	global cursorMoving ;Set in moveCursorContinously based on cursor is being moved or not

	Hotkey If, continousMouseControllIsOn()

	for direction, axises in directions {
		iniFunctionConnecter(scriptSectionname, ["moveCursorContinously" + direction, "setContinousDirectionOn", "setContinousDirectionOff"], [direction])
	}

	Hotkey If
}

setContinousMouseControll() {
	global continousMouseControllOn ;Global value to set here
	continousMouseControllOn := !continousMouseControllOn
}

continousMouseControllIsOn() {
	global continousMouseControllOn ;Set in setContinousMouseControll
	return continousMouseControllOn
}

moveCursorContinously() {
	global directions
	global cursorMoving
	global continousDirection

	if (cursorMoving)
		return
	else
		cursorMoving := true

	stillMoving := true
	while (stillMoving) {
		stillMoving := false
		directionSum := [0, 0]

		for direction, axises in directions {
			if (continousDirection[direction]) {
				stillMoving := true

				directionSum[1] += axises[1]
				directionSum[2] += axises[2]
			}
		}

		moveCursor(directionSum[1], directionSum[2])
	}

	cursorMoving := false
}

setContinousDirectionOn(direction) {
	global continousDirection
	continousDirection[direction] := true
	moveCursorContinously()
}

setContinousDirectionOff(direction) {
	global continousDirection
	continousDirection[direction] := false
}
