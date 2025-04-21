-- PetMorphGUI by BRIXMODZ
-- Compatible with Solara

-- GUI Setup
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PetMorphGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 400)
frame.Position = UDim2.new(0, 10, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🐾 Pet Morph GUI"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1

-- Inventory Pet Selection Dropdown
local inventoryFrame = Instance.new("Frame", frame)
inventoryFrame.Size = UDim2.new(1, -20, 0, 100)
inventoryFrame.Position = UDim2.new(0, 10, 0, 40)
inventoryFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
inventoryFrame.BorderSizePixel = 0

local inventoryLabel = Instance.new("TextLabel", inventoryFrame)
inventoryLabel.Size = UDim2.new(1, 0, 0, 20)
inventoryLabel.Text = "Select Pet from Inventory"
inventoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
inventoryLabel.TextScaled = true
inventoryLabel.BackgroundTransparency = 1

local inventoryList = Instance.new("UIListLayout", inventoryFrame)

local inventoryPetList = {} -- List to store pet buttons

-- Function to populate the pet inventory
local function populateInventoryPets()
    for _, button in pairs(inventoryPetList) do
        button:Destroy() -- Clear existing pet buttons
    end
    inventoryPetList = {}

    -- Assuming pets are stored in player's Backpack
    local pets = player.Backpack:GetChildren()
    for _, pet in ipairs(pets) do
        if pet:IsA("Model") then
            -- Create buttons for each pet in inventory
            local petButton = Instance.new("TextButton", inventoryFrame)
            petButton.Size = UDim2.new(1, -20, 0, 30)
            petButton.Text = pet.Name
            petButton.TextScaled = true
            petButton.Font = Enum.Font.Gotham
            petButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            petButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            petButton.BorderSizePixel = 0
            petButton.MouseButton1Click:Connect(function()
                -- Set the selected pet
                selectedPetName.Text = pet.Name
            end)
            table.insert(inventoryPetList, petButton)
        end
    end
end

-- Scanning all pets in the game
local function populateGamePets()
    for _, button in pairs(gamePetList) do
        button:Destroy() -- Clear existing game pet buttons
    end
    gamePetList = {}

    -- Scan the game (Workspace) for pets
    for _, pet in pairs(workspace:GetDescendants()) do
        if pet:IsA("Model") and pet:FindFirstChild("HumanoidRootPart") then
            -- Create buttons for each pet in the game
            local petButton = Instance.new("TextButton", gameFrame)
            petButton.Size = UDim2.new(1, -20, 0, 30)
            petButton.Text = pet.Name
            petButton.TextScaled = true
            petButton.Font = Enum.Font.Gotham
            petButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            petButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            petButton.BorderSizePixel = 0
            petButton.MouseButton1Click:Connect(function()
                -- Set the selected pet from the game
                selectedGamePetName.Text = pet.Name
            end)
            table.insert(gamePetList, petButton)
        end
    end
end

-- Morph function to change pet visuals
local function morphPets(morphType)
    local targetPetName = selectedPetName.Text
    local visualPetName = newNameInput.Text ~= "" and newNameInput.Text or morphType
    local settings = morphSettings[morphType]

    if not settings then return end

    -- Find the selected pet in inventory or in game
    local targetPet
    for _, pet in pairs(player.Backpack:GetChildren()) do
        if pet.Name == targetPetName then
            targetPet = pet
            break
        end
    end

    if not targetPet then
        for _, pet in pairs(workspace:GetDescendants()) do
            if pet:IsA("Model") and pet.Name == selectedGamePetName.Text then
                targetPet = pet
                break
            end
        end
    end

    if not targetPet then return end

    -- Apply the visual transformation
    for _, part in ipairs(targetPet:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Size = part.Size * settings.scale
        elseif part:IsA("SpecialMesh") then
            part.Scale = part.Scale * Vector3.new(settings.scale, settings.scale, settings.scale)
        end
    end

    -- Update pet's visual name
    targetPet.Name = visualPetName

    print("✅ Pet '" .. targetPetName .. "' visually morphed to: " .. visualPetName)
end

-- Morph buttons
local morphSettings = {
    HUGE = {scale = 2, color = Color3.new(1, 1, 0)},
    TITANIC = {scale = 3.5, color = Color3.new(0, 1, 1)},
    GARGANTUAN = {scale = 5, color = Color3.new(1, 0.2, 0.2)},
}

-- Create morph type buttons
local morphs = {"HUGE", "TITANIC", "GARGANTUAN"}
for i, morph in ipairs(morphs) do
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 250 + (i - 1) * 45)
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

-- Trigger inventory population
populateInventoryPets()
populateGamePets()
