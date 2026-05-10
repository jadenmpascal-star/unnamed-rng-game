# Ore Tier Visual Progression

The principle: **each tier adds one new visual layer on top of the previous tier's silhouette.** A player glancing at an ore should know its rarity in under one second by what's *attached* to it, not by reading text.

| Tier      | Block shape     | Light  | Particles    | Beams       | Rings   | Satellites | Sound      |
|-----------|-----------------|--------|--------------|-------------|---------|------------|------------|
| Common    | Plain cube      | —      | —            | —           | —       | —          | thud       |
| Uncommon  | Plain cube, tinted | dim PointLight | — | — | — | — | thud + chime |
| Rare      | Faceted gem (octahedron) | medium PointLight | sparkle dust | — | — | — | crystal ring |
| Epic      | Faceted gem + halo ring | bright PointLight | sparkle dust | thin vertical beam | — | — | resonant hum |
| Legendary | Floating gem (hovers, spins) | strong PointLight | particle column | full vertical beam | 1 orbital ring | — | bell toll |
| **Mythic**  | **Floating gem + cross beams** | **PointLight + SpotLight pair** | **dense particle column** | **full vertical cross (top + bottom spikes)** | **3 orbital rings** | **—** | **deep gong** |
| **Secret**  | **Floating gem + cross beams** | **rainbow PointLight cycle** | **starfield scatter** | **rainbow vertical cross** | **1 thin equatorial ring** | **5 colored orbiting orbs** | **layered ambient pad** |

## Color rules
- **Common → Legendary**: ore-specific solid color, gold accents allowed
- **Mythic**: pure gold spectrum (#F1C539 core, amber glow) — matches Image 1
- **Secret**: rainbow cycling (red→green→yellow→cyan→magenta), dark space-black backdrop — matches Image 2

## Motion rules
- Rings rotate at different speeds on different axes (Y: 1x, X: 0.7x, Z: 1.3x) — never synced, that looks fake
- Floating gems hover with sine ease (0.3 stud amplitude, 2-second period)
- Cross beam pulses opacity (not size) — size pulse looks cheap
- Secret tier satellites orbit the equator ring at staggered phases (72° apart)

## Performance budget per ore
- Mythic: ~8 parts, 2 beams, 1 particle emitter, 2 lights
- Secret: ~12 parts, 3 beams, 2 particle emitters, 1 light (color-cycled)
- Both share a single ModuleScript so adding a new tier is one config block, not new code.
