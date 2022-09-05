
local mod = modApi:getCurrentMod()
local autoOffset = 0
local id = modApi:getPaletteImageOffset(mod.id)
if id ~= nil then
	autoOffset = id
end
-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath

-- locate our mech assets.
local mechPath = path .."img/units/buckler/"

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
	modApi:appendAsset("img/units/player/buckler_".. file, mechPath .. file)
end

-- create animations for our mech with our imported files.
-- note how the animations starts searching from /img/
local a = ANIMS
a.buckler_mech =			a.MechUnit:new{Image = "units/player/buckler_mech.png", PosX = -20, PosY = -6} --subtracted 7
a.buckler_mecha =			a.MechUnit:new{Image = "units/player/buckler_mech_a.png", PosX = -21, PosY = -6, NumFrames = 4 }
a.buckler_mechw =			a.MechUnit:new{Image = "units/player/buckler_mech_w.png", PosX = -19, PosY = 6 } --added 7, 0 overall
a.buckler_mech_broken =	a.MechUnit:new{Image = "units/player/buckler_mech_broken.png", PosX = -20, PosY = -5 }
a.buckler_mechw_broken =	a.MechUnit:new{Image = "units/player/buckler_mech_w_broken.png", PosX = -21, PosY = 6 }
a.buckler_mech_ns =		a.MechIcon:new{Image = "units/player/buckler_mech_ns.png"}

mechPath = path .."img/units/saw/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/saw_".. file, mechPath .. file)
end

a.saw_mech =			a.MechUnit:new{Image = "units/player/saw_mech.png", PosX = -20, PosY = -6} --subtracted 3
a.saw_mecha =			a.MechUnit:new{Image = "units/player/saw_mech_a.png", PosX = -21, PosY = -6, NumFrames = 4 }
a.saw_mechw =			a.MechUnit:new{Image = "units/player/saw_mech_w.png", PosX = -19, PosY = 8 } --added 1, 2 overall
a.saw_mech_broken =	a.MechUnit:new{Image = "units/player/saw_mech_broken.png", PosX = -18, PosY = 4 }
a.saw_mechw_broken =	a.MechUnit:new{Image = "units/player/saw_mech_w_broken.png", PosX = -21, PosY = 5 }
a.saw_mech_ns =		a.MechIcon:new{Image = "units/player/saw_mech_ns.png"}

mechPath = path .."img/units/rupture/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/rupture_".. file, mechPath .. file)
end

a.rupture_mech =			a.MechUnit:new{Image = "units/player/rupture_mech.png", PosX = -18, PosY = -10} 
a.rupture_mecha =			a.MechUnit:new{Image = "units/player/rupture_mech_a.png", PosX = -19, PosY = -9, NumFrames = 4 }
a.rupture_mechw =			a.MechUnit:new{Image = "units/player/rupture_mech_w.png", PosX = -22, PosY = 5 } 
a.rupture_mech_broken =	a.MechUnit:new{Image = "units/player/rupture_mech_broken.png", PosX = -23, PosY = 2 }
a.rupture_mechw_broken =	a.MechUnit:new{Image = "units/player/rupture_mech_w_broken.png", PosX = -19, PosY = -5 }
a.rupture_mech_ns =		a.MechIcon:new{Image = "units/player/rupture_mech_ns.png"}

BB_SawMech = Pawn:new{
	Name = "Saw Mech",
	Class = "Ranged",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Image = "saw_mech", 
	
	ImageOffset = autoOffset,

	SkillList = {"BB_Ranged_Return"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

BB_BucklerMech = Pawn:new{
	Name = "Buckler Mech",
	Class = "Prime",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Image = "buckler_mech", 
	
	-- ImageOffset specifies which color scheme we will be using.
	-- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = autoOffset,

	SkillList = { "BB_Prime_HolePunch"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

BB_RuptureMech = Pawn:new{
	Name = "Rupture Mech",
	Class = "Science",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Image = "rupture_mech", 
	
	-- ImageOffset specifies which color scheme we will be using.
	-- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = autoOffset,

	SkillList = { "BB_Science_Rupture"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}
