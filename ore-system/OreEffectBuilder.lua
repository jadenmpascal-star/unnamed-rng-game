--!strict
-- OreEffectBuilder
-- Place in ReplicatedStorage. Call OreEffectBuilder.Build(orePart, tierName)
-- and it attaches all the rings, beams, particles, satellites, etc.
-- Call OreEffectBuilder.Destroy(orePart) to clean up.

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local OreVisualConfig = require(ReplicatedStorage:WaitForChild("OreVisualConfig"))

local OreEffectBuilder = {}

local activeEffects: {[BasePart]: {connections: {RBXScriptConnection}, parts: {Instance}}} = {}

-- HELPERS ----------------------------------------------------

local function makeAttachment(parent: BasePart, name: string, offset: Vector3?): Attachment
	local a = Instance.new("Attachment")
	a.Name = name
	a.Position = offset or Vector3.zero
	a.Parent = parent
	return a
end

local function makeBeam(a0: Attachment, a1: Attachment, color: Color3, thickness: number): Beam
	local b = Instance.new("Beam")
	b.Attachment0 = a0
	b.Attachment1 = a1
	b.Color = ColorSequence.new(color)
	b.Width0 = thickness
	b.Width1 = thickness * 0.3
	b.LightEmission = 1
	b.LightInfluence = 0
	b.FaceCamera = true
	b.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.2),
		NumberSequenceKeypoint.new(0.5, 0),
		NumberSequenceKeypoint.new(1, 0.2),
	})
	b.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	b.TextureMode = Enum.TextureMode.Stretch
	b.TextureLength = 4
	b.TextureSpeed = 2
	return b
end

local function buildRing(parent: BasePart, radius: number, color: Color3, segmentCount: number): Model
	local ring = Instance.new("Model")
	ring.Name = "OrbitRing"
	for i = 1, segmentCount do
		local angle = (i / segmentCount) * math.pi * 2
		local nextAngle = ((i + 1) / segmentCount) * math.pi * 2
		local p1 = Vector3.new(math.cos(angle), 0, math.sin(angle)) * radius
		local p2 = Vector3.new(math.cos(nextAngle), 0, math.sin(nextAngle)) * radius
		local mid = (p1 + p2) / 2
		local len = (p2 - p1).Magnitude

		local seg = Instance.new("Part")
		seg.Size = Vector3.new(len * 1.05, 0.15, 0.15)
		seg.Material = Enum.Material.Neon
		seg.Color = color
		seg.Anchored = true
		seg.CanCollide = false
		seg.CastShadow = false
		seg.CFrame = CFrame.new(parent.Position + mid, parent.Position + p2)
		seg.Parent = ring
	end
	ring.Parent = parent
	return ring
end

-- COMPONENT BUILDERS -----------------------------------------

local function addLight(orePart: BasePart, cfg, parts: {Instance})
	if cfg.lightBrightness <= 0 then return end
	local light = Instance.new("PointLight")
	light.Brightness = cfg.lightBrightness
	light.Color = cfg.lightColor or Color3.new(1, 1, 1)
	light.Range = 20
	light.Parent = orePart
	table.insert(parts, light)

	if cfg.hasSpotlights then
		for _, dir in {Vector3.new(0, 1, 0), Vector3.new(0, -1, 0)} do
			local spot = Instance.new("SpotLight")
			spot.Brightness = cfg.lightBrightness * 0.7
			spot.Color = cfg.lightColor
			spot.Range = 30
			spot.Angle = 30
			spot.Face = (dir.Y > 0) and Enum.NormalId.Top or Enum.NormalId.Bottom
			spot.Parent = orePart
			table.insert(parts, spot)
		end
	end
end

