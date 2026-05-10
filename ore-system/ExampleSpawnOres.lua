--!strict
-- ExampleSpawnOres
-- Drop in ServerScriptService to test. Spawns the full tier progression.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local OreVisualConfig = require(ReplicatedStorage:WaitForChild("OreVisualConfig"))
local OreEffectBuilder = require(ReplicatedStorage:WaitForChild("OreEffectBuilder"))
local OreBlockShape = require(ReplicatedStorage:WaitForChild("OreBlockShape"))

local function spawnOre(tierName: string, position: Vector3)
	local cfg = OreVisualConfig.Get(tierName)
	local block = OreBlockShape.Build(cfg.blockShape)
	block.Name = tierName .. "Ore"
	block.Position = position
	block.Parent = Workspace
	OreEffectBuilder.Build(block, tierName)
	return block
end

spawnOre("Mythic", Vector3.new(0, 10, 0))
spawnOre("Secret", Vector3.new(20, 10, 0))

local tiers = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret"}
for i, tier in tiers do
	spawnOre(tier, Vector3.new(-40 + i * 10, 25, -20))
end
