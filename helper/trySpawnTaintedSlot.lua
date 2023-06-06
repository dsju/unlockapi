--Classes
local game = Game()

--Constants
UnlockAPI.Constants.TAINTED_SLOT_VARIANT = 14

--Function (helper)
function UnlockAPI.Helper.TrySpawnTaintedSlot(player)
    if game:GetRoom():IsFirstVisit() then
        for _, entity in pairs({ table.unpack(Isaac.FindByType(EntityType.ENTITY_SHOPKEEPER)), table.unpack(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_INNER_CHILD)) }) do
            entity:Remove()
            entity.Visible = false
        end
    end

    local slot = Isaac.FindByType(EntityType.ENTITY_SLOT, UnlockAPI.Constants.TAINTED_SLOT_VARIANT)[1] or Isaac.Spawn(EntityType.ENTITY_SLOT, UnlockAPI.Constants.TAINTED_SLOT_VARIANT, 0, game:GetRoom():GetCenterPos(), Vector.Zero, nil)
    local slotSprite = slot:GetSprite()

    if not player then return slot end

    local taintedData = UnlockAPI.Helper.GetTaintedData(player:GetName())
    if taintedData.SlotSpritesheet then
        slotSprite:ReplaceSpritesheet(0, taintedData.SlotSpritesheet)
        slotSprite:LoadGraphics()
    end

    return slot
end