local function addParticles(orePart: BasePart, cfg, parts: {Instance})
	if not cfg.hasParticles then return end
	local emitter = Instance.new("ParticleEmitter")
	emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	emitter.Color = cfg.particleColor
	emitter.LightEmission = 1
	emitter.LightInfluence = 0

	if cfg.particleScatter then
		emitter.Rate = 80
		emitter.Lifetime = NumberRange.new(1.5, 3)
		emitter.Speed = NumberRange.new(2, 5)
		emitter.SpreadAngle = Vector2.new(180, 180)
		emitter.Size = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.3, 0.4),
			NumberSequenceKeypoint.new(1, 0),
		})
	else
		emitter.Rate = 50
		emitter.Lifetime = NumberRange.new(1, 2)
		emitter.Speed = NumberRange.new(3, 6)
		emitter.SpreadAngle = Vector2.new(15, 15)
		emitter.EmissionDirection = Enum.NormalId.Top
		emitter.Size = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.5),
			NumberSequenceKeypoint.new(1, 0),
		})
	end

	emitter.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.2, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
	emitter.Parent = orePart
	table.insert(parts, emitter)
end

local function addBeams(orePart: BasePart, cfg, parts: {Instance})
	if not cfg.hasBeam then return end

	local topAtt = makeAttachment(orePart, "BeamTop", Vector3.new(0, 8, 0))
	local botAtt = makeAttachment(orePart, "BeamBot", Vector3.new(0, -8, 0))
	local centerAtt = makeAttachment(orePart, "BeamCenter", Vector3.zero)
	table.insert(parts, topAtt); table.insert(parts, botAtt); table.insert(parts, centerAtt)

	local color = cfg.beamColor or Color3.new(1, 1, 1)
	local thickness = cfg.beamThickness or 0.5

	local beamUp = makeBeam(centerAtt, topAtt, color, thickness)
	beamUp.Parent = orePart
	table.insert(parts, beamUp)

	local beamDown = makeBeam(centerAtt, botAtt, color, thickness)
	beamDown.Parent = orePart
	table.insert(parts, beamDown)

	if cfg.hasCrossBeam then
		local leftAtt = makeAttachment(orePart, "BeamLeft", Vector3.new(-6, 0, 0))
		local rightAtt = makeAttachment(orePart, "BeamRight", Vector3.new(6, 0, 0))
		table.insert(parts, leftAtt); table.insert(parts, rightAtt)

		local beamLeft = makeBeam(centerAtt, leftAtt, color, thickness * 0.7)
		beamLeft.Parent = orePart
		table.insert(parts, beamLeft)

		local beamRight = makeBeam(centerAtt, rightAtt, color, thickness * 0.7)
		beamRight.Parent = orePart
		table.insert(parts, beamRight)
	end
end

local function addRings(orePart: BasePart, cfg, parts: {Instance}, connections: {RBXScriptConnection})
	if cfg.ringCount <= 0 then return end

	local rings = {}
	for i = 1, cfg.ringCount do
		local tilt = cfg.ringTilts and cfg.ringTilts[i] or {axis = Vector3.new(0, 1, 0), speed = 1}
		local ring = buildRing(orePart, 5, cfg.ringColor or Color3.new(1, 1, 1), 24)
		ring.Name = "Ring_" .. i
		table.insert(parts, ring)
		table.insert(rings, {model = ring, axis = tilt.axis, speed = tilt.speed})
	end

	local startTime = os.clock()
	local conn = RunService.Heartbeat:Connect(function()
		local t = os.clock() - startTime
		for _, ringData in rings do
			local angle = t * ringData.speed
			local rotation = CFrame.fromAxisAngle(ringData.axis, angle)
			ringData.model:PivotTo(orePart.CFrame * rotation)
		end
	end)
	table.insert(connections, conn)
end

local function addSatellites(orePart: BasePart, cfg, parts: {Instance}, connections: {RBXScriptConnection})
	if not cfg.hasSatellites then return end

	local satellites = {}
	local count = cfg.satelliteCount or 5
	for i = 1, count do
		local sat = Instance.new("Part")
		sat.Shape = Enum.PartType.Ball
		sat.Size = Vector3.new(0.6, 0.6, 0.6)
		sat.Material = Enum.Material.Neon
		sat.Color = cfg.satelliteColors[i] or Color3.new(1, 1, 1)
		sat.Anchored = true
		sat.CanCollide = false
		sat.CastShadow = false
		sat.Parent = orePart.Parent
		table.insert(parts, sat)

		local light = Instance.new("PointLight")
		light.Color = sat.Color
		light.Brightness = 2
		light.Range = 6
		light.Parent = sat

		table.insert(satellites, {
			part = sat,
			phaseOffset = (i - 1) * (math.pi * 2 / count),
			color = sat.Color,
		})
	end

	local startTime = os.clock()
	local radius = cfg.satelliteOrbitRadius or 4
	local speed = cfg.satelliteOrbitSpeed or 1
	local conn = RunService.Heartbeat:Connect(function()
		local t = os.clock() - startTime
		for _, sat in satellites do
			local angle = t * speed + sat.phaseOffset
			local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
			sat.part.CFrame = CFrame.new(orePart.Position + offset)
		end
	end)
	table.insert(connections, conn)
