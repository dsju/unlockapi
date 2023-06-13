--Variables
local spawningEntityData = {}

--Functions (callback)
function UnlockAPI.Callback:LockedPreEntitySpawn(type, variant, subtype, ...)
    if not UnlockAPI.Save.Loaded or UnlockAPI.Library:IsEntityUnlocked(type, variant, subtype) then return end

    local callbackData = Isaac.RunCallbackWithParam(UnlockAPI.Enums.ModCallbacksCustom.MC_PRE_LOCKED_ENTITY_SPAWN, type, type, variant, subtype, ...)
    if not callbackData then
        table.insert(spawningEntityData, { Type = type, Variant = variant, SubType = subtype })
    else
        return callbackData
    end
end

function UnlockAPI.Callback:LockedEntityPostRender()
    if not UnlockAPI.Save.Loaded then return end

    local checkedEntities = {}

    for _, entityData in pairs(spawningEntityData) do
        local foundEntities = Isaac.FindByType(entityData.Type, entityData.Variant, entityData.SubType)
        for entityIndex = 0, #foundEntities - 1 do
            local selectedEntity = foundEntities[#foundEntities - entityIndex]
            if not selectedEntity then goto continue end

            local entityPtr = GetPtrHash(selectedEntity)

            if selectedEntity.FrameCount ~= 0 or checkedEntities[entityPtr] then goto continue end

            Isaac.RunCallbackWithParam(UnlockAPI.Enums.ModCallbacksCustom.MC_POST_LOCKED_ENTITY_INIT_LATE, entityData.Type, selectedEntity)
            checkedEntities[entityPtr] = true

            ::continue::
        end
    end

    spawningEntityData = {}
end

--Init
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, UnlockAPI.Callback.LockedPreEntitySpawn)
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_RENDER, UnlockAPI.Callback.LockedEntityPostRender)