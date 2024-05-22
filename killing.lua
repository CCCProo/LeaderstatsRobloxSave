local dss = game:GetService("DataStoreService")
local name_data_store = "LeaderstatsSave"

local ds = dss:GetDataStore(name_data_store)
local badgeService = game:GetService("BadgeService")

local name_folder = "leaderstats" --название папки (leaderstats например)

info = {
	Kills = {Value = 0, Save = true} -- Coins который будет равен 100 и он будет сохранён (Save измените на false если не хотите сохранение валюты) 
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

game.Players.PlayerAdded:Connect(function(p)
	local invFolder = Instance.new("Folder", p)
	invFolder.Name = name_folder 

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
	
	p.CharacterAdded:connect(function(Character)
		local Humanoid = Character:FindFirstChild "Humanoid"
		if Humanoid then
			Humanoid.Died:connect(function()
				for i, Child in pairs(Humanoid:GetChildren()) do
					if Child:IsA('ObjectValue') and Child.Value and Child.Value:IsA('Player') then
						local Killer = Child.Value
						if Killer:FindFirstChild(name_folder) then
							Killer[name_folder].Kills += 1
						end
						return
					end
				end
			end)
		end
	end)
end)


game.Players.PlayerRemoving:Connect(saveData)

game:BindToClose(function()
	for i, p in pairs(game.Players:GetPlayers()) do
		saveData(p)
	end
end)
