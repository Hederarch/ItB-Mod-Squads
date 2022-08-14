
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
modApi:appendAsset("img/weapons/clone_icon.png", path .."img/weapons/clone_icon.png")
modApi:appendAsset("img/weapons/rink_icon.png", path .."img/weapons/rink_icon.png")
modApi:appendAsset("img/weapons/hail_icon.png", path .."img/weapons/hail_icon.png")
modApi:appendAsset("img/weapons/dazzle_icon.png", path .."img/weapons/dazzle_icon.png")

-- If we want our weapon to not have a base, we usually base it on Skill - the base for all weapons.

--
Mech_Clone = Skill:new{
	Name = "Clone Cannon",
	Description = "Deploys a copy of the Mech that uses it, though clones cannot make more clones.",
	Icon = "weapons/clone_icon.png",
	Rarity = 1,
	Limited = 1,
	Range = 4,
	PowerCost = 2,
	Upgrades = 2,
	Safe = false,
	UpgradeCost = { 1, 2 },
	UpgradeList = { "No Self Damage",  "+1 Use"  },
	LaunchSound = "/weapons/deploy_tank",
	ImpactSound = "/impact/generic/mech",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		CustomPawn = "CloneMech"
	},
}

function Mech_Clone:GetTargetArea(point)
	-- standard LineArtillery targeting
	local ret = PointList()
	
	for dir = DIR_START, DIR_END do
		for i = 2, self.Range do
			local curr = Point(point + DIR_VECTORS[dir] * i)
			if not Board:IsValid(curr) then
				break
			end
			
			if not self.OnlyEmpty and not Board:IsBlocked(curr,PATH_GROUND) and not Board:IsPawnSpace(curr) then
				ret:push_back(curr)
			end

		end
	end
	
	return ret
end

local function IsTipImage()
  return Board:GetSize() == Point(6,6)
end

function Mech_Clone:GetSkillEffect(p1,p2)
	local ret = SkillEffect()	
	local mech_type = Pawn:GetType()
	
	local self_damage = SpaceDamage(p1,1)
	if self.Safe == true then
		self_damage = SpaceDamage(p1,0)
	end
		ret:AddBurst(p1, "Emitter_Confuse1", DIR_NONE)
		ret:AddBounce(p1,4)
		ret:AddDamage(self_damage)
	
	if Pawn:GetId() <= 2 or IsTipImage()then
		local damage = SpaceDamage(p2,0)
			damage.sAnimation = "explodrill"
			ret:AddArtillery(damage,"effects/shotup_waterdrill.png")
			ret:AddBounce(p2,4)
			
			damage.sPawn = mech_type
			ret:AddDamage(damage)
									--TODO: FIGURE OUT HOW TO GRAB CLONE
	end
	return ret
end

Mech_Clone_A = Mech_Clone:new{
	UpgradeDescription = "No longer damages Mech when firing.",
	Safe = true
}

Mech_Clone_B = Mech_Clone:new{
	UpgradeDescription = "Allows 1 additional use.",
	Limited = 2,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		CustomPawn = "CloneMech",
		Second_Origin = Point(2,3),
		Second_Target = Point(2,0),
	},
}

Mech_Clone_AB = Mech_Clone:new{
	Safe = true,
	Limited = 2,
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		CustomPawn = "CloneMech",
		Second_Origin = Point(2,3),
		Second_Target = Point(2,0),
	},
}

-- cloned from LaserDefault, just pasted to add confusion and no building damage.
Science_WeakLaser = LaserDefault:new{
	Name = "Dazzle Laser",
	Description = "Fires a weak laser that disorients Vek.",
	LaserArt = "effects/laserbend", 
	LaunchSound = "/weapons/bend_beam",
	Damage = 1,
	Icon = "weapons/dazzle_icon.png",
	PowerCost = 1,
	MinDamage = 1,
	FriendlyDamage = true,
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,1),
		Building = Point(2,0),
		Target = Point(2,2),
		Queued1 = Point(1,2),
		Queued2 = Point(3,1),
	}
}

function Science_WeakLaser:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[direction]
	
	self:AddLaser(ret, target, direction)
	
	return ret
end


function Science_WeakLaser:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[dir]
		while Board:GetTerrain(curr) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(curr) and Board:IsValid(curr) do
			ret:push_back(curr)
			curr = curr + DIR_VECTORS[dir]
		end
		
		if Board:IsValid(curr) then
			ret:push_back(curr)
		end
	end
	
	return ret
end

