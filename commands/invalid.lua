UnlockAPI.Constants.VALID_COMMAND_DESCS = {
    "unlock [collectible/trinket/entity/card/customentry/tainted] [id]",
    "lock [collectible/trinket/entity/card/customentry/tainted] [id]",

    "lockall [mod name, optional]",
    "unlockall [mod name, optional]",
}

--Function (callback)
function UnlockAPI.Callback:AfterInvalidCommandExecution(start, cmd)
    if not (start == "unlockapi" and cmd:gsub(" ", "") == "") then return end

    print("UnlockAPI Version: " .. UnlockAPI.Version)
    print("Commands:")

    for _, commandDesc in pairs(UnlockAPI.Constants.VALID_COMMAND_DESCS) do
        print("unlockapi", commandDesc)
    end

    return true
end

UnlockAPI.Mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, UnlockAPI.Callback.AfterInvalidCommandExecution)