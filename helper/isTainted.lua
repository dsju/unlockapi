UnlockAPI.Constants.VANILLA_TAINTED_PLAYERTYPE_MIN = PlayerType.PLAYER_ISAAC_B
UnlockAPI.Constants.VANILLA_TAINTED_PLAYERTYPE_MAX = PlayerType.PLAYER_THESOUL_B

function UnlockAPI.Helper.IsTainted(player)
    local playerType = player:GetPlayerType()
    return (UnlockAPI.Constants.VANILLA_TAINTED_PLAYERTYPE_MIN <= playerType and playerType <= UnlockAPI.Constants.VANILLA_TAINTED_PLAYERTYPE_MAX) or playerType == Isaac.GetPlayerTypeByName(player:GetName(), true)
end