-- PetMorphGUI by BRIXMODZ
-- Enhanced with Pet Name Targeting and Custom Rename
-- Compatible with Solara

-- GUI Setup
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PetMorphGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 280)
frame.Position = UDim2.new(0, 10, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🐾 Pet Morph GUI"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1

-- Input: Pet to Replace
local targetInput = Instance.new("TextBox", frame)
targetInput.PlaceholderText = "Pet Name to Replace"
targetInput.Size = UDim2.new(1, -20, 0, 30)
targetInput.Position = UDim2.new(0, 10, 0, 40)
targetInput.Text = ""
targetInput.TextScaled = true
targetInput.Font = Enum.Font.Gotham
targetInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
targetInput.TextColor3 = Color3.new(1,1,1)

-- Input: New Name
local newNameInput = Instance.new("TextBox", frame)
newNameInput.PlaceholderText = "New Visual Pet Name"
newNameInput.Size = UDim2.new(1, -20, 0, 30)
newNameInput.Position = UDim2.new(0, 10, 0, 75)
newNameInput.Text = ""
newNameInput.TextScaled = true
newNameInput.Font = Enum.Font.Gotham
newNameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
newNameInput.TextColor3 = Color3.new(1,1,1)

-- Morph function
local function morphPets(morphType)
	local targetName = targetInput.Text
	local visualName = newNameInput.Text ~= "" and newNameInput.Text or morphType

	local morphSettings = {
		HUGE = {scale = 2, color = Color3.new(1, 1, 0)},
		TITANIC = {scale = 3.5, color = Color3.new(0, 1, 1)},
		GARGANTUAN = {scale = 5, color = Color3.new(1, 0.2, 0.2)},
	}

	local settings = morphSettings[morphType]
	if not settings then return end

	for _, pet in pairs(workspace:GetDescendants()) do
		if pet:IsA("Model") and pet:FindFirstChild("HumanoidRootPart") and pet.Name:lower():find(targetName:lower()) then
			for _, part in ipairs(pet:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Size = part.Size * settings.scale
				elseif part:IsA("SpecialMesh") then
					part.Scale = part.Scale * Vector3.new(settings.scale, settings.scale, settings.scale)
				end
			end

			pet.Name = visualName

			local billboard = Instance.new("BillboardGui", pet)
			billboard.Size = UDim2.new(0, 200, 0, 50)
			billboard.StudsOffset = Vector3.new(0, 4 * settings.scale, 0)
			billboard.AlwaysOnTop = true

			local label = Instance.new("TextLabel", billboard)
			label.Size = UDim2.new(1, 0, 1, 0)
			label.BackgroundTransparency = 1
			label.Text = visualName
			label.TextColor3 = settings.color
			label.TextStrokeTransparency = 0.5
			label.TextScaled = true
			label.Font = Enum.Font.GothamBlack
		end
	end

	print("✅ Pet '" .. targetName .. "' visually morphed to: " .. visualName)
end

-- Create buttons
local morphs = {"HUGE", "TITANIC", "GARGANTUAN"}
for i, morph in ipairs(morphs) do
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, 120 + (i - 1) * 45)
	btn.Text = "Make " .. morph
	btn.Font = Enum.Font.Gotham
	btn.TextScaled = true
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(function()
		morphPets(morph)
	end)
end
