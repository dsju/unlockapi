---Registers a tainted character that will show a "locked" screen when selected and get unlocked through the vanilla method (Red Key room in Home)
---@param playerName                string  Name of the character that will unlock the tainted
---@param taintedPlayerName         string  Name of the tainted character (will be locked). DO NOT put "t." at the front!
---@param taintedPlayerSpritesheet  any     Path to the spritesheet of the tainted character (eg. /gfx/characters/character_001_isaac.png)
---@param achievementGfx            any     Path to the spritesheet of the unlock paper that appears when the player unlocks the tainted character. Leave nil to use the players'ars when the player unlocks the tainted character, start with !!NOPAPER!! to show text instead (ex. !!NOPAPER!!Cool Item appears!!, this will show "Cool Item appears!!")
function UnlockAPI.Library:RegisterTaintedCharacter(playerName, taintedPlayerName, taintedPlayerSpritesheet, achievementGfx)
    local normalPlayerType = Isaac.GetPlayerTypeByName(playerName, false)
    local taintedPlayerType = Isaac.GetPlayerTypeByName(taintedPlayerName, true)

    UnlockAPI.Unlocks.TaintedCharacters[taintedPlayerType] = {
        NormalPlayerType = normalPlayerType,
        NormalPlayerName = playerName,
        SlotSpritesheet = taintedPlayerSpritesheet,
        AchievementGfx = achievementGfx,
        UnlockRequirements = UnlockAPI.Enums.RequirementType.TAINTED,
    }
end

---Registers a collectible that will be locked until a player beats fulfils the requirements to unlock it
---@param playerUnlockName      string?                 Name of the character that unlocks the collectible, add "t." to the start if it is a tainted character, can be ommited for challenge unlocks
---@param collectibleType       number                  Id of collectible that will be locked
---@param unlockRequirements    RequirementType|string  Bitmask of bosses needed to be beaten for the unlock to be done, or the name of the challenge that unlocks this collectible
---@param achievementGfx        string?                 Path to the spritesheet of the unlock paper that appears when the player unlocks the collectible, start with !!NOPAPER!! to show text instead (ex. !!NOPAPER!!Cool Item appears!!, this will show "Cool Item appears!!"), make nil/false to not show anything (should be ommited for challenge unlocks) 
function UnlockAPI.Library:RegisterCollectible(playerUnlockName, collectibleType, unlockRequirements, achievementGfx)
    UnlockAPI.Unlocks.Collectibles[collectibleType] = {
        PlayerName = playerUnlockName,
        UnlockRequirements = unlockRequirements,
        AchievementGfx = achievementGfx
    }
end

---Registers a trinket that will be locked until a player beats fulfils the requirements to unlock it
---@param playerUnlockName      string?                 Name of the character that unlocks the trinket, add "t." to the start if it is a tainted character, can be ommited for challenge unlocks
---@param trinketType           number                  Id of trinket that will be locked
---@param unlockRequirements    RequirementType|string  Bitmask of bosses needed to be beaten for the unlock to be done, or the name of the challenge that unlocks this trinket
---@param achievementGfx        string?                 Path to the spritesheet of the unlock paper that appears when the player unlocks the trinket, start with !!NOPAPER!! to show text instead (ex. !!NOPAPER!!Cool Item appears!!, this will show "Cool Item appears!!"), make nil/false to not show anything (should be ommited for challenge unlocks)
function UnlockAPI.Library:RegisterTrinket(playerUnlockName, trinketType, unlockRequirements, achievementGfx)
    UnlockAPI.Unlocks.Trinkets[trinketType] = {
        PlayerName = playerUnlockName,
        UnlockRequirements = unlockRequirements,
        AchievementGfx = achievementGfx
    }
end

---Registers a card that will be locked until a player beats fulfils the requirements to unlock it
---@param playerUnlockName      string?                 Name of the character that unlocks the trinket, add "t." to the start if it is a tainted character, can be ommited for challenge unlocks
---@param cardId                number                  Id of card (not the hud one!!) that will be locked
---@param unlockRequirements    RequirementType|string  Bitmask of bosses needed to be beaten for the unlock to be done, or the name of the challenge that unlocks this card
---@param achievementGfx        string?                 Path to the spritesheet of the unlock paper that appears when the player unlocks the card, start with !!NOPAPER!! to show text instead (ex. !!NOPAPER!!Cool Item appears!!, this will show "Cool Item appears!!"), make nil/false to not show anything (should be ommited for challenge unlocks)
function UnlockAPI.Library:RegisterCard(playerUnlockName, cardId, unlockRequirements, achievementGfx)
    UnlockAPI.Unlocks.Cards[cardId] = {
        PlayerName = playerUnlockName,
        UnlockRequirements = unlockRequirements,
        AchievementGfx = achievementGfx
    }
