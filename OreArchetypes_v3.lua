-- OreArchetypes v3 — COMPLETE REWORK
-- 25+ unique ore archetypes based directly on the 11 reference images
-- Every ore family has a unique SHAPE IDENTITY, not just color changes
local M = {}

local function att(parent, x, y, z, ox, oy, oz)
	local a = Instance.new("Attachment")
	a.Position = Vector3.new(x or 0, y or 0, z or 0)
	if ox then a.Orientation = Vector3.new(ox, oy or 0, oz or 0) end
	a.Parent = parent; return a
end
local function pe(parent, props)
	local p = Instance.new("ParticleEmitter")
	for k,v in pairs(props) do pcall(function() p[k]=v end) end
	p.Parent = parent; return p
end
local function light(parent, color, brightness, range)
	local l = Instance.new("PointLight")
	l.Color=color; l.Brightness=brightness or 2; l.Range=range or 20
	l.Shadows=false; l.Parent=parent; return l
end
local function snd(parent, id, vol, pitch)
	local s = Instance.new("Sound")
	s.SoundId=id; s.Volume=vol or 0.4; s.PlaybackSpeed=pitch or 1
	s.Looped=true; s.RollOffMaxDistance=60
	s.Parent=parent; s:Play(); return s
end
local function beam(a0, a1, parent, color, w0, w1, curve, trans)
	local b = Instance.new("Beam")
	b.Attachment0=a0; b.Attachment1=a1
	b.Color=ColorSequence.new(color or Color3.new(1,1,1))
	b.Width0=w0 or 0.5; b.Width1=w1 or 0.2
	b.CurveSize0=curve or 0; b.CurveSize1=curve and -curve or 0
	b.LightEmission=1; b.LightInfluence=0; b.FaceCamera=true
	b.Texture="rbxassetid://6091329339"
	b.Transparency=NumberSequence.new(trans or 0.25)
	b.TextureSpeed=0.4; b.TextureLength=2; b.Parent=parent; return b
end
local function spin(part, speed)
	task.spawn(function()
		while part and part.Parent do
			part.Orientation = part.Orientation + Vector3.new(0, speed or 2, 0)
			task.wait()
		end
	end)
end
local function orbit(parent, color, radius, startAngle, speed, size)
	local orb = Instance.new("Part")
	orb.Size = Vector3.new(size or 1.2, size or 1.2, size or 1.2)
	orb.Shape = Enum.PartType.Ball; orb.Material = Enum.Material.Neon
	orb.Color = color; orb.Transparency = 0; orb.Anchored = true
	orb.CanCollide=false; orb.CanTouch=false; orb.CanQuery=false; orb.CastShadow=false
	orb.CFrame = parent.CFrame * CFrame.new(radius or 8, 0, 0)
	orb.Parent = parent
	light(orb, color, 2, 10)
	local r = radius or 8; local t = startAngle or 0; local sp = speed or 1.2
	task.spawn(function()
		while orb and orb.Parent do
			t = t + sp * 0.016
			orb.CFrame = parent.CFrame * CFrame.new(math.cos(t)*r, math.sin(t*0.7)*1.5, math.sin(t)*r)
			task.wait(0.016)
		end
	end)
end
local function crystal_arm(parent, color, angle, len, spread)
	local arm = Instance.new("Part")
	arm.Size = Vector3.new(0.35, 0.35, len or 8)
	arm.Material = Enum.Material.Neon; arm.Color = color
	arm.Transparency = 0.05; arm.Anchored = true
	arm.CanCollide=false; arm.CanTouch=false; arm.CanQuery=false; arm.CastShadow=false
	arm.CFrame = parent.CFrame * CFrame.new(math.cos(angle)*((len or 8)/2.5), 0, math.sin(angle)*((len or 8)/2.5))
		* CFrame.Angles(0, angle + math.pi/2, math.rad(spread or 12))
	arm.Parent = parent
	local w = Instance.new("WeldConstraint"); w.Part0=parent; w.Part1=arm; w.Parent=arm
	light(arm, color, 1.2, 8)
	return arm
end

local RANK = {
	Layer=0,Common=1,Uncommon=2,Rare=3,Master=4,Surreal=5,
	Epic=6,Legendary=7,Mythic=8,Secret=9,Exotic=10,
	Transcendent=11,Otherworldly=12,Unfathomable=13,
}

-- IMAGE 8: SPIDER CRYSTAL — Red fractured arms radiating outward
local function ORE_Spider(part, color)
	part.Material=Enum.Material.Neon; part.Shape=Enum.PartType.Ball
	part.Color=color; part.Transparency=0.15; part.Size=Vector3.new(4,4,4)
	for i=1,8 do crystal_arm(part, color, (i/8)*math.pi*2, 8+math.random()*3, 12+math.random()*18) end
	local vert=Instance.new("Part"); vert.Size=Vector3.new(0.3,7,0.3)
	vert.Material=Enum.Material.Neon; vert.Color=color:Lerp(Color3.new(1,1,1),0.2)
	vert.Transparency=0.1; vert.Anchored=true; vert.CanCollide=false; vert.CanTouch=false; vert.CanQuery=false
	vert.CFrame=part.CFrame; vert.Parent=part
	local w=Instance.new("WeldConstraint"); w.Part0=part; w.Part1=vert; w.Parent=vert
	spin(part, 0.7)
	pe(att(part,0,0,0),{Texture="rbxassetid://1084973996",Color=ColorSequence.new(color:Lerp(Color3.new(0,0,0),0.3)),Rate=5,Lifetime=NumberRange.new(3,5),Speed=NumberRange.new(2,4),SpreadAngle=Vector2.new(360,360),LightEmission=0.5,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,2),NumberSequenceKeypoint.new(0.5,12),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.4),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,0,0),{Texture="rbxassetid://6707322206",Color=ColorSequence.new(color),Rate=80,Lifetime=NumberRange.new(0.8,1.2),Speed=NumberRange.new(5,9),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.4)})
	light(part,color,5.5,34)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.3,0.65)
end

-- IMAGE 9: SNOW GLOBE — Frosted orb + ground disc + rising ice pillars
local function ORE_SnowGlobe(part, color)
	part.Material=Enum.Material.Glass; part.Shape=Enum.PartType.Ball
	part.Color=color; part.Transparency=0.2; part.Size=Vector3.new(7,7,7)
	for i=1,6 do crystal_arm(part, color:Lerp(Color3.new(1,1,1),0.3), (i/6)*math.pi*2, 5, 8) end
	pe(att(part,0,-9,0),{Texture="rbxassetid://1525327413",Color=ColorSequence.new(color),Rate=12,Lifetime=NumberRange.new(3,3),Speed=NumberRange.new(0,0),LightEmission=0.3,LightInfluence=1,Size=NumberSequence.new(40),Rotation=NumberRange.new(-360,360),RotSpeed=NumberRange.new(-10,10),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.01,0.88),NumberSequenceKeypoint.new(1,1)})})
	for _,xz in ipairs({{8,0},{-8,0},{0,8},{0,-8},{6,6},{-6,-6}}) do
		pe(att(part,xz[1],-10,xz[2]),{Texture="rbxassetid://7104844885",Color=ColorSequence.new(color),Rate=25,Lifetime=NumberRange.new(2,3),Speed=NumberRange.new(8,12),SpreadAngle=Vector2.new(4,4),LightEmission=1,Size=NumberSequence.new(0.4),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})})
	end
	pe(att(part,0,0,0),{Texture="rbxassetid://6119272027",Color=ColorSequence.new(color:Lerp(Color3.new(1,1,1),0.5)),Rate=35,Lifetime=NumberRange.new(2,3),Speed=NumberRange.new(1,3),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.5)})
	light(part,color,3.5,30)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.2,1.3)
