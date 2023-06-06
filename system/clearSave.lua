function UnlockAPI.Callback:ClearSaveData()
    UnlockAPI.Save = { Characters = {}, Challenges = {} }
end

UnlockAPI.Mod:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, UnlockAPI.Enums.CallbackPriority.EARLIEST, UnlockAPI.Callback.ClearSaveData)