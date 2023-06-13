--Classes
local game = Game()
local itemPool = game:GetItemPool()

--Functions (callback)
function UnlockAPI.Callback:PlayerCheckTrinketsUpdate(player)
    if not UnlockAPI.Save.Loaded then return end

    for trinketType in pairs(UnlockAPI.Unlocks.Trinkets) do
        if player:HasTrinket(trinketType) and not UnlockAPI.Library:IsTrinketUnlocked(trinketType) then
            UnlockAPI.Helper.ReplaceTrinket(player, trinketType)
        end
    end
end

function UnlockAPI.Callback:PostTrinketInit(pickup)
    if not UnlockAPI.Save.Loaded or UnlockAPI.Library:IsTrinketUnlocked(pickup.SubType) or Isaac.RunCallbackWithParam(UnlockAPI.Enums.ModCallbacksCustom.MC_PRE_CHANGE_PICKUP_TRINKET, pickup.SubType, pickup, pickup.SubType)  then return end
    pickup:Morph(pickup.Type, pickup.Variant, 0, true, true)
end

--Function (helper)
function UnlockAPI.Helper.ReplaceTrinket(player, trinketType)
    if Isaac.RunCallbackWithParam(UnlockAPI.Enums.ModCallbacksCustom.MC_PRE_CHANGE_HELD_TRINKET, trinketType, player, trinketType) then return end
    if not player:TryRemoveTrinket(trinketType) then return end
    player:AddTrinket(itemPool:GetTrinket(false))
end

--Init
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, UnlockAPI.Callback.PlayerCheckTrinketsUpdate)
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, UnlockAPI.Callback.PostTrinketInit, PickupVariant.PICKUP_TRINKET)