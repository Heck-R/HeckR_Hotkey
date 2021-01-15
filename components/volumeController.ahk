
volumeController_showTooltip := true
volumeController_tooltipVisibleTime := 1000

volumeController_volumeChangeRatio := 0
volumeController_volumeChange := 0

;-------------------------------------------------------

scriptSectionname := "volumeController"

iniFunctionConnecter(scriptSectionname, "increaseVolume")
iniFunctionConnecter(scriptSectionname, "decreaseVolume")
iniFunctionConnecter(scriptSectionname, "muteVolume")
iniFunctionConnecter(scriptSectionname, "toggleVolumeTooltip")

IniRead, volumeController_changePercentage, %iniFile%, %scriptSectionname%_options, volumeChangePercentage, %A_Space%
if( (volumeController_changePercentage != 0) && (volumeController_changePercentage != "") )
	volumeController_volumeChangeRatio := volumeController_changePercentage / 100

IniRead, volumeController_volumeChangeIni, %iniFile%, %scriptSectionname%_options, volumeChange, %A_Space%
if( (volumeController_volumeChangeIni != 0) && (volumeController_volumeChangeIni != "") )
	volumeController_volumeChange := volumeController_volumeChangeIni

;-------------------------------------------------------
;-------------------------------------------------------

increaseVolume() {
	global volumeController_volumeChange
	global volumeController_volumeChangeRatio
	global volumeController_showTooltip ;Set in toggleVolumeTooltip
	global volumeController_tooltipVisibleTime ;Set at the beginning of the script

	soundGet currentVolume
	if(volumeController_volumeChangeRatio == 0)
		SoundSet +%volumeController_volumeChange%
	else
		SoundSet % currentVolume == 0 ? 1 : currentVolume / volumeController_volumeChangeRatio
	
	soundGet currentVolume
	if(volumeController_showTooltip)
		tmpToolTip(round(currentVolume), volumeController_tooltipVisibleTime)
}

decreaseVolume() {
	global volumeController_volumeChange
	global volumeController_volumeChangeRatio
	global volumeController_showTooltip ;Set in toggleVolumeTooltip
	global volumeController_tooltipVisibleTime ;Set at the beginning of the script

	soundGet currentVolume
	if(volumeController_volumeChangeRatio == 0)
		SoundSet -%volumeController_volumeChange%
	else
		SoundSet % currentVolume == 0 ? 1 : currentVolume * volumeController_volumeChangeRatio

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
