function UnlockAPI.Callback:ClearSaveData()
    UnlockAPI.Save = { Characters = {}, Challenges = {} }
end

function UnlockAPI.Callback:SetSaveDataLoaded()
    UnlockAPI.Save.Loaded = false --Gets set by UnlockAPI.Library:LoadSaveData()
end

UnlockAPI.Mod:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, UnlockAPI.Enums.CallbackPriority.EARLIEST, UnlockAPI.Callback.ClearSaveData)
UnlockAPI.Mod:AddPriorityCallback(ModCallbacks.MC_PRE_GAME_EXIT, UnlockAPI.Enums.CallbackPriority.EARLIEST, UnlockAPI.Callback.SetSaveDataLoaded)