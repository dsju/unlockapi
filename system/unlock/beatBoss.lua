--Classes
local game = Game()
local level = game:GetLevel()

--Constants
UnlockAPI.Constants.REQUIREMENT_TYPE_TO_BOSS_DATA = {
    [UnlockAPI.Enums.RequirementType.MOMSFOOT] = {
        Type = EntityType.ENTITY_MOM,
        Variant = { 0 },
        Stage = LevelStage.STAGE3_2,
    },

    [UnlockAPI.Enums.RequirementType.MOMSHEART] = {
        Type = EntityType.ENTITY_MOMS_HEART,
        Variant = { 0, 1 },
        Stage = LevelStage.STAGE4_2,
    },

    [UnlockAPI.Enums.RequirementType.ISAAC] = {
        Type = EntityType.ENTITY_ISAAC,
        Variant = { 0 },
        Stage = LevelStage.STAGE5,
    },

    [UnlockAPI.Enums.RequirementType.SATAN] = {
        Type = EntityType.ENTITY_SATAN,
        Variant = { 0, 10 },
        Stage = LevelStage.STAGE5,
    },

    [UnlockAPI.Enums.RequirementType.BLUEBABY] = {
        Type = EntityType.ENTITY_ISAAC,
        Variant = { 1 },
        Stage = LevelStage.STAGE6,
    },

    [UnlockAPI.Enums.RequirementType.LAMB] = {
        Type = EntityType.ENTITY_THE_LAMB,
        Variant = { 0, 10 },
        Stage = LevelStage.STAGE6,
    },

    [UnlockAPI.Enums.RequirementType.MEGASATAN] = {
        Type = EntityType.ENTITY_MEGA_SATAN_2,
        Variant = { 0 },
        Stage = LevelStage.STAGE6,
    },

    [UnlockAPI.Enums.RequirementType.DELIRIUM] = {
        Type = EntityType.ENTITY_DELIRIUM,
        Variant = { 0 },
        Stage = LevelStage.STAGE7,
    },

    [UnlockAPI.Enums.RequirementType.MOTHER] = {
        Type = EntityType.ENTITY_MOTHER,
        Variant = { 10 },
        Stage = LevelStage.STAGE4_2,
    },

    [UnlockAPI.Enums.RequirementType.BEAST] = {
        Type = EntityType.ENTITY_BEAST,
        Variant = { 0 },
        Stage = LevelStage.STAGE8,
    },

    [UnlockAPI.Enums.RequirementType.HUSH] = {
        Type = EntityType.ENTITY_HUSH,
        Variant = { 0 },
        Stage = LevelStage.STAGE4_3,
    },
}

--Variables
local queuedUnlocks = {}

--Function (callback)
function UnlockAPI.Callback:MarkBossDeath(npc)
    if game.Challenge ~= Challenge.CHALLENGE_NULL or game:GetVictoryLap() > 0 then return end

    local requirementType = UnlockAPI.Helper.GetCurrentBossRequirementType(npc)
    if not requirementType then return end

    queuedUnlocks[requirementType] = true
end

function UnlockAPI.Callback:MarkBossPostUpdate()
    if not UnlockAPI.Helper.ShouldTriggerUnlocks() then return end
    UnlockAPI.Helper.TriggerQueuedUnlocks()
end

function UnlockAPI.Callback:MarkBossPreGameExit()
    queuedUnlocks = {}
end

--Functions (helper)
function UnlockAPI.Helper.GetCurrentBossRequirementType(npc)
    local stageNum = level:GetStage()
    for requirementType, bossData in pairs(UnlockAPI.Constants.REQUIREMENT_TYPE_TO_BOSS_DATA) do
        if bossData.Stage == stageNum and UnlockAPI.Helper.IsEntityOfTable(npc, bossData) then
            return requirementType
        end
    end
end

function UnlockAPI.Helper.IsEntityOfTable(npc, data)
    if npc.Type ~= data.Type then return false end

    local wasInTable
    for _, v in pairs(data.Variant) do
        wasInTable = wasInTable or v == npc.Variant
    end

    return wasInTable
end

function UnlockAPI.Helper.ShouldTriggerUnlocks()
    local room = game:GetRoom()
    return (room:IsClear() and room:GetType() == RoomType.ROOM_BOSS) or level:GetStage() == LevelStage.STAGE8
end

function UnlockAPI.Helper.TriggerQueuedUnlocks()
    for requirementType in pairs(queuedUnlocks) do
        UnlockAPI.Helper.UpdateUnlocks(requirementType)
        queuedUnlocks[requirementType] = nil
    end
end

for _, bossData in pairs(UnlockAPI.Constants.REQUIREMENT_TYPE_TO_BOSS_DATA) do
    UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, UnlockAPI.Callback.MarkBossDeath, bossData.Type)
end
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_UPDATE, UnlockAPI.Callback.MarkBossPostUpdate)
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, UnlockAPI.Callback.MarkBossPreGameExit)
