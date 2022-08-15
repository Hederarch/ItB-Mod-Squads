
local mod = modApi:getCurrentMod()
local autoOffset = modApi:getPaletteImageOffset(mod.id)

-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath

-- locate our mech assets.
local mechPath = path .."img/units/batter/"

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
	modApi:appendAsset("img/units/player/batter_".. file, mechPath .. file)
	
end


-- create animations for our mech with our imported files.
-- note how the animations starts searching from /img/
local a = ANIMS
a.batter_mech =			a.MechUnit:new{Image = "units/player/batter_mech.png", PosX = -20, PosY = -3}
a.batter_mecha =			a.MechUnit:new{Image = "units/player/batter_mech_a.png", PosX = -21, PosY = -3, NumFrames = 4 }
a.batter_mechw =			a.MechUnit:new{Image = "units/player/batter_mech_w.png", PosX = -19, PosY = 6 }
a.batter_mech_broken =	a.MechUnit:new{Image = "units/player/batter_mech_broken.png", PosX = -20, PosY = -4 }
a.batter_mechw_broken =	a.MechUnit:new{Image = "units/player/batter_mech_w_broken.png", PosX = -17, PosY = 8 }
a.batter_mech_ns =		a.MechIcon:new{Image = "units/player/batter_mech_ns.png"}

mechPath = path .."img/units/drill/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/drill_".. file, mechPath .. file)
end

a.drill_mech =			a.MechUnit:new{Image = "units/player/drill_mech.png", PosX = -20, PosY = -3}
a.drill_mecha =			a.MechUnit:new{Image = "units/player/drill_mech_a.png", PosX = -21, PosY = -3, NumFrames = 4 }
a.drill_mechw =			a.MechUnit:new{Image = "units/player/drill_mech_w.png", PosX = -21, PosY = 7 }
a.drill_mech_broken =	a.MechUnit:new{Image = "units/player/drill_mech_broken.png", PosX = -20, PosY = -4 }
a.drill_mechw_broken =	a.MechUnit:new{Image = "units/player/drill_mech_w_broken.png", PosX = -17, PosY = 8 }
a.drill_mech_ns =		a.MechIcon:new{Image = "units/player/drill_mech_ns.png"}

mechPath = path .."img/units/tuner/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/tuner_".. file, mechPath .. file)
end

a.tuner_mech =			a.MechUnit:new{Image = "units/player/tuner_mech.png", PosX = -20, PosY = -5}
a.tuner_mecha =			a.MechUnit:new{Image = "units/player/tuner_mech_a.png", PosX = -21, PosY = -5, NumFrames = 4 }
a.tuner_mechw =			a.MechUnit:new{Image = "units/player/tuner_mech_w.png", PosX = -21, PosY = -2 }
a.tuner_mech_broken =	a.MechUnit:new{Image = "units/player/tuner_mech_broken.png", PosX = -20, PosY = -4 }
a.tuner_mechw_broken =	a.MechUnit:new{Image = "units/player/tuner_mech_w_broken.png", PosX = -17, PosY = 8 }
a.tuner_mech_ns =		a.MechIcon:new{Image = "units/player/tuner_mech_ns.png"}

-- we can make a mech based on another mech much like we did with weapons.
BatterMech = Pawn:new{
	Name = "Batter Mech",
	Class = "Prime",
	Health = 3,
	MoveSpeed = 4,
	Massive = true,
	Image = "batter_mech",
	ImageOffset = autoOffset,
	SkillList = { "Prime_TC_LongBat" },
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}
DrillMech = Pawn:new{
	Name = "Drill Mech",
	Class = "Brute",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Image = "drill_mech",
	ImageOffset = autoOffset,
	SkillList = { "Brute_RockMaker" },
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

TunerMech = Pawn:new{
	Name = "Tuner Mech",
	Class = "Science",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Flying = true,
	Image = "tuner_mech",
	ImageOffset = autoOffset,
	SkillList = { "Science_TC_Launch" },
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}