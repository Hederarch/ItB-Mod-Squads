
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
modApi:appendAsset("img/weapons/skewer_icon.png", path .."img/weapons/skewer_icon.png")
modApi:appendAsset("img/weapons/saw_icon.png", path .."img/weapons/saw_icon.png")
modApi:appendAsset("img/weapons/rupture_icon.png", path .."img/weapons/rupture_icon.png")
modApi:appendAsset("img/effects/shot_saw.png", path .."img/effects/shot_saw.png")
modApi:appendAsset("img/effects/shot_saw_U.png", path .."img/effects/shot_saw_U.png")
modApi:appendAsset("img/effects/shot_saw_R.png", path .."img/effects/shot_saw_R.png")
modApi:appendAsset("img/effects/shot_saw_heal_U.png", path .."img/effects/shot_saw_heal_U.png")
modApi:appendAsset("img/effects/shot_saw_heal_R.png", path .."img/effects/shot_saw_heal_R.png")
modApi:appendAsset("img/effects/blood_shot_U.png", path .."img/effects/blood_shot_U.png")
modApi:appendAsset("img/effects/blood_shot_R.png", path .."img/effects/blood_shot_R.png")

-- If we want our weapon to not have a base, we usually base it on Skill - the base for all weapons.
BB_Ranged_Return = LineArtillery:new{
	Name = "Buzzsaw Blaster",
	Description = "Fires a returning saw that damages Vek between the target and the shooter.",
	Class = "Ranged",
	Icon = "weapons/saw_icon.png",
	Rarity = 1,
	Damage = 1,
	KO = false,
	PowerCost = 0, --AE Change
	UpShot = "effects/shot_saw.png",
	ProjectileArt = "effects/shot_saw",
	ProjectileHeal = "effects/shot_saw_heal",
	Explosion = "",
	ExploArt = "explopush1_",
	LaunchSound = "/weapons/modified_cannons",
	ImpactSound = "/impact/generic/explosion",
	KOSound = "/weapons/brute_ko_combo",
	BounceAmount = 2,
	Upgrades = 2,
	UpgradeCost = {1,2},
	UpgradeList = { "Harvest", "+2 Damage"  },
	Damage = 1,
	BuildingDamage = true,
	Sides = false,
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,1),
		Enemy2 = Point(2,2),
		Target = Point(2,1),
		Second_Origin = Point(2,4),
		Second_Target = Point(2,1),
		CustomEnemy = "Leaper1",
	}
}

function BB_Ranged_Return:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local backDir = GetDirection(p1 - p2)
	local backTarget = GetProjectileEnd(p2,p1,PATH_PROJECTILE) 
	local projectileType = self.ProjectileArt
	
	ret:AddBounce(p1,2)
	arty = SpaceDamage(p2,self.Damage,dir)
	arty.sAnimation = "airpush_"..dir
	ret:AddArtillery(arty,self.UpShot)
	ret:AddBounce(p2,2)
	
	local backShot = SpaceDamage(backTarget,1,backDir)
	backShot.sAnimation = "airpush_"..backDir
		if Board:GetPawnTeam(backTarget) == TEAM_PLAYER or Board:IsBuilding(backTarget) then
			if self.KO == true and Board:IsDeadly(arty, Pawn) then
				backShot = SpaceDamage(backTarget,-1)
				backShot.bKO_Effect = true
				backShot.sAnimation = "ExploAcid1"
				ret:AddProjectile(p2,backShot,self.ProjectileHeal) 
			else 
				backShot = SpaceDamage(backTarget,0)
				backShot.iDamage = DAMAGE_ZERO
				backShot.sAnimation = "airpush_"..backDir
				ret:AddProjectile(p2,backShot,self.ProjectileArt) 
			end
		else
			ret:AddProjectile(p2,backShot,self.ProjectileArt) 
		end
	
	if backTarget ~= p1 then --visual rebound
		local rebound = SpaceDamage(p1,0)
		rebound.bHidePath = true
		rebound.sAnimation = "airpush_"..backDir
		ret:AddArtillery(backTarget,rebound,self.UpShot)
		ret:AddBounce(p1,2)
	end
	return ret
end

BB_Ranged_Return_A = BB_Ranged_Return:new{
	UpgradeDescription = "Return projectile heals allies when dealing lethal damage.",
	KO = true,
	OnKill = "Projectile Heals",
 	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(2,1),
		Target = Point(2,1),
		Second_Origin = Point(2,3),
		Second_Target = Point(2,1),
		CustomEnemy = "Leaper1",
	}
}

BB_Ranged_Return_B = BB_Ranged_Return:new{
	UpgradeDescription = "Increases artillery Damage by 2.",
	Damage = 3
}

BB_Ranged_Return_AB = BB_Ranged_Return:new{

	KO = true,
	OnKill = "Projectile Heals",
	Damage = 3,
 	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(2,1),
		Target = Point(2,1),
		Second_Origin = Point(2,3),
		Second_Target = Point(2,1),
		CustomEnemy = "Firefly1",
	}
}

BB_Prime_HolePunch = Prime_Punchmech:new{
	Name = "Hole Punch",
	Description = "Pierces through an adjacent Vek, launching the result as a projectile.",
	Class = "Prime",
	Icon = "weapons/skewer_icon.png",
	Rarity = 3,
	Explosion = "",
	ProjectileArt = "effects/blood_shot",
	LaunchSound = "/weapons/titan_fist",
	Range = 1, -- Tooltip?
	PathSize = 1,
	Damage = 2,
	Push = false,
	KO = false,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Harvest",  "Add Force"  },
	UpgradeCost = {1,2},
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(2,2),
		Target = Point(2,2)
	}
}

function BB_Prime_HolePunch:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local target = GetProjectileEnd(p2,p2+DIR_VECTORS[dir],PATH_PROJECTILE) 
	
	punch = SpaceDamage(p2,self.Damage)
	if self.Push == true then
		punch = SpaceDamage(p2,self.Damage,dir)
	end
	punch.sAnimation = "explospear1_"..dir
	ret:AddDamage(punch)
	
	if Board:IsPawnSpace(p2)then
		projectile = SpaceDamage(target,1,dir)
		if Board:GetPawnTeam(target) == TEAM_PLAYER or Board:IsBuilding(target) then
			if self.KO == true and Board:IsDeadly(punch, Pawn) then
				projectile = SpaceDamage(target,-1)
				projectile.bKO_Effect = true
				projectile.sAnimation = "ExploAcid1"
			else 
				projectile = SpaceDamage(target,0)
				projectile.iDamage = DAMAGE_ZERO
				projectile.sAnimation = "airpush_"..dir
			end
		else
		projectile.sAnimation = "explopush1_"..dir
		end
		
		ret:AddProjectile(p2,projectile,self.ProjectileArt) 
	end
	

	
	return ret
end 

BB_Prime_HolePunch_A = BB_Prime_HolePunch:new{
	UpgradeDescription = "Projectile heals allies when dealing lethal damage.",
	KO = true,
	OnKill = "Projectile Heals",
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(2,2),
		Target = Point(2,2),
		Friendly = Point(2,0),
		CustomEnemy = "Firefly1",
		Second_Origin = Point(2,3),
		Second_Target = Point(2,2),
	}
}

BB_Prime_HolePunch_B = BB_Prime_HolePunch:new{
	UpgradeDescription = "Pushes target and adds 1 Damage.",
	Damage = 3,
	Push = true,
}

BB_Prime_HolePunch_AB = BB_Prime_HolePunch:new{
	UpgradeDescription = "Projectile heals when dealing lethal damage.",
	KO = true,
	Push = true,
	OnKill = "Projectile Heals",
	Damage = 3,
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(2,2),
		Target = Point(2,2),
		Friendly = Point(2,0),
		CustomEnemy = "Firefly1",
	}
}

BB_Science_Rupture = Skill:new{
	Name = "Nano Detonator",
	Description = "Remotely detonates local nanites, exploding Vek from the inside out.",
	Class = "Science",
	Icon = "weapons/rupture_icon.png",
	PathSize = 8,
	PowerCost = 0,
	Damage = 1,
	Upgrades = 2,
	Fire = 0,
	Safe = false,
	UpgradeCost = {1,2},
	UpgradeList = { "Building Immune", "Add Fire" },
	LaunchSound = "/weapons/push_beam",
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(2,1),
		Enemy2 = Point(1,1),
		Enemy3 = Point(3,1),
		Target = Point(2,1),
	}
}

function BB_Science_Rupture:GetTargetArea(point)
	local ret = PointList()
	
	for i = DIR_START, DIR_END do
		for k = 1, 8 do
			local curr = DIR_VECTORS[i]*k + point
			if Board:IsValid(curr) then
				ret:push_back(DIR_VECTORS[i]*k + point)
			end
		end
	end
	
	return ret
end

function BB_Science_Rupture:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, self.Damage)
	if Board:IsBuilding(p2) and self.Safe then
		damage = SpaceDamage(p2, 0)
		damage.iDamage = 0
	end
	damage.sAnimation = "ExploRaining1"
	damage.iFire = self.Fire
	
	
	local vfx = SpaceDamage(p1,0)
	vfx.sAnimation = "ExploRepulseSmall"
	for i = 0,2,1 do
	ret:AddDamage(vfx)
	ret:AddBounce(p1,-(i+1)*2)
	ret:AddBounce(p2,-(i+1)*2)
	ret:AddDelay(0.4)
	end
	ret:AddDamage(damage)
	
	ret:AddBounce(p2, 4)
	ret:AddBoardShake(0.15)
	
	local damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], 0, (dir+1)%4)
	damagepush.sAnimation = "airpush_"..((dir+1)%4)
	ret:AddDamage(damagepush) 
	damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], 0, (dir-1)%4)
	damagepush.sAnimation = "airpush_"..((dir-1)%4)
	ret:AddDamage(damagepush)
	
	return ret
end

 BB_Science_Rupture_A =  BB_Science_Rupture:new{
	UpgradeDescription = "No longer damages buildings",
	Safe = true,
		TipImage = {
		Unit = Point(2,3),
		Building = Point(2,1),
		Enemy1 = Point(1,1),
		Enemy2 = Point(3,1),
		Queued1 = Point(2,1),
		Queued2 = Point(2,1),
		Target = Point(2,1),
	}
 }
 
  BB_Science_Rupture_B =  BB_Science_Rupture:new{
	UpgradeDescription = "Detonantion lights target on Fire.",
	Fire = 1
 }
 
   BB_Science_Rupture_AB =  BB_Science_Rupture:new{
	Safe = true,
	Fire = 1
 }