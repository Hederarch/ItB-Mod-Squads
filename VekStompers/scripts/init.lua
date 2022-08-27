
-- init.lua is the entry point of every mod

local mod = {
	id = "vek_stompers",
	name = "Vek Stompers",
	version = "0.9.0",
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
    modApi:addWeaponDrop("Prime_Driver")
    modApi:addWeaponDrop("Ranged_ShieldArti")
    modApi:addWeaponDrop("Brute_Magnum")

function mod:load(options, version)
	-- after we have added our mechs, we can add a squad using them.
	modApi:addSquad(
		{
			"Vek Stompers",		-- title
			"CrusherMech",			-- mech #1
			"BubbleMech",			-- mech #2
			"MagnumMech"			-- mech #3
		},
		"Vek Stompers",
		"The rejected prototypes of the Rift Walkers. Their weapons' drawbacks require constant repositioning.",
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod
