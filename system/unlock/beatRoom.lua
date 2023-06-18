--Classes
local game = Game()
local level = game:GetLevel()

--Function (callback)
function UnlockAPI.Callback:RoomPreSpawnCleanAward()
    if game.Challenge ~= Challenge.CHALLENGE_NULL then return end

    local roomType = game:GetRoom():GetType()
    if roomType == RoomType.ROOM_BOSSRUSH then
        UnlockAPI.Helper.UpdateUnlocks(UnlockAPI.Enums.RequirementType.BOSSRUSH)
    end

    if roomType == RoomType.ROOM_BOSS and level:GetStage() == LevelStage.STAGE7_GREED and game.Difficulty >= Difficulty.DIFFICULTY_GREED then
        UnlockAPI.Helper.UpdateUnlocks(UnlockAPI.Enums.RequirementType.GREED)
    end
end

--Init
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, UnlockAPI.Callback.RoomPreSpawnCleanAward)