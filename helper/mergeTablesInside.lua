--Function (helper ^ 2)
local function CloneTable(t)
    local table = {}
    for i, v in pairs(t) do
        table[i] = v
    end
    return table
end

--Function (helper)
function UnlockAPI.Helper.MergeTablesInside(...)
    local mergedTable = {}

    local currentId = 0

    for _, currentTable in pairs({...}) do
        for tableName, tableToMerge in pairs(currentTable) do
            for id, value in pairs(tableToMerge) do
                currentId = currentId + 1

                local newTable = CloneTable(value)
                newTable.ID = newTable.Type or id
                newTable.UnlockCallback = UnlockAPI.Constants.TABLE_NAME_TO_CALLBACK[tableName]
                newTable.AchievementID = currentId

                table.insert(mergedTable, newTable)
            end
        end
    end

    return mergedTable
end