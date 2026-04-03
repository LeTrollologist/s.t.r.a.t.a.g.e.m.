# S.T.R.A.T.A.G.E.M. TERMINAL

**Smart Trigger Regulation And Tactical Action Guidance Execution Manager**
`v4.6` · AutoHotkey v2 · Helldivers 2 · Windows 10/11

> An always-on-top HUD overlay that manages your stratagem loadout, fires directional sequences automatically, and animates each cast in real time — so you can focus on the battlefield instead of the keyboard.

---

## Requirements

| Requirement | Details |
|---|---|
| **AutoHotkey v2.0+** | [Download from autohotkey.com](https://www.autohotkey.com/) — v1.x will **not** work |
| **Windows 10 or 11** | Uses native Windows GUI and transparency APIs |
| **Helldivers 2** | Process name `helldivers2.exe` — in-game hotkeys only activate when the game window is focused |

---

## Installation

1. Install **AutoHotkey v2.0** from [autohotkey.com](https://www.autohotkey.com/)
2. Place `Helldivers.ahk` anywhere on your computer (e.g. your Desktop or a `HellDiversMacros` folder)
3. **Double-click** `Helldivers.ahk` to launch — an AHK icon appears in your system tray
4. The S.T.R.A.T.A.G.E.M. Terminal HUD appears on the **right side of the screen**
5. To auto-start with Windows: right-click the `.ahk` file → *Create shortcut*, place the shortcut in `shell:startup`

> **To stop the script:** right-click the green AHK icon in the system tray → *Exit*

---

## The HUD

The overlay has three states you can cycle through freely, even mid-mission:

### Full Mode *(default)*
The complete configuration panel. Shows all 9 stratagem slots with dropdowns, a deploy button, and the live active HUD below it.

```
┌─ S.T.R.A.T.A.G.E.M. ─────────────────────────── ✦ ─┐
│ ! RAPID FIRE: avoid full-auto weapons  [End] to toggle│
│ LOADOUT  CTRL+1-9  //  SLOTS 3-9 CUSTOMIZABLE         │
│ 1  Reinforce                              [LOCKED]    │
│ 2  Resupply                               [LOCKED]    │
│ 3  [Eagle 500KG Bomb           ▼]                     │
│ 4  [Orbital Laser              ▼]                     │
│ ...                                                   │
│ ACTIVE HUD  //  CTRL+0 SOS BEACON                     │
│ [1] Reinforce     ^ v > < ^                           │
│ [2] Resupply      v v ^ >                             │
│ [3] Eagle 500KG   ^ > v v v                           │
│ ...                                                   │
│ ONLINE        RAPID O        [-]COMPACT  [END]RAPID   │
│          FOR SUPER-EARTH!                             │
└───────────────────────────────────────────────────────┘
```

### Compact Mode *(press `-`)*
HUD-only overlay. The config panel is hidden. The window is **fully click-through** (mouse events pass straight through to the game) and **more transparent** than full mode — designed to sit in your peripheral vision without interfering with play.

### Hidden Mode *(press `=`)*
Everything is hidden. If **Rapid Fire** is active, a small **`RAPID ON`** indicator appears in the top-right corner of the screen so you always know the mode is on. Press `=` again to restore the previous view.

---

## Hotkey Reference

### Global Hotkeys *(work anywhere, even outside the game)*

| Hotkey | Action |
|---|---|
| `=` | Toggle HUD **visible / hidden** |
| `-` | Toggle **compact mode** (click-through HUD only) |
| `End` | Toggle **rapid fire** on / off |
| `Ctrl+Alt+D` | **Reload** the script (also repositions the HUD) |

### In-Game Hotkeys *(only active when `helldivers2.exe` is focused)*

| Hotkey | Action |
|---|---|
| `Ctrl+0` | Fire **SOS Beacon** |
| `Ctrl+1` | Fire **Reinforce** *(hardcoded — always available)* |
| `Ctrl+2` | Fire **Resupply** *(hardcoded — always available)* |
| `Ctrl+3` | Fire custom **Slot 3** |
| `Ctrl+4` | Fire custom **Slot 4** |
| `Ctrl+5` | Fire custom **Slot 5** |
| `Ctrl+6` | Fire custom **Slot 6** |
| `Ctrl+7` | Fire custom **Slot 7** |
| `Ctrl+8` | Fire custom **Slot 8** |
| `Ctrl+9` | Fire custom **Slot 9** |
| `Escape` / `Tab` | **Auto-disable rapid fire** when opening menus or the map |
| `LMB` *(rapid fire on)* | Sustained automatic fire |

> **Tip:** Hold `Ctrl` before pressing the number, just like you would open the stratagem wheel — the script detects when Ctrl is released mid-sequence and stops automatically.

---

## Slot System

The 10 slots are split across three tiers:

| Slot | Key | Type | Stratagem |
|---|---|---|---|
| 1 | `Ctrl+1` | **Locked** | Reinforce |
| 2 | `Ctrl+2` | **Locked** | Resupply |
| 3–9 | `Ctrl+3`–`Ctrl+9` | **Custom** | Your choice |
| 0 | `Ctrl+0` | **Locked** | SOS Beacon |

**Why are slots 1 and 2 locked?**
Reinforce and Resupply are required in virtually every mission — locking them guarantees they're always on Ctrl+1 and Ctrl+2 without risk of accidentally overwriting them. SOS Beacon (`Ctrl+0`) is similarly locked as a universal emergency signal.

---

## Configuring Your Loadout

### Using the Dropdowns
1. Open the full HUD (press `-` to leave compact mode if needed)
2. Click a dropdown for **Slots 3–9** and pick any stratagem from the list
3. The HUD updates instantly to show the new sequence
4. Click **DEPLOY LOADOUT** to save

### Typing a Custom Sequence
If a stratagem isn't in the list, or you want to use a variant, type the sequence directly into the slot box:

```
Up,Down,Left,Right,Up
```

Rules:
- Direction names are **case-sensitive**: `Up`, `Down`, `Left`, `Right`
- Separate with **commas, no spaces**
- The sequence validates automatically; invalid entries are ignored

### Saving and Loading
- Click **DEPLOY LOADOUT** — the button flashes and saves to `stratagem_loadout.ini`
- Your loadout is **automatically loaded** on the next launch
- The file is plain text and can be edited in Notepad

---

## Save File (`stratagem_loadout.ini`)

Location: same folder as `Helldivers.ahk`

Format — 7 lines, one entry per line:
```
Eagle 500KG Bomb
Orbital Laser
Railgun
Shield Generator Pack
Autocannon Sentry
Recoilless Rifle
Guard Dog Rover
```

| Line | Slot |
|---|---|
| 1 | Slot 3 |
| 2 | Slot 4 |
| 3 | Slot 5 |
| 4 | Slot 6 |
| 5 | Slot 7 |
| 6 | Slot 8 |
| 7 | Slot 9 |

> Slots 1, 2, and 0 (Reinforce, Resupply, SOS Beacon) are hardcoded and are never written to or read from this file.

---

## HUD Arrow Legend

During normal display:
```
^ = Up    v = Down    < = Left    > = Right
```

During an active cast, the sequence animates step by step:
```
.  = step already pressed
>  = step currently being pressed
^  = upcoming step (not yet pressed)
```

Example — casting Eagle 500KG Bomb `^ > v v v`, currently on step 3:
```
[3] Eagle 500KG  . . > v v
```

---

## Rapid Fire Mode

Rapid fire enables sustained semi-automatic fire by holding the left mouse button.

| | Detail |
|---|---|
| **Toggle** | Press `End` anywhere |
| **Status** | HUD shows `RAPID @` when active, `RAPID O` when off |
| **Timing** | Hold: 18–32 ms · Between shots: 42–68 ms (randomised each shot) |
| **Auto-off** | Pressing `Escape` or `Tab` disables it automatically |
| **Warning** | **Do NOT use on full-auto weapons** — it overrides the fire rate and causes burst-fire behaviour. Use only for semi-auto weapons requiring fast repeated clicks. |

When the HUD is hidden (`=`) and rapid fire is active, a small red **`RAPID ON`** pill appears at the top-right corner of the screen so you always know the state.

---

## Stratagem Reference

Arrow key: `^` Up · `v` Down · `<` Left · `>` Right

### Mission Essentials

| Stratagem | Sequence |
|---|---|
| Reinforce | `^ v > < ^` |
| SOS Beacon | `^ v > ^` |
| Resupply | `v v ^ >` |
| NUX-223 Hellbomb | `v ^ < v ^ > v ^` |
| SSSD Delivery | `v ^ ^ < >` |
| Prospecting Drill | `v ^ ^ < > >` |
| Super Earth Flag | `v ^ v ^` |
| Seismic Probe | `v v < ^ >` |
| Upload Data | `v < ^ v` |
| Eagle Rearm | `^ ^ < ^` |
| SEAF Artillery | `> ^ ^ v` |
| Illuminate Distractor Beacon | `> > < <` |

### Eagle Stratagems

| Stratagem | Sequence |
|---|---|
| Eagle Strafing Run | `^ > >` |
| Eagle Airstrike | `^ > v >` |
| Eagle Cluster Bomb | `^ > v v >` |
| Eagle Napalm Airstrike | `^ > v ^` |
| Eagle Smoke Strike | `^ > ^ v` |
| Eagle 110MM Rocket Pods | `^ > ^ <` |
| Eagle 500KG Bomb | `^ > v v v` |

### Orbital Stratagems

| Stratagem | Sequence |
|---|---|
| Orbital Gatling Barrage | `> v < ^ ^` |
| Orbital Airburst Strike | `> > >` |
| Orbital 120MM HE Barrage | `> > v < > v` |
| Orbital 380MM HE Barrage | `> v ^ ^ < v v` |
| Orbital Walking Barrage | `> v > v > v` |
| Orbital Laser | `> v ^ > v` |
| Orbital Railcannon Strike | `> ^ v v >` |
| Orbital Precision Strike | `> > ^` |
| Orbital Gas Strike | `> > v >` |
| Orbital EMS Strike | `> > < v` |
| Orbital Smoke Strike | `> > v ^` |
| Orbital Napalm Barrage | `> > v < > ^` |

### Exosuits

| Stratagem | Sequence |
|---|---|
| Patriot Exosuit | `< v > ^ < v v` |
| Emancipator Exosuit | `> ^ < v > v` |

### Sentries & Emplacements

| Stratagem | Sequence |
|---|---|
| Machine Gun Sentry | `v ^ > > ^` |
| Gatling Sentry | `v ^ > < ^` |
| Mortar Sentry | `v ^ ^ < v` |
| HMG Emplacement | `v < ^ v v >` |
| Autocannon Sentry | `v < v ^ ^ >` |
| Rocket Sentry | `v ^ ^ > >` |
| EMS Mortar Sentry | `v ^ ^ v >` |
| Tesla Tower | `v ^ > ^ < ^` |
| Flame Sentry | `v ^ > v ^ ^` |
| Anti-Tank Emplacement | `v ^ < > > >` |
| Shield Generator Relay | `v ^ < > < >` |

### Backpacks & Guard Dogs

| Stratagem | Sequence |
|---|---|
| Guard Dog Rover | `^ ^ v ^ >` |
| Ballistic Shield Backpack | `v < v v ^ <` |
| Guard Dog | `v ^ < ^ >` |
| Guard Dog (Standard) | `v ^ < ^ >` |
| Guard Dog (Dog Breath) | `v ^ < ^ > ^` |
| Shield Generator Pack | `v ^ < > < >` |
| Directional Shield | `v ^ < > ^ ^` |
| Hover Pack | `v ^ ^ v < >` |

### Area Denial & Mines

| Stratagem | Sequence |
|---|---|
| Anti-Personnel Minefield | `v < ^ >` |
| Anti-Tank Mines | `v < ^ < v` |
| Incendiary Mines | `v < < v >` |

### Support Weapons

| Stratagem | Sequence |
|---|---|
| Laser Cannon | `v < v ^ <` |
| Incendiary Breaker | `v < ^ v <` |
| Anti-Materiel Rifle | `v < > ^ v` |
| Stalwart | `v < v ^ ^ <` |
| Expendable Anti-Tank | `v v < ^ >` |
| Recoilless Rifle | `v < > > <` |
| Flamethrower | `v < ^ v ^` |
| Autocannon | `v < v ^ ^ >` |
| Heavy Machine Gun | `v < ^ v v` |
| Airburst Rocket Launcher | `^ v ^ ^ v` |
| Spear | `v v ^ v v` |
| Grenade Launcher | `v < ^ < v` |
| Arc Thrower | `v > v ^ < <` |
| Quasar Cannon | `v v ^ < >` |
| Railgun | `v > v ^ < >` |
| Commando | `v < v ^ >` |
| Sterilizer | `v < ^ v <` |
| StA-X3 W.A.S.P. Launcher | `v v ^ v >` |
| S-11 Speargun | `v > v < ^ >` |

### Special & Vehicles

| Stratagem | Sequence |
|---|---|
| Portable Hellbomb | `v > ^ ^ ^` |
| One True Flag | `v < > > ^` |
| Fast Recon Vehicle | `< v > v > v ^` |
| MS-11 Solo Silo | `v ^ > v v` |
| TD-220 Bastion MK XVI | `< v > v < v ^ v ^` |

---

## Troubleshooting

| Problem | Solution |
|---|---|
| **Hotkeys don't fire in-game** | The game window must be actively focused. Alt-tab back to the game. Confirm `helldivers2.exe` is the process name (check in Task Manager). |
| **HUD appears off-screen or clipped** | Press `Ctrl+Alt+D` to reload the script. It recalculates position based on your current monitor's work area. |
| **Loadout doesn't save** | Check that `Helldivers.ahk` is not in a write-protected folder (e.g. `C:\Program Files`). Move it to your Desktop or Documents. |
| **Controls look flat / unstyled** | AHK v2 uses Windows visual styles. If controls look like Windows XP, check your system theme settings or try running the `.ahk` file directly instead of a compiled `.exe`. |
| **Script crashes on start** | Confirm you have **AutoHotkey v2.0** installed, not v1.x. They are not compatible. Download v2 from autohotkey.com. |
| **Rapid fire fires too fast / too slow** | Timing is randomised (18–32 ms hold, 42–68 ms between shots). This is by design to avoid mechanical patterns. It cannot be tuned in the current version. |
| **Ctrl+# fires the wrong stratagem** | The HUD shows your current loadout. If a slot shows a wrong name, update it in the full HUD and click DEPLOY LOADOUT. |

---

## File Structure

```
HellDiversMacros/
├── Helldivers.ahk          ← main script (run this)
├── stratagem_loadout.ini   ← auto-created on first DEPLOY LOADOUT
└── README.md               ← this file
```

---

## Roadmap

### v5.x — Near Term

| # | Feature | Description |
|---|---|---|
| 1 | **Abort indicator** | If Ctrl is released mid-cast, flash `ABORTED` briefly in the HUD instead of failing silently |
| 2 | **Multi-loadout profiles** | Save and hot-swap named presets (A / B / C) — files stored as `loadout_A.ini`, `loadout_B.ini`, etc. A hotkey mid-mission instantly swaps your full build |
| 3 | **Favorites filter** | Checkbox or toggle to hide stratagems you never use, trimming the 79-item dropdown to only what's relevant to your playstyle |

### v6.x — Mid Term

| # | Feature | Description |
|---|---|---|
| 4 | **Stratagem cooldown timers** | Track time elapsed since each slot was cast; display a per-slot countdown or elapsed time bar in the HUD. Accounts for per-stratagem cooldown differences. |
| 5 | **Keybind remapper** | In-GUI input field to change the hotkey modifier from Ctrl to another key — useful for non-QWERTY keyboard layouts or ergonomic setups |
| 6 | **Quick-cast preview** | While holding Ctrl+# (before the sequence fires), highlight that slot's arrow sequence in the HUD so you can confirm you have the right slot before committing |
| 7 | **Stratagems used counter** | Session tally of how many times each slot has been fired, shown as a small number beside the slot label in the HUD |

### v7.x — Long Term / Stretch Goals

| # | Feature | Description |
|---|---|---|
| 8 | **Mission timer** | A clock showing elapsed time since a user-set "mission start" keypress, displayed in the status bar |
| 9 | **Auto-hide during casting** | Automatically switch to compact mode while a stratagem is mid-cast, then restore the previous mode after the sequence completes |
| 10 | **Sound cues** | Optional short audio beep on successful stratagem fire and on cast abort — no extra audio files needed (Windows `Beep` API) |
| 11 | **GUI theme selector** | Toggle between the current gold/dark theme and alternate themes: green "night vision", blue "democratic", or red "automaton" |
| 12 | **Loadout share codes** | Export your loadout as a short alphanumeric code that teammates can paste in to import your exact build instantly |

---

## Technical Notes

- **Anti-cheat safe:** The script uses standard `SendInput` / `SendEvent` with human-plausible timing. No memory reading, no DLL injection, no screen capture.
- **Key timing:** Each direction key is held for 42–50 ms with 35–65 ms of randomised delay between keys — closely matching natural human input variance.
- **Rapid fire timing:** 18–32 ms hold + 42–68 ms between shots, re-randomised every shot to avoid mechanical firing signatures.
- **Window positioning:** Uses `MonitorGetWorkArea` (excludes taskbar) for accurate placement on any DPI/resolution configuration.
- **Compact click-through:** Achieved via `WS_EX_LAYERED + WS_EX_TRANSPARENT` extended window styles — mouse events pass directly through to the game.

---

*FOR SUPER-EARTH!*
