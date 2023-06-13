local json = require("json")

---Call this before saving your own data.
---Needed to keep track of finished unlocks after quitting a run.
---Returns a table that contains all the beaten characters/challenges
function UnlockAPI.Library:GetSaveData(modName)
    local unlockData = {}

    for tableName, unlockTable in pairs(UnlockAPI.ModRegistry[modName]) do
        unlockData[tableName] = {}
        for unlockName in pairs(unlockTable) do
            unlockData[tableName][unlockName] = UnlockAPI.Save[tableName][unlockName]
        end
    end

    return unlockData
end

---Call this after loading your data (preferrably on MC_POST_GAME_STARTED). 
---Needed to keep track of finished unlocks after quitting a run.
---Loads existing unlock data
---@param saveData table UnlockAPI save Data
function UnlockAPI.Library:LoadSaveData(saveData)
    UnlockAPI.Save.Loaded = true

    if not saveData then return end

    for tableIndex, unlockTable in pairs(saveData) do
        if not UnlockAPI.Save[tableIndex] then
            UnlockAPI.Save[tableIndex] = {}
        end

        for index, value in pairs(unlockTable) do
            UnlockAPI.Save[tableIndex][index] = UnlockAPI.Save[tableIndex][index] or value
        end
    end
end