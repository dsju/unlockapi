local root = "unlockapi" -- Replace this with the path of the "unlockapi" folder in your mod
local modname = "MyMod" --Replace with your mod name
local version = 0.27

if not UnlockAPI then
    UnlockAPI = {}
else
    UnlockAPI.ModRegistry[modname] = { Characters = {}, Challenges = {}, } --Luadebug shouldn't matter
    if UnlockAPI.Version > version then return end
end

Isaac.ConsoleOutput("Unlocks API v" .. version .. ": ")

UnlockAPI = { --Imitation is the sincerest form of flattery, dsju 2023
    Mod = RegisterMod("TSC Unlocks API (" .. modname.. ")", 1),
    Helper = {},
    Library = {},
    Enums = {},
    Unlocks = UnlockAPI.Unlocks or {
        TaintedCharacters = {},
        Collectibles = {},
        Trinkets = {},
        Entities = {},
        Cards = {},
        CustomEntry = {},
    },
    Constants = {},
    Save = UnlockAPI.Save or { Characters = {}, Challenges = {}, },
    Callback = {},
    Characters = UnlockAPI.Characters or {},
    Challenges = UnlockAPI.Challenges or {},
    DisplayNames = UnlockAPI.DisplayNames or {},
    AchievementPapers = {},
    ModRegistry = UnlockAPI.ModRegistry or { [modname] = { Characters = {}, Challenges = {}, } },
    Version = version,
}

local scripts = {
    "enums",

    "system.clearSave",
    "system.papers",

    "system.unlock.beatBoss",
    "system.unlock.tainted",
    "system.unlock.beatRoom",
    "system.unlock.challenge",

    "system.lock.collectible",
    "system.lock.trinket",
    "system.lock.card",
    "system.lock.tainted",

    "helper.fulfilledRequirements",
    "helper.getPlayerUnlockData",
    "helper.updateUnlocks",
    "helper.showUnlock",
    "helper.isRegisteredCharacter",
    "helper.getTaintedData",
    "helper.isTainted",
    "helper.trySpawnTaintedSlot",
    "helper.setRequirements",

    "library.register",
    "library.isUnlocked",
    "library.saving",

    "commands.unlock",
}

for _, script in pairs(scripts) do include(root .. "." .. script) end

Isaac.ConsoleOutput("Loaded!\n")
