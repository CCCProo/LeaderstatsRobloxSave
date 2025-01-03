local dss = game:GetService("DataStoreService")
local name_data_store = "LeaderstatsSave"

local ds = dss:GetDataStore(name_data_store)
local badgeService = game:GetService("BadgeService")

info = {
	["Cash"] = {Value = 100, Save = true},
	["Minutes"] = {Value = 0, Save = true}
}

function saveData(p)
	local inventory = {}

	for i, value in pairs(p.leaderstats:GetChildren()) do
		if info[value.Name] and info[value.Name].Save then
			inventory[value.Name] = value.Value
		end
	end

	ds:SetAsync(p.UserId, inventory)
end

local function add_minutes(player: Player, value: string)
	
	task.spawn(function()
		
		while task.wait(60) do
			
			player.leaderstats[value].Value += 1
			
		end
		
	end)
	
end

game.Players.PlayerAdded:Connect(function(p)
	local invFolder = Instance.new("Folder", p)
	invFolder.Name = "leaderstats" --название папки (leaderstats например)

	for itemName, itemInfo in pairs(info) do
		local newValue = Instance.new("IntValue")
		newValue.Name = itemName
		newValue.Value = itemInfo.Value
		newValue.Parent = invFolder
	end

	local invData = ds:GetAsync(p.UserId) or {}
	for itemName, itemCount in pairs(invData) do
		if invFolder[itemName] and info[itemName] and info[itemName].Save then
			invFolder[itemName].Value = itemCount
		end
	end
	add_minutes(p, "Minutes")
end)


game.Players.PlayerRemoving:Connect(saveData)

game:BindToClose(function()
	for i, p in pairs(game.Players:GetPlayers()) do
		saveData(p)
	end
end)
