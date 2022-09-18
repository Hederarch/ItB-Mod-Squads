
-- init.lua is the entry point of every mod

local mod = {
	id = "hedera_bio_butchers",
	name = "Bio Butchers",
	version = "0.1.0",
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
    modApi:addWeaponDrop("BB_Ranged_Return")
    modApi:addWeaponDrop("BB_Prime_HolePunch")
    modApi:addWeaponDrop("BB_Science_Rupture")


function mod:load(options, version)
	-- after we have added our mechs, we can add a squad using them.
	modApi:addSquad(
		{
			"Bio Butchers",		-- title
			"BB_SawMech",			-- mech #1
			"BB_BucklerMech",			-- mech #2
			"BB_RuptureMech"			-- mech #3
		},
		"Bio Butchers",
		"A squad meant to use the raw material of the vek against them, strategically disassembling their enemies in combat.",
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod
