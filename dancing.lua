local commands_dance = {
	["gg"] = 12754418988
}

local plr = game:GetService("Players")
plr.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		
		if commands_dance[msg] then
			local dance_id = commands_dance[msg]
			
			local character = player.Character or player.CharacterAdded:Wait()

			local humanoid = character:WaitForChild("Humanoid")
			local animator = humanoid:WaitForChild("Animator")
			local anim = Instance.new("Animation")

			anim.AnimationId = "http://www.roblox.com/asset/?id="..dance_id

			local animation_play = animator:LoadAnimation(anim)
			animation_play:Play()
		end
		
	end)
end)

