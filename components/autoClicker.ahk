
scriptSectionname := "autoClicker"

iniFunctionConnecter(scriptSectionname, "toggleAutoClicking", [], 2)
iniFunctionConnecter(scriptSectionname, "heldAutoClicking")

;-------------------------------------------------------
;-------------------------------------------------------

toggleAutoClicking() {
	global autoClicker_clickingFlag ;Keeps local parameter's value across calls

	autoClicker_clickingFlag := !autoClicker_clickingFlag
	while autoClicker_clickingFlag {
		click
	}
}

heldAutoClicking(key) {
	while GetKeyState(key, "P"){
		click
	}
}
