
-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath

-- locate our mech assets.
local mechPath = path .."img/units/crusher/"

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
	modApi:appendAsset("img/units/player/crusher_".. file, mechPath .. file)
end

-- create animations for our mech with our imported files.
-- note how the animations starts searching from /img/
local a = ANIMS
a.crusher_mech =			a.MechUnit:new{Image = "units/player/crusher_mech.png", PosX = -20, PosY = -10} --subtracted 7
a.crusher_mecha =			a.MechUnit:new{Image = "units/player/crusher_mech_a.png", PosX = -21, PosY = -10, NumFrames = 4 }
a.crusher_mechw =			a.MechUnit:new{Image = "units/player/crusher_mech_w.png", PosX = -19, PosY = 6 } --added 7, 0 overall
a.crusher_mech_broken =	a.MechUnit:new{Image = "units/player/crusher_mech_broken.png", PosX = -20, PosY = -5 }
a.crusher_mechw_broken =	a.MechUnit:new{Image = "units/player/crusher_mech_w_broken.png", PosX = -21, PosY = 6 }
a.crusher_mech_ns =		a.MechIcon:new{Image = "units/player/crusher_mech_ns.png"}

mechPath = path .."img/units/bubble/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/bubble_".. file, mechPath .. file)
end

a.bubble_mech =			a.MechUnit:new{Image = "units/player/bubble_mech.png", PosX = -20, PosY = -6} --subtracted 3
a.bubble_mecha =			a.MechUnit:new{Image = "units/player/bubble_mech_a.png", PosX = -21, PosY = -6, NumFrames = 4 }
a.bubble_mechw =			a.MechUnit:new{Image = "units/player/bubble_mech_w.png", PosX = -19, PosY = 4 } --added 1, 2 overall
a.bubble_mech_broken =	a.MechUnit:new{Image = "units/player/bubble_mech_broken.png", PosX = -18, PosY = 4 }
a.bubble_mechw_broken =	a.MechUnit:new{Image = "units/player/bubble_mech_w_broken.png", PosX = -21, PosY = 5 }
a.bubble_mech_ns =		a.MechIcon:new{Image = "units/player/bubble_mech_ns.png"}

mechPath = path .."img/units/magnum/"

for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/magnum_".. file, mechPath .. file)
end

a.magnum_mech =			a.MechUnit:new{Image = "units/player/magnum_mech.png", PosX = -23, PosY = -2} 
a.magnum_mecha =			a.MechUnit:new{Image = "units/player/magnum_mech_a.png", PosX = -24, PosY = -2, NumFrames = 4 }
a.magnum_mechw =			a.MechUnit:new{Image = "units/player/magnum_mech_w.png", PosX = -22, PosY = 1 } 
a.magnum_mech_broken =	a.MechUnit:new{Image = "units/player/magnum_mech_broken.png", PosX = -23, PosY = 2 }
a.magnum_mechw_broken =	a.MechUnit:new{Image = "units/player/magnum_mech_w_broken.png", PosX = -24, PosY = 8 }
a.magnum_mech_ns =		a.MechIcon:new{Image = "units/player/magnum_mech_ns.png"}


CrusherMech = Pawn:new{
	Name = "Crusher Mech",
	Class = "Prime",
	Health = 4,
	MoveSpeed = 3,
	Massive = true,
	Image = "crusher_mech", 
	
	-- ImageOffset specifies which color scheme we will be using.
	-- (only apporpirate if you draw your mechs with Archive olive green colors)
	ImageOffset = 0,

	SkillList = { "Prime_Driver"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

BubbleMech = Pawn:new{
	Name = "Bubble Mech",
	Class = "Ranged",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Image = "bubble_mech", 
	
	ImageOffset = 0,

	SkillList = {"Ranged_ShieldArti"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}

MagnumMech = Pawn:new{
	Name = "Magnum Mech",
	Class = "Brute",
	Health = 3,
	MoveSpeed = 3,
	Massive = true,
	Image = "magnum_mech", 
	
	ImageOffset = 0,

	SkillList = {"Brute_Magnum"},
	SoundLocation = "/mech/prime/punch_mech/",
	ImpactMaterial = IMPACT_METAL,
	DefaultTeam = TEAM_PLAYER,
}