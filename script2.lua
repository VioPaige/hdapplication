-- VR Hands creation


-- Services
local Players = game:GetService("Players")
local sGui = game:GetService("StarterGui")
local uiService = game:GetService("UserInputService")
local vrService = game:GetService("VRService")

-- Instances
-- Folders

-- Other
local player = Players.LocalPlayer
local character = player.Character
local camera = game.Workspace.CurrentCamera




-- Cores
if vrService.VREnabled then
	camera.CameraType = "Scriptable"
	camera.HeadScale = 1

	sGui:SetCore("VRLaserPointerMode", 0)
	sGui:SetCore("VREnableControllerModels", false)

	character.HumanoidRootPart.Anchored = true
	character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame
	
	camera.CFrame = character.HumanoidRootPart.CFrame
	
	for _, v in pairs(character:GetDescendants()) do
		
		if v.Transparency then
			
			v.Transparency = 1
			
		end
		
	end
	
	workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position)
end




-- Functions
function artificialWeld(part0, part1)

	local weld = Instance.new("Weld")
	weld.Part0 = part0
	weld.Part1 = part1
	weld.Parent = part0    

end

function createHand(handType)

	local hand = Instance.new("Part")

	hand.CFrame = character.HumanoidRootPart.CFrame
	hand.Size = Vector3.new(.3, .3, .3)
	hand.Transparency = 0
	hand.CanCollide = false
	hand.Anchored = true
	hand.Name = handType
	hand.Color = Color3.new(1, .72, .6)
	hand.Material = Enum.Material.SmoothPlastic

	hand.Parent = character

	return hand

end

local leftHand
local rightHand



if vrService.VREnabled then

	leftHand = createHand("rightHand")
	rightHand = createHand("leftHand")

end




function moved(controller, newcf)

	if controller == Enum.UserCFrame.LeftHand then

		leftHand.CFrame = camera.CFrame * newcf

	elseif controller == Enum.UserCFrame.RightHand then

		rightHand.CFrame = camera.CFrame * newcf

	end

end














-- Events
uiService.UserCFrameChanged:Connect(moved)
