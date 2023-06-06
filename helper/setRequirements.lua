function UnlockAPI.Helper.SetRequirements(requirementBitmask, playerName, bool)
    local extraMask = requirementBitmask & UnlockAPI.Enums.RequirementType.HARDMODE == UnlockAPI.Enums.RequirementType.HARDMODE and UnlockAPI.Enums.RequirementType.HARDMODE or 0
    for _, requirement in pairs(UnlockAPI.Constants.REQUIREMENTS_VALID_NONMASK) do
        if requirementBitmask | requirement | extraMask == requirementBitmask then
            UnlockAPI.Helper.GetPlayerUnlockData(playerName)[tostring(math.floor(requirement | extraMask))] = bool
        end
    end
end