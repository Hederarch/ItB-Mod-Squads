local mod = modApi:getCurrentMod()

local palette = {
    id = mod.id,
    name = "Ripsaw Red", 
    image = "img/units/player/saw_mech.png", --change MyMech by the name of the mech you want to display
    colorMap = {
        lights =         { 119, 211, 68 }, --PlateHighlight
        main_highlight = { 197, 101,  101 }, --PlateLight
        main_light =     {  98,  46,  65 }, --PlateMid
        main_mid =       {  58,  15,  59 }, --PlateDark
        main_dark =      {  16,  2,  25 }, --PlateOutline
        metal_light =    { 163,  167,  154 }, --BodyHighlight
        metal_mid =      {  82,  88,  65 }, --BodyColor
        metal_dark =     {  31, 35, 21 }, --PlateShadow
    },
}

modApi:addPalette(palette)

 