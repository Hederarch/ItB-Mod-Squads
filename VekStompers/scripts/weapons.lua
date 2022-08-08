
--[[
	some simple examples of how to start coding weapons.
	to test these weapons, you can - with this mod enabled - write in the console:
	
	weapon Weapon_Template
	weapon Weapon_Template2
	
	you can then look over the code below to see how they were made.
	you'll notice Weapon_Template looks cooler than Weapon_Template2.
	to find out more on why that is, you can look at
	Prime_Punchmech in ITB/scripts/weapons_prime.lua,
	and look at how the GetSkillEffect of this weapon is different.
]]


-- this line just gets the file path for your mod, so you can find all your files easily.
local path = mod_loader.mods[modApi.currentMod].resourcePath

-- add assets from our mod so the game can find them.
modApi:appendAsset("img/weapons/driver_icon.png", path .."img/weapons/driver_icon.png")
modApi:appendAsset("img/weapons/shield_arti_icon.png", path .."img/weapons/shield_arti_icon.png")
modApi:appendAsset("img/weapons/magnum_icon.png", path .."img/weapons/magnum_icon.png")

-- If we want our weapon to not have a base, we usually base it on Skill - the base for all weapons.
Prime_Driver = Leap_Attack:new{
	Name = "Driver Punch",
	Description = "Leaps to a unit and punches it.",
	Class = "Prime",
	Icon = "weapons/driver_icon.png",
	Range = 4,
	Damage = 2,
	SelfDamage = 0,
	SelfAnimation = "ExploAir1",
	BuildingDamage = true,
	Fire = false,
	Push = 1,
	PushAnimation = 1,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeCost = { 1 , 2 },
	UpgradeList = { "Rocket Jump",  "+2 Damage"  },
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,2),
		}
}

function Prime_Driver:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	
	if self.Fire == true then
		local launch = SpaceDamage(p1,0)
		launch.iSmoke = 1
		ret:AddBounce(p1,5)
		ret:AddDamage(launch)
	end
	
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddBurst(p1,"Emitter_Burst_$tile",DIR_NONE)
	ret:AddLeap(move, FULL_DELAY)
	ret:AddBurst(p2,"Emitter_Burst_$tile",DIR_NONE)
	
	local backwards = (dir + 2) % 4
	if p1:Manhattan(p2) ~= 1 or dir ~= backwards then
		local dam = SpaceDamage(p2 + DIR_VECTORS[dir], self.Damage)
		if self.Push == 1 then dam.iPush = dir end
		dam.sAnimation = "explosmash_"..dir
		if self.Fire == true then 
			dam.iFire = 1
		end
		if not self.BuildingDamage and Board:IsBuilding(p2 + DIR_VECTORS[dir]) then		-- Target Buildings - 
			dam.iDamage = 0
		end
		ret:AddDamage(dam)
	end

	local damage = SpaceDamage(p2, self.SelfDamage)
	damage.sAnimation = self.SelfAnimation
	if self.SelfDamage ~= 0 then ret:AddDamage(damage) end
	ret:AddBounce(p2,3)
	
	return ret
	
end


Prime_Driver_A = Prime_Driver:new{
	UpgradeDescription = "Adds Smoke to the starting tile and Fire to the target.",
	Fire = true
}
Prime_Driver_B = Prime_Driver:new{
	UpgradeDescription = "Increases Damage by 2.",
	Damage = 4,
}

Prime_Driver_AB = Prime_Driver:new{
	Damage = 4,
	Fire = true
}

Ranged_ShieldArti = ArtilleryDefault:new{
	Name = "Bubble Bolt",
	Description = "Launches an unstable bubble of force capable of forming Shields.",
	Class = "Ranged",
	Icon = "weapons/shield_arti_icon.png",
	LaunchSound = "/weapons/area_shield",
	ImpactSound = "/impact/generic/explosion",
	Range = 1, -- Tooltip?
	--PathSize = INT_MAX,
	Shield = false,
	Safe = false,
	UpShot = "effects/shot_pull_U.png",
	BuildingDamage = true,
	BounceAmount = 1,
	ArtilleryStart = 0,
	Damage = 1,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeCost = { 1 , 2 },
	UpgradeList = { "Shield Exhaust",  "Shield Friendly"  },
	--ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,1),
	}
}	

