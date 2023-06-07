--Classes
local game = Game()
local level = game:GetLevel()

--Variables
local taintedSlot

--Functions (callback)
function UnlockAPI.Callback:UnlockingTaintedPostNewRoom()
    taintedSlot = nil
    if not (level:GetCurrentRoomIndex() == UnlockAPI.Constants.TAINTED_CLOSET_GRIDINDEX and level:GetStage() == LevelStage.STAGE8 and not game:GetRoom():IsSacrificeDone()) then return end

    for _, entityPlayer in pairs(Isaac.FindByType(EntityType.ENTITY_PLAYER)) do
        local player = entityPlayer:ToPlayer()
        if not UnlockAPI.Library:IsTaintedUnlocked(player:GetName()) then
            taintedSlot = UnlockAPI.Helper.TrySpawnTaintedSlot(player)
            return
        end
    end
end

function UnlockAPI.Callback:PostUnlockingTaintedUpdate()
    if not taintedSlot then return end

    local slotSprite = taintedSlot:GetSprite()
    if not slotSprite:IsFinished() then return end

    for _, entityPlayer in pairs(Isaac.FindByType(EntityType.ENTITY_PLAYER)) do
        local player = entityPlayer:ToPlayer()
        if not UnlockAPI.Helper.IsTainted(player) and not UnlockAPI.Library:IsTaintedUnlocked(player:GetName()) then
            UnlockAPI.Helper.UpdateUnlocks(UnlockAPI.Enums.RequirementType.TAINTED, player)

            local taintedData = UnlockAPI.Helper.GetTaintedData(player:GetName())
            UnlockAPI.Helper.ShowUnlock(taintedData.AchievementGfx)

            game:GetRoom():SetSacrificeDone(true)
            break
        end
    end

    taintedSlot = nil
end

--Init
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, UnlockAPI.Callback.UnlockingTaintedPostNewRoom)
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_UPDATE, UnlockAPI.Callback.PostUnlockingTaintedUpdate)