end

-- IMAGE 10: VOID STAR — Dark body + teal cracks + bead orbiters
local function ORE_VoidStar(part, color)
	local teal = Color3.fromRGB(40,210,170)
	part.Material=Enum.Material.SmoothPlastic
	part.Color=Color3.fromRGB(8,8,12); part.Transparency=0; part.Size=Vector3.new(7,7,7)
	spin(part, 0.5)
	pe(att(part,0,0,0),{Texture="rbxassetid://13182899239",Color=ColorSequence.new(teal),Rate=250,Lifetime=NumberRange.new(0.25,0.25),Speed=NumberRange.new(18,28),SpreadAngle=Vector2.new(180,180),LightEmission=3,LightInfluence=1,Size=NumberSequence.new(2.5),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.3,0),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,0,0),{Texture="rbxassetid://1084973996",Color=ColorSequence.new(Color3.fromRGB(4,4,8)),Rate=4,Lifetime=NumberRange.new(4,6),Speed=NumberRange.new(0,0.5),SpreadAngle=Vector2.new(360,360),LightEmission=0,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,4),NumberSequenceKeypoint.new(0.5,14),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.3),NumberSequenceKeypoint.new(1,1)}),ZOffset=-4})
	for i=1,8 do orbit(part,teal,12,(i/8)*math.pi*2,0.6,0.5) end
	pe(att(part,0,0,0),{Texture="rbxassetid://7104844885",Color=ColorSequence.new(teal),Rate=120,Lifetime=NumberRange.new(1.2,1.5),Speed=NumberRange.new(10,18),SpreadAngle=Vector2.new(180,180),LightEmission=1,Size=NumberSequence.new(0.4)})
	light(part,teal,5,32)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.28,0.35)
end

-- IMAGE 6: WIREFRAME CUBE — Holographic edges + god rays + ring
local function ORE_WireframeCube(part, color)
	part.Transparency=1; part.Material=Enum.Material.Plastic; part.CastShadow=false
	spin(part, 1.2)
	local s=5.5
	local edges={{-s,-s,-s,s,-s,-s},{-s,s,-s,s,s,-s},{-s,-s,s,s,-s,s},{-s,s,s,s,s,s},
		{-s,-s,-s,-s,s,-s},{s,-s,-s,s,s,-s},{-s,-s,s,-s,s,s},{s,-s,s,s,s,s},
		{-s,-s,-s,-s,-s,s},{s,-s,-s,s,-s,s},{-s,s,-s,-s,s,s},{s,s,-s,s,s,s}}
	for _,e in ipairs(edges) do
		beam(att(part,e[1],e[2],e[3]),att(part,e[4],e[5],e[6]),part,color,0.22,0.22,0,0.15)
	end
	local baseA=att(part,0,-8,0)
	for i=1,8 do
		local angle=(i/8)*math.pi*2
		beam(baseA,att(part,math.cos(angle)*18,-26,math.sin(angle)*18),part,color,1.0,0.0,0,0.28)
	end
	pe(baseA,{Texture="rbxassetid://1525327413",Color=ColorSequence.new(color),Rate=6,Lifetime=NumberRange.new(2,2),Speed=NumberRange.new(0,0),LightEmission=0.7,LightInfluence=1,Size=NumberSequence.new(30),Rotation=NumberRange.new(-360,360),RotSpeed=NumberRange.new(-6,6),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.01,0.9),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,0,0),{Texture="rbxassetid://7948615545",Color=ColorSequence.new(color),Rate=18,Lifetime=NumberRange.new(0.4,0.4),Speed=NumberRange.new(0,0),LightEmission=1,Size=NumberSequence.new(7),Transparency=NumberSequence.new(0.96)})
	light(part,color,4.5,30)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.22,1.2)
end

-- IMAGE 1: LOTUS STAR — Vertical beam + ring particles + 6 orbs
local function ORE_Lotus(part, color)
	part.Material=Enum.Material.Neon; part.Shape=Enum.PartType.Ball
	part.Color=color; part.Transparency=0.3; part.Size=Vector3.new(5,5,5)
	spin(part, 1.0)
	local topA=att(part,0,22,0); local botA=att(part,0,-22,0); local ctr=att(part,0,0,0)
	beam(topA,botA,part,color,0.55,0.18,0,0.12)
	pe(ctr,{Texture="rbxassetid://3467149276",Color=ColorSequence.new(color),Rate=70,Lifetime=NumberRange.new(1,1),Speed=NumberRange.new(0.5,0.5),LightEmission=1,Size=NumberSequence.new(20)})
	pe(ctr,{Texture="rbxassetid://3467149276",Color=ColorSequence.new(color:Lerp(Color3.new(1,1,1),0.5)),Rate=25,Lifetime=NumberRange.new(0.6,0.6),Speed=NumberRange.new(0,0),LightEmission=1,Size=NumberSequence.new(9)})
	for i=1,6 do orbit(part,color,10,(i/6)*math.pi*2,1.5,0.8) end
	pe(ctr,{Texture="rbxassetid://1084973996",Color=ColorSequence.new(color:Lerp(Color3.new(0,0,0),0.45)),Rate=3,Lifetime=NumberRange.new(4,6),Speed=NumberRange.new(0,1),SpreadAngle=Vector2.new(360,360),LightEmission=0.3,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,3),NumberSequenceKeypoint.new(0.5,10),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.7),NumberSequenceKeypoint.new(1,1)}),ZOffset=-3})
	light(part,color,3.5,26)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.22,0.95)
end

