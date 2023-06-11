--Function (callback)
function UnlockAPI.Callback:ExecuteUnlockAllCommand(start, cmd)
    if start ~= "unlockapi" then return end

    local unlocking, mod = UnlockAPI.Helper.GetStringAndIfUnlockingAll(cmd)
    if not mod then return end

    local consoleText = unlocking and "Unlocking" or "Locking"

    if UnlockAPI.ModRegistry[mod] then
        print(consoleText .. " all achievements of the " .. mod .. " mod.")
    elseif mod == "" then
        print(consoleText .. " all achievements of every registered mod.")
    else
        print(mod .. [[ isn't a valid mod. Please use a valid name. Names are case-sensitive. Registered mod names: ]]) 
        print(UnlockAPI.Helper.GetRegisteredModNames())
        return true
    end

    UnlockAPI.Helper.SetAllModUnlocks(UnlockAPI.ModRegistry[mod] and mod, unlocking)

    print("Done!")
    return true
end

--Function (helper)
function UnlockAPI.Helper.GetStringAndIfUnlockingAll(cmd)
    local subbedStringUnlock = cmd:gsub("unlockall", "")
    local subbedStringLock = cmd:gsub("lockall", "")

    if subbedStringUnlock ~= cmd then
        return true, subbedStringUnlock:gsub(" ", "")
    elseif subbedStringLock ~= cmd then
        return false, subbedStringLock:gsub(" ", "")
    end
end

function UnlockAPI.Helper.SetAllModUnlocks(mod, isUnlocking)
    for _, unlockData in pairs(UnlockAPI.Helper.MergeTablesInside(UnlockAPI.Unlocks)) do
        local playerName = unlockData.PlayerName or unlockData.NormalPlayerName
        if not (not mod or UnlockAPI.ModRegistry[mod].Characters[playerName]) then goto continue end

        if type(unlockData.UnlockRequirements) ~= "string" then
            UnlockAPI.Helper.SetRequirements(unlockData.UnlockRequirements, playerName, isUnlocking)
        else --It's a challenge
            UnlockAPI.Save.Challenges[unlockData.UnlockRequirements] = true
        end

        ::continue::
    end
end

function UnlockAPI.Helper.GetRegisteredModNames()
    local modNames = {}
    for modName in pairs(UnlockAPI.ModRegistry) do table.insert(modNames, modName) end

    return '"' .. table.concat(modNames, ",") .. '"'
end

UnlockAPI.Mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, UnlockAPI.Callback.ExecuteUnlockAllCommand)