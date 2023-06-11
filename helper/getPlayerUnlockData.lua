UnlockAPI.Constants.TAINTED_PREFIX = "t."

function UnlockAPI.Helper.GetPlayerUnlockData(player)
    local displayName
    if type(player) ~= "string" then
        local playerType = player:GetPlayerType()
        displayName = UnlockAPI.DisplayNames[playerType]
    else
        displayName = player
    end

    local playerName = displayName or player:GetName()

    local isTainted = not displayName and UnlockAPI.Helper.IsTainted(player)

    local playerSaveString = playerName
    if isTainted then
        playerSaveString = UnlockAPI.Constants.TAINTED_PREFIX .. playerSaveString
    end

    if not UnlockAPI.Save.Characters[playerSaveString] then
        UnlockAPI.Save.Characters[playerSaveString] = {}
    end

    return UnlockAPI.Save.Characters[playerSaveString], playerSaveString
end