
-- init.lua is the entry point of every mod

local mod = {
	id = "rockuza_squad",
	name = "Rockuza",
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

function mod:load(options, version)
	-- after we have added our mechs, we can add a squad using them.
	modApi:addSquad(
		{
			"Rockuza",		-- title
			"BatterMech",			-- mech #1
			"DrillMech",			-- mech #2
			"TunerMech"			-- mech #3
		},
		"Rockuza",
		"A squad repurposing R.S.T. technology into flashy weapons to rapidly shift the battlefield.",
		self.resourcePath .."img/mod_icon.png"
	)
end

return mod
