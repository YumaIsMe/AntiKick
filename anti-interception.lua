local function setupCollision(part)
    if part:IsA("BasePart") then
        local originalCanCollide = part.CanCollide
        local partMT = getmetatable(part) or {}
        setmetatable(part, {
            __index = function(t, k)
                return k == "CanCollide" and originalCanCollide or partMT.__index and partMT.__index(t, k) or rawget(t, k)
            end,
            __newindex = function(t, k, v)
                if k == "CanCollide" then originalCanCollide = v else rawset(t, k, v) end
            end
        })
    end
end

for _, part in pairs(workspace:GetDescendants()) do setupCollision(part) end
workspace.DescendantAdded:Connect(setupCollision)

local function modifyCollision(part, newCanCollide)
    if part:IsA("BasePart") then part.CanCollide = newCanCollide end
end

for _, part in pairs(workspace:GetDescendants()) do
    if part:IsA("BasePart") then
        modifyCollision(part, false)
    end
end
