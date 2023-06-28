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

        MC_PRE_CHANGE_PICKUP_COLLECTIBLE = "UNLOCKAPI_PRE_CHANGE_PICKUP_COLLECTIBLE",
        MC_PRE_CHANGE_PICKUP_TRINKET = "UNLOCKAPI_PRE_CHANGE_PICKUP_TRINKET",
        MC_PRE_CHANGE_PICKUP_CARD = "UNLOCKAPI_PRE_CHANGE_PICKUP_CARD",

        MC_PRE_CHANGE_HELD_COLLECTIBLE = "UNLOCKAPI_PRE_CHANGE_HELD_COLLECTIBLE",
        MC_PRE_CHANGE_HELD_TRINKET = "UNLOCKAPI_PRE_CHANGE_HELD_TRINKET",
        MC_PRE_CHANGE_HELD_CARD = "UNLOCKAPI_PRE_CHANGE_HELD_CARD",
    },

    CallbackPriority = {
        LATEST = 2^30,
        BEFORE_LATEST = 2^30 - 1,
        EARLIEST = -2^30,
        AFTER_EARLIEST = -2^30 + 1,
    },

    RandomPopupPreventionAchievement = {{{
        UnlockRequirements = "So guys, we did it, we reached a quarter of a million subscribers, 250,000 subscribers and still growing. The fact that we've reached this number in such a short amount of time is just phenomenal, I'm- I'm just amazed. Thank you all so much for supporting this channel and helping it grow. I- I love you guys... You guys are just awesome.",
        AchievementGfx = nil,
    }}}
}
