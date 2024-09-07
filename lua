-- Ro-Rift Sword Bot
-- Ro-Rift Sword Bot Made By trialmeme on Discord

-- Load MoonLib library
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/jakepscripts/moonlib/main/moonlibv1.lua'))()

-- Rayfield GUI Setup
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()

local Window = Rayfield:CreateWindow({
    Name = "Ro-Rift Sword Bot",
    LoadingTitle = "Ro-Rift Sword Bot",
    LoadingSubtitle = "Made by trialmeme",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "RoRiftBot",
       FileName = "SwordBotConfig"
    }
})

local MainTab = Window:CreateTab("Main", 4483362458)
local FarmingSection = MainTab:CreateSection("Farming")

-- Kill All Function
local function KillAll()
    for i, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            pcall(function()
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
            end)
        end
    end
end

FarmingSection:CreateButton({
    Name = "Kill All",
    Callback = function()
        KillAll()
    end
})

-- Auto Kill All and Auto Respawn
local AutoKillAllToggle = false
local AutoKillAllButton = FarmingSection:CreateToggle({
    Name = "Auto Kill All",
    CurrentValue = false,
    Callback = function(Value)
        AutoKillAllToggle = Value
        while AutoKillAllToggle do
            KillAll()
            wait(1) -- Adjust to make faster/slower
        end
    end
})

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if AutoKillAllToggle then
        wait(2) -- Wait for respawn
        KillAll()
    end
end)

-- Dupe Swords Function
local function DupeSwords(amount)
    local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if Tool then
        for i = 1, amount do
            local dupedTool = Tool:Clone()
            dupedTool.Parent = game.Players.LocalPlayer.Backpack
        end
        game.Players.LocalPlayer:LoadCharacter() -- Reset the character
    end
end

FarmingSection:CreateButton({
    Name = "Dupe Swords",
    Callback = function()
        DupeSwords(10) -- Change amount to dupe here
    end
})

-- Anti-Chat Logging
local function AntiChatLog()
    local SafeCall = function(func)
        local success, err = pcall(func)
        if not success then
            warn("Error in function: ", err)
        end
    end
    
    SafeCall(function()
        while true do
            task.wait(0.1)
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ro-Rift made by trialmeme", "All")
        end
    end)
end

FarmingSection:CreateButton({
    Name = "Anti-Chat Logging",
    Callback = function()
        AntiChatLog()
    end
})

-- Ensure the script is safe to run
xpcall(function()
    coroutine.wrap(function()
        while true do
            task.wait(1)
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health == 0 then
                game.Players.LocalPlayer:LoadCharacter()
            end
        end
    end)()
end, function(err)
    warn("An error occurred: ", err)
end)

-- Script loaded notification
Rayfield:Notify({
    Title = "Ro-Rift Sword Bot",
    Content = "Ro-Rift Sword Bot Made By trialmeme",
    Duration = 5,
    Image = 4483362458,
    Actions = {
        Ignore = {
            Name = "Okay!",
            Callback = function()
                print("Notification closed.")
            end
        }
    }
})
