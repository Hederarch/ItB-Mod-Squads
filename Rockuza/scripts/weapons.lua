
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
	modApi:appendAsset("img/weapons/bat_icon.png", path .."img/weapons/bat_icon.png")
	modApi:appendAsset("img/weapons/drill_icon.png", path .."img/weapons/drill_icon.png")
	modApi:appendAsset("img/weapons/tuner_icon.png", path .."img/weapons/tuner_icon.png")

-- If we want our weapon to not have a base, we usually base it on Skill - the base for all weapons.
Prime_TC_LongBat = Skill:new{  
	Class = "Prime",
	Name = "Kinetic Bat",
	Description = "Strikes an adjacent unit, pushing it very far and damaging whatever it hits.",
	Icon = "weapons/bat_icon.png",
	LaunchSound = "/weapons/punt",
	PowerCost = 0,
	PathSize = 1,
	Damage = 1,
	Range = 1,
	TwoClick = true,
	Safe = false,
	PushAnimation = "airpush_",
	Upgrades = 2,
	UpgradeCost = { 1, 2 },
	UpgradeList = { "Ally Immune",  "+2 Damage"  },
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Enemy2 = Point(2,1),
		Target = Point(2,3),
		Second_Click = Point(2,2),
	}
}

function Prime_TC_LongBat:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		if Board:IsPawnSpace(curr) and not Board:GetPawn(curr):IsGuarding() then
			local empty_spaces = self:GetSecondTargetArea(point, curr)
			if not empty_spaces:empty() then
				ret:push_back(curr)
			end
		end
	end
	
	return ret
end

function Prime_TC_LongBat:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2,0)
	damage.sImageMark = "img/combat/icons/bat__hit_icon_"..GetDirection(p2-p1)..".png" --FIXME
	ret:AddDamage(damage)
	ret:AddMelee(p1, damage)
	return ret
end

function Prime_TC_LongBat:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local direction = GetDirection(p2 - p1)
	
	for j = -1, 1 do
		for i = 1, self.Range do
			local curr = p2 + DIR_VECTORS[(direction + j)%4]*i
			if Board:IsValid(curr) and not Board:IsBlocked(curr, PATH_FLYER) then
				ret:push_back(curr)
			end
		end
	end
	
	return ret
end

function Prime_TC_LongBat:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2,0)
	local target = GetProjectileEnd(p2,p3,PATH_PROJECTILE)
	local direction = GetDirection(p3 - p2)
	damage.sImageMark = "img/combat/icons/bat__hit_icon_"..GetDirection(p2-p1)..".png" --WHY DOES THIS NOT WORK
	ret:AddMelee(p1, damage)
	ret:AddBounce(p1,3)
	ret:AddBounce(p2,-4)
	local hit = SpaceDamage(p2,0) --separated so melee doesn't wait for animation before firing
	hit.sAnimation = "explopunch1_"..direction
	ret:AddDamage(hit)
	local move = PointList()
	move:push_back(p2)
	move:push_back(p3)
	if not Board:IsBlocked(target,PATH_PROJECTILE) then -- dont attack an empty edge square, just run to the edge
	    	doDamage = false
		    target = target + DIR_VECTORS[direction]
    	end
    	
    	ret:AddCharge(Board:GetSimplePath(p2, target - DIR_VECTORS[direction]), NO_DELAY)
	if self.Safe == true and (Board:IsPawnTeam(p2, TEAM_PLAYER) == true) then
		ret:AddDamage(SpaceDamage(target - DIR_VECTORS[direction],0))
	else
		ret:AddDamage(SpaceDamage(target - DIR_VECTORS[direction],self.Damage))
	end
	
	ret:AddBurst(p3,"Emitter_Crack_Start2",DIR_NONE)
	ret:AddBounce(p3,4)
	local impact = SpaceDamage(target,self.Damage + 1,direction) 
	if self.Safe == true and (Board:IsPawnTeam(target, TEAM_PLAYER) == true or Board:IsBuilding(target) == true) then
		impact = SpaceDamage(target,0,direction) 
		impact.iDamage = DAMAGE_ZERO
	end
	impact.sAnimation = self.PushAnimation..direction
	ret:AddDamage(impact)
	return ret
end

Prime_TC_LongBat_A = Prime_TC_LongBat:new{
	Safe = true,
	UpgradeDescription = "Impact no longer damages Grid buildings or Mechs.",
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Building = Point(2,1),
		Target = Point(2,3),
		Second_Click = Point(2,2),
	}
}

Prime_TC_LongBat_B = Prime_TC_LongBat:new{
	UpgradeDescription = "Increases Damage by 2.",
	Damage = 3
}

Prime_TC_LongBat_AB = Prime_TC_LongBat:new{
	Safe = true,
	Damage = 3,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Building = Point(2,1),
		Target = Point(2,3),
		Second_Click = Point(2,2),
	}
}

Brute_RockMaker = Skill:new{
	Name = "Excavate",
	Class = "Brute",
	Description = "Extracts a rock from a tile, cracking it.",
	Damage = 2,
	Icon = "weapons/drill_icon.png",
	Bomb = false,
	Upgrades = 1,
	UpgradeCost = {2},
	UpgradeList = { "Explosive Rocks" },
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Target = Point(2,4),
	}
}

