local rs = game:GetService("ReplicatedStorage")

user_admin = 3134114276

local dss = game:GetService("DataStoreService")
local name_data_store = "LeaderstatsSave"

local ds = dss:GetDataStore(name_data_store)


rs.EditValue.OnServerEvent:Connect(function(player, change_user, change_value)
	
	if player.UserId ~= user_admin then return end
	print(change_user)
	if not ds:GetAsync(change_user) then return end
	
	local jsoned = ds:GetAsync(change_user)
	jsoned["Money"] = change_value
	
	ds:SetAsync(change_user, jsoned)
	
	local player_change = game:GetService("Players"):GetNameFromUserIdAsync(change_user)
	
	game.Players:FindFirstChild(player_change).leaderstats.Money.Value = change_value
	
end)