-- IMAGE 2: GALAXY ORB — Nebula core + 3 sweep ring beams + 3 orbiting planets
local function ORE_Galaxy(part, color)
	part.Material=Enum.Material.Neon; part.Shape=Enum.PartType.Ball
	part.Color=color; part.Transparency=0.25; part.Size=Vector3.new(8,8,8)
	pe(att(part,0,0,0),{Texture="rbxassetid://1084973996",Color=ColorSequence.new(color:Lerp(Color3.new(0,0,0),0.6)),Rate=5,Lifetime=NumberRange.new(5,8),Speed=NumberRange.new(0,1),SpreadAngle=Vector2.new(360,360),LightEmission=0.3,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,5),NumberSequenceKeypoint.new(0.5,18),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.7),NumberSequenceKeypoint.new(1,1)}),ZOffset=-3})
	pe(att(part,0,0,0),{Texture="rbxassetid://6119272027",Color=ColorSequence.new(color),Rate=30,Lifetime=NumberRange.new(3,5),Speed=NumberRange.new(2,8),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.4)})
	local rd={{15,0,0,-15,0,0,12,color},{0,15,0,0,-15,0,10,color:Lerp(Color3.fromRGB(100,255,180),0.4)},{11,11,0,-11,-11,0,8,color:Lerp(Color3.new(1,1,1),0.35)}}
	for _,r in ipairs(rd) do
		beam(att(part,r[1],r[2],r[3]),att(part,r[4],r[5],r[6]),part,r[8],1.0,0.35,r[7],0.18)
		beam(att(part,r[4],r[5],r[6]),att(part,r[1],r[2],r[3]),part,r[8],0.45,0.1,r[7],0.45)
	end
	orbit(part,color,13,0,0.7,2.2)
	orbit(part,color:Lerp(Color3.fromRGB(200,255,200),0.4),13,math.pi,0.7,1.6)
	orbit(part,Color3.fromRGB(255,255,180),13,math.pi*0.5,0.9,1.0)
	light(part,color,6.5,42)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.35,0.45)
end

-- IMAGE 3: OCEAN DISC — Rotating dark disc + water rings + tentacle streams
local function ORE_Ocean(part, color)
	part.Material=Enum.Material.Plastic; part.Transparency=1; part.Size=Vector3.new(8,8,8)
	local ocean=Color3.fromRGB(0,160,220)
	task.spawn(function()
		while part and part.Parent do
			part.CFrame=part.CFrame*CFrame.fromEulerAnglesXYZ(0,0.018,0); task.wait()
		end
	end)
	for _,y in ipairs({-18,-12,-4,4}) do
		pe(att(part,0,y,0),{Texture="rbxassetid://1525327413",Color=ColorSequence.new(ocean),Rate=35,Lifetime=NumberRange.new(1.5,1.5),Speed=NumberRange.new(3,3),LightEmission=0,Size=NumberSequence.new(22+math.abs(y)*1.2),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.75),NumberSequenceKeypoint.new(1,1)})})
	end
	for i=1,6 do
		local angle=(i/6)*math.pi*2
		pe(att(part,math.cos(angle)*10,-18,math.sin(angle)*10),{Texture="rbxassetid://196969716",Color=ColorSequence.new(ocean),Rate=70,Lifetime=NumberRange.new(2.5,2.5),Speed=NumberRange.new(6,6),LightEmission=0.3,Size=NumberSequence.new(2.0)})
	end
	pe(att(part,0,0,0),{Texture="rbxassetid://1084976679",Color=ColorSequence.new(ocean),Rate=80,Lifetime=NumberRange.new(8,8),Speed=NumberRange.new(0,2),LightEmission=1,Size=NumberSequence.new(2)})
	light(part,ocean,4,32)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.4,0.5)
end

-- IMAGE 4: VORTEX RINGS — ForceField core + multi-plane beam rings + orbiters
local function ORE_Vortex(part, color)
	part.Material=Enum.Material.ForceField; part.Shape=Enum.PartType.Ball
	part.Color=color; part.Transparency=0; part.Size=Vector3.new(6,6,6)
	spin(part, 1.2)
	local planes={{14,0,8},{0,14,7},{10,10,6}}
	for _,p in ipairs(planes) do
		beam(att(part,p[1],p[2],0),att(part,-p[1],-p[2],0),part,color,0.9,0.3,p[3],0.2)
		beam(att(part,-p[1],-p[2],0),att(part,p[1],p[2],0),part,color:Lerp(Color3.new(1,1,1),0.3),0.4,0.1,p[3],0.45)
	end
	orbit(part,color,12,0,0.9,1.8)
	orbit(part,color:Lerp(Color3.fromRGB(160,100,255),0.5),12,math.pi*0.6,0.9,1.4)
	orbit(part,Color3.fromRGB(80,200,200),12,math.pi*1.2,0.9,1.0)
	pe(att(part,0,0,0),{Texture="rbxassetid://7948615545",Color=ColorSequence.new(color),Rate=22,Lifetime=NumberRange.new(0.5,0.5),Speed=NumberRange.new(0,0),LightEmission=1,Size=NumberSequence.new(9),Transparency=NumberSequence.new(0.96),Rotation=NumberRange.new(-180,180),RotSpeed=NumberRange.new(-15,15)})
	light(part,color,3.5,28)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.3,0.55)
end

-- IMAGE 5: ATOM RINGS — Crystal ball + 3 orbital beam rings in different planes
local function ORE_Atom(part, color)
	part.Material=Enum.Material.Neon; part.Shape=Enum.PartType.Ball
	part.Color=color; part.Transparency=0.1; part.Size=Vector3.new(5,5,5)
	for i=1,4 do crystal_arm(part, color, (i/4)*math.pi*2, 6, 15) end
	local r=9
	local planes={{r,0,0,-r,0,0,8},{0,r,0,0,-r,0,8},{0,0,r,0,0,-r,8}}
	for _,p in ipairs(planes) do
		beam(att(part,p[1],p[2],p[3]),att(part,p[4],p[5],p[6]),part,color,0.35,0.35,p[7],0.35)
		beam(att(part,p[4],p[5],p[6]),att(part,p[1],p[2],p[3]),part,color:Lerp(Color3.new(1,1,1),0.4),0.2,0.2,p[7],0.5)
	end
	light(part,color,3,22)
	pe(att(part,0,0,0),{Texture="rbxassetid://6707322206",Color=ColorSequence.new(color),Rate=20,Lifetime=NumberRange.new(1,1.5),Speed=NumberRange.new(2,4),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.4)})
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.2,0.9)
end

-- IMAGE 7: TEAL CRYSTAL — Tall hexagonal prism with upward sparkle
local function ORE_TealCrystal(part, color)
	part.Material=Enum.Material.Neon
	part.Color=color; part.Transparency=0.1; part.Size=Vector3.new(4,8,4)
	local mesh=Instance.new("SpecialMesh",part); mesh.MeshType=Enum.MeshType.Cylinder
	spin(part, 0.6)
	pe(att(part,0,5,0),{Texture="rbxassetid://6119272027",Color=ColorSequence.new(color:Lerp(Color3.new(1,1,1),0.4)),Rate=30,Lifetime=NumberRange.new(2,3),Speed=NumberRange.new(2,4),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.4),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,-5,0),{Texture="rbxassetid://1525327413",Color=ColorSequence.new(color),Rate=6,Lifetime=NumberRange.new(3,3),Speed=NumberRange.new(0,0),LightEmission=0.3,Size=NumberSequence.new(28),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.01,0.92),NumberSequenceKeypoint.new(1,1)})})
	light(part,color,3,22)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.2,1.1)
end

-- SOLAR DISC: Tilted coin with 8 radial beams + spark ring (IMAGE 11)
local function ORE_SolarDisc(part, color)
	part.Material=Enum.Material.Neon; part.Color=color
	part.Transparency=0; part.Size=Vector3.new(8,1.2,8)
	local mesh=Instance.new("SpecialMesh",part); mesh.MeshType=Enum.MeshType.Cylinder
	part.CFrame=part.CFrame*CFrame.Angles(math.rad(30),0,0)
	spin(part, 2.8)
	local r=10; local attaches={}
	for i=1,8 do table.insert(attaches,att(part,math.cos((i/8)*math.pi*2)*r,math.sin(i)*1.5,math.sin((i/8)*math.pi*2)*r)) end
	for i=1,8 do beam(attaches[i],attaches[(i%8)+1],part,color,0.45,0.18,2,0.2) end
	for i=1,4 do beam(attaches[i],attaches[i+4],part,color:Lerp(Color3.new(1,1,1),0.3),0.3,0.1,0,0.45) end
	pe(att(part,0,0,0),{Texture="rbxassetid://1280736246",Color=ColorSequence.new(color),Rate=120,Lifetime=NumberRange.new(1.5,1.5),Speed=NumberRange.new(20,20),LightEmission=1,Size=NumberSequence.new(1.0),SpreadAngle=Vector2.new(360,360),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,0,0),{Texture="rbxassetid://3916186365",Color=ColorSequence.new(color),Rate=12,Lifetime=NumberRange.new(5,5),Speed=NumberRange.new(0,0),LightEmission=0.6,Size=NumberSequence.new(50)})
	light(part,color,5.5,36)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.35,0.6)
end

-- DIAMOND BURST: Brilliant prism with scatter beams in 6 directions
local function ORE_DiamondBurst(part, color)
	part.Material=Enum.Material.Glass; part.Color=color
	part.Transparency=0.1; part.Size=Vector3.new(6,6,6)
	local mesh=Instance.new("SpecialMesh",part); mesh.MeshType=Enum.MeshType.Wedge; mesh.Scale=Vector3.new(1.6,1.6,1.6)
	spin(part, 2.2)
	local dirs={{12,0,0},{-12,0,0},{0,12,0},{0,-12,0},{0,0,12},{0,0,-12}}
	local ctr=att(part,0,0,0)
	for _,d in ipairs(dirs) do beam(ctr,att(part,d[1],d[2],d[3]),part,color,0.6,0.0,0,0.25) end
	pe(ctr,{Texture="rbxassetid://13182899239",Color=ColorSequence.new(color),Rate=400,Lifetime=NumberRange.new(0.2,0.2),Speed=NumberRange.new(20,35),SpreadAngle=Vector2.new(180,180),LightEmission=4,LightInfluence=1,Size=NumberSequence.new(2.5),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.25,0),NumberSequenceKeypoint.new(1,1)})})
	pe(ctr,{Texture="rbxassetid://6119272027",Color=ColorSequence.new(color:Lerp(Color3.new(1,1,1),0.5)),Rate=60,Lifetime=NumberRange.new(1.5,2),Speed=NumberRange.new(3,6),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.6)})
	light(part,color,5,32)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.25,1.6)
end

-- PRISMATIC: Rainbow iridescent gem with multi-colored star beams
local function ORE_Prismatic(part, color)
	part.Material=Enum.Material.Foil; part.Color=Color3.fromRGB(160,200,180)
	part.Transparency=0; part.Size=Vector3.new(6,6,6)
	local colors={Color3.fromRGB(255,100,100),Color3.fromRGB(255,200,50),Color3.fromRGB(50,220,100),Color3.fromRGB(80,150,255),Color3.fromRGB(180,80,255),Color3.fromRGB(255,100,200)}
	local r=10
	for i,c in ipairs(colors) do
		local angle=(i/#colors)*math.pi*2
		beam(att(part,0,0,0),att(part,math.cos(angle)*r,math.sin(i)*2,math.sin(angle)*r),part,c,0.4,0.0,0,0.25)
		pe(att(part,math.cos(angle)*r,math.sin(i)*2,math.sin(angle)*r),{Texture="rbxassetid://6119272027",Color=ColorSequence.new(c),Rate=8,Lifetime=NumberRange.new(2,3),Speed=NumberRange.new(1,2),SpreadAngle=Vector2.new(90,90),LightEmission=1,Size=NumberSequence.new(0.35)})
	end
	spin(part, 1.8)
	light(part,color,3,24)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.2,0.95)
end

-- LAVA: Dark rock with dripping fire cracks
local function ORE_Lava(part, color)
	local lava=Color3.fromRGB(255,80,20)
	part.Material=Enum.Material.Slate; part.Color=Color3.fromRGB(40,20,10)
	part.Transparency=0; part.Size=Vector3.new(6,6,6)
	pe(att(part,0,0,0),{Texture="rbxassetid://7104844885",Color=ColorSequence.new(lava),Rate=80,Lifetime=NumberRange.new(1,1.5),Speed=NumberRange.new(5,8),SpreadAngle=Vector2.new(180,180),LightEmission=1,Size=NumberSequence.new(0.45),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,5,0),{Texture="rbxassetid://6119272027",Color=ColorSequence.new(Color3.fromRGB(255,120,30)),Rate=25,Lifetime=NumberRange.new(2,3),Speed=NumberRange.new(3,6),SpreadAngle=Vector2.new(180,180),LightEmission=1,Size=NumberSequence.new(0.6),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,-6,0),{Texture="rbxassetid://1084973996",Color=ColorSequence.new(Color3.fromRGB(60,20,5)),Rate=3,Lifetime=NumberRange.new(3,4),Speed=NumberRange.new(1,2),SpreadAngle=Vector2.new(180,180),LightEmission=0.2,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,2),NumberSequenceKeypoint.new(0.5,8),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.5),NumberSequenceKeypoint.new(1,1)})})
	light(part,lava,3.5,26)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.22,0.75)
end

-- GOLD SPARKLE: Glittering coin with golden rain
local function ORE_GoldSparkle(part, color)
	part.Material=Enum.Material.Foil; part.Color=Color3.fromRGB(255,196,40)
	part.Transparency=0; part.Size=Vector3.new(5,3,5)
	spin(part, 2.5)
	pe(att(part,0,3,0),{Texture="rbxassetid://6119272027",Color=ColorSequence.new(Color3.fromRGB(255,210,60)),Rate=50,Lifetime=NumberRange.new(2.5,3),Speed=NumberRange.new(4,8),SpreadAngle=Vector2.new(180,180),LightEmission=1,Size=NumberSequence.new(0.5),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,0,0),{Texture="rbxassetid://1525327413",Color=ColorSequence.new(Color3.fromRGB(255,200,50)),Rate=8,Lifetime=NumberRange.new(2,2),Speed=NumberRange.new(0,0),LightEmission=0.5,Size=NumberSequence.new(30),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.01,0.93),NumberSequenceKeypoint.new(1,1)})})
	light(part,Color3.fromRGB(255,200,40),3.5,26)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.18,1.5)
end

-- MOON GHOST: Pale ethereal orb with slow orbiting moons
local function ORE_Moon(part, color)
	part.Material=Enum.Material.Neon; part.Shape=Enum.PartType.Ball
	part.Color=Color3.fromRGB(220,220,240); part.Transparency=0.4; part.Size=Vector3.new(7,7,7)
	orbit(part,Color3.fromRGB(200,200,230),11,0,0.5,1.8)
	orbit(part,Color3.fromRGB(230,225,240),11,math.pi*0.7,0.5,1.4)
	orbit(part,Color3.fromRGB(210,215,235),11,math.pi*1.4,0.5,1.2)
	pe(att(part,0,0,0),{Texture="rbxassetid://1084973996",Color=ColorSequence.new(Color3.fromRGB(200,210,240)),Rate=3,Lifetime=NumberRange.new(5,7),Speed=NumberRange.new(0,0.5),SpreadAngle=Vector2.new(360,360),LightEmission=0.6,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,4),NumberSequenceKeypoint.new(0.5,14),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.6),NumberSequenceKeypoint.new(1,1)}),ZOffset=-2})
	pe(att(part,0,0,0),{Texture="rbxassetid://6119272027",Color=ColorSequence.new(Color3.fromRGB(220,220,255)),Rate=15,Lifetime=NumberRange.new(3,4),Speed=NumberRange.new(0.5,2),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.4)})
	light(part,Color3.fromRGB(200,210,240),4,30)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.15,1.0)
end

-- VAPORWAVE: Pink/blue scanlines + orbiting cubes
local function ORE_Vaporwave(part, color)
	part.Material=Enum.Material.Neon; part.Color=Color3.fromRGB(180,60,220)
	part.Transparency=0.05; part.Size=Vector3.new(5,8,5)
	spin(part, 1.5)
	local pink=Color3.fromRGB(255,80,200); local blue=Color3.fromRGB(80,160,255)
	for i=1,5 do
		local y=(-2+i)*2
		local c=(i%2==0) and pink or blue
		beam(att(part,-8,y,0),att(part,8,y,0),part,c,0.18,0.18,0,0.45)
	end
	for i=1,3 do
		local cube=Instance.new("Part"); cube.Size=Vector3.new(1.2,1.2,1.2)
		cube.Material=Enum.Material.Neon; cube.Color=(i%2==0) and pink or blue
		cube.Transparency=0.1; cube.Anchored=true; cube.CanCollide=false; cube.CanTouch=false; cube.CanQuery=false
		cube.CFrame=part.CFrame*CFrame.new(math.cos((i/3)*math.pi*2)*10,0,math.sin((i/3)*math.pi*2)*10)
		cube.Parent=part
		local w=Instance.new("WeldConstraint"); w.Part0=part; w.Part1=cube; w.Parent=cube
		spin(cube, 5); light(cube,(i%2==0) and pink or blue,2,8)
	end
	pe(att(part,0,4,0),{Texture="rbxassetid://6707322206",Color=ColorSequence.new(pink),Rate=30,Lifetime=NumberRange.new(1.5,2),Speed=NumberRange.new(2,4),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.5)})
	pe(att(part,0,-4,0),{Texture="rbxassetid://6707322206",Color=ColorSequence.new(blue),Rate=30,Lifetime=NumberRange.new(1.5,2),Speed=NumberRange.new(2,4),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.5)})
	light(part,Color3.fromRGB(200,80,230),5,32)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.28,0.75)
end

-- WORLD CORE: Massive golden sun-heart of the world
local function ORE_WorldCore(part, color)
	part.Material=Enum.Material.Neon; part.Shape=Enum.PartType.Ball
	part.Color=Color3.fromRGB(255,220,80); part.Transparency=0; part.Size=Vector3.new(10,10,10)
	for _,plane in ipairs({{1,0,0},{0,1,0},{0,0,1}}) do
		local s=16
		beam(att(part,plane[1]*s,plane[2]*s,plane[3]*s),att(part,-plane[1]*s,-plane[2]*s,-plane[3]*s),part,Color3.fromRGB(255,230,100),1.5,0.5,14,0.12)
	end
	for i=1,6 do orbit(part,Color3.fromRGB(255,200,50),15,(i/6)*math.pi*2,1.1,2.5) end
	pe(att(part,0,0,0),{Texture="rbxassetid://13182899239",Color=ColorSequence.new(Color3.fromRGB(255,250,180)),Rate=500,Lifetime=NumberRange.new(0.4,0.4),Speed=NumberRange.new(25,40),SpreadAngle=Vector2.new(180,180),LightEmission=4,LightInfluence=1,Size=NumberSequence.new(5),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.25,0),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,0,0),{Texture="rbxassetid://1084973996",Color=ColorSequence.new(Color3.fromRGB(255,220,80)),Rate=6,Lifetime=NumberRange.new(5,8),Speed=NumberRange.new(0,2),SpreadAngle=Vector2.new(360,360),LightEmission=1.5,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,6),NumberSequenceKeypoint.new(0.5,22),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.6),NumberSequenceKeypoint.new(1,1)})})
	light(part,Color3.fromRGB(255,220,80),8,50)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.55,0.3)
end

-- QUASAR: Ultra-rare polar jets + accretion disc
local function ORE_Quasar(part, color)
	part.Material=Enum.Material.Neon; part.Shape=Enum.PartType.Ball
	part.Color=Color3.fromRGB(255,255,255); part.Transparency=0; part.Size=Vector3.new(9,9,9)
	local topA=att(part,0,25,0); local botA=att(part,0,-25,0)
	beam(topA,botA,part,Color3.fromRGB(255,240,180),1.5,0.3,0,0.05)
	pe(topA,{Texture="rbxassetid://7104844885",Color=ColorSequence.new(Color3.fromRGB(255,220,120)),Rate=200,Lifetime=NumberRange.new(2,3),Speed=NumberRange.new(20,30),SpreadAngle=Vector2.new(8,8),LightEmission=1,Size=NumberSequence.new(0.8),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})})
	pe(botA,{Texture="rbxassetid://7104844885",Color=ColorSequence.new(Color3.fromRGB(100,200,255)),Rate=200,Lifetime=NumberRange.new(2,3),Speed=NumberRange.new(20,30),SpreadAngle=Vector2.new(8,8),LightEmission=1,Size=NumberSequence.new(0.8),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})})
	local r=14; local attaches={}
	for i=1,10 do table.insert(attaches,att(part,math.cos((i/10)*math.pi*2)*r,0,math.sin((i/10)*math.pi*2)*r)) end
	for i=1,10 do beam(attaches[i],attaches[(i%10)+1],part,Color3.fromRGB(255,200,80),0.8,0.3,4,0.15) end
	pe(att(part,0,0,0),{Texture="rbxassetid://13182899239",Color=ColorSequence.new(Color3.fromRGB(255,255,240)),Rate=800,Lifetime=NumberRange.new(0.5,0.5),Speed=NumberRange.new(30,50),SpreadAngle=Vector2.new(180,180),LightEmission=5,LightInfluence=1,Size=NumberSequence.new(6),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.2,0),NumberSequenceKeypoint.new(1,1)})})
	light(part,Color3.fromRGB(255,230,150),8,55)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.65,0.25)
