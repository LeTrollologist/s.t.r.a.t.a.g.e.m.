#Requires AutoHotkey v2.0
#SingleInstance Force
CoordMode("ToolTip", "Screen")
SetWorkingDir(A_ScriptDir)

; ============================================================
;  S.T.R.A.T.A.G.E.M. TERMINAL  v4.6
;  Smart Trigger Regulation And Tactical Action
;  Guidance Execution Manager
;
;  Hotkeys:
;    Ctrl+1-2    Fire hardcoded (Reinforce / Resupply)
;    Ctrl+3-9    Fire custom stratagem slot
;    Ctrl+0      Fire SOS beacon
;    =           Toggle HUD visibility
;    -           Toggle compact mode (click-through overlay)
;    End         Toggle rapid fire
;    Ctrl+Alt+D  Reload script
;
;  Slots 3-9: pick from dropdown or type custom
;  sequence directly (e.g. Up,Down,Left,Right)
; ============================================================

; ============================================================
; GLOBALS
; ============================================================
global RapidToggle := false
global HUDVisible  := true
global CompactMode := false
global ActiveSlot  := 0
global ActiveStep  := 0

; Transparency constants
global TR_FULL := 230   ; GFull  normal
global TR_COMP := 130   ; GComp  normal (more transparent, click-through)
global TR_IND  := 210   ; GIndicator

global Strats := [
    "Up,Down,Right,Left,Up",              ; slot 1 Reinforce   (hardcoded)
    "Down,Down,Up,Right",                 ; slot 2 Resupply    (hardcoded)
    "Up,Right,Down,Right",                ; slot 3 custom
    "Right,Down,Up,Right,Down",           ; slot 4 custom
    "Up,Right,Down,Down,Down",            ; slot 5 custom
    "Down,Up,Left,Down,Up,Right,Down,Up", ; slot 6 custom
    "Down,Up,Up,Left,Right",              ; slot 7 custom
    "Down,Up,Up,Left,Right,Right",        ; slot 8 custom
    "Down,Down,Left,Up,Right"             ; slot 9 custom
]
global SOS := "Up,Down,Right,Up"

LoadFile := "stratagem_loadout.ini"

; ============================================================
; MASTER STRATAGEM LIST
; ============================================================
global StratNames := [
    "Reinforce",
    "SOS Beacon",
    "Resupply",
    "NUX-223 Hellbomb",
    "SSSD Delivery",
    "Prospecting Drill",
    "Super Earth Flag",
    "Seismic Probe",
    "Upload Data",
    "Eagle Rearm",
    "SEAF Artillery",
    "Illuminate Distractor Beacon",
    "Eagle Strafing Run",
    "Eagle Airstrike",
    "Eagle Cluster Bomb",
    "Eagle Napalm Airstrike",
    "Eagle Smoke Strike",
    "Eagle 110MM Rocket Pods",
    "Eagle 500KG Bomb",
    "Orbital Gatling Barrage",
    "Orbital Airburst Strike",
    "Orbital 120MM HE Barrage",
    "Orbital 380MM HE Barrage",
    "Orbital Walking Barrage",
    "Orbital Laser",
    "Orbital Railcannon Strike",
    "Orbital Precision Strike",
    "Orbital Gas Strike",
    "Orbital EMS Strike",
    "Orbital Smoke Strike",
    "Patriot Exosuit",
    "Emancipator Exosuit",
    "Machine Gun Sentry",
    "Gatling Sentry",
    "Mortar Sentry",
    "Guard Dog Rover",
    "Ballistic Shield Backpack",
    "Anti-Personnel Minefield",
    "Shield Generator Relay",
    "Tesla Tower",
    "Anti-Tank Mines",
    "Incendiary Mines",
    "HMG Emplacement",
    "Autocannon Sentry",
    "Rocket Sentry",
    "EMS Mortar Sentry",
    "Guard Dog",
    "Shield Generator Pack",
    "Laser Cannon",
    "Incendiary Breaker",
    "Anti-Materiel Rifle",
    "Stalwart",
    "Expendable Anti-Tank",
    "Recoilless Rifle",
    "Flamethrower",
    "Autocannon",
    "Heavy Machine Gun",
    "Airburst Rocket Launcher",
    "Spear",
    "Grenade Launcher",
    "Arc Thrower",
    "Quasar Cannon",
    "Railgun",
    "Commando",
    "Orbital Napalm Barrage",
    "Sterilizer",
    "Guard Dog (Standard)",
    "Guard Dog (Dog Breath)",
    "Directional Shield",
    "Flame Sentry",
    "Anti-Tank Emplacement",
    "Portable Hellbomb",
    "Hover Pack",
    "One True Flag",
    "StA-X3 W.A.S.P. Launcher",
    "Fast Recon Vehicle",
    "S-11 Speargun",
    "MS-11 Solo Silo",
    "TD-220 Bastion MK XVI"
]

