UnlockAPI.Constants.STRING_TO_UNLOCK_TABLE = {
    collectible = "Collectibles",
    trinket = "Trinkets",
    entity = "Entities",
    card = "Cards",
    customentry = "CustomEntry",
    tainted = "TaintedCharacters",
}

--Function (callback)
function UnlockAPI.Callback:ExecuteUnlockCommand(start, cmd)
    if start ~= "unlockapi" then return end

    local unlocking, string = UnlockAPI.Helper.GetStringAndIfUnlocking(cmd)
    if not string then return end

    local unlockData = UnlockAPI.Helper.GetUnlockDataFromCommandString(string)
    if not unlockData then print("This isn't a registered achievement!") return end

    local playerName = unlockData.PlayerName or unlockData.NormalPlayerName
    local isUnlocked = UnlockAPI.Helper.FulfilledAllRequirements(unlockData.UnlockRequirements, UnlockAPI.Helper.GetPlayerUnlockData(playerName))

    if unlocking then
        if isUnlocked then print("Achievement already unlocked!") return end
        UnlockAPI.Helper.SetRequirements(unlockData.UnlockRequirements, playerName, true)
        UnlockAPI.Helper.ShowUnlock(unlockData.AchievementGfx)
    else
        if not isUnlocked then print("Achievement already locked!") return end
        UnlockAPI.Helper.SetRequirements(unlockData.UnlockRequirements, playerName, nil)
    end

    print("Done!")
    return true
end

--Function (helper)
function UnlockAPI.Helper.GetStringAndIfUnlocking(cmd)
    if cmd:find("lockall") then return end

    local subbedStringUnlock = cmd:gsub("unlock", "")
    local subbedStringLock = cmd:gsub("lock", "")

    if subbedStringUnlock ~= cmd then
        return true, subbedStringUnlock
    elseif subbedStringLock ~= cmd then
        return false, subbedStringLock
    end
end

function UnlockAPI.Helper.GetUnlockDataFromCommandString(cmdString)
    for unlockName, unlockTableName in pairs(UnlockAPI.Constants.STRING_TO_UNLOCK_TABLE) do
        local subbedString = cmdString:gsub(" " .. unlockName .. " ", "")
        if subbedString ~= cmdString then
            local unlockId = tonumber(subbedString) or subbedString
            return UnlockAPI.Unlocks[unlockTableName][unlockId]
        end
    end
end

UnlockAPI.Mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, UnlockAPI.Callback.ExecuteUnlockCommand)