function Brute_RockMaker:GetTargetArea(p1)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		if not Board:IsBlocked(p1 + DIR_VECTORS[i], PATH_FLYER) and not Board:IsPawnSpace(p1 + DIR_VECTORS[i])then
			ret:push_back(p1 + DIR_VECTORS[i]) --check adjacents, then check outward
		end
	end
	for dir = DIR_START, DIR_END do
		for i = 2, 8 do
			local curr = Point(p1 + DIR_VECTORS[dir] * i)
			if Board:IsBlocked(curr,PATH_PROJECTILE) then
				break
			end
			
			ret:push_back(curr)
		end
	end
	return ret
end

function Brute_RockMaker:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[dir]
	local spawnRock = Point(-1,-1)
	local behind = p1-DIR_VECTORS[dir]
	
	local dig = SpaceDamage(behind, self.Damage)
	dig.iCrack = 1
	dig.sAnimation = "explodrill"
	ret:AddDamage(dig)
	ret:AddBounce(p2,5)
	ret:AddBounce(behind,-5)
	
	for i = 1, 8 do
		if Board:IsBlocked(target,PATH_PROJECTILE) then
			local hitdamage = SpaceDamage(target,0)
			
			if target - DIR_VECTORS[dir] ~= p1 then
			    spawnRock = target - DIR_VECTORS[dir]
				hitdamage.sAnimation = "ExploAir1"
			else
				hitdamage.sAnimation = "rock1d" 
			end
			
			ret:AddProjectile(hitdamage,"effects/shot_mechrock")
			break
		end
		
		if target == p2 then
			spawnRock = target
			ret:AddProjectile(SpaceDamage(spawnRock),"effects/shot_mechrock")
			break
		end
		
		if not Board:IsValid(target) then
			spawnRock = target - DIR_VECTORS[dir]
			ret:AddProjectile(SpaceDamage(spawnRock),"effects/shot_mechrock")
			break
		end
		
		target = target + DIR_VECTORS[dir]
	end
	
	if Board:IsValid(spawnRock) then
		local damage = SpaceDamage(spawnRock)
		
		if self.Bomb == true then
			damage.sPawn = "BombRock"
		else 
			damage.sPawn = "Wall"
		end

		ret:AddDamage(damage)
		target = spawnRock
	end
	
	return ret
end

Brute_RockMaker_A = Brute_RockMaker:new{
	UpgradeDescription = "Increases Damage by 3, but makes rocks explosive.",
	Bomb = true,
	Damage = 5
}

Science_TC_Launch = Skill:new{  
	Name = "Seismic Harmonizer",
	Description = "Cracks a nearby tile and launches whatever's on it.",
	Class = "Science",
	Icon = "weapons/tuner_icon.png",
	LaunchSound = "/weapons/punt",
	PowerCost = 0,
	Damage = 1,
	Range = 2,
	TwoClick = true,
	Safe = false,
	Upgrades = 2,
	UpgradeCost = { 1, 3 },
	UpgradeList = { "Ally Immune", "+2 Range" },
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,2),
		Second_Click = Point(2,0),
	}
}

function Science_TC_Launch:GetTargetArea(point)
	--cloned from weapons_base DiamondTarget
	local size = self.Range
	local ret = PointList()
	
	local corner = point - Point(size, size)
	
	local p = Point(corner)
		
	for i = 0, ((size*2+1)*(size*2+1)) do
		local diff = point - p
		local dist = math.abs(diff.x) + math.abs(diff.y)
		if Board:IsValid(p) and dist <= size then
			ret:push_back(p)
		end
		p = p + VEC_RIGHT
		if math.abs(p.x - corner.x) == (size*2+1) then
			p.x = p.x - (size*2+1)
			p = p + VEC_DOWN
		end
	end
	
	return ret
end

function Science_TC_Launch:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2,0)
	ret:AddDamage(damage)
	return ret
end

function Science_TC_Launch:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	
	for direction = DIR_START, DIR_END do 
		for i = 1, self.Range do
			local curr = p2 + DIR_VECTORS[direction]*i
			if Board:IsValid(curr) and not Board:IsBlocked(curr, PATH_FLYER) then
				ret:push_back(curr)
			end
		end
	end
	return ret
end

function Science_TC_Launch:GetFinalEffect(p1,p2,p3)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2,0)
	local dir = GetDirection(p3 - p2)
	ret:AddBurst(p1,"Emitter_Crack_Start2",DIR_NONE)
	ret:AddBounce(p1,-4)
	damage.iCrack = 1
	damage.sAnimation = "SwipeClaw2"
	ret:AddDamage(damage)
	ret:AddBounce(p2,-4)

	if Board:IsPawnSpace(p2) == true then
		local move = PointList()
		move:push_back(p2)
		move:push_back(p3)
		ret:AddLeap(move,FULL_DELAY)
		if self.Safe == true and (Board:IsPawnTeam(p2, TEAM_PLAYER) == true) then
			local spare = SpaceDamage(p3,0)
			spare.iDamage = DAMAGE_ZERO
			ret:AddDamage(spare)
		else
			ret:AddDamage(SpaceDamage(p3,self.Damage))
		end
		ret:AddBurst(p3,"Emitter_Crack_Start2",DIR_NONE)
		ret:AddBounce(p3,4)
	end
	return ret
end

Science_TC_Launch_A = Science_TC_Launch:new{
	UpgradeDescription = "No longer damages launched Mechs.",
	Safe = true,
}

Science_TC_Launch_B = Science_TC_Launch:new{
	UpgradeDescription = "Increases Range by 2.",
	Range = 4,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Target = Point(2,3),
		Second_Click = Point(2,0),
	}
}

Science_TC_Launch_AB = Science_TC_Launch:new{
	Range = 4,
	Safe = true,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Target = Point(2,3),
		Second_Click = Point(2,0),
	}
} 