end

---Registers an entity that will be "locked" until a player beats fulfils the requirements to unlock it
---@param playerUnlockName      string?                 Name of the character that unlocks the entity, add "t." to the start if it is a tainted character, can be ommited for challenge unlocks
---@param entityType            number                  Type of the entity to lock
---@param entityVariant         number                  Variant of the entity to lock, leave nil to lock all entities of the same variant
---@param entitySubType         number                  SubType of the entity to lock, leave nil to lock all entities of the same subtype
---@param unlockRequirements    RequirementType|string  Bitmask of requirements that are needed to be fulfiled for the unlock to be done, or the name of the challenge that unlocks this pocket item
---@param achievementGfx        string?                 Path to the spritesheet of the unlock paper that appears when the player unlocks the card, start with !!NOPAPER!! to show text instead (ex. !!NOPAPER!!Cool Item appears!!, this will show "Cool Item appears!!"), make nil/false to not show anything (should be ommited for challenge unlocks)
function UnlockAPI.Library:RegisterEntity(playerUnlockName, entityType, entityVariant, entitySubType, unlockRequirements, achievementGfx)
    table.insert(UnlockAPI.Unlocks.Entities,
    {
        Type = entityType,
        Variant = entityVariant,
        SubType = entitySubType,
        PlayerName = playerUnlockName,
        UnlockRequirements = unlockRequirements,
        AchievementGfx = achievementGfx
    })
end

---Registers a custom entry that will be locked until a player beats fulfils the requirements to unlock it
---@param playerUnlockName      string?                 Name of the character that unlocks the entity, add "t." to the start if it is a tainted character, can be ommited for challenge unlocks
---@param entryName             string                  Name of entry
---@param unlockRequirements    RequirementType|string  Bitmask of bosses needed to be beaten for the unlock to be done, or the name of the challenge that unlocks this custom entry
---@param achievementGfx        string?                 Path to the spritesheet of the unlock paper that appears when the player unlocks the entry, start with !!NOPAPER!! to show text instead (ex. !!NOPAPER!!Cool Item appears!!, this will show "Cool Item appears!!"), make nil/false to not show anything (should be ommited for challenge unlocks)
function UnlockAPI.Library:RegisterCustomEntry(playerUnlockName, entryName, unlockRequirements, achievementGfx)
    UnlockAPI.Unlocks.CustomEntry[entryName] = {
        PlayerName = playerUnlockName,
        UnlockRequirements = unlockRequirements,
        AchievementGfx = achievementGfx
    }
end

---Registers a display name for a player of a specific type. This is for characters that have the same names as others (for example Tarnished Isaac's name is still "Isaac", with this you can use "trIsaac" as the name and have seperate unlocks for him)
---@param playerName            string  Name of the character that unlocks the entity, add "t." to the start if it is a tainted character
---@param playerType            number  Type of the player
function UnlockAPI.Library:RegisterDisplayName(playerName, playerType)
    UnlockAPI.DisplayNames[playerType] = playerName
    UnlockAPI.Characters[playerName] = true
end

---Enables the tracking (and saving) of a certain player's achievements
---@param modName               string      Name of the mod (used in saving)
---@param playerName            string      Name of the character that unlocks the entity, add "t." to the start if it is a tainted character
function UnlockAPI.Library:RegisterPlayer(modName, playerName)
    UnlockAPI.Characters[playerName] = true
    UnlockAPI.ModRegistry[modName].Characters[playerName] = true

    if not PauseScreenCompletionMarksAPI then return end
    UnlockAPI.Compatibility.AddPauseScreenCompletionMarks(playerName)
end

---Registers a challenge and allows its completion to be tracked and for achievements to be locked behind it
---@param modName               string      Name of the mod (used in saving)
---@param challengeName         string      Name of the challenge (used in Isaac.GetChallengeIdByName)
---@param challengeFinalFloor   number      Final stage of the challenge, leave nil to disable
---@param achievementGfx        string?     Path to the spritesheet of the unlock paper that appears when the player finishes the challenge, start with !!NOPAPER!! to show text instead (ex. !!NOPAPER!!Cool Item appears!!, this will show "Cool Item appears!!"), make nil/false to not show anything
function UnlockAPI.Library:RegisterChallenge(modName, challengeName, challengeFinalFloor, achievementGfx)
    local challengeId = Isaac.GetChallengeIdByName(challengeName)

    UnlockAPI.Challenges[challengeId] = {
        FinalFloor = challengeFinalFloor,
        Name = challengeName,
        AchievementGfx = achievementGfx,
    }
    UnlockAPI.ModRegistry[modName].Challenges[challengeName] = true
end