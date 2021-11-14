
#include <HeckerFunc>

;-------------------------------------------------------

scriptSectionname := "simpleActionRemapper"

mapConfigHotkeyToFunction(iniFile, scriptSectionName, "copyContent")
mapConfigHotkeyToFunction(iniFile, scriptSectionName, "pasteContent")
mapConfigHotkeyToFunction(iniFile, scriptSectionName, "deleteContent")

;-------------------------------------------------------
;-------------------------------------------------------

copyContent() {
    Send ^c
}

pasteContent() {
    Send ^v
}

deleteContent() {
    Send {Delete}
}