end

-- NULL VOID: Absolute darkness with white reality tears
local function ORE_NullVoid(part, color)
	part.Material=Enum.Material.SmoothPlastic; part.Color=Color3.fromRGB(0,0,0)
	part.Transparency=0; part.Size=Vector3.new(9,9,9)
	spin(part, 0.25)
	for i=1,6 do
		local angle=(i/6)*math.pi*2
		beam(att(part,0,0,0),att(part,math.cos(angle)*18,math.sin(angle)*2,math.sin(angle)*18),part,Color3.fromRGB(255,255,255),0.4,0.0,0,0.15)
	end
	pe(att(part,0,0,0),{Texture="rbxassetid://13182899239",Color=ColorSequence.new(Color3.fromRGB(255,255,255)),Rate=400,Lifetime=NumberRange.new(0.3,0.3),Speed=NumberRange.new(20,35),SpreadAngle=Vector2.new(180,180),LightEmission=5,LightInfluence=1,Size=NumberSequence.new(3),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.3,0),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,0,0),{Texture="rbxassetid://1084973996",Color=ColorSequence.new(Color3.fromRGB(0,0,0)),Rate=6,Lifetime=NumberRange.new(5,8),Speed=NumberRange.new(0,1),SpreadAngle=Vector2.new(360,360),LightEmission=0,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,6),NumberSequenceKeypoint.new(0.5,20),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.1),NumberSequenceKeypoint.new(1,1)}),ZOffset=-5})
	light(part,Color3.fromRGB(255,255,255),6,40)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.55,0.22)
end

-- GLITCH DIGITAL: Pink/cyan corruption burst
local function ORE_Glitch(part, color)
	local pink=Color3.fromRGB(255,40,120); local cyan=Color3.fromRGB(40,220,255)
	part.Material=Enum.Material.Neon; part.Color=pink
	part.Transparency=0; part.Size=Vector3.new(6,6,6)
	spin(part, 3.5)
	pe(att(part,0,0,0),{Texture="rbxassetid://13182899239",Color=ColorSequence.new(pink),Rate=300,Lifetime=NumberRange.new(0.15,0.15),Speed=NumberRange.new(15,25),SpreadAngle=Vector2.new(180,180),LightEmission=3,LightInfluence=1,Size=NumberSequence.new(2),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.25,0),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,0,0),{Texture="rbxassetid://13182899239",Color=ColorSequence.new(cyan),Rate=200,Lifetime=NumberRange.new(0.2,0.2),Speed=NumberRange.new(10,20),SpreadAngle=Vector2.new(180,180),LightEmission=3,LightInfluence=1,Size=NumberSequence.new(2),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.25,0),NumberSequenceKeypoint.new(1,1)})})
	for i=1,4 do beam(att(part,-8,-4+i*2,0),att(part,8,-4+i*2,0),part,(i%2==0) and pink or cyan,0.15,0.15,0,0.55) end
	light(part,pink,5,30)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.3,0.85)
end

-- ECLIPSE SPLIT: Half gold/half void
local function ORE_Eclipse(part, color)
	part.Material=Enum.Material.Neon; part.Color=Color3.fromRGB(255,200,60)
	part.Transparency=0; part.Size=Vector3.new(7,7,7)
	local topA=att(part,0,0,0)
	for i=1,6 do beam(topA,att(part,math.cos((i/6)*math.pi*2)*14,math.sin((i/6)*math.pi)*3,math.sin((i/6)*math.pi*2)*14),part,Color3.fromRGB(255,220,80),0.5,0.0,0,0.2) end
	for i=1,6 do beam(topA,att(part,math.cos((i/6)*math.pi*2)*14,-math.sin((i/6)*math.pi)*3,math.sin((i/6)*math.pi*2)*14),part,Color3.fromRGB(20,0,40),0.5,0.0,0,0.2) end
	orbit(part,Color3.fromRGB(255,220,80),12,0,1.0,1.5)
	orbit(part,Color3.fromRGB(80,0,160),12,math.pi,1.0,1.5)
	pe(topA,{Texture="rbxassetid://13182899239",Color=ColorSequence.new(Color3.fromRGB(255,220,80)),Rate=200,Lifetime=NumberRange.new(0.3,0.3),Speed=NumberRange.new(15,22),SpreadAngle=Vector2.new(90,90),LightEmission=3,LightInfluence=1,Size=NumberSequence.new(2),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.3,0),NumberSequenceKeypoint.new(1,1)})})
	light(part,Color3.fromRGB(255,200,60),5,34)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.38,0.42)
end

-- NEBULA CLOUD: Purple/pink nebula with star drift
local function ORE_Nebula(part, color)
	local nebula=Color3.fromRGB(200,80,255)
	part.Material=Enum.Material.Neon; part.Shape=Enum.PartType.Ball
	part.Color=nebula; part.Transparency=0.35; part.Size=Vector3.new(7,7,7)
	pe(att(part,0,0,0),{Texture="rbxassetid://1084973996",Color=ColorSequence.new(nebula:Lerp(Color3.fromRGB(100,20,200),0.5)),Rate=4,Lifetime=NumberRange.new(5,8),Speed=NumberRange.new(0,1.5),SpreadAngle=Vector2.new(360,360),LightEmission=0.5,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,4),NumberSequenceKeypoint.new(0.5,16),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.6),NumberSequenceKeypoint.new(1,1)}),ZOffset=-2})
	pe(att(part,0,0,0),{Texture="rbxassetid://1084973996",Color=ColorSequence.new(Color3.fromRGB(255,80,200)),Rate=2,Lifetime=NumberRange.new(5,7),Speed=NumberRange.new(0,1),SpreadAngle=Vector2.new(360,360),LightEmission=0.4,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,3),NumberSequenceKeypoint.new(0.5,12),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.65),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,0,0),{Texture="rbxassetid://6119272027",Color=ColorSequence.new(Color3.fromRGB(255,220,255)),Rate=20,Lifetime=NumberRange.new(4,6),Speed=NumberRange.new(1,4),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.35)})
	orbit(part,nebula,11,0,0.6,1.4)
	orbit(part,Color3.fromRGB(255,120,255),11,math.pi,0.6,1.1)
	light(part,nebula,4.5,32)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.28,0.5)
end

