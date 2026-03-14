-- sub to duck: https://youtube.com/@duck-glaze-skibx?si=VfQ2nCt3t-cn9Mld
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

-- some variables
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SimpleDuckHub"
ScreenGui.Parent = CoreGui:FindFirstChild("RobloxGui") or Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- create fab stuff
local FAB = Instance.new("TextButton", ScreenGui)
FAB.Size = UDim2.fromOffset(50, 50)
FAB.Position = UDim2.new(0.1, 0, 0.8, 0)
FAB.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- Yellow
FAB.Text = "🦆"
FAB.TextSize = 25
Instance.new("UICorner", FAB).CornerRadius = UDim.new(1, 0)

-- drag gui logic stuff
local dragging, dragStart, startPos
FAB.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = FAB.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        FAB.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- generate gui stuff
local Window = Instance.new("Frame", ScreenGui)
Window.Size = UDim2.fromOffset(200, 120)
Window.Position = UDim2.new(0.5, -100, 0.5, -60)
Window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Window.Visible = false
Instance.new("UICorner", Window).CornerRadius = UDim.new(0, 8)

-- little gui stuff
local Title = Instance.new("TextLabel", Window)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Guess the number"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

-- some gui stuff
local RevealBtn = Instance.new("TextButton", Window)
RevealBtn.Size = UDim2.new(0.9, 0, 0, 40)
RevealBtn.Position = UDim2.new(0.05, 0, 0.5, 0)
RevealBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0) -- Orange
RevealBtn.Text = "Reveal Number"
RevealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RevealBtn.Font = Enum.Font.GothamMedium
RevealBtn.TextSize = 14
Instance.new("UICorner", RevealBtn).CornerRadius = UDim.new(0, 6)

-- more gui stuff
FAB.MouseButton1Click:Connect(function()
    Window.Visible = not Window.Visible
end)

-- remote
RevealBtn.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        local remote = ReplicatedStorage:FindFirstChild("UseRevealNumber", true)
        if remote then
            remote:FireServer()
        end
        
        StarterGui:SetCore("SendNotification", {
            Title = "Success",
            Text = "Revealed by Duck",
            Duration = 3,
        })
    end)
    
    if not success then
        StarterGui:SetCore("SendNotification", {
            Title = "Error",
            Text = "Couldn't execute script.",
            Duration = 3,
        })
    end
end)

