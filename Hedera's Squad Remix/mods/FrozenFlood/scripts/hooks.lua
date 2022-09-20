--Full File By: NAH

local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
local scriptPath = mod.scriptPath

local this = {}

local function isClone(pawn)
  local pawnType = pawn:GetType()
  for i=0,2 do
    local pawn = Board:GetPawn(i)
    if pawn and Board:GetPawn(i):GetType()== pawnType then
      return not pawn:IsMech()
    end
  end
  return false
end

local function PawnKilled(mission, pawn)
  if isClone(pawn) then
    Board:AddAnimation(pawn:GetSpace(),"explo_fire1",ANIM_DELAY)
  end
end

function this:load(Hedera_FrozenFlood_ModApiExt)
  Hedera_FrozenFlood_ModApiExt:addPawnKilledHook(PawnKilled)
end

return this
