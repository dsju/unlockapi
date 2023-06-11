--Variable
local functionsAndCallbacks = {}

--Functions (mod)
function UnlockAPI.Mod:AddCallback(modCallback, callbackFunction, callbackArguments)
    Isaac.AddCallback(UnlockAPI.Mod, modCallback, callbackFunction, callbackArguments)
    table.insert(functionsAndCallbacks, {
        Callback = modCallback,
        Function = callbackFunction,
    })
end

function UnlockAPI.Mod:AddPriorityCallback(modCallback, callbackPriority, callbackFunction, callbackArguments)
    Isaac.AddPriorityCallback(UnlockAPI.Mod, modCallback, callbackPriority, callbackFunction, callbackArguments)
    table.insert(functionsAndCallbacks, {
        Callback = modCallback,
        Function = callbackFunction,
    })
end

--Function (core)
function UnlockAPI.Callback:RemoveAllCallbacks()
    for _, callbackData in pairs(functionsAndCallbacks) do
        Isaac.RemoveCallback(UnlockAPI.Mod, callbackData.Callback, callbackData.Function)
    end
end