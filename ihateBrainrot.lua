local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")

local USER_KEY = script_key or getgenv().script_key or ""

local function loadPrivateScript(filePath, key)
    local url = "https://raw.githubusercontent.com/gliche/iHateBrainrot/main/" .. filePath
    local httpRequest = (syn and syn.request) or (http and http.request) or http_request or request

    local response = httpRequest({
        Url = url,
        Method = "GET",
        Headers = { ["Authorization"] = "token github_pat_" .. key }
    })

    if response and response.StatusCode == 200 then
        loadstring(response.Body)()
    else
        print("access denied")
        plr:Kick("Access Denied: Invalid Key!")
    end
end

local soccrPlayerScript = function()
    loadPrivateScript("soccerPlrs.lua", USER_KEY)
end

local fallingBrainrotsScript = function()
    loadPrivateScript("falling.lua", USER_KEY)
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
    LoadingSubtitle = "made by Gliched <3"
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
