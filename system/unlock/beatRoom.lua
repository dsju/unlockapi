--Classes
local game = Game()
local level = game:GetLevel()

--Function (callback)
function UnlockAPI.Callback:RoomPreSpawnCleanAward()
    local roomType = game:GetRoom():GetType()
    if roomType == RoomType.ROOM_BOSSRUSH then
        UnlockAPI.Helper.UpdateUnlocks(UnlockAPI.Enums.RequirementType.BOSSRUSH)
    elseif level:GetStage() == LevelStage.STAGE7_GREED and roomType == RoomType.ROOM_BOSS and game.Difficulty >= Difficulty.DIFFICULTY_GREED then
        UnlockAPI.Helper.UpdateUnlocks(UnlockAPI.Enums.RequirementType.GREED)
    end
end

--Init
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, UnlockAPI.Callback.RoomPreSpawnCleanAward)