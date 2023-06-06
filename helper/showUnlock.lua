--Classes
local game = Game()
local hud = game:GetHUD()
local sfx = SFXManager()

--Constants
UnlockAPI.Constants.PREFIX_DISABLE_ACHIEVEMENTPAPER = "!!NOPAPER!!"

--Function
function UnlockAPI.Helper.ShowUnlock(text)
    if not text then return end

    if text:find(UnlockAPI.Constants.PREFIX_DISABLE_ACHIEVEMENTPAPER) == 1 then
        hud:ShowItemText(text:gsub(UnlockAPI.Constants.PREFIX_DISABLE_ACHIEVEMENTPAPER, ""), nil)
        sfx:Play(SoundEffect.SOUND_PAPER_OUT)
    else
        table.insert(UnlockAPI.AchievementPapers, text)
    end
end