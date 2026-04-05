#Requires AutoHotkey v2.0
#SingleInstance Force
CoordMode("ToolTip", "Screen")
SetWorkingDir(A_ScriptDir)
DllCall("SetProcessDPIAware")

; ============================================================
;  S.T.R.A.T.A.G.E.M. TERMINAL  v4.8.6
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
;  Slots 3-9: type to filter by name (e.g. "re" shows
;  Reinforce, Resupply, etc.) or enter sequence directly.
;  102 stratagems in database.
; ============================================================

; ============================================================
; GLOBALS
; ============================================================
global RapidToggle := false
global HUDVisible  := true
global CompactMode := false
global ActiveSlot  := 0
global ActiveStep  := 0
global CompactX    := -1   ; saved compact overlay X position (v4.8.2)
global CompactY    := -1   ; saved compact overlay Y position (v4.8.2)
global LabelEdits  := []   ; display name override Edit controls (v4.8.4)

; Transparency constants
global TR_FULL := 230
global TR_COMP := 130
global TR_IND  := 210

global Strats := [
    "Up,Down,Right,Left,Up",             ; slot 1 Reinforce   (hardcoded)
    "Down,Down,Up,Right",                ; slot 2 Resupply    (hardcoded)
    "Up,Right,Down,Right",               ; slot 3 - Eagle Airstrike
    "Right,Down,Up,Right,Down",          ; slot 4 - Orbital Laser
    "Up,Right,Down,Down,Down",           ; slot 5 - Eagle 500KG Bomb
    "Left,Down,Right,Up,Left,Down,Down", ; slot 6 - Patriot Exosuit
    "Down,Down,Left,Up,Right",           ; slot 7 - Expendable Anti-Tank
    "Down,Left,Right,Right,Left",        ; slot 8 - Recoilless Rifle
    "Down,Up,Up,Down,Up"                 ; slot 9 - Jump Pack
]
global SOS := "Up,Down,Right,Up"

LoadFile := "stratagem_loadout.ini"

; Default slot names for first-run (no loadout file)
global DefaultSlots := [
    "Eagle Airstrike",
    "Orbital Laser",
    "Eagle 500KG Bomb",
    "Patriot Exosuit",
    "Expendable Anti-Tank",
    "Recoilless Rifle",
    "Jump Pack"
]

