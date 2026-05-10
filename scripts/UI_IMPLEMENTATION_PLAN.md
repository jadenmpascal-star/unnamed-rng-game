# UI Implementation Plan — Convert Figma to Roblox

## Order of Implementation
1. RNGClient.lua — Roll bar HUD (ROLL/AUTO/QUICK buttons + sidebar)
2. RetroUIClient.lua — Inventory, Settings, Index panels
3. CozyNPCDialogueClient.lua — NPC dialogue card
4. ReplicatedFirst/LoadingScreenLoader.lua — Loading screen
5. InfiniteMiningClient.lua — Mining HUD buttons

## Key Changes Per Script

### RNGClient
- Color palette: replace all grey with earthy brown + gold + green
- ROLL button: 200×148px, gold border, stud texture
- AUTO/QUICK: smaller, dimmer, stud texture
- Sidebar: rarity-colored borders per tab
- Add UIStroke gold to main HUD frame

### RetroUIClient  
- Inventory slots: dark brown bg, rarity-colored UIStroke, stud overlay
- Settings rows: dark bg, enabled=green stroke, disabled=red stroke
- All panels: UIGradient dark, UIStroke gold

### CozyNPCDialogueClient
- Card: warm cream/parchment, cornerRadius=80
- Portrait: pivotTo(0,0,0) before camera — fixes Dave facing sideways
- Camera Z distance: h*1.6 (closer), facing straight
- Buttons: Open=green, Leave=red, Who=dark

### LoadingScreenLoader (ReplicatedFirst)
- Remove old CavernLoadingScreen entirely
- Map screenshot: large ImageLabel placeholder
- Progress bar fills as ContentProvider:PreloadAsync runs
- Avatar: CreateHumanoidModelFromDescription, camera at h*1.6
- PLAY button: appears via bounce tween after loading completes
- Sounds: ambient bossa nova + ding on ready
