--Classes
local game = Game()
local level = game:GetLevel()
local SFX = SFXManager()
local HUD = game:GetHUD()

--Constants
UnlockAPI.Constants.TAINTED_PLUTO_WISP_NUM = 5
UnlockAPI.Constants.TAINTED_GOTO_COMMAND = "stage 13"
UnlockAPI.Constants.TAINTED_GRIDINDEX_BEFORE_CLOSET = 108
UnlockAPI.Constants.TAINTED_CLOSET_GRIDINDEX = 94
UnlockAPI.Constants.TAINTED_WISP_POSITION = Vector(5000, 5000)
UnlockAPI.Constants.MAX_SOUND_NUM = 2^16

--Variables
local playingWithLockedTainted

--Functions (callback)
function UnlockAPI.Callback:PostLockedTaintedPlayerInit(player)
    local playerName = player:GetName()
    if not (not playingWithLockedTainted and UnlockAPI.Helper.IsTainted(player) and not UnlockAPI.Library:IsTaintedUnlocked(playerName) and game:GetNumPlayers() > 1) then return end
    player:ChangePlayerType(UnlockAPI.Helper.GetTaintedData(playerName).NormalPlayerType)
end

function UnlockAPI.Callback:PostLockedTaintedPlayerUpdate(player)
	if not (playingWithLockedTainted and UnlockAPI.Helper.IsTainted(player) and not UnlockAPI.Library:IsTaintedUnlocked(player:GetName())) then return end
	for _, v in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR)) do v.Visible = false end
	player:GetSprite().PlaybackSpeed = 0
end

function UnlockAPI.Callback:PostLockedTaintedGameStarted(continued)
	local player = Isaac.GetPlayer(0)
	if not (UnlockAPI.Helper.IsTainted(player) and not UnlockAPI.Library:IsTaintedUnlocked(player:GetName())) then return end

    playingWithLockedTainted = true

    UnlockAPI.Helper.MakeSuperTinyAndInvisible(player)
    UnlockAPI.Helper.DisableContinuingRun(player)

	if game.Difficulty <= Difficulty.DIFFICULTY_HARD then
        UnlockAPI.Helper.GoToHomeCloset()
        UnlockAPI.Helper.MakeDoorInvisible()
	end

	HUD:SetVisible(false)
	player.MoveSpeed = 0
	player.FireDelay = 2^32-1
end

function UnlockAPI.Callback:PostLockedTaintedNewRoom(mod)
	if not (playingWithLockedTainted and level:GetCurrentRoomIndex() ~= UnlockAPI.ConstantsCLOSET_GRIDINDEX) then return end
	UnlockAPI.Helper.MakeDoorInvisible()
    UnlockAPI.Helper.TrySpawnTaintedSlot(Isaac.GetPlayer(0))
end

function UnlockAPI.Callback:PostLockedTaintedRender(mod)
	if not (playingWithLockedTainted and game.Difficulty <= Difficulty.DIFFICULTY_HARD and level:GetCurrentRoomIndex() ~= UnlockAPI.Constants.TAINTED_CLOSET_GRIDINDEX) then return end
	UnlockAPI.Helper.GoToHomeCloset()
end

function UnlockAPI.Callback:PreLockedTaintedGameExit(mod)
	playingWithLockedTainted = false
end

--Functions (helper)
function UnlockAPI.Helper.MakeSuperTinyAndInvisible(player)
	for i = 1, UnlockAPI.Constants.TAINTED_PLUTO_WISP_NUM do
		local wisp = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP, CollectibleType.COLLECTIBLE_PLUTO, UnlockAPI.Constants.TAINTED_WISP_POSITION, Vector.Zero, player)
		wisp:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
		wisp.Visible = false
	end
	player.Visible = false
end

function UnlockAPI.Helper.DisableContinuingRun(player)
	player:Die()
	local playerSprite = player:GetSprite()
	playerSprite.PlaybackSpeed = 0
    player:Update()

    UnlockAPI.Helper.StopAllSounds() --Thanks spoop for scaring me with the red isaac splat sound :)
end

function UnlockAPI.Helper.GoToHomeCloset()
	Isaac.ExecuteCommand(UnlockAPI.Constants.TAINTED_GOTO_COMMAND)
	level:MakeRedRoomDoor(UnlockAPI.Constants.TAINTED_GRIDINDEX_BEFORE_CLOSET, DoorSlot.LEFT0)
	level:ChangeRoom(UnlockAPI.Constants.TAINTED_CLOSET_GRIDINDEX)
	level:ChangeRoom(UnlockAPI.Constants.TAINTED_CLOSET_GRIDINDEX)
end

function UnlockAPI.Helper.MakeDoorInvisible()
	for _, doorSlot in pairs(DoorSlot) do
		local door = game:GetRoom():GetDoor(doorSlot)
		if door then
			door:GetSprite().Scale = Vector.Zero
			return
		end
	end
end

function UnlockAPI.Helper.StopAllSounds()
    for i = 0, UnlockAPI.Constants.MAX_SOUND_NUM do
        SFX:Stop(i)
    end
end

--Init
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, UnlockAPI.Callback.PostLockedTaintedPlayerInit)
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, UnlockAPI.Callback.PostLockedTaintedPlayerUpdate)
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, UnlockAPI.Callback.PostLockedTaintedNewRoom)
UnlockAPI.Mod:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, UnlockAPI.Enums.CallbackPriority.LATEST, UnlockAPI.Callback.PostLockedTaintedGameStarted)
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, UnlockAPI.Callback.PreLockedTaintedGameExit)
UnlockAPI.Mod:AddCallback(ModCallbacks.MC_POST_RENDER, UnlockAPI.Callback.PostLockedTaintedRender)