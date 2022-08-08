
-- init.lua is the entry point of every mod

local mod = {
	id = "apollo_pilot",
	name = "Apollo the Chessmaster",
	version = "1.0.0",
	requirements = {},
	modApiVersion = "2.3.0",
	icon = "img/mod_icon.png"
}

function mod:init()
	-- look in template/pilot to see how to code pilots.
	require(self.scriptPath .."pilot")
end

function mod:load(options, version)
end

return mod
