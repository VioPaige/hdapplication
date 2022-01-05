-- Perlin noise terrain that moves around the player

-- Services
local RunService = game:GetService('RunService')




-- Instances
	-- Folders

	-- Others
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local HumanoidRootPart = char:WaitForChild('HumanoidRootPart')



function charAdd(char)
	HumanoidRootPart = char:WaitForChild('HumanoidRootPart')
end

function charRemove()
	HumanoidRootPart = nil
	for i, v in pairs(workspace:GetChildren()) do
		if v:IsA("Part") then
			v:Destroy()
		end
	end
end

local scale = 100

for x = -100,100,5 do
	for y = -100,100,5 do
		local part = Instance.new('Part')
		part.Anchored = true
		part.Parent = workspace
		function hB()
			if not HumanoidRootPart then return end
			local MidPos = HumanoidRootPart.Position
			local pos = Vector3.new(MidPos.X + x, part.Size.Y / 2, MidPos.Z + y)
			local noise = math.noise(pos.X / scale, pos.Z / scale) + 0.5
			part.Color = Color3.fromHSV(noise, 175/255, 1)
			part.Size = Vector3.new(2.5 + noise * 2, noise * 50, 2.5 + noise * 2)
			part.Position = pos
		end
		
		RunService.Heartbeat:Connect(hB)
	end
	wait()
end




-- Events
player.CharacterAdded:Connect(charAdd)
player.CharacterRemoving:Connect(charRemove)
