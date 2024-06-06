local pr = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")

script.Parent.MouseButton1Up:Connect(function()
	
	local gui = script.Parent.Parent
	
	if not gui.Nickname.Text then return end
	if not gui.Summa.Text then return end
	
	local nickname = gui.Nickname.Text
	local get_id = pr:GetUserIdFromNameAsync(nickname)
	
	local change_value = tonumber(gui.Summa.Text)
	rs.EditValue:FireServer(get_id, change_value)
	
end)
