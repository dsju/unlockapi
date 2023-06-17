--Constants
UnlockAPI.Constants.PAUSE_SCREEN_COMPLETION_NUMBERS = {
    Locked = 0,
    Normal = 1,
    Hard = 2,
}

--Function (core)
function UnlockAPI.Compatibility.AddPauseScreenCompletionMarks(playerName)
    local playerType = UnlockAPI.Helper.GetPlayerTypeFromUnlockName(playerName)
    if not playerType then return end

    PauseScreenCompletionMarksAPI:AddModCharacterCallback(playerType, function()
        return UnlockAPI.Compatibility.GetPauseScreenCompletionMarksTable(playerName)
    end)
end

function UnlockAPI.Compatibility.GetPauseScreenCompletionMarksTable(playerName)
    local playerSave = UnlockAPI.Save.Characters[playerName]
    if not playerSave then return {} end

    local completionMarks = {}

    for markName, requirementType in pairs(UnlockAPI.Enums.RequirementType) do
        if UnlockAPI.Helper.FulfilledAllRequirements(requirementType, playerSave) then
            if UnlockAPI.Helper.FulfilledAllRequirements(requirementType | UnlockAPI.Enums.RequirementType.HARDMODE, playerSave) then
                completionMarks[markName] = UnlockAPI.Constants.PAUSE_SCREEN_COMPLETION_NUMBERS.Hard
            else
                completionMarks[markName] = UnlockAPI.Constants.PAUSE_SCREEN_COMPLETION_NUMBERS.Normal
            end
        else
            completionMarks[markName] = UnlockAPI.Constants.PAUSE_SCREEN_COMPLETION_NUMBERS.Locked
        end
    end

    return completionMarks
end

--Functions (helper)
function UnlockAPI.Helper.GetPlayerTypeFromUnlockName(playerName)
    local possibleTypes = {
        Isaac.GetPlayerTypeByName(playerName, false),
        Isaac.GetPlayerTypeByName(playerName, true),
        Isaac.GetPlayerTypeByName(playerName:gsub(UnlockAPI.Constants.TAINTED_PREFIX, ""), true)
    }

    for _, playerType in pairs(possibleTypes) do
        if playerType >= PlayerType.PLAYER_ISAAC then
            return playerType
        end
    end
end