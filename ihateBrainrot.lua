local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")
local brainrotGames = {
    ["133294838637122"] = jumpForFootballersScript, 
    ["86368783421928"] = fallingPlrScript,
}

local function fallingPlrScript()
	local abyssalPart = CFrame.new(376, -1913, -1467)
	local transcendentPart = CFrame.new(448, -6923, -741)
	local supremePart = CFrame.new(456, -11018, -949)
	local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()
	local tab = window:CreateTab("Home", 4483362458)
	local dangerTab = window:CreateTab("Danger Zone", 4483362458)

	local function autoBrainrot(loadPart, sec)
		hrp.CFrame = loadPart
		task.wait(2)
		local brainrotSection = workspace.DropperParts.ItemSpawners:FindFirstChild(sec)

		for _, brainrot in ipairs(brainrotSection:GetChildren()) do
			hrp.CFrame = loadPart
			task.wait(1)
			local tpFLoorTable = { ["Abyssal"] = "12", ["Transcendent"] = "13", ["Supreme"] = "14" }
			local primary = brainrot.PrimaryPart
			local prox
			local endPart = workspace["NEW Dropper"].HomeTPs:FindFirstChild("TPFloor" .. tpFLoorTable[sec])
			for i, v in ipairs(brainrot:GetDescendants()) do
				if v.Name == "ProximityPrompt" then
					prox = v
				end
			end

			hrp.CFrame = primary.CFrame
			task.wait(0.1)
			prox:InputHoldBegin()
			task.wait(0.6)
			prox:InputHoldEnd()
			task.wait(0.1)
			hrp.CFrame = endPart.CFrame
			task.wait(1)
		end

		window:Notify({ title = "Farming", content = "complete!" })
	end

	local function autoCollect(currentValue)
		while true do
			local plotName = "Plot_" .. plr.Name
			local plot = workspace:FindFirstChild(plotName)
			if plot then
				for _, v in ipairs(plot:GetDescendants()) do
					if v.Name == "CollectTouch" then
						local collectPart = v
						firetouchinterest(collectPart, hrp, 0)
						task.wait()
						firetouchinterest(collectPart, hrp, 1)
					end
				end
			else
				window:Notify({ title = "Couldn't find plot" })
			end
			task.wait()
		end
	end
	tab:CreateButton({
		name = "Auto Farm",
		callback = function()
			autoBrainrot(abyssalPart, "Abyssal")
		end,
	})

	tab:CreateToggle({
		name = "Auto Collect",
		value = false,
		callback = function(value)
			if value then
				if getgenv().Thread then
					task.cancel(getgenv().Thread)
				end
				getgenv().Thread = task.spawn(function()
					autoCollect()
				end)
			else
				task.cancel(getgenv().Thread)
			end
		end,
	})

	dangerTab:CreateButton({
		name = "Unload",
		callback = function()
			window:Notify({ title = "Goodbye!", contetnt = "see you later." })
			task.wait(2)
			window:Unload()
		end,
	})

	tab:CreateButton({
		name = "Delete Dropper Parts",
		callback = function()
			workspace.BariBariNoMi:Destroy()
		end,
	})
end

