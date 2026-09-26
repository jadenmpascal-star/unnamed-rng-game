# Please Don't Fight — Handoff Notes

Roblox boss-fight game. Studio places:
- **Please Don't Fight** — the actual game
- **Untitled Experience** — user's VFX workbench (folders "Jenna and Movews", "Guest 666 and moves")

## Done in the previous Claude chat (playtested, 21 scripts, 0 errors, NOT published)

### User VFX wired in
- Jenna: Life Drain circle, heartstring beam, Heart Seeker homing hearts, heart aura
- Guest 666: Gravity Well black hole, rune halo, Void Mark
- Lost Connection: user's VFX skipped (looked bad) → new red-static teleport effect
- Auras on every boss (c00lkidd + Telamon use user's, 4 new ones made)

### Ultimates (trigger at 70% / 35% HP + every 55s; cinematic intro with bars, title slam, camera sweep, tint, shake, dodge hint)
| Boss | Ultimate |
|---|---|
| Builderman | Ban Hammer — brick-built giant hammer slams a lane |
| 1x1x1x1 | System Purge — glitch blade sweeps arena twice (jump it) |
| tubers93 | Takeover Nuke — nuke + 3 shockwave rings to jump |
| John Doe | Forgotten Crossfire — dark arena, 6 shadow clones dash |
| c00lkidd | C00L Inferno — chasing fire tornadoes + fireball rain |
| Jenna | Heartbreak — giant heart shatters into homing hearts |
| Guest 666 | Event Horizon — 7x black hole pulls everyone, collapses |
| Telamon | Illumina Judgement — golden sword plunge + 8 light lanes |

Every boss got a 4th move (Glitch Step, Exploit Fling, Love Bomb, Blade Cyclone, …), listed in Boss Journal.
Owner command: `/ult` triggers current boss's ultimate.

### Modifiers
- 12 new: TNT Rain, Black Hole Storm, Bounce House, Tornado Alley, Magnet Mayhem, Arms Race, Tiny Trouble, Big Head Mode, Sugar Rush, Spring Shoes, Vampire Bites, Glass Cannon
- Roll chance 35% with at least one plain round between (was 22% every 3rd round)
- Meteor Shower + Static Panic impacts bigger; live badge shows colour + icon

### Accessories
- All 23 have unique powers (grapple hook, headbutt, pumpkin bomb, orbiting swords, pocket black hole, instant fort, time warp, exploding decoy, …)
- 10 new official classic hats (Traffic Cone, Bighead, Pirate Hat, …) — achievement rewards, auto-granted retroactively
- Locker shows power/colour/cooldown; power button fills while recharging, pulses when ready

### Achievements
- Big "Achievement Unlocked" card + sound + confetti, server-wide announcement
- Locker tab renamed "Achievements"; 4 new achievements (incl. "survive a boss ultimate")

### Other
- Removed song rbxassetid://9038879217
- Vote covers fixed (Red vs Blue drop kick, Juggernaut sword clipping, removed 1x1x1x1 slab / floating bounty bar / stray lines)
- No new bosses added yet (wanted multiplayer balance testing first)

## NEXT REQUEST (in progress when chat ended)
1. Use **real models**: Telamon's Illumina ultimate → actual Illumina model; Builderman's hammer → real Roblox hammer tool model
2. Jenna's Heart Seekers → use the **bee model** the user added (replace glowing pink balls)
3. Upgrade VFX of the **original/older attacks** (ones that existed before Claude's work) to "insane" level; slightly improve regular attack VFX
4. Make **ultimates devastating**: cover the whole map, much higher damage

Previous chat had just started step: locating the Illumina model, a real Roblox hammer, and the bee model.

## User preferences
- Wants stunning VFX, real models over primitives, chaotic fun, interactivity
- Wants everything improved; welcomes more bosses/modifiers/accessories
- Publishing is the user's call — never publish
