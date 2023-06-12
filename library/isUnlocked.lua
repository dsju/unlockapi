---Checks if a player has unlocked a character's tainted version or not
---@param playerName string Name of the character that the tainted version is tied to or the name of the tainted
function UnlockAPI.Library:IsTaintedUnlocked(playerName)
    local taintedData = UnlockAPI.Helper.GetTaintedData(playerName)
    return not taintedData or UnlockAPI.Helper.FulfilledAllRequirements(UnlockAPI.Enums.RequirementType.TAINTED, (UnlockAPI.Save.Characters[taintedData.NormalPlayerName] or {}))
end

---Checks if a collectible has been unlocked or not
---@param collectibleType number ID of the collectible
function UnlockAPI.Library:IsCollectibleUnlocked(collectibleType)
    local unlockData = UnlockAPI.Unlocks.Collectibles[collectibleType]
    return not unlockData or UnlockAPI.Helper.FulfilledAllRequirements(unlockData.UnlockRequirements, (UnlockAPI.Save.Characters[unlockData.PlayerName] or {}))
end

---Checks if a trinket has been unlocked or not
---@param trinketId number ID of the trinketId
function UnlockAPI.Library:IsTrinketUnlocked(trinketId)
    local unlockData = UnlockAPI.Unlocks.Trinkets[trinketId]
    return not unlockData or UnlockAPI.Helper.FulfilledAllRequirements(unlockData.UnlockRequirements, (UnlockAPI.Save.Characters[unlockData.PlayerName] or {}))
end

---Checks if a card has been unlocked or not
---@param card number ID of the card
function UnlockAPI.Library:IsCardUnlocked(card)
    local unlockData = UnlockAPI.Unlocks.Cards[card]
    return not unlockData or UnlockAPI.Helper.FulfilledAllRequirements(unlockData.UnlockRequirements, (UnlockAPI.Save.Characters[unlockData.PlayerName] or {}))
end

---Checks if an entity has been unlocked or not
---@param type number Type of the entity
---@param variant? number Variant of the entity, nil to ignore
---@param subtype? number SubType of the entity, nil to ignore
function UnlockAPI.Library:IsEntityUnlocked(type, variant, subtype)
    for _, unlockData in pairs(UnlockAPI.Unlocks.Entities) do
        if type == unlockData.Type and variant == (unlockData.Variant or variant) and subtype == (unlockData.SubType or subtype) then
            return UnlockAPI.Helper.FulfilledAllRequirements(unlockData.UnlockRequirements, (UnlockAPI.Save.Characters[unlockData.PlayerName] or {}))
        end
    end
    return true
end

---Checks if a custom entry has been unlocked or not
---@param name string Name of the custom entry
function UnlockAPI.Library:IsCustomEntryUnlocked(name)
    local unlockData = UnlockAPI.Unlocks.CustomEntry[name]
    return not not unlockData and UnlockAPI.Helper.FulfilledAllRequirements(unlockData.UnlockRequirements, (UnlockAPI.Save.Characters[unlockData.PlayerName] or {}))
end