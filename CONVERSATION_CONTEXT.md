# Full Conversation Context — Save This

## Game Overview
- Roblox RNG mining game inspired by Sol's RNG, REx Reincarnated, Go Mining, Hades RNG
- Name: Unnamed RNG Game (placeholder)
- Theme: Bossa nova music, earthy green/brown retro vibes

## UI Design Decisions
- Style: Retro LEGO studded texture on ALL panels
- Colors: Dark earthy brown bg (#1E1508), gold borders (#F1C539), green accents (#43BB5C), cream text (#EFE5CC)
- Font: Retro pixel/chunky (Arcade in Roblox)
- Sounds: Wooden thud clicks, whoosh panel open/close, bossa nova background
- Loading screen: Cozy retro, green theme, actual map screenshot background, player avatar with idle animation, progress bar, PLAY button
- All panels get stud texture overlay using rbxassetid://278837339

## What's Been Done
1. Mining system: 10 layers, 0-10000m depth, explosion ability, return button
2. Ore decorations: Common/Uncommon = plain blocks (no decoration), Rare+ = unique shapes per ore
3. Loading screen: Moved to ReplicatedFirst, PLAY button should work now
4. NPC dialogue: Rewritten with parchment style, Dave viewport facing straight (PivotTo fix)
5. Color palette in RNGClient: Updated from all-grey to actual gold/green/blue colors
6. ROLL button: Upgraded with gradient + larger text
7. Ocean/fishing system: DELETED per user request
8. Gauntlet fit: Offsets fixed, rotation zeroed
9. Admin panel: Fixed rare ore spawn buttons (was using nil global)
10. FallenPartsDestroyHeight: Set to -15000 in workspace properties (manual)

## What Still Needs To Be Done
1. UI REWORK — all panels need earthy brown + gold + stud texture applied
2. Ore shapes — Rare+ ores need truly unique 3D shapes (not just colored blocks)
3. Ore effects — Reference images: atomic energy rings, orbital beams, glowing cores
4. Loading screen — Needs actual map screenshot, better animations, bossa nova music
5. NPC dialogue — Dave still facing sideways in viewport
6. Index — Shows weird parts, needs proper aura preview
7. Sound effects — Most sounds failing with 'not authorized' errors
8. Settings UI — Needs rework
9. Inventory UI — Needs rework
10. Admin panel UI — Needs rework

## Key Scripts
- RNGClient (StarterPlayerScripts) — main UI, roll buttons, inventory, settings, index, admin
- CozyNPCDialogueClient (StarterPlayerScripts) — NPC dialogue
- LoadingScreenLoader (ReplicatedFirst) — loading screen
- InfiniteMiningClient (StarterPlayerScripts) — mining HUD
- MiningAreaCaveSystem (ServerScriptService) — mining server
- RetroUIClient (StarterPlayerScripts) — UI theme/skin
- CozyUISkinClient (StarterPlayerScripts) — stud texture applicator

## Figma File
https://www.figma.com/design/2thf67I1YzdA0XA1zyFDL0/
Contains: Loading Screen, Roll HUD, NPC Dialogue designs (rate limited, resets daily)

## GitHub Repo
https://github.com/jadenmpascal-star/unnamed-rng-game

## Ore Reference Images
- Golden atomic energy field (orbiting rings, cross beams, glowing core)
- Multicolor atomic (rainbow beams, orbiting particles)
- Lighthouse with volumetric god-ray lighting
- These are the target quality for Mythic/Secret ores

## User Preferences
- Hates AI-looking UI
- Wants studded retro textures on everything
- Wants unique ore shapes (circles, diamonds, not just recolored blocks)
- Wants bossa nova music everywhere
- Wants sound effects on EVERY interaction
- Wants the map to show in loading screen (not abstract shapes)
- Wants Dave facing STRAIGHT in NPC viewport
- Color scheme: earthy brown + gold + green (NOT purple)
- Font: retro pixel chunky (Arcade)