global StratKeys := [
    "Up,Down,Right,Left,Up",
    "Up,Down,Right,Up",
    "Down,Down,Up,Right",
    "Down,Up,Left,Down,Up,Right,Down,Up",
    "Down,Up,Up,Left,Right",
    "Down,Up,Up,Left,Right,Right",
    "Down,Up,Down,Up",
    "Down,Down,Left,Up,Right",
    "Down,Left,Up,Down",
    "Up,Up,Left,Up",
    "Right,Up,Up,Down",
    "Right,Right,Left,Left",
    "Up,Right,Right",
    "Up,Right,Down,Right",
    "Up,Right,Down,Down,Right",
    "Up,Right,Down,Up",
    "Up,Right,Up,Down",
    "Up,Right,Up,Left",
    "Up,Right,Down,Down,Down",
    "Right,Down,Left,Up,Up",
    "Right,Right,Right",
    "Right,Right,Down,Left,Right,Down",
    "Right,Down,Up,Up,Left,Down,Down",
    "Right,Down,Right,Down,Right,Down",
    "Right,Down,Up,Right,Down",
    "Right,Up,Down,Down,Right",
    "Right,Right,Up",
    "Right,Right,Down,Right",
    "Right,Right,Left,Down",
    "Right,Right,Down,Up",
    "Left,Down,Right,Up,Left,Down,Down",
    "Right,Up,Left,Down,Right,Down",
    "Down,Up,Right,Right,Up",
    "Down,Up,Right,Left,Up",
    "Down,Up,Up,Left,Down",
    "Up,Up,Down,Up,Right",
    "Down,Left,Down,Down,Up,Left",
    "Down,Left,Up,Right",
    "Down,Up,Left,Right,Left,Right",
    "Down,Up,Right,Up,Left,Up",
    "Down,Left,Up,Left,Down",
    "Down,Left,Left,Down,Right",
    "Down,Left,Up,Down,Down,Right",
    "Down,Left,Down,Up,Up,Right",
    "Down,Up,Up,Right,Right",
    "Down,Up,Up,Down,Right",
    "Down,Up,Left,Up,Right",
    "Down,Up,Left,Right,Left,Right",
    "Down,Left,Down,Up,Left",
    "Down,Left,Up,Down,Left",
    "Down,Left,Right,Up,Down",
    "Down,Left,Down,Up,Up,Left",
    "Down,Down,Left,Up,Right",
    "Down,Left,Right,Right,Left",
    "Down,Left,Up,Down,Up",
    "Down,Left,Down,Up,Up,Right",
    "Down,Left,Up,Down,Down",
    "Up,Down,Up,Up,Down",
    "Down,Down,Up,Down,Down",
    "Down,Left,Up,Left,Down",
    "Down,Right,Down,Up,Left,Left",
    "Down,Down,Up,Left,Right",
    "Down,Right,Down,Up,Left,Right",
    "Down,Left,Down,Up,Right",
    "Right,Right,Down,Left,Right,Up",
    "Down,Left,Up,Down,Left",
    "Down,Up,Left,Up,Right",
    "Down,Up,Left,Up,Right,Up",
    "Down,Up,Left,Right,Up,Up",
    "Down,Up,Right,Down,Up,Up",
    "Down,Up,Left,Right,Right,Right",
    "Down,Right,Up,Up,Up",
    "Down,Up,Up,Down,Left,Right",
    "Down,Left,Right,Right,Up",
    "Down,Down,Up,Down,Right",
    "Left,Down,Right,Down,Right,Down,Up",
    "Down,Right,Down,Left,Up,Right",
    "Down,Up,Right,Down,Down",
    "Left,Down,Right,Down,Left,Down,Up,Down,Up"
]

global StratMap := Map()
Loop StratNames.Length {
    StratMap[StratNames[A_Index]] := StratKeys[A_Index]
}

