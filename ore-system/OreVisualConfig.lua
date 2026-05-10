--!strict
-- OreVisualConfig
-- Place in ReplicatedStorage so both client and server can read it.
-- Adding a new tier = one new entry. No code changes needed elsewhere.

local OreVisualConfig = {}

OreVisualConfig.Tiers = {
	Common = {
		blockShape = "Cube",
		blockColor = Color3.fromRGB(140, 140, 140),
		material = Enum.Material.Slate,
		lightBrightness = 0,
		hasParticles = false,
		hasBeam = false,
		ringCount = 0,
		hasSatellites = false,
		floats = false,
	},

	Uncommon = {
		blockShape = "Cube",
		blockColor = Color3.fromRGB(120, 180, 110),
		material = Enum.Material.Slate,
		lightBrightness = 0.5,
		lightColor = Color3.fromRGB(120, 200, 120),
		hasParticles = false,
		hasBeam = false,
		ringCount = 0,
		hasSatellites = false,
		floats = false,
	},

	Rare = {
		blockShape = "Octahedron",
		blockColor = Color3.fromRGB(80, 140, 220),
		material = Enum.Material.Glass,
		lightBrightness = 1.5,
		lightColor = Color3.fromRGB(120, 180, 255),
		hasParticles = true,
		particleColor = ColorSequence.new(Color3.fromRGB(180, 220, 255)),
		hasBeam = false,
		ringCount = 0,
		hasSatellites = false,
		floats = false,
	},

	Epic = {
		blockShape = "Octahedron",
		blockColor = Color3.fromRGB(160, 80, 220),
		material = Enum.Material.Neon,
		lightBrightness = 2.5,
		lightColor = Color3.fromRGB(200, 120, 255),
		hasParticles = true,
		particleColor = ColorSequence.new(Color3.fromRGB(220, 160, 255)),
		hasBeam = true,
		beamThickness = 0.4,
		beamColor = Color3.fromRGB(220, 160, 255),
		ringCount = 0,
		hasSatellites = false,
		floats = false,
	},

	Legendary = {
		blockShape = "Octahedron",
		blockColor = Color3.fromRGB(255, 140, 60),
		material = Enum.Material.Neon,
		lightBrightness = 4,
		lightColor = Color3.fromRGB(255, 180, 80),
		hasParticles = true,
		particleColor = ColorSequence.new(Color3.fromRGB(255, 200, 100)),
		hasBeam = true,
		beamThickness = 0.6,
		beamColor = Color3.fromRGB(255, 180, 80),
		ringCount = 1,
		ringColor = Color3.fromRGB(255, 200, 100),
		hasSatellites = false,
		floats = true,
		floatAmplitude = 0.3,
		floatPeriod = 2,
	},

	-- ===== MYTHIC: matches Image 1 (golden atomic) =====
	Mythic = {
		blockShape = "Octahedron",
		blockColor = Color3.fromRGB(241, 197, 57),
		material = Enum.Material.Neon,
		lightBrightness = 6,
		lightColor = Color3.fromRGB(255, 215, 100),
		hasSpotlights = true,
		hasParticles = true,
		particleColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 230, 150)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(241, 197, 57)),
		}),
		hasBeam = true,
		beamThickness = 0.8,
		beamColor = Color3.fromRGB(255, 215, 100),
		hasCrossBeam = true,
		ringCount = 3,
		ringColor = Color3.fromRGB(255, 215, 100),
		ringTilts = {
			{axis = Vector3.new(0, 1, 0), speed = 1.0},
			{axis = Vector3.new(1, 0, 0), speed = 0.7},
			{axis = Vector3.new(0, 0, 1), speed = 1.3},
		},
		hasSatellites = false,
		floats = true,
		floatAmplitude = 0.3,
		floatPeriod = 2.5,
		soundId = "rbxassetid://9112854440",
	},

	-- ===== SECRET: matches Image 2 (multicolor atomic) =====
	Secret = {
		blockShape = "Octahedron",
		blockColor = Color3.fromRGB(20, 20, 35),
		material = Enum.Material.Neon,
		lightBrightness = 5,
		lightColor = Color3.fromRGB(255, 255, 255),
		lightCycleColors = true,
		hasSpotlights = true,
		hasParticles = true,
		particleColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 80, 80)),
			ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 220, 80)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 255, 120)),
			ColorSequenceKeypoint.new(0.75, Color3.fromRGB(80, 220, 255)),
			ColorSequenceKeypoint.new(1.0, Color3.fromRGB(220, 80, 255)),
		}),
		particleScatter = true,
		hasBeam = true,
		beamThickness = 0.6,
		beamRainbow = true,
		hasCrossBeam = true,
		ringCount = 1,
		ringColor = Color3.fromRGB(255, 255, 255),
		ringTilts = {
			{axis = Vector3.new(0, 1, 0), speed = 0.8},
		},
		hasSatellites = true,
		satelliteCount = 5,
		satelliteColors = {
			Color3.fromRGB(255, 80, 80),
			Color3.fromRGB(80, 255, 120),
			Color3.fromRGB(255, 220, 80),
			Color3.fromRGB(80, 220, 255),
			Color3.fromRGB(220, 80, 255),
		},
		satelliteOrbitRadius = 4,
		satelliteOrbitSpeed = 1.2,
		floats = true,
		floatAmplitude = 0.4,
		floatPeriod = 3,
		soundId = "rbxassetid://9112854440",
	},
}

function OreVisualConfig.Get(tierName: string)
	return OreVisualConfig.Tiers[tierName] or OreVisualConfig.Tiers.Common
end

return OreVisualConfig
