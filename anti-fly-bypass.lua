local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local old
old = hookmetamethod(game, "__index", function(self, key)
    if not checkcaller() and key == "PlatformStand" and self.ClassName == "Humanoid" and self.Parent == LocalPlayer.Character then
        return false
    end
    return old(self, key)
end)

game.DescendantAdded:Connect(function(descendant)
    if descendant.ClassName:find("Body") and descendant:IsDescendantOf(LocalPlayer.Character) then
        
        local oldIndex, oldNamecall
        
        oldIndex = hookmetamethod(descendant, "__index", newcclosure(function(self, key)
            if not checkcaller() and self == descendant then
                local success, result = pcall(oldIndex, self, key)
                if not success then
                    return error(result)
                end
                return
            end
            return oldIndex(self, key)
        end))
        
        oldNamecall = hookmetamethod(descendant, "__namecall", newcclosure(function(self, ...)
            if not checkcaller() and self == descendant then
                local success, result = pcall(oldNamecall, self, ...)
                if not success then
                    return error(result)
                end
                return
            end
            return oldNamecall(self, ...)
        end))
    end
end)