; ============================================================
; HELPERS
; ============================================================
ArrowIcons(seq) {
    seq := StrReplace(seq, "Up",    "^")
    seq := StrReplace(seq, "Down",  "v")
    seq := StrReplace(seq, "Left",  "<")
    seq := StrReplace(seq, "Right", ">")
    return StrReplace(seq, ",", " ")
}

KeysForName(name) {
    global StratMap
    if StratMap.Has(name)
        return StratMap[name]
    if RegExMatch(name, "^(Up|Down|Left|Right)(,(Up|Down|Left|Right))*$")
        return name
    return ""
}

BuildHUDLine(slot, name, seq, activeStep := 0) {
    arrows    := StrSplit(seq, ",")
    label     := Format("{:2}", slot = 0 ? "0" : slot)
    nameTrunc := StrLen(name) > 13 ? SubStr(name, 1, 12) "~" : name
    namePad   := Format("{:-13s}", nameTrunc)
    line      := "[" label "] " namePad " "
    Loop arrows.Length {
        i     := A_Index
        arrow := ArrowIcons(arrows[i])
        if (activeStep = 0)
            line .= arrow
        else if (i < activeStep)
            line .= "."
        else if (i = activeStep)
            line .= ">"
        else
            line .= arrow
    }
    return RTrim(line)
}

GetTipPos(&tx, &ty) {
    global CompactMode, GFull, GComp, GW
    g := CompactMode ? GComp : GFull
    WinGetPos(&wx, &wy, , , g.Hwnd)
    tx := wx + GW + 8
    ty := wy + 12
}

; ============================================================
; LAYOUT CONSTANTS
; ============================================================
global GW := 380
global PX := 10
global IW := GW - PX * 2

; ============================================================
;  BUILD GFull  — config + HUD overlay
; ============================================================
global GFull := Gui("+AlwaysOnTop -Caption")
GFull.BackColor := "090915"
GFull.MarginX   := 0
GFull.MarginY   := 0

fy := 0

; top accent
GFull.Add("Text", "x0 y" fy " w" GW " h2 BackgroundFFD700")
fy += 2
GFull.Add("Text", "x0 y" fy " w" GW " h1 Background4FC3F7")
fy += 1

; title bar
GFull.Add("Text", "x0 y" fy " w" GW " h42 Background0D0D20")
GFull.SetFont("s9 Bold cFFD700", "Courier New")
GFull.Add("Text", "x" PX " y" (fy+3) " w" (GW-34) " h14 Background0D0D20", "S.T.R.A.T.A.G.E.M.")
GFull.SetFont("s6 c3A6A9A", "Courier New")
GFull.Add("Text", "x" PX " y" (fy+18) " w" IW " h9 Background0D0D20", "SMART TRIGGER REGULATION AND TACTICAL ACTION")
GFull.Add("Text", "x" PX " y" (fy+28) " w" IW " h9 Background0D0D20", "GUIDANCE EXECUTION MANAGER  v4.6")
GFull.SetFont("s10 Bold cC8A227", "Courier New")
GFull.Add("Text", "x" (GW-28) " y" (fy+5) " w22 h28 Background0D0D20", "✦")
fy += 42

GFull.Add("Text", "x0 y" fy " w" GW " h1 BackgroundC8A227")
fy += 1

; rapid fire note (compact single line)
fy += 3
GFull.SetFont("s6 cAA2222", "Courier New")
GFull.Add("Text", "x" PX " y" fy " w" IW " h9 Center",
    "! RAPID FIRE: avoid full-auto weapons  [End] to toggle")
fy += 12
GFull.Add("Text", "x0 y" fy " w" GW " h1 Background1A2A40")
fy += 4

; loadout header
GFull.SetFont("s6 c3A6A9A", "Courier New")
GFull.Add("Text", "x" PX " y" fy " w" IW " h9",
    "LOADOUT  CTRL+1-9  //  SLOTS 3-9 CUSTOMIZABLE")
fy += 13

; ── HARDCODED ROWS (1=Reinforce, 2=Resupply) ─────────────
LbW := 18
CbX := PX + LbW + 3
CbW := GW - CbX - PX