end

local function addFloating(orePart: BasePart, cfg, connections: {RBXScriptConnection})
	if not cfg.floats then return end
	if not orePart.Anchored then orePart.Anchored = true end

	local basePos = orePart.Position
	local amplitude = cfg.floatAmplitude or 0.3
	local period = cfg.floatPeriod or 2
	local startTime = os.clock()

	local conn = RunService.Heartbeat:Connect(function()
		local t = os.clock() - startTime
		local yOffset = math.sin((t / period) * math.pi * 2) * amplitude
		local spinAngle = t * 0.5
		orePart.CFrame = CFrame.new(basePos + Vector3.new(0, yOffset, 0)) * CFrame.Angles(0, spinAngle, 0)
	end)
	table.insert(connections, conn)
end

local function addColorCycle(orePart: BasePart, cfg, parts: {Instance}, connections: {RBXScriptConnection})
	if not cfg.lightCycleColors and not cfg.beamRainbow then return end

	local light = orePart:FindFirstChildOfClass("PointLight")
	local beams = {}
	for _, child in orePart:GetChildren() do
		if child:IsA("Beam") then table.insert(beams, child) end
	end

	local rainbowColors = {
		Color3.fromRGB(255, 80, 80),
		Color3.fromRGB(255, 220, 80),
		Color3.fromRGB(80, 255, 120),
		Color3.fromRGB(80, 220, 255),
		Color3.fromRGB(220, 80, 255),
	}

	local startTime = os.clock()
	local conn = RunService.Heartbeat:Connect(function()
		local t = (os.clock() - startTime) * 0.5
		local idx = (t % #rainbowColors)
		local i1 = math.floor(idx) + 1
		local i2 = (i1 % #rainbowColors) + 1
		local frac = idx - math.floor(idx)
		local c1, c2 = rainbowColors[i1], rainbowColors[i2]
		local color = Color3.new(
			c1.R + (c2.R - c1.R) * frac,
			c1.G + (c2.G - c1.G) * frac,
			c1.B + (c2.B - c1.B) * frac
		)
		if light and cfg.lightCycleColors then light.Color = color end
		if cfg.beamRainbow then
			for _, b in beams do b.Color = ColorSequence.new(color) end
		end
	end)
	table.insert(connections, conn)
end

-- PUBLIC API -------------------------------------------------

function OreEffectBuilder.Build(orePart: BasePart, tierName: string)
	local cfg = OreVisualConfig.Get(tierName)
	if not cfg then return end

	orePart.Material = cfg.material or Enum.Material.Plastic
	orePart.Color = cfg.blockColor or Color3.new(1, 1, 1)

	local connections: {RBXScriptConnection} = {}
	local parts: {Instance} = {}

	addLight(orePart, cfg, parts)
	addParticles(orePart, cfg, parts)
	addBeams(orePart, cfg, parts)
	addRings(orePart, cfg, parts, connections)
	addSatellites(orePart, cfg, parts, connections)
	addFloating(orePart, cfg, connections)
	addColorCycle(orePart, cfg, parts, connections)

	activeEffects[orePart] = {connections = connections, parts = parts}
end

function OreEffectBuilder.Destroy(orePart: BasePart)
	local data = activeEffects[orePart]
	if not data then return end
	for _, conn in data.connections do conn:Disconnect() end
	for _, p in data.parts do
		if p and p.Parent then p:Destroy() end
	end
	activeEffects[orePart] = nil
end

return OreEffectBuilder