; ============================================================
; MASTER STRATAGEM LIST  (102 entries)
; ============================================================
global Stratagems := [
    ; --- MISSION & OBJECTIVE ---
    {Name: "Call In Super Destroyer",      Keys: "Up,Up,Down,Down,Left,Right,Left,Right"},
    {Name: "Cargo Container",              Keys: "Down,Up,Down,Down,Down"},
    {Name: "Data Jack",                    Keys: "Right,Down,Up,Up,Down"},
    {Name: "Dark Fluid Vessel",            Keys: "Up,Left,Right,Down,Up,Up"},
    {Name: "Eagle Rearm",                  Keys: "Up,Up,Left,Up,Right"},
    {Name: "Hive Breaker Drill",           Keys: "Left,Up,Down,Right,Down,Down"},
    {Name: "NUX-223 Hellbomb",             Keys: "Down,Up,Left,Down,Up,Right,Down,Up"},
    {Name: "Orbital Illumination Flare",   Keys: "Right,Right,Left,Left"},
    {Name: "Prospecting Drill",            Keys: "Down,Down,Left,Right,Down,Down"},
    {Name: "Reinforce",                    Keys: "Up,Down,Right,Left,Up"},
    {Name: "Resupply",                     Keys: "Down,Down,Up,Right"},
    {Name: "SEAF Artillery",               Keys: "Right,Up,Up,Down"},
    {Name: "Seismic Probe",                Keys: "Up,Up,Left,Right,Down,Down"},
    {Name: "SOS Beacon",                   Keys: "Up,Down,Right,Up"},
    {Name: "SSSD Delivery",                Keys: "Down,Down,Down,Up,Up"},
    {Name: "Super Earth Flag",             Keys: "Down,Up,Down,Up"},
    {Name: "Tectonic Drill",               Keys: "Up,Down,Up,Down,Up,Down"},
    {Name: "Upload Data",                  Keys: "Left,Right,Up,Up,Up"},

    ; --- ORBITAL ---
    {Name: "Orbital 120MM HE Barrage",     Keys: "Right,Right,Down,Left,Right,Down"},
    {Name: "Orbital 380MM HE Barrage",     Keys: "Right,Down,Up,Up,Left,Down,Down"},
    {Name: "Orbital Airburst Strike",      Keys: "Right,Right,Right"},
    {Name: "Orbital EMS Strike",           Keys: "Right,Right,Left,Down"},
    {Name: "Orbital Gas Strike",           Keys: "Right,Right,Down,Right"},
    {Name: "Orbital Gatling Barrage",      Keys: "Right,Down,Left,Up,Up"},
    {Name: "Orbital Laser",                Keys: "Right,Down,Up,Right,Down"},
    {Name: "Orbital Napalm Barrage",       Keys: "Right,Right,Down,Left,Right,Up"},
    {Name: "Orbital Precision Strike",     Keys: "Right,Right,Up"},
    {Name: "Orbital Railcannon Strike",    Keys: "Right,Up,Down,Down,Right"},
    {Name: "Orbital Smoke Strike",         Keys: "Right,Right,Down,Up"},
    {Name: "Orbital Walking Barrage",      Keys: "Right,Down,Right,Down,Right,Down"},

    ; --- EAGLE ---
    {Name: "Eagle 110MM Rocket Pods",      Keys: "Up,Right,Up,Left"},
    {Name: "Eagle 500KG Bomb",             Keys: "Up,Right,Down,Down,Down"},
    {Name: "Eagle Airstrike",              Keys: "Up,Right,Down,Right"},
    {Name: "Eagle Cluster Bomb",           Keys: "Up,Right,Down,Down,Right"},
    {Name: "Eagle Napalm Airstrike",       Keys: "Up,Right,Down,Up"},
    {Name: "Eagle Smoke Strike",           Keys: "Up,Right,Up,Down"},
    {Name: "Eagle Strafing Run",           Keys: "Up,Right,Right"},

    ; --- SUPPORT WEAPONS & BACKPACKS ---
    {Name: "Airburst Rocket Launcher",     Keys: "Down,Up,Up,Left,Right"},
    {Name: "Anti-Materiel Rifle",          Keys: "Down,Left,Right,Up,Down"},
    {Name: "Arc Thrower",                  Keys: "Down,Right,Down,Up,Left,Left"},
    {Name: "Autocannon",                   Keys: "Down,Left,Down,Up,Up,Right"},
    {Name: "AX/ARC-3 K-9",                Keys: "Down,Up,Left,Up,Right,Left"},
    {Name: "AX/FLAM-75 Hot Dog",           Keys: "Down,Up,Left,Up,Left,Left"},
    {Name: "Ballistic Shield Backpack",    Keys: "Down,Left,Down,Down,Up,Left"},
    {Name: "Breaching Hammer",             Keys: "Down,Left,Right,Left,Up"},
    {Name: "C4 Pack",                      Keys: "Down,Right,Up,Up,Right,Up"},
    {Name: "Commando",                     Keys: "Down,Left,Up,Down,Right"},
    {Name: "Cremator",                     Keys: "Down,Down,Right,Down,Up,Up"},
    {Name: "De-Escalator",                 Keys: "Down,Right,Up,Left,Right"},
    {Name: "Defoliation Tool",             Keys: "Down,Left,Up,Down,Up,Right"},
    {Name: "Epoch",                        Keys: "Down,Left,Up,Left,Right"},
    {Name: "Expendable Anti-Tank",         Keys: "Down,Down,Left,Up,Right"},
    {Name: "Expendable Napalm",            Keys: "Down,Down,Left,Up,Left"},
    {Name: "Flamethrower",                 Keys: "Down,Left,Up,Down,Up"},
    {Name: "Grenade Launcher",             Keys: "Down,Left,Up,Left,Down"},
    {Name: "Guard Dog",                    Keys: "Down,Up,Left,Up,Right,Down"},
    {Name: "Guard Dog (Dog Breath)",       Keys: "Down,Up,Left,Up,Right,Up"},
    {Name: "Guard Dog Rover",              Keys: "Down,Up,Left,Up,Right,Right"},
    {Name: "Heavy Machine Gun",            Keys: "Down,Left,Up,Down,Down"},
    {Name: "Hover Pack",                   Keys: "Down,Up,Up,Down,Left,Right"},
    {Name: "Jump Pack",                    Keys: "Down,Up,Up,Down,Up"},
    {Name: "Laser Cannon",                 Keys: "Down,Left,Down,Up,Left"},
    {Name: "Leveller",                     Keys: "Down,Down,Left,Up,Down"},
    {Name: "Maxigun",                      Keys: "Down,Left,Right,Down,Up,Up"},
    {Name: "MG-43 Machine Gun",            Keys: "Down,Left,Down,Up,Right"},
    {Name: "MS-11 Solo Silo",              Keys: "Down,Up,Right,Down,Down"},
    {Name: "One True Flag",                Keys: "Down,Left,Right,Right,Up"},
    {Name: "Quasar Cannon",                Keys: "Down,Down,Up,Left,Right"},
    {Name: "Railgun",                      Keys: "Down,Right,Down,Up,Left,Right"},
    {Name: "Recoilless Rifle",             Keys: "Down,Left,Right,Right,Left"},
    {Name: "S-11 Speargun",                Keys: "Down,Right,Down,Left,Up,Right"},
    {Name: "Shield Generator Pack",        Keys: "Down,Up,Left,Right,Left,Right"},
    {Name: "Spear",                        Keys: "Down,Down,Up,Down,Down"},
    {Name: "StA-X3 W.A.S.P. Launcher",    Keys: "Down,Down,Up,Down,Right"},
    {Name: "Stalwart",                     Keys: "Down,Left,Down,Up,Up,Left"},
    {Name: "Sterilizer",                   Keys: "Down,Left,Up,Down,Left"},
    {Name: "Supply Pack",                  Keys: "Down,Left,Down,Up,Up,Down"},
    {Name: "Warp Pack",                    Keys: "Down,Left,Right,Down,Left,Right"},

    ; --- DEFENSIVE & EMPLACEMENTS ---
    {Name: "Anti-Personnel Minefield",     Keys: "Down,Left,Up,Right"},
    {Name: "Anti-Tank Emplacement",        Keys: "Down,Up,Left,Right,Right,Right"},
    {Name: "Anti-Tank Mines",              Keys: "Down,Left,Up,Up"},
    {Name: "Autocannon Sentry",            Keys: "Down,Up,Right,Up,Left,Up"},
    {Name: "Directional Shield",           Keys: "Down,Up,Left,Right,Up,Up"},
    {Name: "EMS Mortar Sentry",            Keys: "Down,Up,Right,Down,Right"},
    {Name: "Flame Sentry",                 Keys: "Down,Up,Right,Down,Up,Up"},
    {Name: "Gas Mines",                    Keys: "Down,Left,Left,Right"},
    {Name: "Gas Mortar Sentry",            Keys: "Down,Up,Right,Down,Left"},
    {Name: "Gatling Sentry",               Keys: "Down,Up,Right,Left"},
    {Name: "Grenadier Battlement",         Keys: "Down,Right,Down,Left,Right"},
    {Name: "HMG Emplacement",              Keys: "Down,Up,Left,Right,Right,Left"},
    {Name: "Incendiary Mines",             Keys: "Down,Left,Left,Down"},
    {Name: "Laser Sentry",                 Keys: "Down,Up,Right,Down,Up,Right"},
    {Name: "Machine Gun Sentry",           Keys: "Down,Up,Right,Right,Up"},
    {Name: "Mortar Sentry",                Keys: "Down,Up,Right,Right,Down"},
    {Name: "Portable Hellbomb",            Keys: "Down,Right,Up,Up,Up"},
    {Name: "Rocket Sentry",                Keys: "Down,Up,Right,Right,Left"},
    {Name: "Shield Generator Relay",       Keys: "Down,Up,Left,Right,Left,Right"},
    {Name: "Tesla Tower",                  Keys: "Down,Up,Right,Up,Left,Right"},

    ; --- EXOSUITS & VEHICLES ---
    {Name: "Emancipator Exosuit",          Keys: "Left,Down,Right,Up,Left,Down,Up"},
    {Name: "Fast Recon Vehicle",           Keys: "Left,Down,Right,Down,Right,Down,Up"},
    {Name: "Patriot Exosuit",              Keys: "Left,Down,Right,Up,Left,Down,Down"},
    {Name: "TD-220 Bastion MK XVI",        Keys: "Left,Down,Right,Down,Left,Down,Up,Down,Up"}
]

; Flat name list for ComboBox population
StratNameList := []
for s in Stratagems
    StratNameList.Push(s.Name)

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
    global Stratagems
    for s in Stratagems {
        if s.Name = name
            return s.Keys
    }
    if RegExMatch(name, "^(Up|Down|Left|Right)(,(Up|Down|Left|Right))*$")
        return name
    return ""
}

BuildHUDLine(slot, name, seq, activeStep := 0) {
    arrows    := StrSplit(seq, ",")
    label     := (slot = 0) ? " C+0" : "C+" slot
    nameTrunc := StrLen(name) > 15 ? SubStr(name, 1, 14) "~" : name
    namePad   := Format("{:-15s}", nameTrunc)
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
global GW      := 460
global PX      := 12
global IW      := GW - PX * 2
global LbW     := 24    ; slot-number label width (fits "C+N")
global CbX     := PX + LbW + 4
global CbW     := GW - CbX - PX
global LblFldW := 72    ; display-name override edit width
global AdjCbW  := CbW - LblFldW - 4

; ============================================================
;  BUILD GFull  — config + HUD overlay
; ============================================================
global GFull := Gui("+AlwaysOnTop -Caption -DPIScale")
GFull.BackColor := "080812"
GFull.MarginX   := 0
GFull.MarginY   := 0

fy := 0

; ── top accent ───────────────────────────────────────────────
GFull.Add("Text", "x0 y0 w" GW " h2 BackgroundFFD700")
fy += 2
GFull.Add("Text", "x0 y" fy " w" GW " h1 Background4FC3F7")
fy += 1

; ── title bar ────────────────────────────────────────────────
GFull.Add("Text", "x0 y" fy " w" GW " h46 Background0B0B1C")
GFull.SetFont("s10 Bold cFFD700", "Courier New")
GFull.Add("Text", "x" PX " y" (fy+4) " w" (GW-PX-44) " h14 Background0B0B1C",
    "S.T.R.A.T.A.G.E.M.")
GFull.SetFont("s6 c4A8A9A", "Courier New")
GFull.Add("Text", "x" PX " y" (fy+20) " w" (GW-PX-44) " h10 Background0B0B1C",
    "SMART TRIGGER REGULATION AND TACTICAL ACTION")
GFull.Add("Text", "x" PX " y" (fy+31) " w" (GW-PX-44) " h10 Background0B0B1C",
    "GUIDANCE EXECUTION MANAGER  //  v4.8.6  //  102 STRATAGEMS")
GFull.SetFont("s11 Bold cC8A227", "Courier New")
GFull.Add("Text", "x" (GW-42) " y" (fy+7) " w30 h28 Background0B0B1C", "✦")
fy += 46

; ── gold separator ───────────────────────────────────────────
GFull.Add("Text", "x0 y" fy " w" GW " h1 BackgroundC8A227")
fy += 1

; ── rapid fire warning ───────────────────────────────────────
GFull.Add("Text", "x0 y" fy " w" GW " h12 Background0A0A16")
GFull.SetFont("s6 cAA2222", "Courier New")
GFull.Add("Text", "x" PX " y" (fy+1) " w" IW " h10 Center Background0A0A16",
    "! RAPID FIRE: avoid full-auto weapons  //  [End] to toggle")
fy += 12

; ── SETTINGS section ─────────────────────────────────────────
GFull.Add("Text", "x0 y" fy " w" GW " h1 Background1A2A3A")
fy += 1
GFull.Add("Text", "x0 y" fy " w" GW " h14 Background0B1020")
GFull.SetFont("s6 Bold cFFD700", "Courier New")
GFull.Add("Text", "x" PX " y" (fy+2) " w80 h10 Background0B1020", "SETTINGS")
GFull.SetFont("s6 c2A4A6A", "Courier New")
GFull.Add("Text", "x" (GW-PX-110) " y" (fy+2) " w110 h10 Right Background0B1020",
    "OPACITY")
fy += 14

; full opacity row
GFull.Add("Text", "x0 y" fy " w" GW " h18 Background080810")
GFull.SetFont("s6 c4A8A9A", "Courier New")
GFull.Add("Text", "x" PX " y" (fy+4) " w28 h10 Background080810", "FULL")
global FOpacVal := GFull.Add("Text",
    "x" (GW-PX-24) " y" (fy+4) " w24 h10 Right c7AACBC Background080810", TR_FULL)
global FOpacSlider := GFull.Add("Slider",
    "x" (PX+32) " y" (fy+1) " w" (IW-58) " h16 Range50-255 TickInterval51",
    TR_FULL)
FOpacSlider.OnEvent("Change", ApplyOpacity)
fy += 18

; compact opacity row
GFull.Add("Text", "x0 y" fy " w" GW " h18 Background080810")
GFull.SetFont("s6 c4A8A9A", "Courier New")
GFull.Add("Text", "x" PX " y" (fy+4) " w28 h10 Background080810", "COMP")
global FCompOpacVal := GFull.Add("Text",
    "x" (GW-PX-24) " y" (fy+4) " w24 h10 Right c7AACBC Background080810", TR_COMP)
global FCompOpacSlider := GFull.Add("Slider",
    "x" (PX+32) " y" (fy+1) " w" (IW-58) " h16 Range50-255 TickInterval51",
    TR_COMP)
FCompOpacSlider.OnEvent("Change", ApplyCompactOpacity)
fy += 18

fy += 3

; ── LOADOUT section ──────────────────────────────────────────
GFull.Add("Text", "x0 y" fy " w" GW " h1 Background1A2A3A")
fy += 1
GFull.Add("Text", "x0 y" fy " w" GW " h14 Background0B1020")
GFull.SetFont("s6 Bold cFFD700", "Courier New")
GFull.Add("Text", "x" PX " y" (fy+2) " w80 h10 Background0B1020", "LOADOUT")
GFull.SetFont("s6 c2A4A6A", "Courier New")
GFull.Add("Text", "x" (GW-PX-130) " y" (fy+2) " w130 h10 Right Background0B1020",
    "CTRL+1-9  //  SLOTS 3-9")
fy += 14

; column labels
GFull.Add("Text", "x0 y" fy " w" GW " h11 Background090914")
GFull.SetFont("s5 c2A5A6A", "Courier New")
GFull.Add("Text", "x" CbX " y" (fy+1) " w100 h9 Background090914", "STRATAGEM")
GFull.Add("Text", "x" (CbX+AdjCbW+4) " y" (fy+1) " w" LblFldW " h9 Center Background090914",
    "LABEL")
fy += 11

; hardcoded rows (Reinforce, Resupply)
HardNames := ["Reinforce", "Resupply"]
Loop 2 {
    i   := A_Index
    rbg := (Mod(i, 2) = 0) ? "0C0C1E" : "0A0A18"
    GFull.Add("Text", "x0 y" fy " w4 h20 BackgroundAA2222")
    GFull.Add("Text", "x4 y" fy " w" (GW-4) " h20 Background" rbg)
    GFull.SetFont("s7 Bold cFFD700", "Courier New")
    GFull.Add("Text", "x" PX " y" (fy+3) " w" LbW " h14 Background" rbg, i)
    GFull.SetFont("s7 c8A8AA0", "Courier New")
    GFull.Add("Text", "x" CbX " y" (fy+3) " w" AdjCbW " h14 Background" rbg, HardNames[i])
    GFull.SetFont("s5 c2A2A55", "Courier New")
    GFull.Add("Text", "x" (CbX+AdjCbW+4) " y" (fy+6) " w" LblFldW " h9 Center Background" rbg,
        "LOCKED")
    fy += 20
    GFull.Add("Text", "x0 y" fy " w" GW " h1 Background14142A")
    fy += 1
}

; divider
GFull.Add("Text", "x4 y" fy " w" (GW-4) " h2 Background0C0C1E")
fy += 2

; custom slot rows (C+3 through C+9)
global Drops := []
Loop 7 {
    j   := A_Index
    i   := j + 2
    rbg := (Mod(i, 2) = 0) ? "0C0C1E" : "0A0A18"
    GFull.Add("Text", "x0 y" fy " w4 h20 BackgroundB8921E")
    GFull.Add("Text", "x4 y" fy " w" (GW-4) " h20 Background" rbg)
    GFull.SetFont("s7 Bold c4FC3F7", "Courier New")
    GFull.Add("Text", "x" PX " y" (fy+3) " w" LbW " h14 Background" rbg, "C+" i)
    GFull.SetFont("s7 cC8A850", "Courier New")
    d := GFull.Add("ComboBox",
        "x" CbX " y" (fy+1) " w" AdjCbW " h200 vStrat" i " Background0A0918 cC8C890",
        StratNameList)
    d.OnEvent("Change", UpdateOverlayFromDrops)
    try DllCall("uxtheme\SetWindowTheme", "Ptr", d.Hwnd, "Str", "DarkMode_CFD", "Ptr", 0)
    Drops.Push(d)
    GFull.SetFont("s7 c6A8A6A", "Courier New")
    le := GFull.Add("Edit",
        "x" (CbX+AdjCbW+4) " y" (fy+2) " w" LblFldW " h16 Background0A0918 c8ABB70")
    SendMessage(0x1501, 1, StrPtr("label"), le.Hwnd)
    le.OnEvent("Change", (*) => UpdateOverlay())
    LabelEdits.Push(le)
    fy += 20
    if j < 7 {
        GFull.Add("Text", "x0 y" fy " w" GW " h1 Background14142A")
        fy += 1
    }
}

; gold separator + deploy
GFull.Add("Text", "x0 y" fy " w" GW " h1 BackgroundC8A227")
fy += 1
fy += 3
GFull.SetFont("s7 Bold c22C55E", "Courier New")
FSaveBtn := GFull.Add("Button", "x" PX " y" fy " w" IW " h20", ">> DEPLOY LOADOUT <<")
FSaveBtn.OnEvent("Click", SaveLoadout)
try DllCall("uxtheme\SetWindowTheme", "Ptr", FSaveBtn.Hwnd, "Str", "DarkMode_Explorer", "Ptr", 0)
fy += 24

; ── ACTIVE HUD section ───────────────────────────────────────
GFull.Add("Text", "x0 y" fy " w" GW " h1 Background1A2A3A")
fy += 1
GFull.Add("Text", "x0 y" fy " w" GW " h14 Background0B1020")
GFull.SetFont("s6 Bold cFFD700", "Courier New")
GFull.Add("Text", "x" PX " y" (fy+2) " w80 h10 Background0B1020", "ACTIVE HUD")
GFull.SetFont("s6 c2A4A6A", "Courier New")
GFull.Add("Text", "x" (GW-PX-110) " y" (fy+2) " w110 h10 Right Background0B1020",
    "CTRL+0 SOS BEACON")
fy += 14

GFull.Add("Text", "x0 y" fy " w" GW " h185 Background050508")
GFull.SetFont("s8 Bold cFFD700", "Courier New")
global FOverlay := GFull.Add("Text",
    "x" PX " y" (fy+4) " w" IW " h177 Background050508", "")
fy += 185

; ── status bar ───────────────────────────────────────────────
GFull.Add("Text", "x0 y" fy " w" GW " h1 BackgroundC8A227")
fy += 1
GFull.Add("Text", "x0 y" fy " w" GW " h18 Background07070F")
GFull.SetFont("s6 Bold c22C55E", "Courier New")
global FStatus := GFull.Add("Text",
    "x" PX " y" (fy+4) " w70 h10 Background07070F", "ONLINE")
GFull.SetFont("s6 Bold cCC3333", "Courier New")
global FRapid := GFull.Add("Text",
    "x" (GW//2-38) " y" (fy+4) " w76 h10 Center Background07070F", "RAPID  O")
GFull.SetFont("s6 c2A4A6A", "Courier New")
GFull.Add("Text",
    "x" (GW-PX-136) " y" (fy+4) " w136 h10 Right Background07070F",
    "[-]COMPACT  [END]RAPID")
fy += 18

; ── FOR SUPER-EARTH ──────────────────────────────────────────
GFull.Add("Text", "x0 y" fy " w" GW " h1 Background2A5A8A")
fy += 1
GFull.Add("Text", "x0 y" fy " w" GW " h18 Background0C1525")
GFull.SetFont("s7 Bold c4FC3F7", "Courier New")
GFull.Add("Text", "x0 y" (fy+3) " w" GW " h12 Center Background0C1525",
    "FOR SUPER-EARTH!")
fy += 18

; ── bottom accent ────────────────────────────────────────────
GFull.Add("Text", "x0 y" fy " w" GW " h1 Background4FC3F7")
fy += 1
GFull.Add("Text", "x0 y" fy " w" GW " h2 BackgroundFFD700")
fy += 2

global FullH := fy

; ============================================================
;  BUILD GComp  — compact click-through HUD overlay
; ============================================================
global GComp := Gui("+AlwaysOnTop -Caption -DPIScale +ToolWindow +E0x80000")
GComp.BackColor := "080812"
GComp.MarginX   := 0
GComp.MarginY   := 0

cy := 0

; ── top accent ───────────────────────────────────────────────
GComp.Add("Text", "x0 y0 w" GW " h2 BackgroundFFD700")
cy += 2
GComp.Add("Text", "x0 y" cy " w" GW " h1 Background4FC3F7")
cy += 1

; ── compact title bar ────────────────────────────────────────
GComp.Add("Text", "x0 y" cy " w" GW " h22 Background0B0B1C")
GComp.SetFont("s7 Bold cFFD700", "Courier New")
GComp.Add("Text", "x" PX " y" (cy+4) " w" (GW//2-PX) " h14 Background0B0B1C",
    "S.T.R.A.T.A.G.E.M.")
GComp.SetFont("s6 c3A7A8A", "Courier New")
GComp.Add("Text", "x" (GW//2) " y" (cy+6) " w" (GW//2-PX) " h10 Right Background0B0B1C",
    "COMPACT  [-]")
cy += 22

; ── gold separator + padding ─────────────────────────────────
GComp.Add("Text", "x0 y" cy " w" GW " h1 BackgroundC8A227")
cy += 1
cy += 3

; ── HUD overlay ──────────────────────────────────────────────
GComp.Add("Text", "x0 y" cy " w" GW " h185 Background050508")
GComp.SetFont("s8 Bold cFFD700", "Courier New")
global COverlay := GComp.Add("Text",
    "x" PX " y" (cy+4) " w" IW " h177 Background050508", "")
cy += 185

; ── status bar ───────────────────────────────────────────────
GComp.Add("Text", "x0 y" cy " w" GW " h1 BackgroundC8A227")
cy += 1
cy += 3
GComp.Add("Text", "x0 y" cy " w" GW " h18 Background07070F")
GComp.SetFont("s6 Bold c22C55E", "Courier New")
global CStatus := GComp.Add("Text",
    "x" PX " y" (cy+4) " w70 h10 Background07070F", "ONLINE")
GComp.SetFont("s6 Bold cCC3333", "Courier New")
global CRapid := GComp.Add("Text",
    "x" (GW//2-38) " y" (cy+4) " w76 h10 Center Background07070F", "RAPID  O")
GComp.SetFont("s6 c2A4A6A", "Courier New")
GComp.Add("Text",
    "x" (GW-PX-118) " y" (cy+4) " w118 h10 Right Background07070F",
    "[-]FULL  [END]RAPID")
cy += 18

; ── FOR SUPER-EARTH ──────────────────────────────────────────
GComp.Add("Text", "x0 y" cy " w" GW " h1 Background2A5A8A")
cy += 1
GComp.Add("Text", "x0 y" cy " w" GW " h18 Background0C1525")
GComp.SetFont("s7 Bold c4FC3F7", "Courier New")
GComp.Add("Text", "x0 y" (cy+3) " w" GW " h12 Center Background0C1525",
    "FOR SUPER-EARTH!")
cy += 18

; ── bottom accent ────────────────────────────────────────────
GComp.Add("Text", "x0 y" cy " w" GW " h1 Background4FC3F7")
cy += 1
GComp.Add("Text", "x0 y" cy " w" GW " h2 BackgroundFFD700")
cy += 2

global CompH := cy

; ============================================================
;  BUILD GIndicator  — tiny rapid-fire dot when HUD hidden
; ============================================================
global IndW := 72
global IndH := 14
global GIndicator := Gui("+AlwaysOnTop -Caption -DPIScale +ToolWindow +E0x80000")
GIndicator.BackColor := "0A0008"
GIndicator.MarginX := 0
GIndicator.MarginY := 0
GIndicator.SetFont("s6 Bold cFF2222", "Courier New")
global GIndText := GIndicator.Add("Text", "x3 y2 w66 h10 BackgroundTrans", "RAPID ON")

; ============================================================
; PREVENT WINDOW MOVEMENT (GFull only; GComp is click-through)
; ============================================================
OnMessage(0x0084, WM_NCHITTEST_Block)
WM_NCHITTEST_Block(wParam, lParam, msg, hwnd) {
    global GFull
    if hwnd = GFull.Hwnd
        return 1
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
; UPDATE ALL SLOTS FROM DROPDOWNS
; ============================================================
UpdateOverlayFromDrops(*) {
    global Drops
    Loop 7 {
        SetStratFromName(A_Index + 2, Drops[A_Index].Text)
    }
    UpdateOverlay()
}

; ============================================================
; LOAD / DEFAULT
; ============================================================
if FileExist(LoadFile) {
    Lines := StrSplit(FileRead(LoadFile), "`n", "`r")
    Loop 7 {
        j    := A_Index
        i    := j + 2
        name := Lines.Length >= j ? Trim(Lines[j]) : DefaultSlots[j]
        Drops[j].Text := name
        SetStratFromName(i, name)
    }
    ; line 8 — saved opacity (v4.8.1)
    if Lines.Length >= 8 {
        raw := Trim(Lines[8])
        if IsInteger(raw) {
            val := Integer(raw)
            if val >= 50 && val <= 255 {
                TR_FULL := val
                FOpacSlider.Value := val
                FOpacVal.Value    := val
            }
        }
    }
    ; lines 9-10 — saved compact position (v4.8.2)
    if Lines.Length >= 9 && IsInteger(Trim(Lines[9]))
        CompactX := Integer(Trim(Lines[9]))
    if Lines.Length >= 10 && IsInteger(Trim(Lines[10]))
        CompactY := Integer(Trim(Lines[10]))
    ; line 11 — saved compact opacity
    if Lines.Length >= 11 {
        raw := Trim(Lines[11])
        if IsInteger(raw) {
            val := Integer(raw)
            if val >= 50 && val <= 255 {
                TR_COMP := val
                FCompOpacSlider.Value := val
                FCompOpacVal.Value    := val
            }
        }
    }
    ; lines 12-18 — display name overrides (v4.8.4)
    Loop 7 {
        lineIdx := 11 + A_Index
        if Lines.Length >= lineIdx
            LabelEdits[A_Index].Value := Trim(Lines[lineIdx])
    }
} else {
    Loop 7 {
        j := A_Index
        Drops[j].Text := DefaultSlots[j]
        SetStratFromName(j + 2, DefaultSlots[j])
    }
}

; ============================================================
; POSITION & SHOW
; ============================================================
MonitorGetWorkArea(, &WALeft, &WATop, &WARight, &WABottom)
UsableW := WARight - WALeft
Mrg     := Max(8, Round(UsableW * 0.01))
Xpos    := WARight - GW - Mrg
Ypos    := WATop + Mrg

GFull.Show("x" Xpos " y" Ypos " w" GW " h" FullH " NoActivate")
CompXpos := (CompactX >= 0) ? CompactX : Xpos
CompYpos := (CompactY >= 0) ? CompactY : Ypos
GComp.Show("x" CompXpos " y" CompYpos " w" GW " h" CompH " NoActivate")
GComp.Hide()

WinSetTransparent(TR_FULL, GFull.Hwnd)
WinSetTransparent(TR_COMP, GComp.Hwnd)
WinSetExStyle("+0x20", GComp.Hwnd)

GIndicator.Show("x" (WARight - IndW - Mrg) " y" (WATop + Mrg) " w" IndW " h" IndH " NoActivate")
GIndicator.Hide()
WinSetTransparent(TR_IND, GIndicator.Hwnd)
WinSetExStyle("+0x20", GIndicator.Hwnd)

UpdateOverlay()

; ============================================================
; SAVE
; ============================================================
SaveLoadout(*) {
    global Drops, TR_FULL, CompactX, CompactY, GComp, LabelEdits
    Loop 7 {
        SetStratFromName(A_Index + 2, Drops[A_Index].Text)
    }
    content := ""
    Loop 7 {
        content .= Drops[A_Index].Text . "`n"
    }
    content .= TR_FULL . "`n"
    WinGetPos(&cx, &cy, , , GComp.Hwnd)
    content .= cx . "`n"
    content .= cy . "`n"
    content .= TR_COMP
    Loop 7 {
        content .= "`n" LabelEdits[A_Index].Value
    }
    f := FileOpen(LoadFile, "w")
    f.Write(content)
    f.Close()
    UpdateOverlay()
    FlashDeploy()
}

; ============================================================
; DISPLAY
; ============================================================
UpdateOverlay() {
    global ActiveSlot, ActiveStep, Strats, SOS, FOverlay, COverlay, Drops, LabelEdits
    lines := ""
    Loop 9 {
        i       := A_Index
        seq     := Strats[i]
        rawName := (i = 1) ? "Reinforce" : (i = 2) ? "Resupply" : Drops[i - 2].Text
        lbl     := (i >= 3) ? Trim(LabelEdits[i - 2].Value) : ""
        name    := (lbl != "") ? lbl : rawName
        lines .= BuildHUDLine(i, name, seq, (i = ActiveSlot ? ActiveStep : 0)) "`n"
    }
    lines .= "-- SOS -------------`n"
    lines .= BuildHUDLine(0, "SOS Beacon", SOS, (ActiveSlot = 0 ? ActiveStep : 0))
    FOverlay.Value := lines
    COverlay.Value := lines
}

UpdateIndicator() {
    global HUDVisible, RapidToggle, GIndicator
    if (!HUDVisible && RapidToggle)
        GIndicator.Show("NoActivate")
    else
        GIndicator.Hide()
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
    global TR_FULL
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

ApplyOpacity(*) {
    global FOpacSlider, FOpacVal, TR_FULL, GFull
    TR_FULL := FOpacSlider.Value
    FOpacVal.Value := TR_FULL
    WinSetTransparent(TR_FULL, GFull.Hwnd)
}

ApplyCompactOpacity(*) {
    global FCompOpacSlider, FCompOpacVal, TR_COMP, GComp
    TR_COMP := FCompOpacSlider.Value
    FCompOpacVal.Value := TR_COMP
    WinSetTransparent(TR_COMP, GComp.Hwnd)
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
    global CompactMode, HUDVisible, CompactX, CompactY
    CompactMode := !CompactMode
    if HUDVisible {
        if CompactMode {
            WinGetPos(&wx, &wy, , , GFull.Hwnd)
            GFull.Hide()
            startX := (CompactX >= 0) ? CompactX : wx
            startY := (CompactY >= 0) ? CompactY : wy
            GComp.Show("x" startX " y" startY " NoActivate")
        } else {
            WinGetPos(&wx, &wy, , , GComp.Hwnd)
            CompactX := wx
            CompactY := wy
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
        SetAllRapid("RAPID  @")
        ToolTip("RAPID FIRE ACTIVE", tx, ty)
    } else {
        SetAllRapid("RAPID  O")
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
        SetAllRapid("RAPID  O")
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
