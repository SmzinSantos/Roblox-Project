--// Roblox Fly Command
--// Criado para usar em executor/admin system

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local flying = false
local speed = 50

local function Fly()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")

    flying = true

    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = hrp

    humanoid.PlatformStand = true

    while flying do
        local moveDirection = humanoid.MoveDirection
        bodyVelocity.Velocity = moveDirection * speed
        task.wait()
    end

    humanoid.PlatformStand = false
    bodyVelocity:Destroy()
end

local function StopFly()
    flying = false
end

-- Chat command
player.Chatted:Connect(function(msg)
    msg = msg:lower()

    if msg == "/fly" then
        if not flying then
            Fly()
        end
    end

    if msg == "/unfly" then
        StopFly()
    end
end)

print("Fly Command Loaded!")