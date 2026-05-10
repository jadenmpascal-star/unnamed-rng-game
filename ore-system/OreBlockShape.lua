--!strict
-- OreBlockShape
-- Builds the mineable ore part itself. Place in ReplicatedStorage.

local OreBlockShape = {}

local function makeCube(): BasePart
	local p = Instance.new("Part")
	p.Shape = Enum.PartType.Block
	p.Size = Vector3.new(4, 4, 4)
	return p
end

local function makeOctahedron(): BasePart
	local p = Instance.new("Part")
	p.Shape = Enum.PartType.Ball
	p.Size = Vector3.new(4, 4, 4)
	local mesh = Instance.new("SpecialMesh")
	mesh.MeshType = Enum.MeshType.Sphere
	mesh.Scale = Vector3.new(1, 1.4, 1)
	mesh.Parent = p
	return p
end

OreBlockShape.Builders = {
	Cube = makeCube,
	Octahedron = makeOctahedron,
}

function OreBlockShape.Build(shapeName: string): BasePart
	local builder = OreBlockShape.Builders[shapeName] or makeCube
	local part = builder()
	part.Anchored = true
	part.CanCollide = true
	part.CastShadow = false
	return part
end

return OreBlockShape
