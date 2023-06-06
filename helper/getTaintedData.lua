function UnlockAPI.Helper.GetTaintedData(playerName)
    local taintedType = Isaac.GetPlayerTypeByName(playerName, true)
    if UnlockAPI.Unlocks.TaintedCharacters[taintedType] then
        return UnlockAPI.Unlocks.TaintedCharacters[taintedType]
    else
        for taintedName, taintedData in pairs(UnlockAPI.Unlocks.TaintedCharacters) do
            if taintedData.NormalPlayerName == playerName then
                return taintedData
            end
        end
    end
end