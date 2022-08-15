local mod = modApi:getCurrentMod()

local palette = {
    id = mod.id,
    name = "Home Run Gold", 
    image = "img/units/player/batter_mech.png", --change MyMech by the name of the mech you want to display
    colorMap = {
        lights =         { 29, 234, 147 }, --PlateHighlight
        main_highlight = { 232, 174,  29 }, --PlateLight
        main_light =     {  157,  88,  17 }, --PlateMid
        main_mid =       {  108,  38,  7 }, --PlateDark
        main_dark =      {  73,  29,  3 }, --PlateOutline
        metal_light =    { 102,  102,  102 }, --BodyHighlight
        metal_mid =      {  74,  67,  67 }, --BodyColor
        metal_dark =     {  46, 34, 34 }, --PlateShadow
    },
}

modApi:addPalette(palette)

 