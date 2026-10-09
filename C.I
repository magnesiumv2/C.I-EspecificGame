WindUI = loadstring(game:HttpGet("https://github.com"))()

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

Tab = Window:CreateTab({ Title = "Buffer Flooder", Icon = "lucide-zap" })

Tab:AddInput({
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

end
})
