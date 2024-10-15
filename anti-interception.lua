local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local RawMetaTable = getrawmetatable(game)
local OriginalNewIndex = RawMetaTable.__newindex
local CallerCheck = checkcaller

setreadonly(RawMetaTable, false)

RawMetaTable.__newindex = newcclosure(function(self, propertyName, propertyValue)
    if CallerCheck() then 
        return OriginalNewIndex(self, propertyName, propertyValue) 
    end 
    
    if tostring(self) == "HumanoidRootPart" or tostring(self) == "Torso" then 
        if propertyName == "CFrame" and self:IsDescendantOf(LocalPlayer.Character) then 
            return true 
        end
    end
    
    return OriginalNewIndex(self, propertyName, propertyValue)
end)

setreadonly(RawMetaTable, true)
