local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FreezeButton = Instance.new("TextButton")
local AutoAcceptButton = Instance.new("TextButton")
local BypassButton = Instance.new("TextButton")

-- Assegna la GUI al Player
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Imposta la finestra principale
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 192, 203)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true  -- rende la finestra trascinabile!

-- Titolo carino
Title.Parent = Frame
Title.Text = "Trade Scam"
Title.Font = Enum.Font.Cartoon
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1

-- Bottone Freeze Trade
FreezeButton.Parent = Frame
FreezeButton.Position = UDim2.new(0.1, 0, 0.25, 0)
FreezeButton.Size = UDim2.new(0.8, 0, 0.2, 0)
FreezeButton.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
FreezeButton.Text = "Freeze Trade: OFF"
FreezeButton.Font = Enum.Font.Cartoon
FreezeButton.TextSize = 18

-- Bottone Auto Accept
AutoAcceptButton.Parent = Frame
AutoAcceptButton.Position = UDim2.new(0.1, 0, 0.5, 0)
AutoAcceptButton.Size = UDim2.new(0.8, 0, 0.2, 0)
AutoAcceptButton.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
AutoAcceptButton.Text = "Auto Accept: OFF"
AutoAcceptButton.Font = Enum.Font.Cartoon
AutoAcceptButton.TextSize = 18

-- Bottone Bypass Anti Cheat
BypassButton.Parent = Frame
BypassButton.Position = UDim2.new(0.1, 0, 0.75, 0)
BypassButton.Size = UDim2.new(0.8, 0, 0.2, 0)
BypassButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
BypassButton.Text = "Bypass Anti Cheat: ON"
BypassButton.Font = Enum.Font.Cartoon
BypassButton.TextSize = 18

-- Funzione per cambiare ON/OFF
local function toggleButton(button, textOn, textOff)
    if string.find(button.Text, "OFF") then
        button.Text = textOn
    else
        button.Text = textOff
    end
end

-- Eventi click
FreezeButton.MouseButton1Click:Connect(function()
    toggleButton(FreezeButton, "Freeze Trade: ON", "Freeze Trade: OFF")
end)

AutoAcceptButton.MouseButton1Click:Connect(function()
    toggleButton(AutoAcceptButton, "Auto Accept: ON", "Auto Accept: OFF")
end)

BypassButton.MouseButton1Click:Connect(function()
    toggleButton(BypassButton, "Bypass Anti Cheat: ON", "Bypass Anti Cheat: OFF")
end)
