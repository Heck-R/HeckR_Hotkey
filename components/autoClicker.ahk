
scriptSectionname := "autoClicker"

iniFunctionConnecter(scriptSectionname, "toggleAutoFire", [], 2)
iniFunctionConnecter(scriptSectionname, "heldAutoFire")

;-------------------------------------------------------
;-------------------------------------------------------

toggleAutoFire() {
	global autoFire_clickingFlag ;Keeps local parameter's value across calls

	autoFire_clickingFlag := !autoFire_clickingFlag
	while autoFire_clickingFlag {
		click
	}
}

heldAutoFire(key) {
	while GetKeyState(key, "P"){
		click
	}
}
