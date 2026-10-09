WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

Window = WindUI:CreateWindow({
    Title = "Cyber Invasion",
    SubTitle = "V one",
    Icon = "Computer",
    Size = UDim2.new(0, 580, 0, 440),
    Transparent = true,
    Theme = "Dark",
    BackgroundImage = "rbxassetid://1210928143",
    BackgroundTransparency = 0.85
})

local Tab = Window:Tab({
    Title = "device damage",
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
   Title = "denial-of-service attack",
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

Tab:Button({
    Title = "damage the target computer screen",
    Desc = "Bugs the target computer screen day and night.",
    Callback = function()
        -- Agora ele usa a variável _G.Target que vem da sua TextBox
        if _G.Target and _G.Target ~= "" then
            local Players = game:GetService("Players")
            local WorkspaceCom = workspace:FindFirstChild("WorkspaceCom")
            
            local targetPlayer = nil
            for _, player in pairs(Players:GetPlayers()) do
                if string.find(string.lower(player.Name), string.lower(_G.Target)) or string.find(string.lower(player.DisplayName), string.lower(_G.Target)) then
                    targetPlayer = player
                    break
                end
            end
            
            if targetPlayer then
                local trafficCones = WorkspaceCom and WorkspaceCom:FindFirstChild("001_TrafficCones")
                
                if trafficCones then
                    -- Para a execução anterior se você mudar de alvo e clicar de novo
                    if _G.PunishThread then
                        pcall(function()
                            task.cancel(_G.PunishThread)
                        end)
                        _G.PunishThread = nil
                    end
                    
                    _G.PunishAtivo = true

                    -- Loop otimizado em segundo plano (sem travar sua tela)
                    _G.PunishThread = task.spawn(function()
                        while _G.PunishAtivo and targetPlayer and targetPlayer.Parent == Players do
                            local character = targetPlayer.Character
                            if not character then 
                                task.wait(0.2)
                                continue 
                            end
                            
                            local targetHRP = character:FindFirstChild("HumanoidRootPart")
                            local humanoid = character:FindFirstChildOfClass("Humanoid")
                            
                            if not targetHRP or (humanoid and humanoid.Health <= 0) then
                                break
                            end
                            
                            local destinoPunishCFrame = targetHRP.CFrame
                            
                            if humanoid and (humanoid.Sit or character:FindFirstChild("Seat") or character:FindFirstChild("VehicleSeat") or humanoid.SeatPart) then
                                destinoPunishCFrame = CFrame.new(9999999, -500, -9999999)
                                
                                local cadeiraFisica = humanoid.SeatPart or character:FindFirstChild("Seat") or character:FindFirstChild("VehicleSeat")
                                if cadeiraFisica and cadeiraFisica:IsA("BasePart") and cadeiraFisica.Anchored then
                                    pcall(function()
                                        cadeiraFisica.Anchored = false
                                    end)
                                end
                            else
                                local pernaDireita = character:FindFirstChild("RightLeg") 
                                    or character:FindFirstChild("RightLowerLeg") 
                                    or character:FindFirstChild("Right Leg")
                                
                                if pernaDireita and pernaDireita:IsA("BasePart") then
                                    destinoPunishCFrame = pernaDireita.CFrame
                                end
                            end
                            
                            local props = trafficCones:GetChildren()
                            if #props > 0 then
                                for _, prop in pairs(props) do
                                    if not _G.PunishAtivo then break end
                                    
                                    local setCFrameRemote = prop:FindFirstChild("SetCurrentCFrame")
                                    if setCFrameRemote and setCFrameRemote:IsA("RemoteFunction") then
                                        task.spawn(function()
                                            pcall(function()
                                                setCFrameRemote:InvokeServer(destinoPunishCFrame)
                                            end)
                                        end)
                                    end
                                end
                            end
                            
                            task.wait(0.15) 
                        end
                        _G.PunishAtivo = false
                        _G.PunishThread = nil
                    end)
                end
            end
        end
    end
})

Tab:Button({
    Title = "Close target computer game",
    Desc = "Target computer screen collapse",
    Callback = function()
        -- Modo Liga/Desliga (Toggle)
        if _G.PunishAtivo then
            _G.PunishAtivo = false
            if _G.PunishThread then
                pcall(function()
                    task.cancel(_G.PunishThread)
                end)
                _G.PunishThread = nil
            end
            return 
        end

        if _G.Target and _G.Target ~= "" then
            local Players = game:GetService("Players")
            local WorkspaceCom = workspace:FindFirstChild("WorkspaceCom")
            
            local targetPlayer = nil
            for _, player in pairs(Players:GetPlayers()) do
                if string.find(string.lower(player.Name), string.lower(_G.Target)) or string.find(string.lower(player.DisplayName), string.lower(_G.Target)) then
                    targetPlayer = player
                    break
                end
            end
            
            if targetPlayer then
                local trafficCones = WorkspaceCom and WorkspaceCom:FindFirstChild("001_TrafficCones")
                
                if trafficCones then
                    _G.PunishAtivo = true
                    local alternarLado = true
                    local tempoSentado = 0 -- Contador interno para o delay da cadeira

                    _G.PunishThread = task.spawn(function()
                        while _G.PunishAtivo and targetPlayer and targetPlayer.Parent == Players do
                            local character = targetPlayer.Character
                            
                            if not character or not character:FindFirstChild("HumanoidRootPart") then 
                                task.wait(0.2)
                                continue 
                            end
                            
                            local targetHRP = character:FindFirstChild("HumanoidRootPart")
                            local humanoid = character:FindFirstChildOfClass("Humanoid")
                            
                            if humanoid and humanoid.Health <= 0 then
                                targetPlayer.CharacterAdded:Wait()
                                task.wait(0.5) 
                                continue
                            end
                            
                            local destinoPunishCFrame
                            
                            -- Verifica se o jogador está sentado
                            local estaSentado = humanoid and (humanoid.Sit or character:FindFirstChild("Seat") or character:FindFirstChild("VehicleSeat") or humanoid.SeatPart)
                            
                            if estaSentado then
                                -- Acumula o tempo que ele passou sentado baseado no delay do loop (0.15s)
                                tempoSentado = tempoSentado + 0.15
                                
                                -- Só aplica o teleporte se já tiver passado 0.5 segundos ou mais
                                if tempoSentado >= 0.5 then
                                    if alternarLado then
                                        destinoPunishCFrame = CFrame.new(-9999999999999999, 9999, 999999999999)
                                    else
                                        destinoPunishCFrame = CFrame.new(999999999999995, 9999, -999999999999)
                                    end
                                    alternarLado = not alternarLado
                                    
                                    -- Libera a cadeira física do mapa para o teleporte funcionar
                                    local cadeiraFisica = humanoid.SeatPart or character:FindFirstChild("Seat") or character:FindFirstChild("VehicleSeat")
                                    if cadeiraFisica and cadeiraFisica:IsA("BasePart") and cadeiraFisica.Anchored then
                                        pcall(function()
                                            cadeiraFisica.Anchored = false
                                        end)
                                    end
                                else
                                    -- Se ele acabou de sentar e ainda não deu 0.5s, mantém os cones no corpo dele normalmente
                                    destinoPunishCFrame = targetHRP.CFrame
                                end
                            else
                                -- Se NÃO estiver sentado, reseta o cronômetro e segue o fluxo normal
                                tempoSentado = 0
                                if alternarLado then
                                    destinoPunishCFrame = CFrame.new(-9999999999999999, 9999, 999999999999)
                                else
                                    destinoPunishCFrame = CFrame.new(999999999999995, 9999, -999999999999)
                                end
                                alternarLado = not alternarLado
                            end
                            
                            -- Envia as requisições de rede em segundo plano para os props
                            local props = trafficCones:GetChildren()
                            if #props > 0 then
                                for _, prop in pairs(props) do
                                    if not _G.PunishAtivo then break end
                                    
                                    local setCFrameRemote = prop:FindFirstChild("SetCurrentCFrame")
                                    if setCFrameRemote and setCFrameRemote:IsA("RemoteFunction") then
                                        task.spawn(function()
                                            pcall(function()
                                                setCFrameRemote:InvokeServer(destinoPunishCFrame)
                                            end)
                                        end)
                                    end
                                end
                            end
                            
                            -- Delay principal mantido em 0.15 segundos
                            task.wait(0.15) 
                        end
                        _G.PunishAtivo = false
                        _G.PunishThread = nil
                    end)
                end
            end
        end
    end
})

local Tab2 = Window:Tab({
   Title = "collection of information about devices",
   })

Tab2:Button({
    Title = "acquire the username of the target device",
    Desc = "acquires the u.name of the target device",
    Callback = function()
        if _G.Target and _G.Target ~= "" then
            local Players = game:GetService("Players")
            for _, player in pairs(Players:GetPlayers()) do
                if string.find(string.lower(player.Name), string.lower(_G.Target)) or string.find(string.lower(player.DisplayName), string.lower(_G.Target)) then
                    setclipboard(player.Name)
                    break
                end
            end
        end
    end
})

Tab2:Button({
    Title = "acquire target device ID",
    Desc = "acquires the ID of the target device",
    Callback = function()
        if _G.Target and _G.Target ~= "" then
            local Players = game:GetService("Players")
            for _, player in pairs(Players:GetPlayers()) do
                if string.find(string.lower(player.Name), string.lower(_G.Target)) or string.find(string.lower(player.DisplayName), string.lower(_G.Target)) then
                    setclipboard(tostring(player.UserId))
                    break
                end
            end
        end
    end
})

Tab2:Input({
    Title = "Write the target device ID here.",
    Desc = "Uses the target device ID for functions.",
    Placeholder = "Paste UserID here (Numbers only)...",
    Callback = function(Value)
        _G.TargetID = Value
    end
})

Tab2:Button({
    Title = "Follow the target device via ID.",
    Desc = "Follow the target device by entering the ID.",
    Callback = function()
        if _G.TargetID and _G.TargetID ~= "" then
            local TeleportService = game:GetService("TeleportService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            local targetUserId = tonumber(_G.TargetID)
            
            if targetUserId then
                local success, errorMessage, placeId, jobId = pcall(function()
                    return TeleportService:GetPlayerPlaceInstanceAsync(targetUserId)
                end)
                
                if success and jobId then
                    TeleportService:TeleportToPlaceInstance(placeId, jobId, LocalPlayer)
                end
            end
        end
    end
})

Tab2:Button({
    Title = "acquire server ID",
    Desc = "acquires the server ID",
    Callback = function()
        -- Copia o ID único do servidor atual direto para o Ctrl+V
        if game.JobId and game.JobId ~= "" then
            setclipboard(game.JobId)
        end
    end
})

Tab2:Input({
    Title = "Write the server ID here to hack into.",
    Desc = "hack server",
    Placeholder = "Write the server ID here.",
    Callback = function(Value)
        _G.ServerJobID = Value
    end
})

Tab2:Button({
    Title = "invade the server",
    Desc = "invade the server for id",
    Callback = function()
        if _G.ServerJobID and _G.ServerJobID ~= "" then
            local TeleportService = game:GetService("TeleportService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            -- Teleporta direto para o ID da sala digitado na TextBox acima
            pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, _G.ServerJobID, LocalPlayer)
            end)
        end
    end
})
