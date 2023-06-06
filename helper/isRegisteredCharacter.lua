--Function (helper)
function UnlockAPI.Helper.IsRegisteredCharacter(player)
    local playerType = player:GetPlayerType()

    local displayName = UnlockAPI.DisplayNames[playerType]
    local playerName = displayName or player:GetName()

    local isTainted = not displayName and playerName == Isaac.GetPlayerTypeByName(playerName, true)

    local playerSaveString = playerName
    if isTainted then
        playerSaveString = UnlockAPI.Constants.TAINTED_PREFIX .. playerSaveString
    end

    return not not UnlockAPI.Characters[playerSaveString]
end