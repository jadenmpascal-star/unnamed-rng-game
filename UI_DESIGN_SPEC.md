# Unnamed RNG Game — UI Design Specification

## Design Language
- **Style:** Retro LEGO studded, earthy brown panels, gold + green accents
- **Font:** Inter Bold for titles, Inter Regular for body text
- **Stud texture:** Real 3D studs (base ellipse + highlight + dark center) tiled at 15px spacing
- **Panels:** Dark brown bg, gold border stroke, inner gradient, top/bottom bevel lines, drop shadow

## Color Palette
```
bg:       #1E1508  (very dark brown)
panel:    #292011  (dark brown panel)
panelMid: #342718  (mid panel)
panelLt:  #413220  (lighter panel)
gold:     #F1C539  (warm gold — borders, ROLL button)
goldDark: #9C7418  (dark gold)
green:    #43BB5C  (primary action — PLAY, equipped)
greenDk:  #1B662C  (dark green)
cream:    #EFE5CC  (warm white text)
dimCream: #98886B  (muted text)
red:      #CC382E
blue:     #3894F5
purple:   #9938F5
```

## Panels Designed in Figma

### 1. Loading Screen (1920×1080)
- Dark earthy background with gradient
- MAP SCREENSHOT placeholder (replace with actual Roblox map screenshot)
- Dark overlay gradient so bottom UI is readable over map
- Pixel hill silhouettes at bottom
- Title: UNNAMED (cream) + RNG GAME (gold), Inter Bold 92px, with shadow offset
- Green underline accent with fade gradient
- Tip box: dark panel, gold border, rotating tips
- Progress bar: dark bg, gold border, green fill with gradient + glow
- PLAY button: dark green, gold border 3px, gold glow shadow, stud texture, 450×82px
- Avatar box: shows player avatar with idle animation, gold border

### 2. Roll Bar HUD (1920×165)
- Full-width dark panel at bottom of screen
- Gold top accent line
- LEFT: Coins display (gold) + Luck display (green), both with stud texture
- CENTER TOP: Aura ticker (scrolling text)
- CENTER: AUTO button (dim) | ROLL button (HUGE, green+gold, 200×148px) | QUICK button (dim)
- RIGHT: 7 sidebar tab buttons (ADMIN/ART/COMP/INDX/INV/QUEST/SET), each with unique rarity color

### 3. Inventory Panel (620×730)
- Dark panel, gold border
- AURAS / POTIONS tabs
- 4×3 aura grid, each slot: dark bg, rarity-colored border, stud texture, aura name + qty
- EQUIPPED badge (gold) on equipped slots
- Rarity colors: Common=dim, Uncommon=green, Rare=blue, Epic=purple, Legendary=gold

### 4. NPC Dialogue Card (820×195)
- Parchment/warm cream background, very rounded corners (80px)
- LEFT: Portrait frame (pops up above card, shows NPC model facing STRAIGHT)
- NPC name in dark brown, underline bar
- Dialogue text + 'Click to skip'
- RIGHT buttons: [Open] green | Who are you? dark | [Leave] red

### 5. Settings Panel (580×540)
- Dark panel, gold border, stud texture
- SETTINGS title in gold
- Tab row: Rolling | Notifs | Sound | Boss | Misc
- 6 setting rows: dark bg, stud texture, label + value + checkbox
- Enabled=green, Disabled=red

### 6. Mining HUD (280×165)
- Dark panel, orange accent border
- EXPLOSION button: dark orange, orange glow, stud texture, 260×76px
- Ready! / cooldown text below

### 7. Return Button (220×60)
- Blue panel, blue border
- '⬆ Return to Surface' text

### 8. Aura Index (640×760)
- Dark panel, gold border
- LEFT sidebar: rarity list (Locked, Common, Uncommon...)
- RIGHT: Viewport with corner bracket decorations + Info card below
- Info card: aura name, odds, type, amplify conditions, creator credit, Replay Cutscene button

## Stud Implementation in Roblox
In Roblox UI, studs are implemented as:
```lua
local studs = Instance.new('ImageLabel', parent)
studs.Image = 'rbxassetid://278837339'
studs.ImageTransparency = 0.82
studs.ScaleType = Enum.ScaleType.Tile
studs.TileSize = UDim2.fromOffset(20, 20)
studs.Size = UDim2.fromScale(1, 1)
studs.BackgroundTransparency = 1
studs.ZIndex = parent.ZIndex + 1
```

## Sound Effects Plan
- Button click: wooden thud sound
- Panel open: whoosh + creak
- Panel close: soft thud  
- ROLL: existing cutscene sounds
- PLAY button: satisfying ding
- Background: bossa nova loop