function Ranged_ShieldArti:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p1 - p2)
	local target = GetProjectileEnd(p1,p2)
	
	ret:AddBounce(p1, 1)
	if self.Shield == true then
		local back = SpaceDamage(p1 + DIR_VECTORS[direction], 0)
		back.iShield = EFFECT_CREATE
		back.sAnimation = "airpush_"..direction
		ret:AddDamage(back)
	end

	local damage = SpaceDamage(p2,self.Damage)
	damage.sAnimation = "ExploRepulse1"
	if self.Safe == true then 
		if Board:IsPawnTeam(p2, TEAM_PLAYER) == true or Board:IsBuilding(p2) == true then
			damage = SpaceDamage(p2,0)
			damage.iShield = EFFECT_CREATE
		end
	end
	ret:AddArtillery(damage, self.UpShot)
	

	for dir = DIR_START, DIR_END do
		if dir ~= direction then
			damage = SpaceDamage(p2 + DIR_VECTORS[dir], 0)
			damage.iPush = dir
			damage.sAnimation = "airpush_"..dir
			ret:AddDamage(damage)
		end
	end
	ret:AddBounce(p2, self.BounceAmount)
	
	return ret
end

Ranged_ShieldArti_A = Ranged_ShieldArti:new{
	UpgradeDescription = "Shields the tile behind the shooter.",
	Shield = true,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,4),
		Target = Point(2,1)
	}
}

Ranged_ShieldArti_B = Ranged_ShieldArti:new{
	UpgradeDescription = "Does not damage Mechs or Grid, and shields them.",
	Safe = true,
	TipImage = {
		Unit = Point(2,3),
		Building = Point(2,1),
		Target = Point(2,1)
	}
}

Ranged_ShieldArti_AB = Ranged_ShieldArti:new{
	Shield = true,
	Safe = true,
	BounceAmount = 5,
	Damage = 2,
	TipImage = {
		Unit = Point(2,3),
		Building = Point(2,1),
		Building = Point(2,4),
		Target = Point(2,1)
	}
}

Brute_Magnum = Skill:new{
	Name = "Magnum Cannon",
	Description = "Fires a powerful cannon that covers your mech in the exhaust.",
	Explo = "explopush1_",
	Icon = "weapons/magnum_icon.png",
	Class = "",
	Damage = 2,
	Smoke = 1,
	ProjectileArt = "effects/shot_shockblast",
	Push = 1,
	LaunchSound = "/weapons/modified_cannons",
	ZoneTargeting = ZONE_DIR,
	Upgrades = 2,
	UpgradeCost = { 1 , 2 },
	UpgradeList = { "Vent Smoke",  "+2 Damage"  },
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "MagnumMech",
	}
}
-- taken from TankDefault
function Brute_Magnum:GetTargetArea(p1)
	return Board:GetSimpleReachable(p1, self.PathSize, self.CornersAllowed)
end

function Brute_Magnum:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	
	if self.Smoke == 1 then
		local selfDam = SpaceDamage(p1, 0)
		selfDam.iSmoke = EFFECT_CREATE
		ret:AddDamage(selfDam)
	else
		local selfDam = SpaceDamage(p1 + DIR_VECTORS[direction], 0)
		selfDam.iSmoke = EFFECT_CREATE
		ret:AddDamage(selfDam)
	end
	
	local target = GetProjectileEnd(p1,p2)  
	
	
	local damage = SpaceDamage(target, self.Damage)
	damage.iPush = direction
	
	ret:AddProjectile(damage, self.ProjectileArt, NO_DELAY)--"effects/shot_mechtank")
	return ret
end

Brute_Magnum_A = Brute_Magnum:new{
	UpgradeDescription = "Redirects Smoke in front of the Mech when firing.",
	Smoke = 0
}

Brute_Magnum_B = Brute_Magnum:new{
	UpgradeDescription = "Increases Damage by 2",
	Damage = 4
}

Brute_Magnum_AB = Brute_Magnum:new{
	Smoke = 0,
	Damage = 4
}
