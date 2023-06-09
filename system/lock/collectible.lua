--Classes
local game = Game()
local itemPool = game:GetItemPool()
local itemConfig = Isaac.GetItemConfig()

--Constants
UnlockAPI.Constants.MAX_TRIES_GET_SAME_TYPE_COLLECTIBLE = 100

--Function (callback)
function UnlockAPI.Callback:PlayerCheckCollectiblesUpdate(player)
    for collectibleType in pairs(UnlockAPI.Unlocks.Collectibles) do
        if player:HasCollectible(collectibleType) and not UnlockAPI.Library:IsCollectibleUnlocked(collectibleType) then
            UnlockAPI.Helper.FullyReplaceCollectible(player, collectibleType)
        end
    end
end

function UnlockAPI.Callback:PostCollectibleInit(pickup)
    if UnlockAPI.Library:IsCollectibleUnlocked(pickup.SubType) or Isaac.RunCallbackWithParam(UnlockAPI.Enums.ModCallbacksCustom.MC_PRE_CHANGE_PICKUP_COLLECTIBLE, pickup.SubType, pickup, pickup.SubType) then return end
    pickup:Morph(pickup.Type, pickup.Variant, 0, true, true)
end

--Functions (helper)
function UnlockAPI.Helper.FullyReplaceCollectible(player, collectibleType)
    if Isaac.RunCallbackWithParam(UnlockAPI.Enums.ModCallbacksCustom.MC_PRE_CHANGE_HELD_COLLECTIBLE, collectibleType, player, collectibleType) then return end

    for _ = 1, player:GetCollectibleNum(collectibleType) do
        local activeSlot = UnlockAPI.Helper.GetActiveItemSlot(player, collectibleType)
        player:RemoveCollectible(collectibleType)

        local collectibleConfig = UnlockAPI.Helper.GetItemConfigOfSameType(collectibleType)
        player:AddCollectible(collectibleConfig.ID, collectibleConfig.MaxCharges, true, activeSlot)
    end
end

function UnlockAPI.Helper.GetItemConfigOfSameType(collectibleType)
    local itemType = itemConfig:GetCollectible(collectibleType).Type

    local tries = 0
    while tries < UnlockAPI.Constants.MAX_TRIES_GET_SAME_TYPE_COLLECTIBLE do
        local chosenCollectible = itemPool:GetCollectible(ItemPoolType.POOL_TREASURE, false, Random(), CollectibleType.COLLECTIBLE_BREAKFAST)
        local collectibleConfig = itemConfig:GetCollectible(chosenCollectible)

        if collectibleConfig.Type == itemType then
            return collectibleConfig
        else
            tries = tries + 1
        end
    end

    return CollectibleType.COLLECTIBLE_BREAKFAST
end

function UnlockAPI.Helper.GetActiveItemSlot(player, collectibleType)
    for _, activeSlot in pairs(ActiveSlot) do
        if player:GetActiveItem(activeSlot) == collectibleType then
            return activeSlot
        end
    end

    return nil
end

--Init
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, UnlockAPI.Callback.PlayerCheckCollectiblesUpdate)
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, UnlockAPI.Callback.PostCollectibleInit, PickupVariant.PICKUP_COLLECTIBLE)
