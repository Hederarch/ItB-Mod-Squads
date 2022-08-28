
-- init.lua is the entry point of every mod

local mod = {
	id = "hedera_frozen_flood",
	name = "Frozen Flood",
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
    modApi:addWeaponDrop("FF_Mech_Clone")
    modApi:addWeaponDrop("FF_Science_WeakLaser")
    modApi:addWeaponDrop("FF_Ranged_Terraformer")
    modApi:addWeaponDrop("FF_Brute_XGun")

function mod:load(options, version)
	-- after we have added our mechs, we can add a squad using them.
	modApi:addSquad(
		{
			"Frozen Flood",		-- title
			"FF_CloneMech",			-- mech #1
			"FF_GlacierMech",			-- mech #2
			"FF_HailMech"			-- mech #3
		},
		"Frozen Flood",
		"A squad unearthed from the ice in an alternate Pinnacle. Their advanced weapons can easily overwhelm the Vek, but risk destroying each other.",
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod
