```
╔══════════════════════════════════════════╗
║  S.T.R.A.T.A.G.E.M.  T E R M I N A L   ║
║         v 4 . 7   //   H D 2            ║
╚══════════════════════════════════════════╝
```

# S.T.R.A.T.A.G.E.M. TERMINAL
## v4.7 - Smart Trigger Regulation And Tactical Action Guidance Execution Manager

---

> **DISCLAIMER - READ BEFORE USE**
>
> This tool operates in a **legal gray area**. Using third-party macro software in online games may violate Helldivers 2's Terms of Service or the terms of your platform (Steam, PSN). Use of this tool could result in account warnings, suspensions, or permanent bans. I am not responsible for any consequences resulting from the use of this software, including but not limited to: account penalties, bans, loss of game progress, emotional distress, or any damage to your property or hardware. **Use entirely at your own risk.**
>
> The stratagem casting function sends keyboard inputs to the game. The rapid fire function intercepts and re-sends mouse button events. Both are detectable in principle by anti-cheat systems. I make no guarantees about detection rates, ban rates, or ongoing game compatibility. This project is provided as-is, for educational and personal use only.

---

## SECTION 1: Overview

**S.T.R.A.T.A.G.E.M. TERMINAL** is an AutoHotkey v2 overlay utility for **Helldivers 2** that puts a fully configurable stratagem casting HUD directly on your screen while you play. Rather than memorizing arrow sequences under fire, you configure your loadout once, then fire any stratagem with a single `Ctrl+N` hotkey - the script handles the directional input automatically.

**Key capabilities:**

- **9 loadout slots** - Slots 0 (SOS Beacon), 1 (Reinforce), and 2 (Resupply) are hardcoded. Slots 3–9 are fully customizable from a searchable dropdown.
- **102 stratagems in the built-in database** - covering Mission & Objective, Orbital, Eagle, Support Weapons & Backpacks, Defensive & Emplacements, and Exosuits & Vehicles.
- **Rapid-fire mode** - jittered automatic mouse input (42–68 ms interval, 18–32 ms hold) toggled via the `End` key for semi-auto weapons.
- **Compact click-through overlay** - press `-` to collapse the config panel to a minimal HUD that passes all mouse input through to the game.
- **HUD visibility controls** - press `=` to hide/show the entire HUD without closing the script. A tiny **RAPID ON** indicator persists in the top-right corner if rapid fire is still active while the HUD is hidden.
- **Persistent loadout storage** - slot assignments are saved to `stratagem_loadout.ini` and restored on next launch.
- **Live cast animation** - the active HUD line shows a step-by-step progress indicator as each directional key is sent.

---

## SECTION 2: Requirements

- **AutoHotkey v2.0 or later** - https://www.autohotkey.com/
- **Windows 10 or Windows 11**
- **Helldivers 2** (Steam or otherwise)

> The script uses `#HotIf WinActive("ahk_exe helldivers2.exe")` to scope in-game hotkeys, so stratagems only fire when the game window is focused.

---

## SECTION 3: Installation