HardNames := ["Reinforce", "Resupply"]
Loop 2 {
    i   := A_Index
    rbg := (Mod(i, 2) = 0) ? "0C0C1E" : "080815"
    GFull.Add("Text", "x0 y" fy " w" GW " h16 Background" rbg)
    GFull.SetFont("s7 Bold cFFD700", "Courier New")
    GFull.Add("Text", "x" PX " y" (fy+1) " w" LbW " h13 Background" rbg, i)
    GFull.SetFont("s6 c5A5A7A", "Courier New")
    GFull.Add("Text", "x" CbX " y" (fy+2) " w" (CbW-22) " h11 Background" rbg, HardNames[i])
    GFull.SetFont("s5 c333355", "Courier New")
    GFull.Add("Text", "x" (GW-PX-18) " y" (fy+3) " w18 h9 Right Background" rbg, "LOCKED")
    fy += 16
    GFull.Add("Text", "x0 y" fy " w" GW " h1 Background1A2A40")
    fy += 1
}

; ── CUSTOM SLOT ROWS (3-9) ───────────────────────────────
global Drops := []
Loop 7 {
    j   := A_Index
    i   := j + 2
    rbg := (Mod(i, 2) = 0) ? "0C0C1E" : "080815"
    GFull.Add("Text", "x0 y" fy " w" GW " h18 Background" rbg)
    GFull.SetFont("s7 Bold cFFD700", "Courier New")
    GFull.Add("Text", "x" PX " y" (fy+2) " w" LbW " h13 Background" rbg, i)
    GFull.SetFont("s6 cC8A850", "Courier New")
    d := GFull.Add("ComboBox",
        "x" CbX " y" (fy+1) " w" CbW " h150 vStrat" i " Background0C0B03 cC8A850",
        StratNames)
    d.OnEvent("Change", UpdateOverlayFromDrops)
    Drops.Push(d)
    fy += 18
    if j < 7 {
        GFull.Add("Text", "x0 y" fy " w" GW " h1 Background1A2A40")
        fy += 1
    }
}

GFull.Add("Text", "x0 y" fy " w" GW " h1 BackgroundC8A227")
fy += 1

; hide hint
fy += 3
GFull.SetFont("s6 Bold c2A5A7A", "Courier New")
GFull.Add("Text", "x" PX " y" fy " w" IW " h9 Center", "[ = ] HIDE HUD DURING GUNPLAY")
fy += 12

GFull.Add("Text", "x0 y" fy " w" GW " h1 BackgroundC8A227")
fy += 1
fy += 3

; deploy button
GFull.SetFont("s7 Bold c22C55E", "Courier New")
FSaveBtn := GFull.Add("Button", "x" PX " y" fy " w" IW " h18", "DEPLOY LOADOUT")
FSaveBtn.OnEvent("Click", SaveLoadout)
fy += 24

GFull.Add("Text", "x0 y" fy " w" GW " h1 BackgroundC8A227")
fy += 1
fy += 3

; active HUD
GFull.SetFont("s6 c3A6A9A", "Courier New")
GFull.Add("Text", "x" PX " y" fy " w" IW " h9", "ACTIVE HUD  //  CTRL+0 SOS BEACON")
fy += 11

GFull.Add("Text", "x0 y" fy " w" GW " h195 Background06060F")
GFull.SetFont("s8 Bold cFFD700", "Courier New")
global FOverlay := GFull.Add("Text", "x" PX " y" (fy+3) " w" IW " h189 Background06060F", "")
fy += 195

GFull.Add("Text", "x0 y" fy " w" GW " h1 BackgroundC8A227")
fy += 1
fy += 3