function Science_WeakLaser:AddLaser(ret,point,direction,queued,forced_end)
	local queued = queued or false
	local minDamage = self.MinDamage or 1
	local damage = self.Damage
	local start = point - DIR_VECTORS[direction]

	while Board:IsValid(point) and not (Board:IsBuilding(point) and not Board:IsFrozen(point)) do --allow breaking ice on buildings
	
		local temp_damage = damage  --This is so that if damage is set to 0 because of an ally, it doesn't affect the damage calculation of the laser.
		
		if not self.FriendlyDamage and Board:IsPawnTeam(point, TEAM_PLAYER) then
			temp_damage = DAMAGE_ZERO
		end
		
		local dam = SpaceDamage(point, temp_damage, DIR_FLIP)
		
		-- if it's the end of the line (ha), add the laser art -- not pretty
		if forced_end == point or (Board:IsBuilding(point + DIR_VECTORS[direction]) and not Board:IsFrozen(point + DIR_VECTORS[direction])) or Board:GetTerrain(point) == TERRAIN_MOUNTAIN or not Board:IsValid(point + DIR_VECTORS[direction]) then
			if queued then 
				ret:AddQueuedProjectile(dam,self.LaserArt)
			else
				ret:AddProjectile(start,dam,self.LaserArt,FULL_DELAY)
			end
			break
		else
			if queued then
				ret:AddQueuedDamage(dam)  
			else
				ret:AddDamage(dam)   --JUSTIN TEST
			end
		end
		
		damage = damage - 1
		if damage < minDamage then damage = minDamage end
					
		point = point + DIR_VECTORS[direction]	
	end
end

Ranged_Terraformer = LineArtillery:new{
	Name = "Rink Artillery",
	Description = "Fires a projectile that converts surrounding tiles into ice and freezes nearby Mechs.",
	Range = RANGE_ARTILLERY,	
	UpShot = "effects/shotup_ice.png",
	Class = "Ranged", 
	Icon = "weapons/rink_icon.png",
	ArtilleryStart = 2,
	ArtillerySize = 8,
	BounceAmount = 3,
	BuildingDamage = true,
	Push = 1,
	WideArea = 0,
	DamageOuter = 0,
	DamageCenter = 1,
	Damage = 2,---USED FOR TOOLTIPS
	Explosion = "",
	ExplosionCenter = "ExploArt1",
	ExplosionOuter = "",
	OuterAnimation = "airpush_",
	Upgrades = 2,
	UpgradeCost = { 1, 3 },
	UpgradeList = {"+1 Size", "+2 Size"},
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Target = Point(2,2),
		Building = Point(0,2),
		Building1 = Point(4,2),
		Friendly = Point(2,1)
	}
}

function Ranged_Terraformer:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
		local hit = SpaceDamage(p2,2,dir)
		hit.sAnimation = "ExploRepulse1"
		hit.iTerrain = TERRAIN_ICE
		ret:AddArtillery(hit, self.UpShot)
		ret:AddBounce(p2,4)
	if self.WideArea > 0 then
	local spread = SpaceDamage(p2,1)
	
	spread.iTerrain = TERRAIN_ICE
	ret:AddDelay(0.2)
	
		for i = DIR_START, DIR_END do
			ret:AddDelay(0.02)
			spread.loc = p2 + DIR_VECTORS[i]
			spread.sAnimation = "ExploRepulseSmall"
			self:IceSelect(ret,spread)
			
			
			if self.WideArea > 1 then
				ret:AddDelay(0.02)
				spread.loc = p2 + DIR_VECTORS[i] + DIR_VECTORS[i]
				self:IceSelect(ret,spread)
				ret:AddDelay(0.02)
				spread.loc = p2 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]
				self:IceSelect(ret,spread)
				
			end
			if self.WideArea > 2 then
				ret:AddDelay(0.02)
				spread.loc = p2 + DIR_VECTORS[i]*3
				self:IceSelect(ret,spread)
				ret:AddDelay(0.02)
				spread.loc = p2 + DIR_VECTORS[i]*2 + DIR_VECTORS[(i+1)%4]
				self:IceSelect(ret,spread)
				ret:AddDelay(0.02)
				spread.loc = p2 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]*2
				self:IceSelect(ret,spread)
				
			end
		end
	end
	return ret	
end