-- STAR BURST: 12 star beams outward + stardust
local function ORE_StarBurst(part, color)
	part.Material=Enum.Material.Neon; part.Shape=Enum.PartType.Ball
	part.Color=color; part.Transparency=0.05; part.Size=Vector3.new(7,7,7)
	local ctr=att(part,0,0,0)
	for i=1,12 do
		local angle=(i/12)*math.pi*2
		beam(ctr,att(part,math.cos(angle)*15,math.sin(angle)*2,math.sin(angle)*15),part,color:Lerp(Color3.new(1,1,1),0.3),0.5,0.0,0,0.2)
	end
	orbit(part,color:Lerp(Color3.new(1,1,1),0.3),12,0,1.2,1.5)
	orbit(part,color,12,math.pi,1.2,1.2)
	pe(ctr,{Texture="rbxassetid://6119272027",Color=ColorSequence.new(color:Lerp(Color3.new(1,1,1),0.4)),Rate=50,Lifetime=NumberRange.new(3,4),Speed=NumberRange.new(3,7),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.5)})
	light(part,color,5,36)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.35,0.4)
end

-- COSMIC SHARD: Meteoric wedge with cosmic dust trail
local function ORE_CosmicShard(part, color)
	part.Material=Enum.Material.Neon; part.Color=color
	part.Transparency=0.1; part.Size=Vector3.new(6,6,6)
	local mesh=Instance.new("SpecialMesh",part); mesh.MeshType=Enum.MeshType.Wedge; mesh.Scale=Vector3.new(1.3,1.3,1.3)
	spin(part, 2.0)
	pe(att(part,0,0,0),{Texture="rbxassetid://6119272027",Color=ColorSequence.new(color),Rate=40,Lifetime=NumberRange.new(3,5),Speed=NumberRange.new(1,4),SpreadAngle=Vector2.new(360,360),LightEmission=1,Size=NumberSequence.new(0.4)})
	pe(att(part,0,0,0),{Texture="rbxassetid://1084973996",Color=ColorSequence.new(color:Lerp(Color3.new(0,0,0),0.5)),Rate=3,Lifetime=NumberRange.new(4,6),Speed=NumberRange.new(0,1),SpreadAngle=Vector2.new(360,360),LightEmission=0.3,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,3),NumberSequenceKeypoint.new(0.5,10),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.6),NumberSequenceKeypoint.new(1,1)})})
	light(part,color,3.5,26)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.2,0.8)
end

-- VOID CRYSTAL: Dark spiked void
local function ORE_VoidCrystal(part, color)
	part.Material=Enum.Material.SmoothPlastic; part.Color=Color3.fromRGB(5,0,12)
	part.Transparency=0; part.Size=Vector3.new(7,7,7)
	for i=1,6 do crystal_arm(part, Color3.fromRGB(80,0,160), (i/6)*math.pi*2, 8, 25) end
	spin(part, 0.4)
	local void=Color3.fromRGB(100,0,200)
	pe(att(part,0,0,0),{Texture="rbxassetid://13182899239",Color=ColorSequence.new(void),Rate=180,Lifetime=NumberRange.new(0.3,0.3),Speed=NumberRange.new(15,22),SpreadAngle=Vector2.new(180,180),LightEmission=2,LightInfluence=1,Size=NumberSequence.new(2.5),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.3,0),NumberSequenceKeypoint.new(1,1)})})
	pe(att(part,0,0,0),{Texture="rbxassetid://1084973996",Color=ColorSequence.new(Color3.fromRGB(2,0,5)),Rate=4,Lifetime=NumberRange.new(5,7),Speed=NumberRange.new(0,0.5),SpreadAngle=Vector2.new(360,360),LightEmission=0,Size=NumberSequence.new({NumberSequenceKeypoint.new(0,5),NumberSequenceKeypoint.new(0.5,16),NumberSequenceKeypoint.new(1,0)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.2),NumberSequenceKeypoint.new(1,1)}),ZOffset=-4})
	light(part,void,4,24)
	snd(part,"rbxasset://sounds/electronicpingshort.wav",0.28,0.3)
end

