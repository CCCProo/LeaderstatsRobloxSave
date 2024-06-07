local commands_dance = {
	["gg ggds"] = 12754418988
}

local sound_teamp = {
	["Abiba"] = 624513719
}


local teams = game:GetService("Teams")

local plr = game:GetService("Players")
plr.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		
		if commands_dance[string.lower(msg)] then
			local dance_id = commands_dance[string.lower(msg)]
			
			local character = player.Character or player.CharacterAdded:Wait()

			local humanoid = character:WaitForChild("Humanoid")
			local animator = humanoid:WaitForChild("Animator")
			local anim = Instance.new("Animation")

			anim.AnimationId = "http://www.roblox.com/asset/?id="..dance_id

			local animation_play = animator:LoadAnimation(anim)
			animation_play:Play()
		end
		
		local text = tostring(msg)
		
		if string.find(string.lower(text), string.lower("Help")) then
			
			local sound
			
			if not sound_teamp[player.Team] then return end
			
			local sound_id = sound_teamp[player.Team]
			
			if player.Team == teams['Whos'] then
				
				sound = Instance.new("Sound", game.Workspace)
				sound.SoundId = "rbxassetid://"..sound_id
			elseif player.Team == teams['What'] then
				sound = Instance.new("Sound", game.Workspace)
				sound.SoundId = "rbxassetid://"..sound_id
			end
			
			sound:Play()
		end
		
	end)
end)
