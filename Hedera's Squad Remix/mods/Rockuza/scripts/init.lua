
-- init.lua is the entry point of every mod

local mod = {
	id = "hedera_rockuza_squad",
	name = "Rockuza",
	version = "1.0.0",
	requirements = {},
	modApiVersion = "2.3.0",
	icon = "img/mod_icon.png"
}

function mod:init()
	-- look in template/mech to see how to code mechs.
	require(self.scriptPath .."palettes")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."weapons")
end

--New shop
    modApi:addWeaponDrop("RZ_Prime_TC_LongBat")
    modApi:addWeaponDrop("RZ_Brute_RockMaker")
    modApi:addWeaponDrop("RZ_Science_TC_Launch")

function mod:load(options, version)
	-- after we have added our mechs, we can add a squad using them.
	modApi:addSquad(
		{
			"Rockuza",		-- title
			"RZ_BatterMech",			-- mech #1
			"RZ_DrillMech",			-- mech #2
			"RZ_TunerMech"			-- mech #3
		},
		"Rockuza",
		"A squad repurposing R.S.T. technology into flashy weapons to rapidly shift the battlefield.",
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod
