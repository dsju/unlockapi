--Classes
local game = Game()
local itemPool = game:GetItemPool()

--Constants
UnlockAPI.Constants.MAX_TRIES_GET_SAME_TYPE_COLLECTIBLE = 100

--Function (callback)
function UnlockAPI.Callback:PlayerCheckCardUpdate(player)
    if not UnlockAPI.Save.Loaded then return end

    for card in pairs(UnlockAPI.Unlocks.Cards) do
        local cardSlot = UnlockAPI.Helper.GetCardSlot(player, card)
        if cardSlot and not UnlockAPI.Library:IsCardUnlocked(card) then
            if not Isaac.RunCallbackWithParam(UnlockAPI.Enums.ModCallbacksCustom.MC_PRE_CHANGE_HELD_CARD, card, player, card) then
                player:SetCard(cardSlot, itemPool:GetCard(Random(), false, false, false))
            end
        end
    end
end

function UnlockAPI.Callback:PostCardInit(pickup)
    if not UnlockAPI.Save.Loaded or UnlockAPI.Library:IsCardUnlocked(pickup.SubType) or Isaac.RunCallbackWithParam(UnlockAPI.Enums.ModCallbacksCustom.MC_PRE_CHANGE_PICKUP_CARD, pickup.SubType, pickup, pickup.SubType) then return end
    pickup:Morph(pickup.Type, pickup.Variant, 0, true, false)
end

--Functions (helper)
function UnlockAPI.Helper.GetCardSlot(player, card)
    for cardSlot = 0, player:GetMaxPocketItems() - 1 do
        if player:GetCard(cardSlot) == card then
            return cardSlot
        end
    end
end

--Init
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, UnlockAPI.Callback.PlayerCheckCardUpdate)
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, UnlockAPI.Callback.PostCardInit, PickupVariant.PICKUP_TAROTCARD)
