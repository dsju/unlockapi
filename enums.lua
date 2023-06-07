UnlockAPI.Enums = {
    ---@enum RequirementType
    RequirementType = {
        MOMSHEART = 2^1,
        ISAAC = 2^2,
        SATAN = 2^3,
        LAMB = 2^4,
        BLUEBABY = 2^5,
        BOSSRUSH = 2^6,
        HUSH = 2^7,
        MEGASATAN = 2^8,
        MOTHER = 2^9,
        WITNESS = 2^9, --Legacy
        BEAST = 2^10,
        DELIRIUM = 2^11,
        GREED = 2^12,
        MOMSFOOT = 2^13, --oops!

        TAINTED = 2^16,

        HARDMODE = 2^32,
    },

    ModCallbacksCustom = {
        MC_PRE_LOCKED_ENTITY_SPAWN = "UNLOCKAPI_PRE_LOCKED_ENTITY_SPAWN",
        MC_POST_LOCKED_ENTITY_INIT_LATE = "UNLOCKAPI_POST_LOCKED_ENTITY_INIT_LATE",

        MC_BEAT_REQUIREMENT = "UNLOCKAPI_BEAT_REQUIREMENT",

        MC_UNLOCK_COLLECTIBLE = "UNLOCKAPI_UNLOCK_COLLECTIBLE",
        MC_UNLOCK_TRINKET = "UNLOCKAPI_UNLOCK_TRINKET",
        MC_UNLOCK_CARD = "UNLOCKAPI_UNLOCK_CARD",
        MC_UNLOCK_ENTITY = "UNLOCKAPI_UNLOCK_ENTITY",
        MC_UNLOCK_CUSTOMENTRY = "UNLOCKAPI_UNLOCK_CUSTOMENTRY",
        MC_UNLOCK_TAINTED = "UNLOCKAPI_UNLOCK_TAINTED",
    },

    CallbackPriority = {
        LATEST = 2^30,
        BEFORE_LATEST = 2^30 - 1,
        EARLIEST = -2^30,
        AFTER_EARLIEST = -2^30 + 1,
    }
}