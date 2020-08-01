
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
		tooltip % round(currentVolume)
	
	settimer volumeControllerTooltipOff, -%volumeController_tooltipVisibleTime%
}

decreaseVolume() {
	global volumeController_showTooltip ;Set in toggleVolumeTooltip
	global volumeController_tooltipVisibleTime ;Set at the beginning of the script

	SoundSet -5
	SoundGet currentVolume
	if(volumeController_showTooltip)
		Tooltip % round(currentVolume)
	
	settimer volumeControllerTooltipOff, -%volumeController_tooltipVisibleTime%
}

muteVolume() {
	global volumeController_showTooltip ;Set in toggleVolumeTooltip
	global volumeController_tooltipVisibleTime ;Set at the beginning of the script

	SoundSet, +1, , MUTE
	SoundGet, currentVolume, , MUTE
	if(volumeController_showTooltip){
		if(currentVolume == "On")
			ToolTip Sound Off
		else
			ToolTip Sound On
	}
	
	settimer volumeControllerTooltipOff, -%volumeController_tooltipVisibleTime%
}

toggleVolumeTooltip() {
	global volumeController_showTooltip ;Global value to set here

	volumeController_showTooltip := !volumeController_showTooltip
}

volumeControllerTooltipOff() {
	ToolTip
}