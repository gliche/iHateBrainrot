local abyssalPart = CFrame.new(376, -1913, -1467)
local transcendentPart = CFrame.new(448, -6923, -741)
local supremePart = CFrame.new(456, -11018, -949)
local plr = game.Players.LocalPlayer
local chr = plr.Character
local hrp = chr.HumanoidRootPart
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()
local tab = window:CreateTab({name = "Home", icon = 4483362458}) 
local dangerTab = window:CreateTab({name = "Danger Tab", icon = 4483362458})

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
			if getgenv().Thread then task.cancel(getgenv().Thread) end
			getgenv().Thread  = 
			task.spawn(function()
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
