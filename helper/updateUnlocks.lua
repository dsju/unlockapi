local game = Game()

--Function (helper^2)
local function GetRequirementsToAdd(requirementType)
    local requirementsToAdd = {}
    table.insert(requirementsToAdd, requirementType)

    if requirementType ~= UnlockAPI.Enums.RequirementType.TAINTED and game.Difficulty == Difficulty.DIFFICULTY_HARD or game.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
        table.insert(requirementsToAdd, requirementType | UnlockAPI.Enums.RequirementType.HARDMODE)
    end

    return requirementsToAdd
end

local function MergeTablesInside(coreTable)
    local mergedTable = {}

    for _, tableToMerge in pairs(coreTable) do
        for _, value in pairs(tableToMerge) do
            table.insert(mergedTable, value)
        end
    end

    return mergedTable
end

--Function (helper)
function UnlockAPI.Helper.UpdateUnlocks(requirementType, specifiedPlayer)
    local newRequirementsFulfiled = {}

    local requirementsToAdd = GetRequirementsToAdd(requirementType)
    for _, entityPlayer in pairs(Isaac.FindByType(EntityType.ENTITY_PLAYER)) do

        local playerUnlockData, playerName = UnlockAPI.Helper.GetPlayerUnlockData(specifiedPlayer or entityPlayer:ToPlayer())
        for _, requirementId in pairs(requirementsToAdd) do
            local requirementIdString = tostring(math.floor(requirementId))

            if not playerUnlockData[requirementIdString] then
                table.insert(newRequirementsFulfiled, { UnlockData = playerUnlockData, Requirement = requirementId, PlayerName = playerName })
                playerUnlockData[requirementIdString] = true
                print(requirementIdString)
            end
        end

        if specifiedPlayer then break end
    end

    for _, fulfilledData in pairs(newRequirementsFulfiled) do
        for _, achievementData in pairs(MergeTablesInside(UnlockAPI.Unlocks)) do

            if type(achievementData.UnlockRequirements) ~= "string" and (achievementData.UnlockRequirements or 0) & fulfilledData.Requirement ~= fulfilledData.Requirement then goto continue end
            if not (fulfilledData.PlayerName == achievementData.PlayerName and UnlockAPI.Helper.FulfilledAllRequirements(achievementData.UnlockRequirements, fulfilledData.UnlockData)) then goto continue end

            UnlockAPI.Helper.ShowUnlock(achievementData.AchievementGfx)

            ::continue::
        end
    end
end