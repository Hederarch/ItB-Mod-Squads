local mod = modApi:getCurrentMod()

local palette = {
    id = mod.id,
    name = "Ice Age Blue", 
    image = "img/units/player/clone_mech.png", --change MyMech by the name of the mech you want to display
    colorMap = {
        lights =         { 175, 234, 82 }, --PlateHighlight
        main_highlight = { 141, 173,  188 }, --PlateLight
        main_light =     {  71, 102, 141 }, --PlateMid
        main_mid =       {  34,  42,  72 }, --PlateDark
        main_dark =      {  15,  12,  30 }, --PlateOutline
        metal_light =    { 167,  155,  155 }, --BodyHighlight
        metal_mid =      {  84,  71,  71 }, --BodyColor
        metal_dark =     {  37, 28, 28 }, --PlateShadow
    },
}

modApi:addPalette(palette)

 