function Ranged_Terraformer:IceSelect(ret,spread)
	local point = spread.loc
	
	if Board:IsValid(point)then
		if	(Board:IsBuilding(point) and not Board:IsFrozen(point)) then --don't damage buildings 
			local spare = SpaceDamage(point,0)
			spare.sAnimation =  "ExploRepulse1"
			ret:AddDamage(spare)
		elseif Board:IsPawnSpace(point) and Board:IsPawnTeam(point, TEAM_PLAYER)  then -- freeze NPCs and mechs
			local unit = Board:GetPawn(point)
			local spare = SpaceDamage(point,0)
			spare.sAnimation =  "ExploRepulse1"
			spare.iFrozen = 1
			ret:AddDamage(spare)
		elseif Board:IsTerrain(point,TERRAIN_ICE) or Board:IsTerrain(point,TERRAIN_MOUNTAIN) then --do not convert ice to ice, crack ice instead
			local alt = SpaceDamage(point,1)
			alt.sAnimation = "ExploRepulseSmall"
			ret:AddBounce(point,4)
			ret:AddDamage(alt)
		elseif not Board:IsBuilding(point) then
			ret:AddDamage(spread)
			ret:AddBounce(point,4)
		end
	end
end

local function IsVolcano(point)
	if IsTipImage() then
		return false
	end
	if Board:GetCustomTile(Point(1,1)) == "supervolcano.png" then
		if point == Point(0,0) or
		point == Point(0,1) or
		point == Point(1,0) or
		point == Point(1,1) then
			return true
		end
	end
	return false
end

Ranged_Terraformer_A = Ranged_Terraformer:new{
	UpgradeDescription = "Increases converted area by 1.",
	WideArea = 1
}

Ranged_Terraformer_B = Ranged_Terraformer:new{
	UpgradeDescription = "Increases converted area by 2.",
	WideArea = 2
}

Ranged_Terraformer_AB = Ranged_Terraformer:new{
	WideArea = 3
}

Brute_XGun = Skill:new{
	Name = "Hail Charge",
	Description = "Fires a payload that releases a rocket barrage over a wide area, avoiding buildings.",
	Class = "Brute",
	ProjectileArt = "effects/shot_sniper",
	Icon = "weapons/hail_icon.png",
	UpShot = "effects/shotup_smallbullet_missile.png",
	Damage = 1,
	Explosion = "ExploAir1",
	Waves = 1,
	Upgrades = 2,
	UpgradeCost = { 2, 2 },
	UpgradeList = {"Bigger Burst","Bigger Burst"},
	TipImage = {
		Unit = Point(2,4),
		Enemy1 = Point(2,2),
		Target = Point(2,3),
	},
	ZoneTargeting = ZONE_DIR,
	Range = RANGE_PROJECTILE,
	PathSize = INT_MAX,
}

function Brute_XGun:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local target = GetProjectileEnd(p1,p2,PATH_PROJECTILE)  
	
	local leader = SpaceDamage(target,self.Damage,dir)
	ret:AddAnimation(target,"ExploRepulseSmall2")
	ret:AddProjectile(leader, self.ProjectileArt, FULL_DELAY)
	ret:AddAnimation(target,"ExploRepulse2")
	
	local spread = SpaceDamage (target,1)
	spread.sAnimation = self.Explosion
	self:AvoidBuilding(ret,spread,target,1,1)

	if self.Waves > 1 then
		ret:AddDelay(0.3)
		self:AvoidBuilding(ret,spread,target,0,2)
	end
	
	if self.Waves > 2 then
		ret:AddDelay(0.3)
		self:AvoidBuilding(ret,spread,target,2,2)
	end
	
	
	return ret
end

function Brute_XGun:AvoidBuilding(ret,damage,target,diag_coeff,orth_coeff)
	for i = DIR_START,DIR_END do
		local selector = target + DIR_VECTORS[i]*orth_coeff + DIR_VECTORS[(i+1)%4]*diag_coeff
		if not Board:IsValid(selector) or Board:IsPawnSpace(selector) and (Board:GetPawn(selector):GetType() == "Train_Pawn" or Board:GetPawn(selector):GetType() == "Train_Damaged") then
			-- should not have an empty line here, do anyway. i know it's bad practice, leave me alone this is already too complex
		elseif  Board:IsBuilding(selector) and not Board:IsFrozen(selector) then
			local spare = SpaceDamage(selector,0)
			spare.sAnimation = "ExploRepulseSmall2"
			ret:AddArtillery(target,spare,self.UpShot,NO_DELAY)
			ret:AddBounce(target,6)
		else
			damage.loc = selector 
			ret:AddArtillery(target,damage,self.UpShot,NO_DELAY)
			ret:AddBounce(target,6)
		end
	end
end

Brute_XGun_A = Brute_XGun:new{
	UpgradeDescription = "Increases Damage by 1 and releases more rockets.",
	Waves = 2,
	Damage = 2,
}

Brute_XGun_B = Brute_XGun:new{
	UpgradeDescription = "Increases Damage by 1 and releases more rockets.",
	Waves = 2,
	Damage = 2,
}

Brute_XGun_AB = Brute_XGun:new{
	Waves = 3,
	Damage = 3,
}