local function jumpForFootballersScript()
	local base
	local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()
	local tab = window:CreateTab("Home", 4483362458)
	local dangerTab = window:CreateTab("Danger Zone", 4483362458)
	for i, v in ipairs(workspace.Plots:GetDescendants()) do
		if v.Name == "owner" and v.Value == plr.Name then
			base = v.Parent
		end
	end

	local moneyPad = base:FindFirstChild("QuadMoneyPad")
	local rebirthPad = base:FindFirstChild("DoubleRebirthPad")
	local old
	local hum = chr.Humanoid

	getgenv().selected = nil
	getgenv().luckyBlockTweenTime = 1
	getgenv().backBaseTweenTime = 1
	getgenv().autoPlace = false
	getgenv().loaded = true
	getgenv().window = window
	getgenv().on = false
	if moneyPad and rebirthPad then
		moneyPad:Destroy()
		rebirthPad:Destroy()
	end

	local function autoCollect(on)
		repeat
			if getgenv().selected == nil then
				return
			end

			local tService = game:GetService("TweenService")
			local luckyBlockName = getgenv().selected .. " Lucky Block"
			local luckyBlock = workspace.Live.Slimes:FindFirstChild(luckyBlockName)

			if luckyBlock then
				local luckyPrimary = luckyBlock.PrimaryPart
				local prox = luckyBlock:FindFirstChild("StealPrompt", true)

				local goal = { CFrame = luckyPrimary.CFrame - Vector3.new(0, 10, 0) }
				local info = TweenInfo.new(tonumber(getgenv().luckyBlockTweenTime))
				local tween = tService:Create(hrp, info, goal)

				tween:Play()

				tween.Completed:Wait()
				task.wait(0.3)
				hrp.Anchored = true
				prox:InputHoldBegin()
				task.wait(0.5)
				prox:InputHoldEnd()

				task.wait(0.5)
				hrp.Anchored = false

				local tpPart = base:FindFirstChild("FakePart", true)
				info = TweenInfo.new(tonumber(getgenv().backBaseTweenTime))
				goal = { CFrame = tpPart.CFrame }

				for i, v in ipairs(workspace.Plots:GetDescendants()) do
					if v.Name == "owner" and v.Value == plr.Name then
						base = v.Parent
					end
				end

				local tween2 = tService:Create(hrp, info, goal)
				tween2:Play()
				tween2.Completed:Wait()
				if getgenv().autoFarming then
					local args = {
						{
							sortEnabled = true,
							sortDirection = "Ascending",
						},
					}
					game:GetService("ReplicatedStorage")
						:WaitForChild("SharedModules")
						:WaitForChild("Network")
						:WaitForChild("Remotes")
						:WaitForChild("Equip Best Base")
						:InvokeServer(unpack(args))
				end
				task.wait(0.5)
			else
				window:Notify({ title = "lucky block was not found/doesn't exist, please try again" })
				return
			end
		until not getgenv().on
	end
	tab:CreateToggle({
		name = "Auto Farm",
		value = false,
		callback = function(value)
			getgenv().on = value
			if value then
				autoCollect()
			end
		end,
	})

	tab:CreateToggle({
		name = "Auto Place",
		value = false,
		callback = function(value)
			getgenv().autoPlacing = value
		end,
	})
	tab:CreateDropdown({
		name = "Brainrot To Farm",
		multiSelect = false,
		options = {
			"Common",
			"Rare",
			"Epic",
			"Legendary",
			"Mythic",
			"67",
			"Secret",
			"Soccer God",
			"Champion",
			"OG",
			"Spain",
		},
		callback = function(item)
			getgenv().selected = item
		end,
	})

	tab:CreateInput({
		name = "Lucky Block Tween Time",
		numeric = true,
		value = "1",
		placeholder = "Enter a number",
		callback = function(number)
			getgenv().luckyBlockTweenTime = number
		end,
	})

	tab:CreateInput({
		name = "Back Base Tween Time",
		numeric = true,
		value = "1",
		placeholder = "Enter a number",
		callback = function(number)
			getgenv().backBaseTweenTime = number
		end,
	})
	tab:CreateButton({
		name = "Auto Open",
		callback = function()
			for i = 1, 20, 1 do
				local args = {
					i,
				}
				game:GetService("ReplicatedStorage")
					:WaitForChild("SharedModules")
					:WaitForChild("Network")
					:WaitForChild("Remotes")
					:WaitForChild("Open Lucky Block")
					:FireServer(unpack(args))
			end
		end,
	})

	dangerTab:CreateButton({
		name = "Unload",
		callback = function()
			window:Notify({ title = "Goodbye!" })
			task.wait(0.5)
			window:Unload()
		end,
	})
end

local currentGameScript = brainrotGames[tostring(game.GameId)] or brainrotGames[tostring(game.PlaceId)]

if currentGameScript then
    currentGameScript()
else
    plr:Kick("The game you are playing isn't supported yet.")
end
