--Classes
local game = Game()

--Constants
UnlockAPI.Constants.REQUIREMENTS_VALID_NONMASK = {}

for _, unlockType in pairs(UnlockAPI.Enums.RequirementType) do
    if unlockType ~= UnlockAPI.Enums.RequirementType.HARDMODE then
        table.insert(UnlockAPI.Constants.REQUIREMENTS_VALID_NONMASK, unlockType)
    end
end

local function CheckBitmask(requirementBitmask, saveTable)
    if not saveTable then return false end
    local extraMask = requirementBitmask & UnlockAPI.Enums.RequirementType.HARDMODE == UnlockAPI.Enums.RequirementType.HARDMODE and UnlockAPI.Enums.RequirementType.HARDMODE or 0

    for name, requirement in pairs(UnlockAPI.Constants.REQUIREMENTS_VALID_NONMASK) do
        if requirementBitmask | requirement | extraMask == requirementBitmask then
            if not saveTable[tostring(math.floor(requirement | extraMask))] then --Flooring to get rid of the annoying .0 at the end
                return false
            end
        end
    end
    return true
end

--Function (helper)
function UnlockAPI.Helper.FulfilledAllRequirements(requirementBitmask, saveTable)
    if type(requirementBitmask) == "string" then
        return UnlockAPI.Save.Challenges[requirementBitmask]
    else
        return CheckBitmask(requirementBitmask, saveTable)
    end
end