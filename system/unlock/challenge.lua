--Classes
local game = Game()
local level = game:GetLevel()

--Functions (callback)
function UnlockAPI.Callback:ChallengePreClearAward()
    local challengeData = UnlockAPI.Challenges[game.Challenge]
    if not (challengeData and UnlockAPI.Helper.CurrentRoomFulfillsUnfinishedChallengeRequirements(challengeData)) then return end
    UnlockAPI.Helper.FinishChallenge(challengeData)
end

--Functions (helper)
function UnlockAPI.Helper.CurrentRoomFulfillsUnfinishedChallengeRequirements(challengeData)
    return
    not UnlockAPI.Save.Challenges[challengeData.Name]
    and level:GetStage() >= challengeData.FinalFloor
    and game:GetRoom():GetType() == RoomType.ROOM_BOSS
end

function UnlockAPI.Helper.FinishChallenge(challengeData)
    UnlockAPI.Save.Challenges[challengeData.Name] = true
    UnlockAPI.Helper.ShowUnlock(challengeData.AchievementGfx)
end

--Init
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, UnlockAPI.Callback.ChallengePreClearAward)