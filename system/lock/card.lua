--Classes
local game = Game()
local itemPool = game:GetItemPool()

--Constants
UnlockAPI.Constants.MAX_TRIES_GET_SAME_TYPE_COLLECTIBLE = 100

--Function (callback)
function UnlockAPI.Callback:PlayerCheckCardUpdate(player)
    for card in pairs(UnlockAPI.Unlocks.Cards) do
        local cardSlot = UnlockAPI.Helper.GetCardSlot(player, card)
        if cardSlot then
            player:SetCard(cardSlot, itemPool:GetCard(Random(), false, false, false))
        end
    end
end

function UnlockAPI.Callback:PostCardInit(pickup)
    if UnlockAPI.Library:IsCardUnlocked(pickup.SubType) then return end
    pickup:Morph(pickup.Type, pickup.Variant, 0, true, true)
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