-- ORE DISPATCH TABLE
local ORE_MAP = {
	-- FIRE/LAVA
	["Ruby"]=ORE_Spider, ["Inferno Ruby"]=ORE_Spider, ["Bloodstone"]=ORE_Spider,
	["Brimstone"]=ORE_Lava, ["Pyroclast"]=ORE_Lava, ["Incinderium"]=ORE_Lava,
	["Pyrite Ember"]=ORE_Lava, ["Magma Pearl"]=ORE_Spider, ["Fire Pearl"]=ORE_Spider,
	["Hellforge Ingot"]=ORE_Spider, ["Lava Stone"]=ORE_Lava, ["Volcano Glass"]=ORE_Lava,
	["Heatstone"]=ORE_Lava, ["Volcanic Iron"]=ORE_Lava, ["Lava Quartz"]=ORE_Lava,
	["Fire Opal"]=ORE_Lava, ["Heat Crystal"]=ORE_Lava, ["Heat Sink"]=ORE_Lava,
	["Ember Core"]=ORE_Lava, ["Vulcanite"]=ORE_Spider, ["Magma Crystal"]=ORE_Spider,
	["Cinder Ore"]=ORE_Lava, ["Cinder Heart"]=ORE_Spider,
	["Pyromorphite"]=ORE_Lava, ["Cinder Quartz"]=ORE_Lava, ["Solar Pearl"]=ORE_GoldSparkle,
	-- EMERALD / GREEN
	["Emerald"]=ORE_TealCrystal, ["Peridot"]=ORE_TealCrystal, ["Malachite"]=ORE_TealCrystal,
	["Malachitepulse"]=ORE_TealCrystal,
	-- SAPPHIRE / BLUE
	["Sapphire"]=ORE_Atom, ["Lapis Lazuli"]=ORE_Atom, ["Sodalite"]=ORE_Atom,
	["Galena"]=ORE_Atom, ["Cobaltglow"]=ORE_Atom, ["Sodaliteheart"]=ORE_Atom,
	-- AMETHYST / PURPLE
	["Amethyst"]=ORE_Vortex, ["Iolite"]=ORE_Vortex, ["Jade"]=ORE_TealCrystal,
	["Tanzanite"]=ORE_Vortex, ["Tourmaline"]=ORE_Vortex, ["Voidstone"]=ORE_VoidCrystal,
	-- GOLD
	["Gold"]=ORE_GoldSparkle, ["Gold Flake"]=ORE_GoldSparkle, ["Gilded Dust"]=ORE_GoldSparkle,
	["Goldstone"]=ORE_GoldSparkle, ["Gold Obsidian"]=ORE_GoldSparkle, ["Pyrite"]=ORE_GoldSparkle,
	["Tigerlight"]=ORE_GoldSparkle, ["Quarrylight"]=ORE_GoldSparkle, ["Dustglow"]=ORE_GoldSparkle,
	-- SHADOW / VOID STAR (Image 10)
	["Shadow Quartz"]=ORE_VoidStar, ["Umbra Stone"]=ORE_VoidStar, ["Voidshard"]=ORE_VoidStar,
	["Eclipse Sliver"]=ORE_VoidStar, ["Black Mirror"]=ORE_VoidStar, ["Voidheart"]=ORE_VoidCrystal,
	["Void Crystal"]=ORE_VoidCrystal, ["Abyss Shard"]=ORE_VoidCrystal, ["Nullstone"]=ORE_VoidCrystal,
	["Smoky Quartz"]=ORE_VoidStar, ["Dusk Pearl"]=ORE_VoidStar, ["Abyss Heart"]=ORE_VoidCrystal,
	["Wraithstone"]=ORE_VoidCrystal, ["Mirrorshard"]=ORE_VoidStar, ["Nightglass"]=ORE_VoidStar,
	["Null Origin"]=ORE_NullVoid, ["Ravenite"]=ORE_VoidStar, ["Black Diamond"]=ORE_NullVoid,
	["Snowflake Obsidian"]=ORE_VoidStar, ["Mahogany Obsidian"]=ORE_VoidStar,
	["Rainbow Obsidian"]=ORE_Prismatic, ["Obsidian"]=ORE_VoidStar, ["Onyxsong"]=ORE_VoidStar,
	-- GLACIER / ICE (Image 9)
	["Glacier Quartz"]=ORE_SnowGlobe, ["Snowstone"]=ORE_SnowGlobe, ["Cryotic"]=ORE_SnowGlobe,
	["Hailstone"]=ORE_SnowGlobe, ["Glacial Heart"]=ORE_SnowGlobe, ["Frostbite"]=ORE_SnowGlobe,
	["Cerlustrium"]=ORE_SnowGlobe, ["Cryoflare"]=ORE_SnowGlobe, ["Rose Quartz"]=ORE_SnowGlobe,
	["Calcite Crystal"]=ORE_SnowGlobe, ["Calcitesong"]=ORE_SnowGlobe,
	["Dawn Opal"]=ORE_Moon, ["Larimar"]=ORE_Moon,
	-- HOLO / TECH (Image 6)
	["Holo Crystal"]=ORE_WireframeCube, ["Static Glass"]=ORE_WireframeCube,
	["Chroma Crystal"]=ORE_WireframeCube, ["Refractor"]=ORE_WireframeCube,
	["Titanium"]=ORE_WireframeCube, ["Platinum"]=ORE_DiamondBurst,
	["Vaporwave Shard"]=ORE_Vaporwave, ["Spectrum Shard"]=ORE_Vaporwave,
	["Analog Core"]=ORE_Glitch, ["CRT Heart"]=ORE_Glitch, ["Glitch Core"]=ORE_Glitch,
	["Pixel Core"]=ORE_Glitch,
	-- GALAXY / COSMOS (Image 2)
	["Galaxite"]=ORE_Galaxy, ["Astralite"]=ORE_Galaxy, ["Nebula Crystal"]=ORE_Nebula,
	["Pulsar Shard"]=ORE_StarBurst, ["Cosmic Quartz"]=ORE_CosmicShard,
	["Meteor Iron"]=ORE_CosmicShard, ["Star Sapphire"]=ORE_StarBurst,
	["Comet Shard"]=ORE_CosmicShard, ["Aurorite"]=ORE_Nebula,
	["Singularity Shard"]=ORE_NullVoid, ["Galaxy Bloom"]=ORE_Galaxy,
	["Big Bang Shard"]=ORE_Quasar, ["Echo Crystal"]=ORE_Moon, ["Opal"]=ORE_Prismatic,
	-- SOLAR
	["Sun Coin"]=ORE_SolarDisc, ["Solar Forge"]=ORE_SolarDisc,
	["Sunstone"]=ORE_GoldSparkle, ["Solar Crystal"]=ORE_GoldSparkle,
	["Solar Ember"]=ORE_SolarDisc, ["Hyperheated Quasar"]=ORE_Quasar,
	-- STONE / EARTH (Image 1)
	["Stonebloom"]=ORE_Lotus, ["Ashflower"]=ORE_Lotus, ["Stonepulse"]=ORE_Lotus,
	["Earthsong"]=ORE_Lotus, ["Stoneheart"]=ORE_Lotus, ["Bloodbloom"]=ORE_Spider,
	["Granitestar"]=ORE_Lotus, ["Marblebloom"]=ORE_Lotus, ["Travertinepulse"]=ORE_Lotus,
	["Marbleheart"]=ORE_Moon, ["Pinkstar"]=ORE_Nebula, ["Spinelbloom"]=ORE_Lotus,
	["Garnetsong"]=ORE_Spider, ["Slatebloom"]=ORE_Lotus, ["Nickelpulse"]=ORE_Lotus,
	["Leadheart"]=ORE_Lotus, ["Petrified Bone"]=ORE_Lotus, ["Stoneweave"]=ORE_Lotus,
	["Fossilite"]=ORE_Lotus, ["Cobaltglow"]=ORE_Atom, ["Granitebloom"]=ORE_Lotus,
	["Hematheart"]=ORE_Spider, ["Galenastar"]=ORE_Atom,
	-- WATER / OCEAN (Image 3)
	["Tideheart"]=ORE_Ocean, ["Crystal Lotus"]=ORE_Lotus, ["Worldheart"]=ORE_WorldCore,
	["Worldheart Dust"]=ORE_WorldCore, ["Worldheart Stone"]=ORE_WorldCore,
	["Bedrock Heart"]=ORE_Lotus,
	-- ANCIENT / MYSTIC (Image 4)
	["Ancient Relic"]=ORE_Vortex, ["Altovite"]=ORE_Vortex, ["Eclipse Core"]=ORE_Eclipse,
	-- MOON / PEARL
	["Moonstone"]=ORE_Moon, ["Shadow Pearl"]=ORE_Moon, ["Bismuth"]=ORE_Prismatic,
	["Citrine"]=ORE_GoldSparkle, ["Garnet"]=ORE_Spider, ["Spinel"]=ORE_Spider,
	-- DIAMOND
	["Diamond"]=ORE_DiamondBurst, ["Topaz"]=ORE_GoldSparkle,
	-- ULTIMATE
	["Heart of the Mine"]=ORE_WorldCore,
}

local RANK_FALLBACK = {
	[3]=ORE_GoldSparkle, [4]=ORE_Lotus, [5]=ORE_Atom, [6]=ORE_DiamondBurst,
	[7]=ORE_Vortex, [8]=ORE_Ocean, [9]=ORE_VoidStar, [10]=ORE_Galaxy,
	[11]=ORE_StarBurst, [12]=ORE_NullVoid, [13]=ORE_Quasar,
}

function M.Apply(part, ore)
	local id = ore.Id or ""
	local rarity = ore.Rarity or "Common"
	local rank = RANK[rarity] or 0
	local color = ore.Color or Color3.fromRGB(180,180,255)
	if rank < 3 then return end
	local ok, err = pcall(function()
		local fn = ORE_MAP[id] or RANK_FALLBACK[rank] or ORE_GoldSparkle
		fn(part, color)
	end)
	if not ok then warn("[OreArchetypes] " .. id .. ": " .. tostring(err)) end
end

function M.hasArchetype(id)
	return id ~= nil and id ~= ""
end

function M.applyArchetype(part, ore)
	M.Apply(part, ore)
end

return M
