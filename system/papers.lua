--Classes
local sfx = SFXManager()

--Constants
UnlockAPI.Constants.ACHIEVEMENT_PAPER_APPEAR_ANIM = "Appear"
UnlockAPI.Constants.ACHIEVEMENT_PAPER_DISAPPEAR_ANIM = "Dissapear" --Fuck you nicalis
UnlockAPI.Constants.ACHIEVEMENT_PAPER_OVERLAY_SPRITESHEET_ID = 3
UnlockAPI.Constants.ACHIEVEMENT_PAPER_FRAME_START_DISAPPEAR = 200
UnlockAPI.Constants.ACHIEVEMENT_PAPER_FRAME_NEXT_UNLOCK = 220
UnlockAPI.Constants.ACHIEVEMENT_PAPER_FRAME_START = 0
UnlockAPI.Constants.ACHIEVEMENT_PAPER_UPDATE_MODULO = 2
UnlockAPI.Constants.ACHIEVEMENT_PAPER_SCREEN_DIV = 2

--Instances
local achievementSprite = Sprite()
achievementSprite:Load("gfx/ui/achievement/achievements.anm2", true)
achievementSprite:Play(achievementSprite:GetDefaultAnimation())

--Variables
local currentFrame = 0

--Function (callback)
function UnlockAPI.Callback:PostAchievementRender()
    if #UnlockAPI.AchievementPapers == 0 and currentFrame <= UnlockAPI.Constants.ACHIEVEMENT_PAPER_FRAME_START  then return end

    if currentFrame == UnlockAPI.Constants.ACHIEVEMENT_PAPER_FRAME_START then

        achievementSprite:ReplaceSpritesheet(UnlockAPI.Constants.ACHIEVEMENT_PAPER_OVERLAY_SPRITESHEET_ID, UnlockAPI.AchievementPapers[1])
        achievementSprite:LoadGraphics()
        achievementSprite:Play(UnlockAPI.Constants.ACHIEVEMENT_PAPER_APPEAR_ANIM, true)
        sfx:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12)

    elseif currentFrame == UnlockAPI.Constants.ACHIEVEMENT_PAPER_FRAME_START_DISAPPEAR then
        achievementSprite:Play(UnlockAPI.Constants.ACHIEVEMENT_PAPER_DISAPPEAR_ANIM, true)

    elseif currentFrame == UnlockAPI.Constants.ACHIEVEMENT_PAPER_FRAME_NEXT_UNLOCK then
        currentFrame = UnlockAPI.Constants.ACHIEVEMENT_PAPER_FRAME_START
        table.remove(UnlockAPI.AchievementPapers, 1)

        return
    end

    if currentFrame % UnlockAPI.Constants.ACHIEVEMENT_PAPER_UPDATE_MODULO == 0 then
        achievementSprite:Update()
    end
    achievementSprite:Render(Vector(Isaac.GetScreenWidth(), Isaac.GetScreenHeight())/UnlockAPI.Constants.ACHIEVEMENT_PAPER_SCREEN_DIV)

    currentFrame = currentFrame + 1

    if currentFrame % UnlockAPI.Constants.ACHIEVEMENT_PAPER_UPDATE_MODULO ~= 0 then return end

    for _, entityPlayer in pairs(Isaac.FindByType(EntityType.ENTITY_PLAYER)) do
        local player = entityPlayer:ToPlayer()
        player:SetMinDamageCooldown(player:GetDamageCooldown() + 1)
    end
end

--Init
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_RENDER, UnlockAPI.Callback.PostAchievementRender)