1. **Install AutoHotkey v2** from https://www.autohotkey.com/ - choose the v2 installer (not v1.x).
2. **Download or clone** this repository to any local folder (e.g., `C:\Users\Owner\HellDiversMacros\`).
3. Confirm the folder contains `Helldivers.ahk`.
4. **Double-click `Helldivers.ahk`** to launch the script. An AHK icon will appear in the system tray.
5. On first run, the HUD appears on the **right edge of your primary monitor**, vertically centered. A default loadout (Eagle Airstrike, Orbital Laser, Eagle 500KG Bomb, Patriot Exosuit, Expendable Anti-Tank, Recoilless Rifle, Jump Pack) is loaded into slots 3–9.
6. **Optional:** Right-click the system tray AHK icon and choose **Open** or configure it to run on startup via Task Scheduler or the Windows Startup folder.

---

## SECTION 4: Quick Start

1. **Launch the script** - the full config panel appears docked to the right side of your screen.
2. **Assign your loadout** - use the dropdown boxes in slots 3–9 to select stratagems. Type in the box to filter by name.
3. **Click `>> DEPLOY LOADOUT <<`** - this saves your choices to `stratagem_loadout.ini` and flashes the status bar with **DEPLOYED!**
4. **Launch Helldivers 2** and focus the game window.
5. **Hold `Ctrl` and press a number key** (0–9) to cast the corresponding stratagem.
6. **Press `-`** to switch to compact mode (click-through overlay only) when you no longer need the config panel.
7. **Press `End`** to toggle rapid fire on or off. Watch the status bar: **RAPID @** means active.
8. **Press `=`** to hide the HUD entirely if you want a clean screen.

---

## SECTION 5: Hotkey Reference

| Hotkey | Action | Context |
|---|---|---|
| `Ctrl+0` | Cast SOS Beacon (hardcoded) | In-game only |
| `Ctrl+1` | Cast Reinforce (hardcoded) | In-game only |
| `Ctrl+2` | Cast Resupply (hardcoded) | In-game only |
| `Ctrl+3` | Cast custom slot 3 | In-game only |
| `Ctrl+4` | Cast custom slot 4 | In-game only |
| `Ctrl+5` | Cast custom slot 5 | In-game only |
| `Ctrl+6` | Cast custom slot 6 | In-game only |
| `Ctrl+7` | Cast custom slot 7 | In-game only |
| `Ctrl+8` | Cast custom slot 8 | In-game only |
| `Ctrl+9` | Cast custom slot 9 | In-game only |
| `=` (equals) | Toggle HUD visibility on/off | Global |
| `-` (minus) | Toggle compact click-through mode | Global |
| `End` | Toggle rapid fire mode | Global |
| `Ctrl+Alt+D` | Reload the script | Global |
| `Escape` | Auto-disable rapid fire if active | In-game only |
| `Tab` | Auto-disable rapid fire if active | In-game only |

> **Note:** `Escape` and `Tab` only cancel rapid fire - they are not consumed by the script. The tilde (`~`) prefix ensures the keys still pass through to the game normally.

---

## SECTION 6: Slot System

The slot system is divided into three tiers:

### Slot 0 - SOS Beacon (Hardcoded)
Slot 0 is permanently assigned to the **SOS Beacon** (`^ v > ^` - Up, Down, Right, Up). It is triggered by `Ctrl+0` and cannot be changed via the UI. The sequence is stored in the global variable `SOS`.

### Slots 1–2 - Hardcoded
| Slot | Stratagem | Hotkey |
|---|---|---|
| 1 | Reinforce | `Ctrl+1` |
| 2 | Resupply | `Ctrl+2` |

These rows are displayed in the config panel with a **red left stripe** and a **LOCKED** label. They cannot be changed through the dropdown system.

### Slots 3–9 - Custom
Slots 3–9 are fully configurable via **ComboBox dropdowns** containing all 102 stratagems from the built-in database. The dropdowns display a **gold left stripe** to indicate they are editable.

**To assign a stratagem:**
1. Click the dropdown for the desired slot (3–9).
2. Type any part of the stratagem name to filter the list (e.g., type `"orb"` to narrow to Orbital entries).
3. Select the desired stratagem from the filtered list.
4. Click **`>> DEPLOY LOADOUT <<`** to save and activate the assignment.

The **DEPLOY LOADOUT** button writes all 7 custom slot names to `stratagem_loadout.ini`, updates the internal sequence array, and triggers a brief **DEPLOYED!** flash in the status bar. Your loadout survives script restarts.

---

## SECTION 7: Display Modes

The HUD operates in three distinct visual states:

### 1. Full Mode (Default)
The complete config panel is visible - title bar, hardcoded slot rows, 7 custom dropdown rows, the DEPLOY LOADOUT button, the active HUD readout, the status bar, and the FOR SUPER-EARTH footer. The panel is **non-moveable** by design (WM_NCHITTEST is blocked) and docks to the right side of the screen, vertically centered using `MonitorGetWorkArea`. Transparency is set to 230/255.

### 2. Compact Mode (press `-`)
Pressing `-` hides the full config panel and shows the **GComp** overlay - a compact, always-on-top, click-through window (`+E0x80000` extended style) showing only the HUD readout and status bar. The overlay is **fully click-through**: all mouse input passes to whatever is beneath it in the game. Transparency is set to 130/255. Pressing `-` again returns to Full Mode; the window position is preserved between transitions.

### 3. Hidden Mode (press `=`)
Both GFull and GComp are hidden. The HUD is completely invisible. If **Rapid Fire is ON**, a small **RAPID ON** indicator window (GIndicator) appears in the top-right corner of the screen as a reminder that the mode is still active. Pressing `=` again restores whichever mode (Full or Compact) was previously visible.

---

## SECTION 8: Rapid Fire Mode

Rapid fire mode simulates automatic mouse fire by intercepting `LButton` hold events and re-sending timed click pulses.

**Activation:** Press `End` to toggle. Status bar updates to **RAPID @** when active.

**Timing:** Each shot uses jittered intervals to avoid detection patterns:
- Fire interval: `Random(42, 68)` ms between shots
- Hold duration: `Random(18, 32)` ms per press

**Auto-disable:** Rapid fire is automatically turned off when `Escape` or `Tab` is pressed in-game (e.g., opening the ESC menu or the map). This prevents the tool from continuing to fire while navigating menus.

**Scope:** Rapid fire only activates when `helldivers2.exe` is the foreground window AND `RapidToggle` is true. It has no effect in any other application.

**Important warning:** Avoid using rapid fire with full-auto weapons. The tool is intended for semi-automatic weapons (e.g., the Liberator) where holding the mouse button normally produces only one shot. Using it with full-auto weapons can cause unexpected behavior.

---

## SECTION 9: Stratagem Database (102 Entries)

Arrow notation key: `^` = Up, `v` = Down, `<` = Left, `>` = Right

---

### Mission & Objective (18)

| Name | Sequence |
|---|---|
| Call In Super Destroyer | `^ ^ v v < > < >` |
| Cargo Container | `v ^ v v v` |
| Data Jack | `> v ^ ^ v` |
| Dark Fluid Vessel | `^ < > v ^ ^` |
| Eagle Rearm | `^ ^ < ^ >` |
| Hive Breaker Drill | `< ^ v > v v` |
| NUX-223 Hellbomb | `v ^ < v ^ > v ^` |
| Orbital Illumination Flare | `> > < <` |
| Prospecting Drill | `v v < > v v` |
| Reinforce | `^ v > < ^` |
| Resupply | `v v ^ >` |
| SEAF Artillery | `> ^ ^ v` |
| Seismic Probe | `^ ^ < > v v` |
| SOS Beacon | `^ v > ^` |
| SSSD Delivery | `v v v ^ ^` |
| Super Earth Flag | `v ^ v ^` |
| Tectonic Drill | `^ v ^ v ^ v` |
| Upload Data | `< > ^ ^ ^` |

---

### Orbital Stratagems (12)

| Name | Sequence |
|---|---|
| Orbital 120MM HE Barrage | `> > v < > v` |
| Orbital 380MM HE Barrage | `> v ^ ^ < v v` |
| Orbital Airburst Strike | `> > >` |
| Orbital EMS Strike | `> > < v` |
| Orbital Gas Strike | `> > v >` |
| Orbital Gatling Barrage | `> v < ^ ^` |
| Orbital Laser | `> v ^ > v` |
| Orbital Napalm Barrage | `> > v < > ^` |
| Orbital Precision Strike | `> > ^` |
| Orbital Railcannon Strike | `> ^ v v >` |
| Orbital Smoke Strike | `> > v ^` |
| Orbital Walking Barrage | `> v > v > v` |

---

### Eagle Stratagems (7)

| Name | Sequence |
|---|---|
| Eagle 110MM Rocket Pods | `^ > ^ <` |
| Eagle 500KG Bomb | `^ > v v v` |
| Eagle Airstrike | `^ > v >` |
| Eagle Cluster Bomb | `^ > v v >` |
| Eagle Napalm Airstrike | `^ > v ^` |
| Eagle Smoke Strike | `^ > ^ v` |
| Eagle Strafing Run | `^ > >` |

---

### Support Weapons & Backpacks (41)

| Name | Sequence |
|---|---|
| Airburst Rocket Launcher | `v ^ ^ < >` |
| Anti-Materiel Rifle | `v < > ^ v` |
| Arc Thrower | `v > v ^ < <` |
| Autocannon | `v < v ^ ^ >` |
| AX/ARC-3 K-9 | `v ^ < ^ > <` |
| AX/FLAM-75 Hot Dog | `v ^ < ^ < <` |
| Ballistic Shield Backpack | `v < v v ^ <` |
| Breaching Hammer | `v < > < ^` |
| C4 Pack | `v > ^ ^ > ^` |
| Commando | `v < ^ v >` |
| Cremator | `v v > v ^ ^` |
| De-Escalator | `v > ^ < >` |
| Defoliation Tool | `v < ^ v ^ >` |
| Epoch | `v < ^ < >` |
| Expendable Anti-Tank | `v v < ^ >` |
| Expendable Napalm | `v v < ^ <` |
| Flamethrower | `v < ^ v ^` |
| Grenade Launcher | `v < ^ < v` |
| Guard Dog | `v ^ < ^ > v` |
| Guard Dog (Dog Breath) | `v ^ < ^ > ^` |
| Guard Dog Rover | `v ^ < ^ > >` |
| Heavy Machine Gun | `v < ^ v v` |
| Hover Pack | `v ^ ^ v < >` |
| Jump Pack | `v ^ ^ v ^` |
| Laser Cannon | `v < v ^ <` |
| Leveller | `v v < ^ v` |
| Maxigun | `v < > v ^ ^` |
| MG-43 Machine Gun | `v < v ^ >` |
| MS-11 Solo Silo | `v ^ > v v` |
| One True Flag | `v < > > ^` |
| Quasar Cannon | `v v ^ < >` |
| Railgun | `v > v ^ < >` |
| Recoilless Rifle | `v < > > <` |
| S-11 Speargun | `v > v < ^ >` |
| Shield Generator Pack | `v ^ < > < >` |
| Spear | `v v ^ v v` |
| StA-X3 W.A.S.P. Launcher | `v v ^ v >` |
| Stalwart | `v < v ^ ^ <` |
| Sterilizer | `v < ^ v <` |
| Supply Pack | `v < v ^ ^ v` |
| Warp Pack | `v < > v < >` |

---

### Defensive & Emplacements (20)

| Name | Sequence |
|---|---|
| Anti-Personnel Minefield | `v < ^ >` |
| Anti-Tank Emplacement | `v ^ < > > >` |
| Anti-Tank Mines | `v < ^ ^` |
| Autocannon Sentry | `v ^ > ^ < ^` |
| Directional Shield | `v ^ < > ^ ^` |
| EMS Mortar Sentry | `v ^ > v >` |
| Flame Sentry | `v ^ > v ^ ^` |
| Gas Mines | `v < < >` |
| Gas Mortar Sentry | `v ^ > v <` |
| Gatling Sentry | `v ^ > <` |
| Grenadier Battlement | `v > v < >` |
| HMG Emplacement | `v ^ < > > <` |
| Incendiary Mines | `v < < v` |
| Laser Sentry | `v ^ > v ^ >` |
| Machine Gun Sentry | `v ^ > > ^` |
| Mortar Sentry | `v ^ > > v` |
| Portable Hellbomb | `v > ^ ^ ^` |
| Rocket Sentry | `v ^ > > <` |
| Shield Generator Relay | `v ^ < > < >` |
| Tesla Tower | `v ^ > ^ < >` |

---

### Exosuits & Vehicles (4)

| Name | Sequence |
|---|---|
| Emancipator Exosuit | `< v > ^ < v ^` |
| Fast Recon Vehicle | `< v > v > v ^` |
| Patriot Exosuit | `< v > ^ < v v` |
| TD-220 Bastion MK XVI | `< v > v < v ^ v ^` |

---

## SECTION 10: Configuration Files

### `stratagem_loadout.ini`
Stores the names assigned to custom slots 3–9, one entry per line (7 lines total). The file is plain text with no section headers. It is created automatically when you click **DEPLOY LOADOUT** for the first time.

Example contents:
```
Eagle Airstrike
Orbital Laser
Eagle 500KG Bomb
Patriot Exosuit
Expendable Anti-Tank
Recoilless Rifle
Jump Pack
```

On startup, if this file exists, slot names are read from it and matched against the stratagem database to resolve sequences. If the file is absent, the `DefaultSlots` array in the script provides the first-run defaults.

### `Helldivers.ahk`
The main script file. To change first-run defaults (the loadout used when no `.ini` file is present), edit the `DefaultSlots` array near the top of the file:

```ahk
global DefaultSlots := [
    "Eagle Airstrike",
    "Orbital Laser",
    "Eagle 500KG Bomb",
    "Patriot Exosuit",
    "Expendable Anti-Tank",
    "Recoilless Rifle",
    "Jump Pack"
]
```

Each entry must exactly match a `Name` field in the `Stratagems` array, or it will be silently ignored and the sequence for that slot will be left empty.

---

## SECTION 11: Troubleshooting

| Problem | Cause | Fix |
|---|---|---|
| HUD not visible | Script is not running, or HUD was hidden with `=` | Check the system tray for the AHK icon. Press `=` to toggle visibility back on. |
| Stratagems not casting | Game window is not focused, or Ctrl key state is misread | Click the game window to give it focus. Ensure no other program is intercepting `Ctrl`. |
| Wrong stratagem sequence | Slot name in `.ini` does not match a database entry exactly | Open the dropdown for that slot, reselect the correct stratagem, and click DEPLOY LOADOUT. |
| HUD running off screen | Non-standard monitor resolution or DPI scaling | The script uses `MonitorGetWorkArea` to position itself; ensure your primary monitor is set correctly in Windows Display Settings. |
| Rapid fire not working | Rapid fire requires `helldivers2.exe` to be the active window | Click the game window to bring it to the foreground, then re-toggle with `End`. |
| Script not running | AutoHotkey v1 is installed instead of v2, or `#Requires` check failed | Uninstall AHK v1 and install AHK v2 from https://www.autohotkey.com/. Right-click `Helldivers.ahk` and choose **Run with** > **AutoHotkey v2**. |

---

## SECTION 12: File Structure

```
HellDiversMacros/
├── Helldivers.ahk          # Main script
├── stratagem_loadout.ini   # Saved loadout (auto-created on first DEPLOY)
└── README.md               # This file
```

---

## SECTION 13: RELEASE ROADMAP

> **CLASSIFIED - SUPER EARTH FORWARD OPERATIONS COMMAND**
> The following roadmap details planned enhancements to the S.T.R.A.T.A.G.E.M. TERMINAL system. All versions are subject to operational revision. Helldiver, study this document carefully.

---

### v4.8.x - Polish & Reliability

#### v4.8.1 - HUD Opacity Slider
- Real-time opacity slider in the config panel. Drag to set HUD transparency anywhere from 50 to 255 without restarting the script.

#### v4.8.2 - Compact Mode Position Memory
- Compact overlay remembers its last dragged screen position across script restarts, written to `stratagem_loadout.ini` as `CompactX` and `CompactY` keys.

#### v4.8.3 - Per-Slot Hotkey Label
- Each slot row in the HUD displays the assigned hotkey (e.g., `Ctrl+5`) inline next to the slot number for quick reference.

#### v4.8.4 - Slot Display Name Override
- A secondary input field per slot allows you to type a custom short label (e.g., "Nuke") that displays in the HUD instead of the full stratagem name.

#### v4.8.5 - Startup Position Option
- A config dropdown allows selecting the initial docking position on launch: **Right Edge**, **Left Edge**, **Top-Right**, **Top-Left**, **Bottom-Right**, or **Center**.

#### v4.8.6 - Auto-Reload Watch
- The script monitors its own `.ahk` file for modification timestamps. If the file changes on disk, it automatically reloads without requiring `Ctrl+Alt+D`.

#### v4.8.7 - Cast Flash Animation Improvement
- The active slot highlight during casting changes from a plain white flash to a brief **cyan pulse** (`4FC3F7`) that fades over 200 ms for better visibility.

#### v4.8.8 - Config Export to Clipboard
- A one-click button in the config panel copies the current 7-slot loadout as a JSON string to the clipboard (e.g., `{"slots":["Eagle Airstrike","Orbital Laser",...]}`) for sharing or backup.

#### v4.8.9 - In-App Update Notifier
- On startup, the script silently checks the configured GitHub releases page. If a newer version tag is detected, a small yellow banner appears in the status bar: **"v4.8.9 available - github.com/..."**

#### v4.8.10 - Sequence Reverse-Lookup
- A search field in the config panel accepts a full directional sequence (e.g., `Up,Down,Right,Left,Up`) and displays the matching stratagem name, useful for identifying sequences seen in community content.

---

### v4.9.x - Stratagem Library Management

#### v4.9.1 - Favorites System
- Any stratagem in the database can be starred or unstarred. Starred stratagems float to the top of all slot dropdowns for fast access.

#### v4.9.2 - Recently Used List
- The last 10 stratagems cast this session automatically appear at the top of the dropdown list under a **RECENT** section separator.

#### v4.9.3 - Category Filter Tabs
- Filter tabs appear above each dropdown: **All / Orbital / Eagle / Support / Defense / Mission / Vehicles**. Clicking a tab narrows the dropdown list to that category.

#### v4.9.4 - Sequence Validator
- Before committing a cast, the engine validates that the sequence string contains only recognized direction tokens. Slots with malformed sequences are highlighted in **red** in the HUD.

#### v4.9.5 - Custom Stratagem Entry Dialog
- An **Add New Stratagem** button opens a modal form with Name and Sequence fields. Confirmed entries are appended to the session's stratagem list and become available in all dropdowns immediately.

#### v4.9.6 - Duplicate Sequence Detector
- If two active slots share identical directional sequences, both rows are highlighted in **yellow** in the HUD and config panel as a loadout redundancy warning.

#### v4.9.7 - Import from JSON
- A file picker button allows loading a `stratagems.json` file to merge additional community entries with or replace the built-in 102-entry list.

#### v4.9.8 - Stratagem Notes
- Right-clicking any slot row in the HUD opens a small input popup to attach a personal text note (e.g., "use for heavy armor"). Notes appear as tooltips when hovering the slot in compact mode.

#### v4.9.9 - Library Panel
- A dedicated modal window shows all 102+ stratagems in a scrollable table with full arrow sequences, sortable by Name or Category. Accessible via a **Library** button in the config panel.

#### v4.9.10 - Export Library
- A button in the Library Panel exports the full stratagem list to a user-selected file path as either a formatted `.txt` table or a `.json` file.

---

### v5.0.x - Multi-Loadout Profiles

#### v5.0.1 - Profile System Foundation
- Loadout profiles are stored as separate `.ini` files in a `/profiles` subdirectory. You can create, rename, and delete profiles from the config panel.

#### v5.0.2 - Profile Switcher Panel
- A dropdown in the config UI displays the active profile name. Selecting a different profile loads it immediately. The active profile name is shown in the HUD title bar.

#### v5.0.3 - Profile Switch Hotkey
- A configurable global hotkey (`Ctrl+Alt+P` by default) cycles through all saved profiles in alphabetical order, with a tooltip confirming the newly active profile.

#### v5.0.4 - Mission Type Tags
- Each profile can be tagged as **Bugs / Automatons / Illuminates / General**. Tags are displayed next to the profile name in the switcher and can be used to filter the list.

#### v5.0.5 - Profile Import/Export
- Profiles can be exported as `.ini` files for sharing. Drag-and-drop an `.ini` onto the config panel window to import it as a new profile.

#### v5.0.6 - Profile Copy
- A **Duplicate** button in the profile switcher creates an exact copy of the current profile under a new name, ready for modification.

#### v5.0.7 - Profile Loadout Diff
- A side-by-side comparison panel shows slot-by-slot differences between any two selected profiles, highlighting added, removed, or changed stratagems.

#### v5.0.8 - Profile Share Code
- Encodes a full profile (7 slot names) into a short alphanumeric string (~20 chars). Paste the string on another installation to import the profile instantly.

#### v5.0.9 - Profile History
- The last profile switch is stored in memory. A single **Undo** button or `Ctrl+Z` hotkey restores the previous profile.

#### v5.0.10 - Default Profile on Startup
- A config option specifies which profile is loaded automatically when the script starts, overriding any previously active profile.

---

### v5.1.x - GUI Scaling & Display

#### v5.1.1 - DPI-Aware Rendering
- All GUI element sizes are computed from the OS DPI setting, fixing layout proportions at 125%, 150%, and 200% Windows display scaling without manual adjustment.

#### v5.1.2 - Window Size Presets
- Three single-click presets: **Small (320px)**, **Standard (420px)**, and **Wide (560px)** adjust the HUD width and reposition it to the right edge automatically.

#### v5.1.3 - Font Size Override
- A global font size slider in the Settings panel (range 6pt–14pt) applies to all GUI text elements simultaneously, useful for high-DPI or small-monitor environments.

#### v5.1.4 - Arrow Character Style Selector
- Choose the notation style for directional sequences: **ASCII** (`^v<>`), **Unicode** (`↑↓←→`), or **Roman** (`U D L R`) across all HUD displays.

#### v5.1.5 - Accent Color Picker
- The gold, cyan, and red accent colors used throughout the HUD can each be changed via a hex color picker dialog. Changes apply live without restarting.

#### v5.1.6 - Independent Opacity for Background and Text
- Two separate transparency sliders control the background fill opacity and the text/foreground element opacity independently, allowing, for example, an invisible background with fully visible text.

#### v5.1.7 - Light Mode
- A white-background, high-contrast theme with dark text, designed for Users in bright environments or those who prefer a non-tactical aesthetic.

#### v5.1.8 - Custom Background Color
- Replace the default dark navy (`080812`) background with any solid RGB color via a color picker, enabling personalized visual integration with desktop themes.

#### v5.1.9 - Animation Toggle
- A global toggle in Settings disables all flash, pulse, and transition animations. Recommended for low-end systems or Users with photosensitivity concerns.

#### v5.1.10 - Multi-Monitor Pin
- When multiple monitors are detected, a dropdown in Settings allows selecting which monitor the HUD docks to. The HUD repositions immediately on change.

---

### v5.2.x - Hotkey Remapper

#### v5.2.1 - Cast Hotkey Modifier Remapper
- The `Ctrl` modifier used for slots 0–9 can be changed to any modifier key or combination: `Alt`, `Shift`, `Win`, `Ctrl+Alt`, etc. via a UI dropdown.

#### v5.2.2 - Per-Slot Independent Hotkey
- Assign a completely different hotkey to each slot independently (e.g., Slot 3 = `F3`, Slot 4 = `Alt+4`), overriding the global modifier scheme.

#### v5.2.3 - HUD Toggle Hotkey Remapper
- The `=` and `-` keys used for HUD visibility and compact mode can be rebound to any key via the Hotkeys settings panel.

#### v5.2.4 - Rapid Fire Hotkey Remapper
- The `End` key used to toggle rapid fire can be rebound to any key, including function keys, numpad keys, or mouse buttons.

#### v5.2.5 - Hotkey Conflict Checker
- When a new hotkey is assigned, the system performs a real-time check against all existing bindings. Conflicts are highlighted in red with a tooltip identifying the conflicting action.

#### v5.2.6 - Mouse Button Support
- Stratagem slots can be bound to additional mouse buttons: `M4` (XButton1), `M5` (XButton2), or scroll wheel up/down.

#### v5.2.7 - Gamepad Button Support
- XInput controller buttons (`A/B/X/Y`, bumpers, trigger combinations) can be bound to stratagem slots via a ViGEm bridge integration, enabling controller-primary play styles.

#### v5.2.8 - Hotkey Profile Per Loadout Profile
- Each loadout profile stores its own complete hotkey configuration. Switching profiles also switches hotkeys automatically.

#### v5.2.9 - Hotkey Display in HUD
- The currently bound key for each slot is displayed next to the slot number in both Full and Compact mode overlay displays.

#### v5.2.10 - Hotkey Export/Import
- Save and restore complete hotkey configurations as JSON files for backup or sharing between machines.

---

### v5.3.x - Cast Engine Enhancements

#### v5.3.1 - Global Cast Speed Slider
- A slider in Settings adjusts all input delays from `0.5x` (fast, higher sequence error risk) to `3x` (slow, very safe for high-latency inputs or accessibility needs).

#### v5.3.2 - Per-Stratagem Speed Override
- Individual stratagems can have their cast speed overridden in the Library Panel, useful for stratagems with long sequences on specific hardware or latency conditions.

#### v5.3.3 - Input Method Selector
- Choose the AHK input method: **SendInput** (fastest, default), **SendEvent** (game-compatibility mode), or **SendPlay** (for virtualized environments).

#### v5.3.4 - Activation Key Config
- The stratagem activation key (held during casting) can be changed from `Ctrl` to any key (e.g., `CapsLock`, `Alt`, `RCtrl`) via the Settings panel.

#### v5.3.5 - Buffered Cast Queue
- Pressing multiple `Ctrl+N` hotkeys in rapid succession queues the casts. The engine executes them in order, each waiting for the previous to complete before beginning.

#### v5.3.6 - Cast Abort Key
- A configurable key (default: `Q`) interrupts any cast currently in progress, stopping further directional key sends mid-sequence.

#### v5.3.7 - Anti-Spam Interval
- A configurable minimum cooldown (ms) between any two cast events prevents accidental double-press from triggering the same stratagem twice in quick succession.

#### v5.3.8 - Cast Dry-Run Mode
- A **Test** button in the config panel shows exactly which key events would be sent for the selected slot's sequence, without actually sending them. Output is displayed as a tooltip.

#### v5.3.9 - Cast Debug Log
- Every cast event is appended to `cast_debug.log`: timestamp, slot number, stratagem name, sequence, and whether the cast completed or was aborted (Ctrl released early).

#### v5.3.10 - Advanced Jitter Profiles
- Four jitter profiles selectable in Settings: **Uniform** (current behavior), **Gaussian** (bell-curve distribution), **Human** (varied timing with occasional micro-pauses), **Fast** (minimal jitter, maximum speed).

---

### v5.4.x - HUD Layout Editor

#### v5.4.1 - HUD Position Drag Handle
- A slim grab strip at the top of the compact overlay enables repositioning by drag without disabling the click-through mode. The handle is not click-through itself.

#### v5.4.2 - Slot Visibility Toggles
- Checkboxes in the config panel allow hiding individual slots from the HUD display without removing their assignments. Hidden slots still respond to hotkeys.

#### v5.4.3 - Slot Reorder
- Slots can be drag-to-reordered within the HUD display list. This changes display order only; hotkey assignments (Ctrl+3 always fires slot 3) remain fixed.

#### v5.4.4 - HUD Width Resize Grip
- A drag handle on the right edge of the overlay allows resizing the HUD width between 300px and 600px. Font and layout reflow to fit the new width.

#### v5.4.5 - Snap-to-Edge
- When the HUD is dragged within 20 pixels of any screen edge or corner, it snaps to that edge with correct margin alignment.

#### v5.4.6 - Save Layout
- A **Save Layout** button persists the current HUD size, position, visibility state, and slot display order to the config file.

#### v5.4.7 - Mini Mode
- A new single-line **Mini Mode** displays a rolling ticker that cycles through active slot names and sequences, reducing the HUD footprint to a single line.

#### v5.4.8 - HUD Column Count
- In compact mode, slots can be displayed in 1 or 2 columns. Two-column layout halves the vertical height of the overlay.

#### v5.4.9 - Click-Through Toggle for Full Mode
- An option in Settings makes the full config GUI click-through as well, allowing interaction with the game behind the full panel. Config dropdowns remain accessible via hotkey.

#### v5.4.10 - Per-Slot Color Coding
- Each slot row can be assigned an individual background tint color (from a color picker) for rapid visual identification during gameplay.

---

### v5.5.x - Quick-Cast Favorites Bar

#### v5.5.1 - Favorites Bar Overlay
- A small floating toolbar displays up to 8 favorite stratagems as named tiles, visible above or beside the main HUD at all times.

#### v5.5.2 - Drag-to-Favorites
- Drag any stratagem name from any slot dropdown to the favorites bar to add it. Drag it back off to remove it.

#### v5.5.3 - Favorites Bar Hotkeys
- `F1`–`F8` keys are bound to favorites bar slots, allowing direct cast without occupying the main Ctrl+N assignments.

#### v5.5.4 - Favorites Bar Position
- The favorites bar can be docked to the top, bottom, left, or right edge of the screen, or floated freely.

#### v5.5.5 - Favorites Bar Auto-Hide
- The bar automatically hides when the game window is focused and re-appears when a configurable hotkey is held, or on game unfocus.

#### v5.5.6 - Arrow Preview in Favorites Bar
- Each tile in the favorites bar shows the stratagem's arrow sequence in miniature below the name for quick verification.

#### v5.5.7 - Favorites Per Profile
- Each loadout profile maintains its own independent favorites list. Switching profiles also switches the favorites bar contents.

#### v5.5.8 - Favorites Export/Import
- Share favorite collections as JSON files. Import a favorites JSON from someone else to use their quick-access set.

#### v5.5.9 - Favorites Usage Counter
- A small number badge on each favorites tile shows how many times that stratagem has been cast from the favorites bar this session.

#### v5.5.10 - Favorites Bar Theme
- The favorites bar can either inherit the current HUD color theme or apply a separate minimalist flat style with user-configurable accent color.

---

### v5.6.x - Theme System

#### v5.6.1 - Theme: Helldiver Classic
- The current default gold/navy color scheme is formalized as the **Helldiver Classic** named theme, selectable alongside all other themes from the theme picker.

#### v5.6.2 - Theme: Night Ops
- Pure black background (`000000`), dim red accents (`660000`), minimal stripe separators. Designed for low-light environments and minimal visual intrusion.

#### v5.6.3 - Theme: Super Earth
- Royal blue background (`1A2A6C`), white text, gold borders. Patriotic design inspired by Super Earth propaganda aesthetics.

#### v5.6.4 - Theme: Automaton
- Grey metal background (`2A2A2A`), red chrome text (`CC0000`), circuit-board style divider lines between sections.

#### v5.6.5 - Theme: Illuminate
- Deep purple background (`1A0030`), white and lavender text, energy-pulse accent bars in violet (`AA00FF`).

#### v5.6.6 - Theme Editor UI
- A full visual theme editor with hex color pickers for every HUD element: background, title text, slot numbers, stratagem names, sequence arrows, accent stripes, status bar, borders.

#### v5.6.7 - Theme Export/Import
- Save any custom theme as a `.json` file. Import theme files from other Users or the community. Themes are validated before applying.

#### v5.6.8 - Theme Preview
- Hovering a theme name in the selection list shows a live preview of the HUD with that theme applied, without committing the change.

#### v5.6.9 - Gradient Accent Option
- Replaces solid accent bars with a 2-color gradient rendered via multiple stacked thin Text controls, creating a smooth color transition across header and footer bars.

#### v5.6.10 - Community Theme URL
- Generate a shareable URL that encodes the full theme configuration. Anyone with the URL can paste it into the theme importer to install the theme in one click.

---

### v5.7.x - Rapid Fire Enhancements

#### v5.7.1 - Fire Rate Slider
- A live slider in Settings adjusts the rapid fire shot interval from 20 ms to 150 ms. A small indicator shows the effective rounds-per-second at the current setting.

#### v5.7.2 - Burst Mode
- Configure a burst count (e.g., 3) so each left-click triggers exactly N shots then pauses, simulating a burst-fire weapon pattern rather than full-auto.

#### v5.7.3 - Right-Click Rapid Fire
- Option to enable rapid fire on the right mouse button independently of the left button, with separate fire rate and burst settings.

#### v5.7.4 - Hold Mode
- A Settings toggle changes rapid fire behavior from a persistent toggle to a **hold-to-fire** mode: rapid fire is only active while the `End` key is physically held down.

#### v5.7.5 - Weapon Preset Profiles
- Save named fire rate configurations (e.g., **Liberator**, **Punisher**, **Slugger**) with individual interval, hold time, and burst settings switchable from a dropdown.

#### v5.7.6 - Per-Weapon Indicator
- The loaded weapon preset name is shown in the rapid fire status area of the HUD (e.g., **RAPID @ LIBERATOR**) so you always knows which preset is active.

#### v5.7.7 - Rapid Fire Audio Cue
- Optional per-shot click sound during rapid fire mode. The WAV file path is configurable in Settings. Disable completely with a single checkbox.

#### v5.7.8 - Shot Counter
- A running total of shots fired in rapid mode this session is displayed in the status bar next to the RAPID indicator. Resets on script restart.

#### v5.7.9 - Fire Rate Randomization Width
- A secondary slider controls how wide the jitter range is: **Tight (+/-5 ms)** for consistent fire rate, or **Loose (+/-30 ms)** for more human-like variation.

#### v5.7.10 - Advanced Human-Pattern Mode
- A special jitter algorithm that adds occasional micro-pauses (10–50 ms with low probability) between shots to simulate realistic trigger discipline under sustained fire.

---

### v5.8.x - Usage Statistics

#### v5.8.1 - Session Cast Counter
- Total stratagems cast this session is displayed in the status bar next to the ONLINE indicator, incrementing with each successful cast.

#### v5.8.2 - All-Time Cast Log
- Every cast is recorded to `cast_history.csv` with columns: Timestamp, Slot, Stratagem Name, Sequence Length, Result (Complete/Aborted).

#### v5.8.3 - Most-Used Ranking
- A Stats panel tab shows the top 10 most-cast stratagems all-time, with cast counts and percentage of total casts as ASCII bar graphs.

#### v5.8.4 - Average Cast Speed
- The Stats panel measures and displays the average time elapsed between cast initiation and sequence completion in milliseconds, per stratagem and globally.

#### v5.8.5 - Abort Detection
- Casts where `Ctrl` was released before the sequence completed are detected and counted separately as **Aborted** in the stats log and session counter.

#### v5.8.6 - Stats Panel
- A dedicated **Stats** tab in the config panel shows all session and all-time statistics with ASCII bar graph visualizations for top stratagems and cast timing distributions.

#### v5.8.7 - Session Duration Timer
- The elapsed time since the script was started is displayed in the status bar in `HH:MM` format, giving Users a session clock without switching windows.

#### v5.8.8 - Per-Slot Cast Count
- A small numerical badge on each slot row in the config panel shows how many times that slot has been cast this session.

#### v5.8.9 - Stats Export
- A button in the Stats panel copies the full statistics report to the clipboard as formatted plain text, or saves it to a user-selected `.txt` file.

#### v5.8.10 - Stats Reset
- A **Reset All Stats** button in the Stats panel clears all counters and the cast history CSV. A confirmation dialog appears first, and a timestamped backup is created before clearing.

---

### v5.9.x - Settings Panel

#### v5.9.1 - Dedicated Settings Window
- A full-featured settings modal window separate from the main loadout panel, with a sections sidebar for navigation. Accessible via a gear icon or keyboard shortcut.

#### v5.9.2 - Settings Categories
- The settings window is organized into sidebar sections: **General**, **Display**, **Hotkeys**, **Cast Engine**, **Rapid Fire**, **Statistics**, **Advanced**.

#### v5.9.3 - Settings Search
- A search field at the top of the settings window filters all settings by keyword in real time, highlighting matching labels across all categories.

#### v5.9.4 - Inline Help Text
- Hovering any setting label, checkbox, or slider displays a tooltip explaining the option's effect, valid values, and any caveats.

#### v5.9.5 - Reset Per Category
- Each settings section has a **Reset to Defaults** button that restores only that section's settings without affecting other categories.

#### v5.9.6 - Settings Backup
- An **Export Settings** button saves all current settings to a timestamped `.cfg` file before making bulk changes, serving as a safety checkpoint.

#### v5.9.7 - Settings Restore
- An **Import Settings** button opens a file picker to load any `.cfg` backup file, restoring all settings from that snapshot.

#### v5.9.8 - First-Run Setup Wizard
- On the very first launch (no config files present), a 5-step guided wizard walks you through: HUD position, cast hotkey modifier, first loadout assignment, rapid fire configuration, and display mode preference.

#### v5.9.9 - Settings Changelog
- A small scrollable log at the bottom of the settings window records what settings were changed and when, providing an audit trail for troubleshooting.

#### v5.9.10 - Settings Sync
- A path field in Advanced Settings allows pointing to a shared folder (Dropbox, OneDrive, network share) to sync the settings `.cfg` file across multiple machines.

---

### v6.0.x - Mission Awareness

#### v6.0.1 - Mission Timer
- A manual start/stop stopwatch displayed in the HUD footer, formatted as `MM:SS`. Started and stopped via a configurable hotkey or a button in the config panel.

#### v6.0.2 - Reinforcement Tracker
- A small numeric input in the status bar allows manually tracking remaining reinforcements (0–20). Displayed prominently in the HUD status area.

#### v6.0.3 - Eagle Charge Counter
- Track how many Eagle strikes remain before rearm is required. The counter is displayed next to Eagle slots and decrements with each Eagle cast.

#### v6.0.4 - Eagle Rearm Listener
- When the Eagle Rearm stratagem slot is cast, the Eagle charge counter automatically resets to its configured maximum value.

#### v6.0.5 - Stratagem Charge Display
- Remaining use counts for Eagle stratagems are displayed as small badges next to their slot numbers in the HUD, decremented automatically on cast.

#### v6.0.6 - Extract Timer
- A configurable countdown from mission start to SEAF extract window. Set mission length in Settings; the HUD shows time remaining to extract in the footer.

#### v6.0.7 - Custom Objective Reminders
- Create timed reminder messages that appear as HUD overlays at specified mission clock times (e.g., "Activate uplink at 15:00"). Up to 5 reminders per session.

#### v6.0.8 - Session Mission Log
- Every stratagem cast is recorded with the mission timer timestamp, creating a post-mission timeline of actions for review and loadout refinement.

#### v6.0.9 - Mission Summary Overlay
- When the game window loses focus (e.g., Alt+Tab at mission end), a summary overlay displays: total casts, most-used stratagems, session duration, and abort count.

#### v6.0.10 - Booster Notes
- A sticky note panel in the config UI for recording active boosters and their effects each mission. Notes persist until manually cleared.

---

### v6.1.x - Smart Auto-Hide

#### v6.1.1 - Cursor-Lock Detection
- The HUD automatically hides when the mouse cursor enters game-lock state (center-locked in-game), reducing visual clutter during active combat.

#### v6.1.2 - Auto-Hide Delay
- A configurable delay (0–5 seconds) determines how long after the game window gains focus the HUD waits before auto-hiding, preventing premature concealment.

#### v6.1.3 - Auto-Show on Hotkey
- Pressing any `Ctrl+N` cast hotkey automatically un-hides the HUD if it was auto-hidden, providing brief confirmation of the cast action.

#### v6.1.4 - Fade-Out Animation
- When auto-hiding, the HUD fades out smoothly over a configurable 200–500 ms period rather than disappearing instantly.

#### v6.1.5 - Peek Mode
- Holding a configurable key (default: `Ctrl+Shift`) temporarily reveals the HUD while it is in auto-hidden state. Releasing the key re-hides it.

#### v6.1.6 - Return-to-Position
- After any auto-hide/show cycle, the HUD returns to the exact same screen coordinates it occupied before hiding.

#### v6.1.7 - Game Unfocus Detection
- When you Alt+Tabs out of the game, the HUD automatically shows in Full Mode to allow loadout adjustments during the out-of-game window.

#### v6.1.8 - Menu-Aware Hiding
- The HUD auto-shows when the ESC or Tab menu is detected as open (via the existing Escape/Tab hook), ensuring loadout visibility during in-game menus.

#### v6.1.9 - Per-Display-Mode Auto-Hide
- Auto-hide behavior is configured separately for Full Mode and Compact Mode, allowing different hide delays and triggers depending on which display mode is active.

#### v6.1.10 - Auto-Hide Whitelist
- A text field in Settings accepts additional executable names (beyond `helldivers2.exe`) where the HUD should remain visible, accommodating multi-monitor or overlay setups.

---

### v6.2.x - Audio Feedback

#### v6.2.1 - Cast Start Beep
- A configurable short tone (frequency and duration) plays the instant a stratagem cast sequence begins, providing audio confirmation of hotkey detection.

#### v6.2.2 - Cast Complete Tone
- A distinct tone (different pitch or pattern from the start beep) plays when a stratagem sequence completes successfully, confirming all keys were sent.

#### v6.2.3 - Cast Abort Buzz
- A low, distinct buzz sound plays when a cast is interrupted (Ctrl released early), alerting you to reattempt the stratagem.

#### v6.2.4 - Rapid Fire Click
- An optional per-shot click sound during rapid fire mode provides tactile audio feedback. The click frequency mirrors the configured fire rate.

#### v6.2.5 - Loadout Deploy Chime
- A multi-tone chime plays when the DEPLOY LOADOUT button is successfully pressed and the loadout is written to disk.

#### v6.2.6 - Custom WAV Support
- Any audio event can be pointed to a custom `.wav` file on disk via a file picker in the Audio Settings panel, allowing fully personalized sound design.

#### v6.2.7 - Volume Per Event
- Individual volume sliders (0–100%) for each audio event: Cast Start, Cast Complete, Cast Abort, Rapid Click, Deploy Chime. Master volume slider overrides all.

#### v6.2.8 - TTS Readout
- Text-to-speech via Windows SAPI announces the stratagem name aloud on each cast (e.g., "Orbital Laser"). Voice, speed, and volume are configurable.

#### v6.2.9 - Audio Profiles
- Four switchable presets: **Loud** (all events at full volume), **Quiet** (reduced volumes, no TTS), **Silent** (all audio disabled), **Custom** (user-defined per-event volumes). Switchable via a configurable hotkey.

#### v6.2.10 - Audio Output Device Selector
- Choose which Windows audio output device plays tool sounds, keeping them separate from game audio routed to headphones or a different device.

---

### v6.3.x - Stratagem Combo System

#### v6.3.1 - Combo Definition
- Create named macros that chain multiple stratagem casts in a single hotkey press, with configurable delays between each cast in the chain.

#### v6.3.2 - Combo Editor UI
- A visual sequence builder with a drag-to-reorder interface for combo steps. Each step shows the stratagem name, arrow sequence, and a configurable inter-cast delay input.

#### v6.3.3 - Inter-Cast Delay
- Configure the gap in milliseconds between each stratagem in a combo. Different delays per step allow fine-tuning for cooldown windows or tactical timing.

#### v6.3.4 - Combo Abort Key
- A configurable key interrupts a combo mid-chain, stopping further stratagems from casting. Partial combos already in flight complete their current cast.

#### v6.3.5 - Combo Progress Indicator
- While a combo is executing, the HUD shows which step is currently being cast (e.g., **COMBO: 2/4 - Orbital Laser**) and dims completed steps.

#### v6.3.6 - Conditional Execution
- A per-step option requires `Ctrl` to still be held at each step boundary. If released mid-combo, execution halts, preventing ghost casts after manual abort.

#### v6.3.7 - Combo Hotkey Assignment
- Any combo can be assigned to any hotkey including function keys, numpad keys, and (with v5.2.7 installed) gamepad buttons.

#### v6.3.8 - Preset Combos
- Built-in named combo templates: **Opening Blitz** (Eagle Airstrike + Orbital Precision Strike + Orbital Laser), **Support Drop** (Resupply + Reinforce), **Area Denial** (Anti-Tank Mines + Gas Mines + Incendiary Mines).

#### v6.3.9 - Combo Import/Export
- Share combo definitions as `.json` files. Import community combos or export personal ones for backup or sharing with squadmates.

#### v6.3.10 - Combo Usage Tracking
- Each combo has a lifetime execution counter in the Stats panel. Cast counts are broken down per combo and included in the session summary.

---

### v6.4.x - Stratagem Cooldown Tracking

#### v6.4.1 - Cooldown Timer Foundation
- A per-slot countdown timer starts automatically after each cast. The timer duration is sourced from the cooldown database.

#### v6.4.2 - Cooldown Database
- A built-in table of approximate cooldown durations for all 102 stratagems, cross-referenced with community-verified timing data.

#### v6.4.3 - Cooldown HUD Indicator
- Slot rows dim and display a countdown number (e.g., `[4] Eagle Airstrike  (:23)`) when on cooldown. The row returns to normal color when the timer expires.

#### v6.4.4 - Cooldown Ready Alert
- When a cooldown expires, the corresponding HUD slot briefly flashes its accent color to draw your attention to the newly available stratagem.

#### v6.4.5 - Cooldown Sound Alert
- An optional distinct tone (configurable in Audio Settings) plays when any stratagem's cooldown expires, providing audio notification without requiring HUD attention.

#### v6.4.6 - Eagle Charge Integration
- Eagle stratagem cooldown timers reset automatically when the Eagle Rearm stratagem is cast, reflecting the in-game rearm behavior accurately.

#### v6.4.7 - Cooldown Override
- A **Reset All Cooldowns** button (accessible via hotkey or config panel) clears all active timers simultaneously, appropriate after dying and respawning.

#### v6.4.8 - Custom Cooldown Values
- Edit the cooldown duration for any individual stratagem in the Library Panel to match modified values from boosters (e.g., Hellpod Space Optimization) or game patches.

#### v6.4.9 - Cooldown Pause
- A **Pause Timers** button freezes all active cooldown countdowns, useful during lobby waits or when tracking breaks down.

#### v6.4.10 - Cooldown Log
- Exports a per-session CSV of cooldown events: stratagem name, cast time, expected ready time, actual ready time. Useful for loadout cadence analysis.

---

### v6.5.x - Context-Aware Suggestions

#### v6.5.1 - Manual Faction Input
- A dropdown in the config panel allows selecting the current mission enemy faction: **Terminids / Automatons / Illuminate / Mixed**.

#### v6.5.2 - Anti-Bug Recommended Loadout
- A curated top-8 stratagem suggestion set optimized for Terminid missions, emphasizing area denial, fire damage, and light armor penetration.

#### v6.5.3 - Anti-Bot Recommended Loadout
- A curated top-8 stratagem suggestion set optimized for Automaton missions, emphasizing precision strikes, anti-armor, and shield deployment.

#### v6.5.4 - Anti-Illuminate Recommended Loadout
- A curated top-8 stratagem suggestion set optimized for Illuminate missions, emphasizing energy defense, EMS, and mobile stratagems.

#### v6.5.5 - Difficulty Modifier
- A secondary dropdown (**Casual / Standard / Helldive**) adjusts suggestion priorities, weighting survivability stratagems higher on harder difficulties.

#### v6.5.6 - Suggestion Panel
- A collapsible side panel in the config UI shows up to 5 slot suggestions with the stratagem name and a one-line reason (e.g., "Effective against Chargers").

#### v6.5.7 - Accept Suggestion
- A single-click **Apply** button next to each suggestion loads it into the recommended slot immediately.

#### v6.5.8 - Accept All Suggestions
- A single **Accept All** button applies the entire recommended loadout to slots 3–9 in one action, with a confirmation prompt.

#### v6.5.9 - Dismiss Permanently
- A **Never Show** option per suggestion removes that recommendation permanently from the suggestion engine for the current user profile.

#### v6.5.10 - Community Vote Data
- Suggestion priorities are optionally weighted by community upvote counts pulled from a `suggestions.json` hosted on the project's GitHub repository.

---

### v6.6.x - Loadout Sharing & Network

#### v6.6.1 - Share Code Generator
- Encodes the current 7-slot loadout into a short base64 string (~40 characters) displayable in the config panel and copyable with one click.

#### v6.6.2 - Share Code Import
- A text field in the config panel accepts a share code. Clicking **Load** decodes and applies the encoded loadout to slots 3–9.

#### v6.6.3 - QR Code Display
- Renders the current share code as a QR code image inside the config panel using pure AHK GDI+ rendering, scannable by a phone for cross-device loadout transfer.

#### v6.6.4 - One-Click Discord Copy
- Formats the current loadout as a readable Discord message block (code-formatted with emoji arrows) and copies it to the clipboard for immediate posting.

#### v6.6.5 - LAN Broadcast
- Broadcasts the current loadout over the local network via UDP on a configured port, enabling squadmates running the tool to receive it automatically.

#### v6.6.6 - LAN Receive
- Listens for inbound LAN broadcasts from other squad members and displays received loadouts in a **Squad Loadouts** panel in the config UI.

#### v6.6.7 - Duplicate-Slot Warning
- When a party member's loadout is received via LAN, any stratagems that overlap with the local user's slots are highlighted in yellow as coordination warnings.

#### v6.6.8 - Coverage Gap Suggestion
- After receiving all party member loadouts, the system analyzes combined coverage and suggests stratagems that the squad is collectively missing.

#### v6.6.9 - Party Comparison View
- A 4-column panel in the config UI displays all connected party members' loadouts side by side for pre-mission coordination and deconfliction.

#### v6.6.10 - Loadout Permalink
- Generates a URL via the GitHub Gist API that encodes the current loadout. Anyone with the URL can open it in a browser or paste it into the share code importer.

---

### v6.7.x - Performance & Resource Optimization

#### v6.7.1 - Sleep Mode
- When `helldivers2.exe` is not the foreground window, all polling loops reduce to 1 Hz, dramatically lowering CPU usage during desktop use or between missions.

#### v6.7.2 - Lazy GUI Redraw
- HUD Text controls are only redrawn when their values actually change, eliminating redundant `Value` assignments on every timer tick.

#### v6.7.3 - Compiled EXE Option
- Provides a pre-compiled `STRAGEM.exe` using AHK's built-in compiler, requiring no AHK installation for end users. Downloadable from the releases page.

#### v6.7.4 - Portable Mode
- All configuration files are written exclusively to the script directory. No files are created in `AppData`, `TEMP`, or the registry, enabling fully portable USB-stick deployment.

#### v6.7.5 - Memory Footprint Audit
- Systematic profiling and optimization targeting idle RAM consumption below **15 MB**, including stratagem array compression and GUI handle management review.

#### v6.7.6 - Startup Time Optimization
- GUI construction and file I/O are profiled and restructured to achieve visible HUD display within **200 ms** of script launch on modern hardware.

#### v6.7.7 - Config File Compression
- For Users with large numbers of profiles, INI files are optionally replaced with a compact binary format that reduces I/O overhead on profile switches.

#### v6.7.8 - Reduced Redraw Compact Mode
- The compact HUD redraws exclusively on state changes (active slot change, rapid fire toggle, etc.) rather than on any timer tick, reducing flicker and CPU cycles.

#### v6.7.9 - Low-Spec Mode
- A Settings toggle disables all animations, reduces the GUI to a minimal text-only strip, and targets sub-5% CPU usage on single-core workloads.

#### v6.7.10 - Internal Performance Panel
- A developer-accessible panel (toggle via `Ctrl+Alt+Shift+P`) displays live metrics: GUI redraw counts per second, event queue depth, memory usage, and timer resolution.

---

### v6.8.x - Accessibility

#### v6.8.1 - High-Contrast Mode
- Forces black background and white text with no intermediate grays, meeting **WCAG AA** contrast ratio requirements for Users with visual impairments.

#### v6.8.2 - Large-Text Mode
- Scales all UI fonts to a minimum of 12pt and widens controls proportionally. Useful for 4K displays at 100% scaling or Users with low vision.

#### v6.8.3 - Colorblind Mode
- Three presets replace accent colors with colorblind-safe palettes: **Deuteranopia** (red-green), **Protanopia** (red), **Tritanopia** (blue-yellow).

#### v6.8.4 - Reduced Motion
- Disables all flash animations, fade transitions, and pulse effects throughout the UI. Appropriate for Users with vestibular disorders or motion sensitivity.

#### v6.8.5 - Keyboard-Only Config Navigation
- All config panel controls are fully navigable via `Tab`, `Arrow`, and `Enter` keys without mouse interaction, meeting keyboard accessibility standards.

#### v6.8.6 - Screen Reader Hints
- Hidden accessible label text is added to all GUI controls via AHK's accessibility API, enabling screen reader software to announce control purposes.

#### v6.8.7 - Mouse-Over Tooltips
- Hovering any label, button, slot row, or sequence display triggers a descriptive tooltip explaining its purpose and current value.

#### v6.8.8 - Adjustable Click Target Size
- A Settings option sets minimum hit-area dimensions for all buttons and interactive controls: standard (default), **24x24 px**, or **32x32 px**, reducing precision demands.

#### v6.8.9 - Locale Selection
- A locale dropdown in Settings allows selecting a regional date/time format (US, EU, ISO 8601, etc.) applied to all log timestamps and timer displays.

#### v6.8.10 - Accessibility Profile Export
- All accessibility settings (contrast, font size, colorblind mode, motion, locale) can be exported as a named profile `.json` file and shared between machines or users.

---

### v6.9.x - Diagnostics & Support

#### v6.9.1 - Log Viewer
- The AHK error log (`#ErrorStdOut` output) is readable directly within the config panel via a scrollable text area, eliminating the need to open an external text editor.

#### v6.9.2 - Game Process Monitor
- A live indicator in the status bar shows whether `helldivers2.exe` is currently detected by the OS process list, along with its PID. Updates every 5 seconds.

#### v6.9.3 - Sequence Test Mode
- A **Cast to Notepad** button opens Notepad (or the system default text editor) and fires the selected slot's sequence as literal text characters for manual verification without affecting the game.

#### v6.9.4 - Config Integrity Check
- On startup, `stratagem_loadout.ini` is validated for correct line count and known stratagem names. Corrupted or mismatched entries trigger a warning dialog with an option to reset to defaults.

#### v6.9.5 - System Info Snapshot
- A **Generate Report** button produces a formatted block containing: OS version, AHK version, screen resolution, DPI setting, and monitor count. Copy to clipboard for bug reports.

#### v6.9.6 - Auto-Backup
- Before every save operation, `stratagem_loadout.ini` is copied to `stratagem_loadout.bak`. The backup is overwritten each save, providing a one-level rollback.

#### v6.9.7 - Crash Recovery
- If the script exits unexpectedly, a `crash.log` is written containing the last known state. On the next launch, the script detects the crash log and offers to restore the last good configuration.

#### v6.9.8 - Config Reset Button
- A **Reset All Settings** button in the Diagnostics section restores all settings and the loadout to factory defaults. A confirmation dialog and automatic backup precede the reset.

#### v6.9.9 - Unit Test Mode
- Running the script with the `--test` command-line argument executes a headless validation suite: all 102 stratagem sequences are parsed and re-serialized, and any format errors are reported to stdout.

#### v6.9.10 - Support Bundle
- A **Generate Support Bundle** button creates a ZIP archive containing: the AHK error log, `stratagem_loadout.ini`, the system info snapshot, and AHK version string. Ready for attachment to a GitHub Issue.

---

### v7.0.x - Companion App Window

#### v7.0.1 - External Companion Window
- A separate resizable application window (not an overlay) dedicated to pre-mission loadout setup and configuration, launchable from the system tray icon.

#### v7.0.2 - Full Stratagem Database Browser
- The companion window contains a searchable, sortable, and filterable table of all stratagems with their names, categories, sequences, and cooldown values.

#### v7.0.3 - Drag-and-Drop Loadout Builder
- Drag stratagem rows from the database browser directly to slot positions in the companion loadout panel. The overlay updates in real time via IPC.

#### v7.0.4 - Real-Time HUD Mirror
- The companion window displays a live pixel-accurate preview of how the overlay currently looks, updating as slot assignments or themes are changed.

#### v7.0.5 - All Settings Accessible in Companion
- The complete Settings panel (from v5.9) is embedded as a tab in the companion window, providing full configuration access in a comfortable desktop environment.

#### v7.0.6 - Stats Dashboard in Companion
- Session and all-time statistics are displayed in the companion window using ASCII art bar graphs, line charts for cast frequency over time, and top-stratagem rankings.

#### v7.0.7 - Theme Editor in Companion
- The visual WYSIWYG theme editor (from v5.6.6) is hosted in the companion window with a live HUD preview pane that updates on every color change.

#### v7.0.8 - IPC Channel
- The main overlay script and companion window communicate state (active slot, rapid fire status, current loadout) via a named pipe, keeping both windows synchronized.

#### v7.0.9 - Multi-Tab Companion Layout
- The companion window uses a tab strip: **Loadout | Library | Settings | Stats | Themes**. Each tab provides a dedicated full-height content area.

#### v7.0.10 - Companion Window Position Memory
- The companion window remembers its size and position independently from the overlay. Both are restored on the next launch from separate config keys.

---

### v7.1.x - Web Companion & Mobile

#### v7.1.1 - Local Web Server Mode
- The script can optionally serve a web UI on `localhost:7447`, accessible from any device on the same local network including phones, tablets, and other PCs.

#### v7.1.2 - Mobile-Friendly Loadout Builder
- The web UI includes a touch-optimized slot assignment interface with large tap targets, swipe-to-scroll stratagem lists, and a single-page layout suited for phone screens.

#### v7.1.3 - Mobile Stratagem Reference
- The web companion includes a full stratagem database view optimized for phone screens: searchable by name, filterable by category, with arrow sequences displayed clearly.

#### v7.1.4 - QR Code Pairing
- Scanning the QR code displayed in the desktop companion window automatically opens the web companion on the phone, pre-configured with the correct local IP and port.

#### v7.1.5 - Push Loadout from Phone
- Changes made to slot assignments in the mobile web UI are pushed to the desktop script via a REST API call, updating the overlay immediately.

#### v7.1.6 - Offline PWA Mode
- The web UI is built as a Progressive Web App: installable to a phone's home screen and functional offline for loadout planning without an active server connection.

#### v7.1.7 - Shared Favorites via Web
- The favorites list (from v5.5) is accessible and editable from the mobile web companion, with changes syncing back to the desktop overlay.

#### v7.1.8 - Mobile Dark Mode
- The web companion automatically follows the phone's OS dark/light mode preference via the `prefers-color-scheme` media query.

#### v7.1.9 - Loadout Share URL
- Generate a URL that encodes a full loadout in query parameters. Anyone can open the URL in a browser to view and copy the loadout, with no server required.

#### v7.1.10 - Multi-Device Sync
- Loadout changes made on any connected web client propagate to all other connected devices and the desktop overlay in real time via WebSocket events.

---

### v7.2.x - Community Platform

#### v7.2.1 - GitHub-Hosted Loadout Registry
- A structured JSON database of community-submitted loadouts hosted in the project's GitHub repository, with faction tags, difficulty ratings, and upvote counts.

#### v7.2.2 - Browse Community Loadouts in Companion
- The companion Library tab includes a community browser: search, filter by faction/difficulty, view loadout details, and see upvote counts and submission dates.

#### v7.2.3 - Submit Loadout to Community
- A one-click **Submit** button in the companion Loadout tab opens a form to add a description and tags, then submits the current loadout to the community registry via the GitHub API.

#### v7.2.4 - Community Stratagem Corrections
- A **Report Error** button next to any stratagem in the Library opens a pre-filled GitHub Issue form for submitting sequence corrections, reducing friction for community contributions.

#### v7.2.5 - Featured Loadout of the Week
- A highlighted panel in the community browser showcases a curated loadout each week, selected by the project maintainer and pinned above search results.

#### v7.2.6 - Loadout Comments
- Community loadout pages in the companion show recent short comments from other users. Authenticated Users (via GitHub OAuth) can post their own comments.

#### v7.2.7 - Follow Tags
- Subscribe to loadout tags (e.g., `solo-run`, `speedrun`, `extraction`) to receive in-app notifications when new matching loadouts are submitted to the registry.

#### v7.2.8 - Trending Loadouts
- A **Trending** sort option in the community browser ranks loadouts by import count over the last 7 days, surfacing currently popular community meta builds.

#### v7.2.9 - Loadout Versioning
- Community loadouts track edit history. The companion browser shows a diff view comparing any two versions, with author and timestamp for each change.

#### v7.2.10 - Anonymous Telemetry Opt-In
- An opt-in checkbox in Settings allows anonymously contributing aggregate stratagem usage statistics, helping improve the suggestion engine and community database.

---

### v7.3.x - AI Stratagem Advisor

#### v7.3.1 - Local LLM Integration
- Embeds a lightweight quantized language model via `llama.cpp` for fully on-device AI suggestions, requiring no internet connection or API key.

#### v7.3.2 - Natural Language Loadout Query
- Type a free-form request (e.g., "give me an anti-tank build for Helldive") into the AI panel and the model populates all 7 custom slots with appropriate stratagems.

#### v7.3.3 - Mission Context Form
- A structured input form (enemy faction, difficulty, objective type, squad size, personal role) provides context to the AI for more targeted suggestions than free-text alone.

#### v7.3.4 - AI Reasoning Display
- Each AI-suggested slot includes a one-line plain text explanation of the pick (e.g., "Effective against heavy armor at range; pairs well with Railgun.").

#### v7.3.5 - Synergy Analysis
- The AI flags redundant slot combinations (two armor-killers, overlapping area denial) and suggests alternative stratagems to improve loadout coverage balance.

#### v7.3.6 - AI Learning Mode
- Feedback buttons (**Worked Well** / **Didn't Work**) on each AI suggestion session train a local preference model that refines future suggestions for your playstyle.

#### v7.3.7 - Voice Query
- Speak a natural language request into the microphone. Windows Speech Recognition transcribes it in real time and sends the text to the AI panel, enabling hands-free loadout planning.

#### v7.3.8 - Cooldown-Aware Suggestions
- The AI considers stratagem cooldown durations (from v6.4) when building loadouts, preferring combinations with staggered cooldowns to maximize sustained stratagem uptime.

#### v7.3.9 - Meta Integration
- The AI optionally pulls recent community vote data (from v7.2) to weight suggestions toward currently high-performing community loadouts while still respecting your context.

#### v7.3.10 - Suggestion History
- A scrollable history of all past AI recommendation sessions is accessible in the AI panel, showing the context input, suggestions made, and any feedback provided.

---

### v7.4.x - Discord Integration

#### v7.4.1 - Discord Rich Presence
- The script publishes current loadout summary (e.g., "Eagle Airstrike / Orbital Laser / Jump Pack...") and session timer duration to Discord Rich Presence status.

#### v7.4.2 - Loadout to Discord Clipboard
- Formats the current loadout as a Discord-flavored markdown code block with emoji arrows and copies it to the clipboard for immediate posting in a server channel.

#### v7.4.3 - Discord Webhook
- A configurable webhook URL in Settings allows the script to POST the current loadout to any Discord server channel with a single button press or hotkey.

#### v7.4.4 - Import Loadout from Discord
- Paste a Discord message URL into the import field; the tool fetches the message via the Discord API and parses any recognized loadout format, populating slots automatically.

#### v7.4.5 - Discord Bot Commands
- A lightweight companion Discord bot responds to `!loadout` (returns your current loadout) and `!strat [name]` (returns the arrow sequence for any stratagem) in your server.

#### v7.4.6 - Discord Overlay Awareness
- Detects when the Discord in-game overlay is active and automatically adjusts the STRAGEM HUD position to avoid visual overlap.

#### v7.4.7 - Discord Voice Activity Detection
- Monitors Discord push-to-talk and voice activity state. When voice is active, rapid fire audio cues are automatically muted to prevent interference.

#### v7.4.8 - Stratagem Database Update Notifications
- When a new stratagem sequence patch is released, the companion Discord bot posts an announcement in the configured notification channel with a changelog summary.

#### v7.4.9 - Discord Party Sync
- Squad members running the tool can sync loadouts through a shared Discord channel: post your share code and the tool auto-detects and imports party member loadouts from the channel history.

#### v7.4.10 - Discord Server Link
- An in-app **Join Community** button opens the official S.T.R.A.T.A.G.E.M. TERMINAL Discord server invite link for support, loadout sharing, and community discussion.

---

### v7.5.x - Automatic Game Patch Updates

#### v7.5.1 - Game Patch Detector
- On launch, the script hashes `helldivers2.exe` and compares it against the last known hash. A status bar message warns if a game patch is detected, prompting a sequence re-verification.

#### v7.5.2 - Stratagem DB Update Checker
- Silently queries the GitHub releases page for a newer `stratagems.json` on each startup. A banner notification appears if an update is available.

#### v7.5.3 - Auto-Download Patches
- With explicit user permission (opt-in checkbox in Settings), the script downloads and applies verified stratagem sequence corrections automatically on startup.

#### v7.5.4 - Patch Validation
- All downloaded stratagem data is checksum-verified against the published hash before being applied, preventing tampered or corrupted database files from loading.

#### v7.5.5 - Patch Rollback
- A **Restore Previous Database** button in the Diagnostics panel reverts to the stratagem database version in use before the last applied patch.

#### v7.5.6 - Patch Changelog Viewer
- An in-app changelog panel (accessible from the update notification banner) shows a formatted list of what changed in each database update: added stratagems, corrected sequences, removed entries.

#### v7.5.7 - Sequence Re-Validation on Patch
- After any database update, all currently loaded loadout slots are automatically re-validated. Slots whose sequences changed in the patch are flagged in yellow in the config panel.

#### v7.5.8 - Community Confirmation
- A database patch is only marked as **Verified** and auto-distributed after at least 3 community contributors confirm the sequences via a GitHub discussion thread.

#### v7.5.9 - Manual Patch Mode
- Advanced You can edit `stratagems.json` directly. If a pending auto-patch is available, the tool warns before overwriting manual edits.

#### v7.5.10 - Patch History Browser
- An in-app timeline view in the Diagnostics panel shows every database change since v4.7, with dates, version tags, and you who submitted each correction.

---

### v7.6.x - Streaming & Content Creator Tools

#### v7.6.1 - OBS Browser Source
- The local web server (from v7.1.1) serves a transparent overlay page at `localhost:7447/obs-overlay` that can be added as a Browser Source in OBS Studio for stream integration.

#### v7.6.2 - Stream-Optimized HUD Layout
- A dedicated stream layout uses larger fonts (minimum 14pt), higher contrast colors, and a simplified single-column design optimized for visibility at 1080p stream resolution.

#### v7.6.3 - Twitch Chat Loadout Command
- Integrate with Streamlabs/StreamElements chat bot: `!loadout` in chat triggers an auto-response listing all 9 current slots in a readable format.

#### v7.6.4 - Viewer Vote Integration
- Via Twitch EventSub, viewers can vote in chat for your next stratagem. The most-voted option is highlighted in the HUD. you has 10 seconds to cast or override.

#### v7.6.5 - Stream Alerts on Cast
- Trigger StreamElements or SE.Live webhook alerts when a configured "big combo" is executed, creating automatic stream moments for highlight clips.

#### v7.6.6 - Custom HUD Branding
- A Settings panel for streamers allows adding a name strip, logo placeholder area (PNG file path), or sponsor text ticker to the HUD overlay for brand customization.

#### v7.6.7 - Highlight Clip Marker
- Pressing a configurable hotkey timestamps the current moment in the session log with a `[CLIP]` marker, making it easy to find highlight moments in post-session review.

#### v7.6.8 - YouTube Chapter Data
- Exports the session cast log as YouTube chapter timestamps in standard format (`0:00 Opening`, `1:34 Eagle Airstrike`, etc.) for automated VOD chapter creation.

#### v7.6.9 - Stream Recording Cast Log
- Writes a live `.srt` subtitle file with stratagem names and timestamps synchronized to OBS recording timecode, enabling auto-subtitles in stream VODs.

#### v7.6.10 - Creator Kit
- A downloadable ZIP package containing: a pre-configured OBS scene collection, overlay CSS file, Streamlabs bot script, and a step-by-step streaming setup guide for new creators.

---

### v7.7.x - Achievements & Progression

#### v7.7.1 - Achievement System
- 30 built-in achievements tracking milestones: **First Blood** (first cast), **Thousand Yard Stare** (1,000 total casts), **Eagle Scout** (cast every Eagle stratagem), and 27 more.

#### v7.7.2 - Achievement Notification
- When an achievement is earned, a toast popup appears briefly in the bottom-right corner of the HUD with the achievement name, icon, and a one-line description.

#### v7.7.3 - Achievement Panel
- A dedicated **Achievements** tab in the companion window shows all 30 achievements with completion status, progress bars for countable milestones, and unlock dates.

#### v7.7.4 - Stratagem Mastery Ranks
- Each stratagem tracks lifetime cast count. At defined thresholds, the stratagem advances through ranks: **Rookie > Veteran > Elite > Legend**, displayed in the Library Panel.

#### v7.7.5 - Rank Badge Display
- Mastery rank is shown as a small badge icon on each slot row in the config panel (e.g., a single chevron for Veteran, three for Legend), giving a visual progression indicator.

#### v7.7.6 - Daily Challenges
- Randomized daily objectives refresh at midnight local time (e.g., "Cast the Autocannon Sentry 5 times", "Execute a 3-stratagem combo"). Displayed in a banner in the status area.

#### v7.7.7 - Challenge Streak Tracker
- Consecutive days completing at least one daily challenge build a streak counter displayed in the companion Stats tab. Streaks unlock exclusive HUD accent color variants.

#### v7.7.8 - Milestone Unlocks
- Reaching major milestones (e.g., 500 total casts, Legend rank on any stratagem) unlocks exclusive HUD themes and achievement badge icon variants in the Theme picker.

#### v7.7.9 - Achievement Export
- A **Generate Achievement Card** button in the Achievements panel renders a PNG image showing your name, total casts, earned achievement badges, and top-ranked stratagems using GDI+ rendering.

#### v7.7.10 - Achievement Leaderboard
- You can optionally submit their achievement score (total achievements earned + mastery ranks) to a public GitHub-hosted JSON leaderboard, viewable in the companion Achievements tab.

---

### v7.8.x - Extended Platform Support

#### v7.8.1 - Wine Compatibility
- Tested and documented procedure for running the script under Wine on Linux. A `/docs/linux-wine.md` setup guide covers Wine version requirements, DLL overrides, and known limitations.

#### v7.8.2 - Steam Deck Mode
- A gamepad-first UI mode with large controls optimized for the Steam Deck's touchscreen, trigger binding support via v5.2.7, and on-screen indicator adjustments for the 1280x800 display.

#### v7.8.3 - Windows 11 Mica Background
- On Windows 11 with compatible DWM, the config panel uses the **Mica** material (backdrop blur + tinted translucency) via `DwmSetWindowAttribute` for native OS visual integration.

#### v7.8.4 - Windows 11 Rounded Corners
- Applies DWM rounded corner style (`DWMWCP_ROUND`) to all GUI windows on Windows 11 via `DwmSetWindowAttribute`, matching the system UI aesthetic.

#### v7.8.5 - Controller-Only Navigation
- All config panel controls (dropdowns, buttons, sliders) are navigable using a connected gamepad's D-pad and face buttons without any keyboard or mouse input required.

#### v7.8.6 - Touchscreen Mode
- Enables larger hit targets, swipe-to-scroll on the stratagem dropdown list, and pinch-to-resize gestures for the HUD overlay, supporting touchscreen laptops and tablets.

#### v7.8.7 - Localization: 5 Languages
- All UI strings are externalized to locale files. Included locales: **French (fr-FR)**, **German (de-DE)**, **Japanese (ja-JP)**, **Korean (ko-KR)**, **Brazilian Portuguese (pt-BR)**.

#### v7.8.8 - RTL Layout Support
- Right-to-left text layout support for **Arabic** and **Hebrew** locales is stubbed and documented for future implementation, so RTL support can be added later without major refactoring.

#### v7.8.9 - 64-Bit Compiled EXE
- Official 64-bit AHK v2 compiled release with all dependencies bundled (AHK runtime, llama.cpp if AI module is present). Single-file distribution with no external installer required.

#### v7.8.10 - Accessibility API
- Full implementation of the Windows UI Automation (UIA) provider interface for all GUI controls, so screen reader software (NVDA, JAWS, Narrator) can fully announce and interact with the tool.

---

### v7.9.x - Plugin & Extension System

#### v7.9.1 - Plugin API v1.0 Spec
- A fully documented API specification for third-party AHK v2 include files to hook into STRAGEM events: `OnCast`, `OnSlotChange`, `OnProfileSwitch`, `OnRapidToggle`, and `OnHUDDraw`.

#### v7.9.2 - Plugin Loader
- On startup, the script scans a `/plugins` subdirectory and automatically loads all `.ahk` files found there using `#Include`. Load order is alphabetical.

#### v7.9.3 - Plugin Permission Model
- Each plugin must declare required permissions in a header comment block: `NETWORK`, `FILE_WRITE`, `GUI_CREATE`, `HOTKEY_REGISTER`. The loader warns you on first install for each declared permission.

#### v7.9.4 - Plugin Sandbox
- Plugins operate in a restricted context. Direct access to global variables is prevented; all state access is mediated through the Plugin API functions, reducing the risk of conflicts.

#### v7.9.5 - Plugin Manager UI
- A **Plugins** tab in the companion Settings window lists all loaded plugins with enable/disable toggles, version numbers, permission badges, and one-click uninstall.

#### v7.9.6 - First-Party Plugin: Wiki Connector
- Right-clicking any stratagem name in the HUD or Library Panel opens the corresponding `helldivers.wiki.gg` page in the default browser.

#### v7.9.7 - First-Party Plugin: Build Guide Linker
- Allows attaching a YouTube URL to any loadout profile. A **Watch Guide** button in the profile switcher opens the linked video in the default browser for pre-mission study.

#### v7.9.8 - Plugin Marketplace
- An in-app browser in the companion Plugins tab lists community plugins from a GitHub-hosted registry with names, descriptions, install counts, and one-click download.

#### v7.9.9 - Plugin Versioning
- Each plugin declares a `STRAGEM_MIN_VERSION` in its header. The loader performs a semantic version check and warns you if a plugin is incompatible with the installed STRAGEM version.

#### v7.9.10 - STRAGEM SDK Release
- An official SDK ZIP release containing: a plugin template file, the complete Plugin API documentation, five example plugins (Wiki Connector, Audio Events, TTS, Stats Export, Theme Switcher), and a `scaffold.ahk` wizard that generates a new plugin skeleton interactively.

---

## SECTION 14: Version History

| Version | Summary |
|---|---|
| **v4.0** | Initial public release. Basic overlay with 6 configurable slots. |
| **v4.1** | ComboBox dropdowns replaced raw text input fields for stratagem selection. |
| **v4.2** | Compact click-through mode introduced; overlay passes mouse input to game. |
| **v4.3** | Rapid fire mode added with jittered timing for semi-auto weapon support. |
| **v4.4** | `MonitorGetWorkArea` DPI fix ensures correct positioning on high-DPI displays. |
| **v4.5** | RAPID ON indicator added for hidden mode: small persistent top-right dot when rapid fire is active but HUD is hidden. |
| **v4.6** | Loadout expanded to 9 slots; Slot 0 hardcoded to SOS Beacon. |
| **v4.7** | Stratagems refactored from flat arrays to object array with `{Name, Keys}` properties. Database expanded to **102 entries**. GUI overhauled to 420px width with colored left-stripe slot rows, dark ComboBox theming via `SetWindowTheme`, and enhanced status bar. |

---

## SECTION 15: Contributing & Credits

**Sequence Corrections:** If you discover an incorrect stratagem sequence, please open a GitHub Issue with the stratagem name, the current (incorrect) sequence, and the correct sequence. Community verification is appreciated before corrections are merged.

**New Stratagems:** When Arrowhead Game Studios adds new stratagems in a game patch, open a GitHub Issue or pull request with the stratagem name, category, and directional sequence in the format used by the existing array (`Keys: "Up,Down,Left,Right,..."`).

**Built With:** [AutoHotkey v2.0](https://www.autohotkey.com/) - the open-source scripting language for Windows automation.

**Stratagem Data:** Sequences sourced and verified against [helldivers.wiki.gg](https://helldivers.wiki.gg). Community contributions to sequence accuracy are welcome and credited.

**License:** Provided as-is for personal, non-commercial use. Not affiliated with Arrowhead Game Studios or Sony Interactive Entertainment.

---

> *FOR SUPER-EARTH. FOR MANAGED DEMOCRACY. HELLDIVERS NEVER DIE.*
