# Enemy Cooldowns — Enhanced Edition

**Author:** Nidhaus  
**Game:** World of Warcraft 3.3.5a (WotLK)  
**Server:** Warmane Blackrock  

---

## About

PvP addon that tracks enemy cooldowns in real time. Built on top of the original **Enemy Cooldowns** addon — almost entirely rewritten: bugs fixed, core rewritten, and a full configuration menu added that the original never had.

<img width="600" height="407" alt="Image" src="https://github.com/user-attachments/assets/2956d5a7-27d3-46d1-af0a-a687d941db3b" />
<img width="1320" height="862" alt="Image" src="https://github.com/user-attachments/assets/bbfc9c27-be7d-4c01-b157-f40f947ac611" />

---

## Features

- Tracks cooldowns for every class (racials, trinkets, defensives, interrupts, CC, mobility)
- Handles cooldown resets (Preparation, Cold Snap, Metamorphosis)
- In-game configuration menu (`/ecd`) with blue theme and NUF-style sliders
- Configurable layout: icons per column, X/Y spacing, group gap, global scale
- Configurable fonts for player names and timers (with outline and size)
- Color by remaining time (>10s, ≤10s, ≤3s) with color picker
- Sort order: by cast time, remaining ascending/descending
- Enable/disable per zone: Arena, Battleground, World
- Cooldown swipe overlay toggle
- Reset All button restores defaults without /reload
- Localization: English by default, Spanish included (auto-detected)
- Automatic memory cleanup of stale GUIDs

---

## Commands

| Command | Description |
|---------|-------------|
| `/ecd` | Open configuration |
| `/ecd lock` | Lock frame position |
| `/ecd unlock` | Unlock and show drag handle |
| `/ecd reset` | Reset position |
| `/ecd resetall` | Reset ALL settings to defaults |

---

## Installation

Copy the `EnemyCooldowns` folder into `Interface/AddOns/` and restart the game.
change name to EnemyCooldowns to
---

## Credits

- **Base:** Enemy Cooldowns (original author unknown)
- **Enhanced edition:** Nidhaus
