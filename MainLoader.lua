local ChickenFarmScript = "https://raw.githubusercontent.com/gliche/iHateBrainrot/refs/heads/main/ChickenFarm"
local SoccerPlayerScript = "https://raw.githubusercontent.com/gliche/iHateBrainrot/refs/heads/main/soccerPlrs.lua"
local FallForBrainrotsScript = "https://raw.githubusercontent.com/gliche/iHateBrainrot/refs/heads/main/falling"

local GameLibrary = {
    ["chicken farm"] = ChickenFarmScript,
    ["soccer players"] = SoccerPlayerScript,
    ["fall for brainrots"] = FallForBrainrotsScript
}

if not GameLibrary[GameScript] then
    game.Players.LocalPlayer:Kick("This game isn't supported yet or you typed the wrong game name!")
else
    loadstring(game:HttpGet(GameLibrary[GameScript]))()
end
