local getgenv, getnamecallmethod, hookmetamethod, hookfunction, newcclosure, checkcaller, string_lower, string_gsub = 
    getgenv, getnamecallmethod, hookmetamethod, hookfunction, newcclosure, checkcaller, string.lower, string.gsub

if getgenv().AntiKickScript then
    return
end

local LocalPlayer = game:GetService("Players").LocalPlayer

getgenv().AntiKickScript = {
    Enabled = true,
    CheckCaller = true
}

local OriginalNamecall; OriginalNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local instance, message = ...
    local methodName = getnamecallmethod()

    if getgenv().AntiKickScript.Enabled and CompareInstances(instance, LocalPlayer) and string_gsub(methodName, "^%l", string.upper) == "Kick" then
        return
    end

    return OriginalNamecall(...)
end))

local OriginalKickFunction; OriginalKickFunction = hookfunction(LocalPlayer.Kick, function(...)
    local instance, message = ...

    if getgenv().AntiKickScript.Enabled and CompareInstances(instance, LocalPlayer) then
        return
    end
end)
