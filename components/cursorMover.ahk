
scriptSectionname := "cursorMover"

iniFunctionConnecter(scriptSectionname, "moveCursorLeft", [1])
iniFunctionConnecter(scriptSectionname, "moveCursorRight", [1])
iniFunctionConnecter(scriptSectionname, "moveCursorUp", [1])
iniFunctionConnecter(scriptSectionname, "moveCursorDown", [1])

;-------------------------------------------------------
;-------------------------------------------------------

moveCursorLeft(pixelNum) {
	MouseMove, -pixelNum, 0, 0, R
}

moveCursorRight(pixelNum) {
	MouseMove, pixelNum, 0, 0, R
}

moveCursorUp(pixelNum) {
	MouseMove, 0, -pixelNum, 0, R
}

moveCursorDown(pixelNum) {
	MouseMove, 0, pixelNum, 0, R
}
