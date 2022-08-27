
local mod = modApi:getCurrentMod()
local autoOffset = modApi:getPaletteImageOffset(mod.id)

-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath

-- locate our mech assets.
local mechPath = path .."img/units/clone/"

-- make a list of our files.
local files = {
	"mech.png",
	"mech_a.png",
	"mech_w.png",
	"mech_w_broken.png",
	"mech_broken.png",
	"mech_ns.png",
	"mech_h.png"
}

-- iterate our files and add the assets so the game can find them.
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/clone_".. file, mechPath .. file)
end

-- create animations for our mech with our imported files.
-- note how the animations starts searching from /img/
local a = ANIMS
a.clone_mech =			a.MechUnit:new{Image = "units/player/clone_mech.png", PosX = -20, PosY = -2} --subtracted 7
a.clone_mecha =			a.MechUnit:new{Image = "units/player/clone_mech_a.png", PosX = -21, PosY = -2, NumFrames = 4 }
a.clone_mech_broken =    a.MechUnit:new{Image = "units/player/clone_mech_broken.png", PosX = -21, PosY = -2 } --PosX = -20, PosY = -5 Thanks TrueIch
a.clone_mech_broken =	a.MechUnit:new{Image = "units/player/clone_mech_broken.png", PosX = -20, PosY = -5 }
a.clone_mechw_broken =	a.MechUnit:new{Image = "units/player/clone_mech_w_broken.png", PosX = -21, PosY = 6 }
a.clone_mech_ns =		a.MechIcon:new{Image = "units/player/clone_mech_ns.png"}

mechPath = path .."img/units/hail/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/hail_".. file, mechPath .. file)
end

a.hail_mech =			a.MechUnit:new{Image = "units/player/hail_mech.png", PosX = -20, PosY = -6} --subtracted 3
a.hail_mecha =			a.MechUnit:new{Image = "units/player/hail_mech_a.png", PosX = -21, PosY = -6, NumFrames = 4 }
a.hail_mechw =			a.MechUnit:new{Image = "units/player/hail_mech_w.png", PosX = -19, PosY = 4 } --added 1, 2 overall
a.hail_mech_broken =    a.MechUnit:new{Image = "units/player/hail_mech_broken.png", PosX = -20, PosY = -3 } --PosX = -18, PosY = 4 Thanks TrueIch
a.hail_mechw_broken =	a.MechUnit:new{Image = "units/player/hail_mech_w_broken.png", PosX = -21, PosY = 5 }
a.hail_mech_ns =		a.MechIcon:new{Image = "units/player/hail_mech_ns.png"}

mechPath = path .."img/units/glacier/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/glacier_".. file, mechPath .. file)
end

a.glacier_mech =			a.MechUnit:new{Image = "units/player/glacier_mech.png", PosX = -20, PosY = -6} 
a.glacier_mecha =			a.MechUnit:new{Image = "units/player/glacier_mech_a.png", PosX = -21, PosY = -4, NumFrames = 4 }
a.glacier_mechw =			a.MechUnit:new{Image = "units/player/glacier_mech_w.png", PosX = -19, PosY = 6 } 
a.glacier_mech_broken =	a.MechUnit:new{Image = "units/player/glacier_mech_broken.png", PosX = -20, PosY = 8 }
a.glacier_mech_broken =        a.MechUnit:new{Image = "units/player/glacier_mech_broken.png", PosX = -24, PosY = -4 } ---20, PosY = 8 Thanks TrueIch
a.glacier_mech_ns =		a.MechIcon:new{Image = "units/player/glacier_mech_ns.png"}


CloneMech = Pawn:new{
	Name = "Clone Mech",
	Class = "Science",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Image = "clone_mech", 
	
	ImageOffset = autoOffset,

	SkillList = {"Science_WeakLaser","Mech_Clone"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

GlacierMech = Pawn:new{
	Name = "Glacier Mech",
	Class = "Ranged",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Image = "glacier_mech", 
	
	ImageOffset = autoOffset,

	SkillList = {"Ranged_Terraformer"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

HailMech = Pawn:new{
	Name = "Hail Mech",
	Class = "Brute",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Image = "hail_mech", 
	
	ImageOffset = autoOffset,

	SkillList = {"Brute_XGun"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}