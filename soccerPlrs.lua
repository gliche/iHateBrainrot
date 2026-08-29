local base

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