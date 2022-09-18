local mod = modApi:getCurrentMod()

local palette = {
    id = mod.id,
    name = "Vekticide Green", 
    image = "img/units/player/crusher_mech.png", --change MyMech by the name of the mech you want to display
    colorMap = {
        lights =         { 215, 185, 58 }, --PlateHighlight
        main_highlight = { 88, 141,  94 }, --PlateLight
        main_light =     {  49,  100,  75 }, --PlateMid
        main_mid =       {  20,  58,  54 }, --PlateDark
        main_dark =      {  5,  20,  28 }, --PlateOutline
        metal_light =    { 109,  133,  135 }, --BodyHighlight
        metal_mid =      {  61,  82,  93 }, --BodyColor
        metal_dark =     {  34, 45, 65 }, --PlateShadow
    },
}

modApi:addPalette(palette)

 