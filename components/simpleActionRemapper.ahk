
scriptSectionname := "simpleActionRemapper"

iniFunctionConnecter(scriptSectionname, "copyContent")
iniFunctionConnecter(scriptSectionname, "pasteContent")
iniFunctionConnecter(scriptSectionname, "deleteContent")

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
