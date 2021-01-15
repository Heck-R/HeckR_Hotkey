
volumeController_showTooltip := true
volumeController_tooltipVisibleTime := 1000

;-------------------------------------------------------

scriptSectionname := "volumeController"

iniFunctionConnecter(scriptSectionname, "increaseVolume")
iniFunctionConnecter(scriptSectionname, "decreaseVolume")
iniFunctionConnecter(scriptSectionname, "muteVolume")
iniFunctionConnecter(scriptSectionname, "toggleVolumeTooltip")

;-------------------------------------------------------
;-------------------------------------------------------

increaseVolume() {
	global volumeController_showTooltip ;Set in toggleVolumeTooltip
	global volumeController_tooltipVisibleTime ;Set at the beginning of the script

	SoundSet +5
	soundGet currentVolume
	if(volumeController_showTooltip)
		tmpToolTip(round(currentVolume), volumeController_tooltipVisibleTime)
}

decreaseVolume() {
	global volumeController_showTooltip ;Set in toggleVolumeTooltip
	global volumeController_tooltipVisibleTime ;Set at the beginning of the script

	SoundSet -5
	SoundGet currentVolume
	if(volumeController_showTooltip)
		tmpToolTip(round(currentVolume), volumeController_tooltipVisibleTime)
}

muteVolume() {
	global volumeController_showTooltip ;Set in toggleVolumeTooltip
	global volumeController_tooltipVisibleTime ;Set at the beginning of the script

	SoundGet, soundOn, , MUTE
	SoundSet, +1, , MUTE

	if(volumeController_showTooltip)
		tmpToolTip("Sound " . soundOn, volumeController_tooltipVisibleTime)
}

toggleVolumeTooltip() {
	global volumeController_showTooltip ;Global value to set here

	volumeController_showTooltip := !volumeController_showTooltip
}
