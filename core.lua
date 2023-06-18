local root = "unlockapi" -- Replace this with the path of the "unlockapi" folder in your mod
local modname = "MyMod" --Replace with your mod name
local version = 0.33

if not UnlockAPI then
    UnlockAPI = {}
else
    UnlockAPI.ModRegistry[modname] = { Characters = {}, Challenges = {}, } --luamod shouldn't matter
    if UnlockAPI.Version > version then return end
    UnlockAPI.Callback:RemoveAllCallbacks()
end

Isaac.ConsoleOutput("TSC Unlock API v" .. version .. ": ")

UnlockAPI = { --Imitation is the sincerest form of flattery, dsju 2023
    Mod = RegisterMod("TSC Unlock API (" .. modname.. ")", 1),
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
    Save = UnlockAPI.Save or { Loaded = false, Characters = {}, Challenges = {}, },
    Callback = {},
    Compatibility = {},
    Characters = UnlockAPI.Characters or {},
    Challenges = UnlockAPI.Challenges or {},
    DisplayNames = UnlockAPI.DisplayNames or {},
    AchievementPapers = {},
    ModRegistry = UnlockAPI.ModRegistry or { [modname] = { Characters = {}, Challenges = {}, } },
    Version = version,
}

local scripts = {
    "enums",

    "system.callback",
    "system.save",
    "system.papers",

    "compatibility.pause_screen_completion_marks_api",

    "system.unlock.beatBoss",
    "system.unlock.tainted",
    "system.unlock.beatRoom",
    "system.unlock.challenge",

    "system.lock.collectible",
    "system.lock.trinket",
    "system.lock.card",
    "system.lock.tainted",
    "system.lock.entity",

    "helper.fulfilledRequirements",
    "helper.getPlayerUnlockData",
    "helper.updateUnlocks",
    "helper.showUnlock",
    "helper.isRegisteredCharacter",
    "helper.getTaintedData",
    "helper.isTainted",
    "helper.trySpawnTaintedSlot",
    "helper.setRequirements",
    "helper.mergeTablesInside",

    "library.register",
    "library.isUnlocked",
    "library.saving",

    "commands.unlock",
    "commands.unlockall",
    "commands.blank",
}

for _, script in pairs(scripts) do include(root .. "." .. script) end

Isaac.ConsoleOutput('Loaded! Type "unlockapi" in the console to see valid commands.\n')