; status bar
GFull.Add("Text", "x0 y" fy " w" GW " h16 Background08080F")
GFull.SetFont("s6 c22C55E", "Courier New")
global FStatus := GFull.Add("Text", "x" PX         " y" (fy+2) " w70 h11 Background08080F", "ONLINE")
GFull.SetFont("s6 cCC3333", "Courier New")
global FRapid  := GFull.Add("Text", "x" (GW//2-36) " y" (fy+2) " w72 h11 Center Background08080F", "RAPID O")
GFull.SetFont("s6 c2A4A6A", "Courier New")
GFull.Add("Text",            "x" (GW-120)           " y" (fy+2) " w110 h11 Right Background08080F", "[-]COMPACT  [END]RAPID")
fy += 16

; FOR SUPER-EARTH bar
GFull.Add("Text", "x0 y" fy " w" GW " h1 Background2A5A8A")
fy += 1
GFull.Add("Text", "x0 y" fy " w" GW " h16 Background0D1525")
GFull.SetFont("s7 Bold c4FC3F7", "Courier New")
GFull.Add("Text", "x0 y" (fy+2) " w" GW " h12 Center Background0D1525", "FOR SUPER-EARTH!")
fy += 16

; bottom accent
GFull.Add("Text", "x0 y" fy " w" GW " h1 Background4FC3F7")
fy += 1
GFull.Add("Text", "x0 y" fy " w" GW " h2 BackgroundFFD700")
fy += 2

global FullH := fy

; ============================================================
;  BUILD GComp  — compact click-through HUD overlay
; ============================================================
global GComp := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x80000")
GComp.BackColor := "090915"
GComp.MarginX   := 0
GComp.MarginY   := 0

cy := 0

GComp.Add("Text", "x0 y" cy " w" GW " h2 BackgroundFFD700")
cy += 2
GComp.Add("Text", "x0 y" cy " w" GW " h1 Background4FC3F7")
cy += 1

GComp.Add("Text", "x0 y" cy " w" GW " h20 Background0D0D20")
GComp.SetFont("s7 Bold cFFD700", "Courier New")
GComp.Add("Text", "x" PX " y" (cy+3) " w" (GW//2-PX) " h13 Background0D0D20", "S.T.R.A.T.A.G.E.M.")
GComp.SetFont("s6 c3A6A9A", "Courier New")
GComp.Add("Text", "x" (GW//2) " y" (cy+5) " w" (GW//2-PX) " h9 Right Background0D0D20", "COMPACT [-]")
cy += 20

GComp.Add("Text", "x0 y" cy " w" GW " h1 BackgroundC8A227")
cy += 4

GComp.Add("Text", "x0 y" cy " w" GW " h195 Background06060F")
GComp.SetFont("s8 Bold cFFD700", "Courier New")
global COverlay := GComp.Add("Text", "x" PX " y" (cy+3) " w" IW " h189 Background06060F", "")
cy += 195

GComp.Add("Text", "x0 y" cy " w" GW " h1 BackgroundC8A227")
cy += 4

GComp.Add("Text", "x0 y" cy " w" GW " h16 Background08080F")
GComp.SetFont("s6 c22C55E", "Courier New")
global CStatus := GComp.Add("Text", "x" PX         " y" (cy+2) " w70 h11 Background08080F", "ONLINE")
GComp.SetFont("s6 cCC3333", "Courier New")
global CRapid  := GComp.Add("Text", "x" (GW//2-36) " y" (cy+2) " w72 h11 Center Background08080F", "RAPID O")
GComp.SetFont("s6 c2A4A6A", "Courier New")
GComp.Add("Text",            "x" (GW-96)            " y" (cy+2) " w86 h11 Right Background08080F", "[-]FULL  [END]RAPID")
cy += 16

GComp.Add("Text", "x0 y" cy " w" GW " h1 Background2A5A8A")
cy += 1
GComp.Add("Text", "x0 y" cy " w" GW " h16 Background0D1525")
GComp.SetFont("s7 Bold c4FC3F7", "Courier New")
GComp.Add("Text", "x0 y" (cy+2) " w" GW " h12 Center Background0D1525", "FOR SUPER-EARTH!")
cy += 16

GComp.Add("Text", "x0 y" cy " w" GW " h1 Background4FC3F7")
cy += 1
GComp.Add("Text", "x0 y" cy " w" GW " h2 BackgroundFFD700")
cy += 2

global CompH := cy

; ============================================================
;  BUILD GIndicator  — tiny rapid-fire dot when HUD hidden
; ============================================================
global IndW := 68
global IndH := 14
global GIndicator := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x80000")
GIndicator.BackColor := "0A0008"
GIndicator.MarginX := 0
GIndicator.MarginY := 0
GIndicator.SetFont("s6 Bold cFF2222", "Courier New")
global GIndText := GIndicator.Add("Text", "x3 y2 w62 h10 BackgroundTrans", "RAPID ON")

; ============================================================
; PREVENT WINDOW MOVEMENT (GFull only; GComp is click-through)
; ============================================================
OnMessage(0x0084, WM_NCHITTEST_Block)
WM_NCHITTEST_Block(wParam, lParam, msg, hwnd) {
    global GFull
    if hwnd = GFull.Hwnd
        return 1  ; HTCLIENT
}

OnMessage(0x0112, WM_SYSCOMMAND_Block)
WM_SYSCOMMAND_Block(wParam, lParam, msg, hwnd) {
    global GFull
    if hwnd = GFull.Hwnd && (wParam & 0xFFF0) = 0xF010
        return 0
}

; ============================================================
; STRATAGEM SLOT MANAGEMENT
; ============================================================
SetStratFromName(i, name) {
    global Strats, SOS
    keys := KeysForName(name)
    if keys = ""
        return
    if i = 0
        SOS := keys
    else
        Strats[i] := keys
}

; ============================================================
; LOAD / DEFAULT
; ============================================================
UpdateOverlayFromDrops(*) {
    global Drops
    Loop 7 {
        SetStratFromName(A_Index + 2, Drops[A_Index].Text)
    }
    UpdateOverlay()
}

if FileExist(LoadFile) {
    Lines := StrSplit(FileRead(LoadFile), "`n", "`r")
    Loop 7 {
        j    := A_Index
        i    := j + 2
        name := Lines.Length >= j ? Trim(Lines[j]) : StratNames[i]
        Drops[j].Text := name
        SetStratFromName(i, name)
    }
} else {
    Loop 7 {
        j := A_Index
        i := j + 2
        Drops[j].Text := StratNames[i]
        SetStratFromName(i, StratNames[i])
    }
}

; ============================================================
; POSITION & SHOW
; ============================================================
; Use work area (excludes taskbar) for correct positioning
MonitorGetWorkArea(, &WALeft, &WATop, &WARight, &WABottom)
UsableW := WARight - WALeft
UsableH := WABottom - WATop
Mrg     := Max(8, Round(UsableW * 0.01))

Xpos := WARight - GW - Mrg
Ypos := WATop + Max(Mrg, Round((UsableH - FullH) / 2))
if (Ypos + FullH > WABottom - Mrg)
    Ypos := Max(WATop, WABottom - FullH - Mrg)

GFull.Show("x" Xpos " y" Ypos " w" GW " h" FullH " NoActivate")
GComp.Show("x" Xpos " y" Ypos " w" GW " h" CompH " NoActivate")
GComp.Hide()

WinSetTransparent(TR_FULL, GFull.Hwnd)
WinSetTransparent(TR_COMP, GComp.Hwnd)
; Make GComp fully click-through (WS_EX_TRANSPARENT requires WS_EX_LAYERED above)
WinSetExStyle("+0x20", GComp.Hwnd)

; Position indicator at top-right of work area
GIndicator.Show("x" (WARight - IndW - Mrg) " y" (WATop + Mrg) " w" IndW " h" IndH " NoActivate")
GIndicator.Hide()
WinSetTransparent(TR_IND, GIndicator.Hwnd)
WinSetExStyle("+0x20", GIndicator.Hwnd)

UpdateOverlay()

; ============================================================
; SAVE
; ============================================================
SaveLoadout(*) {
    global Drops
    Loop 7 {
        SetStratFromName(A_Index + 2, Drops[A_Index].Text)
    }
    content := ""
    Loop 7 {
        content .= Drops[A_Index].Text . "`n"
    }
    f := FileOpen(LoadFile, "w")
    f.Write(RTrim(content, "`n"))
    f.Close()
    UpdateOverlay()
    FlashDeploy()
}

; ============================================================
; DISPLAY
; ============================================================
UpdateOverlay() {
    global ActiveSlot, ActiveStep, Strats, SOS, FOverlay, COverlay, Drops
    lines := ""
    Loop 9 {
        i    := A_Index
        seq  := Strats[i]
        name := (i = 1) ? "Reinforce" : (i = 2) ? "Resupply" : Drops[i - 2].Text
        lines .= BuildHUDLine(i, name, seq, (i = ActiveSlot ? ActiveStep : 0)) "`n"
    }
    lines .= "-- SOS ---------`n"
    lines .= BuildHUDLine(0, "SOS Beacon", SOS, (ActiveSlot = 0 ? ActiveStep : 0))
    FOverlay.Value := lines
    COverlay.Value := lines
}

UpdateIndicator() {
    global HUDVisible, RapidToggle, GIndicator
    if (!HUDVisible && RapidToggle) {
        GIndicator.Show("NoActivate")
    } else {
        GIndicator.Hide()
    }
}

SetAllStatus(val) {
    global FStatus, CStatus
    FStatus.Value := val
    CStatus.Value := val
}

SetAllRapid(val) {
    global FRapid, CRapid
    FRapid.Value := val
    CRapid.Value := val
}

FlashDeploy() {
    global TR_FULL, TR_COMP
    WinSetTransparent(255, GFull.Hwnd)
    SetAllStatus("DEPLOYED!")
    SetTimer(() => (
        WinSetTransparent(TR_FULL, GFull.Hwnd),
        SetAllStatus("ONLINE")
    ), -900)
}

FlashHUD() {
    global TR_FULL
    WinSetTransparent(255, GFull.Hwnd)
    SetTimer(() => WinSetTransparent(TR_FULL, GFull.Hwnd), -130)
}

; ============================================================
; HOTKEYS — GLOBAL
; ============================================================
*=:: {
    global HUDVisible, CompactMode
    HUDVisible := !HUDVisible
    if HUDVisible {
        if CompactMode
            GComp.Show("NoActivate")
        else
            GFull.Show("NoActivate")
    } else {
        GFull.Hide()
        GComp.Hide()
    }
    UpdateIndicator()
}

*-:: {
    global CompactMode, HUDVisible
    CompactMode := !CompactMode
    if HUDVisible {
        if CompactMode {
            WinGetPos(&wx, &wy, , , GFull.Hwnd)
            GFull.Hide()
            GComp.Show("x" wx " y" wy " NoActivate")
        } else {
            WinGetPos(&wx, &wy, , , GComp.Hwnd)
            GComp.Hide()
            GFull.Show("x" wx " y" wy " NoActivate")
        }
    }
}

*End:: {
    global RapidToggle
    RapidToggle := !RapidToggle
    GetTipPos(&tx, &ty)
    if RapidToggle {
        SetAllRapid("RAPID @")
        ToolTip("RAPID FIRE ACTIVE", tx, ty)
    } else {
        SetAllRapid("RAPID O")
        ToolTip("RAPID FIRE OFFLINE", tx, ty)
    }
    SetTimer(() => ToolTip(), -1500)
    UpdateIndicator()
}

^!d:: Reload()

; ============================================================
; HOTKEYS — IN GAME
; ============================================================
#HotIf WinActive("ahk_exe helldivers2.exe")

~Escape::
~Tab:: {
    global RapidToggle
    if RapidToggle {
        RapidToggle := false
        SetAllRapid("RAPID O")
        GetTipPos(&tx, &ty)
        ToolTip("RAPID FIRE OFF (Menu/Map)", tx, ty)
        SetTimer(() => ToolTip(), -1500)
        UpdateIndicator()
    }
}

*^0:: CastStratagem(SOS,       0)
*^1:: CastStratagem(Strats[1], 1)
*^2:: CastStratagem(Strats[2], 2)
*^3:: CastStratagem(Strats[3], 3)
*^4:: CastStratagem(Strats[4], 4)
*^5:: CastStratagem(Strats[5], 5)
*^6:: CastStratagem(Strats[6], 6)
*^7:: CastStratagem(Strats[7], 7)
*^8:: CastStratagem(Strats[8], 8)
*^9:: CastStratagem(Strats[9], 9)

CastStratagem(seq, slotNum) {
    global ActiveSlot, ActiveStep, FOverlay, COverlay
    FlashHUD()
    Keys       := StrSplit(StrReplace(seq, " "), ",")
    ActiveSlot := slotNum
    FOverlay.Opt("cFFFFFF")
    COverlay.Opt("cFFFFFF")

    Loop Keys.Length {
        i := A_Index
        if !GetKeyState("Ctrl", "P")
            break
        ActiveStep := i
        UpdateOverlay()
        SendInput("{Blind}{" Keys[i] " down}")
        Sleep(i = 1 ? 50 : 42)
        SendInput("{Blind}{" Keys[i] " up}")
        Sleep(Random(35, 65))
    }

    ActiveSlot := 0
    ActiveStep := 0
    FOverlay.Opt("cFFD700")
    COverlay.Opt("cFFD700")
    UpdateOverlay()
}

; ============================================================
; RAPID FIRE  (jittered interval)
; ============================================================
#HotIf WinActive("ahk_exe helldivers2.exe") && RapidToggle

*LButton:: {
    ShootAuto()
    SetTimer(ShootAuto, Random(42, 68))
}

ShootAuto() {
    if !GetKeyState("LButton", "P") {
        SetTimer(ShootAuto, 0)
        return
    }
    SendEvent("{Blind}{LButton down}")
    Sleep(Random(18, 32))
    SendEvent("{Blind}{LButton up}")
    SetTimer(ShootAuto, Random(42, 68))
}

#HotIf
