local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")

local soccrPlayerScript = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/gliche/iHateBrainrot/refs/heads/main/soccerPlrs.lua?token=GHSAT0AAAAAAEER47YQ2WZ6GVZV3P3JXNLK2USIKGQ"))()
end

local fallingBrainrotsScript = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/gliche/iHateBrainrot/refs/heads/main/falling.lua?token=GHSAT0AAAAAAEER47YRXPRIH4EJNXCWJIS62USIIFA"))()
end

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

local brainrotGames = {
    ["133294838637122"] = soccrPlayerScript, 
    ["86368783421928"] = fallingBrainrotsScript,
}

if getgenv().loaded and getgenv().window then
    getgenv().window:Unload()
end

local window = Rayfield:CreateWindow({
    Name = "Gliched's Brainrot Destroyer",
    LoadingTitle = "Gliched's Brainrot Destroyer",
    LoadingSubtitle = "made by Gliched <3",
    ConfigurationSaving = {
        Enabled = false
    }
})

getgenv().window = window
getgenv().loaded = true

local tab = window:CreateTab("Home", 4483362458)
local dangerTab = window:CreateTab("Danger Zone", 4483362458)

local currentGameScript = brainrotGames[tostring(game.GameId)] or brainrotGames[tostring(game.PlaceId)]

if currentGameScript then
    currentGameScript()
else
	plr:Kick("The game you are playing isn't supported yet.")
end