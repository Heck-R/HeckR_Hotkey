
; Global variables
autoFire_fireFlag := false
autoFire_key := "vk1" ;Set in setAutoFireKey()

;-------------------------------------------------------

scriptSectionname := "autoFire"

iniFunctionConnecter(scriptSectionname, "toggleAutoFire", [], 2)
iniFunctionConnecter(scriptSectionname, "heldAutoFire")
iniFunctionConnecter(scriptSectionname, "setAutoFireKey")

;-------------------------------------------------------
;-------------------------------------------------------

toggleAutoFire() {
	global autoFire_fireFlag
	global autoFire_key

	autoFire_fireFlag := !autoFire_fireFlag
	while autoFire_fireFlag {
		SendInput {Blind}{%autoFire_key%}
	}
}

heldAutoFire(key) {
	global autoFire_fireFlag
	global autoFire_key

	autoFire_fireFlag := false

	while GetKeyState(key, "P"){
		SendInput {%autoFire_key%}
	}
}

setAutoFireKey() {
	global autoFire_key

	autoFire_key := readSingleKey(true, 0)
	tmpToolTip("Rapid fire key is set to: " . autoFire_key, 2000, 0, 0)
}
