-- LocalScript for Pet Visual Swap UI in Roblox (Solara)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Ensure that the library is accessible
local lib = require(ReplicatedStorage:WaitForChild("Library"))

-- Create the UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")  -- Ensure it is parented to PlayerGui

-- Create UI frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.Parent = screenGui

-- From Pet UI Label and TextBox
local fromPetLabel = Instance.new("TextLabel")
fromPetLabel.Size = UDim2.new(0, 350, 0, 30)
fromPetLabel.Position = UDim2.new(0, 25, 0, 50)
fromPetLabel.Text = "Enter Pet Name (From):"
fromPetLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
fromPetLabel.Parent = frame

local fromPetTextBox = Instance.new("TextBox")
fromPetTextBox.Size = UDim2.new(0, 350, 0, 30)
fromPetTextBox.Position = UDim2.new(0, 25, 0, 90)
fromPetTextBox.PlaceholderText = "e.g., Neon Cat"
fromPetTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
fromPetTextBox.Parent = frame

-- To Pet UI Label and TextBox
local toPetLabel = Instance.new("TextLabel")
toPetLabel.Size = UDim2.new(0, 350, 0, 30)
toPetLabel.Position = UDim2.new(0, 25, 0, 130)
toPetLabel.Text = "Enter Visual Pet Name (To):"
toPetLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
toPetLabel.Parent = frame

local toPetTextBox = Instance.new("TextBox")
toPetTextBox.Size = UDim2.new(0, 350, 0, 30)
toPetTextBox.Position = UDim2.new(0, 25, 0, 170)
toPetTextBox.PlaceholderText = "e.g., Titanic Monkey"
toPetTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
toPetTextBox.Parent = frame

-- Result Message
local resultLabel = Instance.new("TextLabel")
resultLabel.Size = UDim2.new(0, 350, 0, 30)
resultLabel.Position = UDim2.new(0, 25, 0, 220)
resultLabel.Text = ""
resultLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
resultLabel.Parent = frame

-- Swap Button
local swapButton = Instance.new("TextButton")
swapButton.Size = UDim2.new(0, 350, 0, 50)
swapButton.Position = UDim2.new(0, 25, 0, 260)
swapButton.Text = "Swap Pets"
swapButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
swapButton.TextColor3 = Color3.fromRGB(255, 255, 255)
swapButton.Parent = frame

-- Function to swap the pet visuals
local function swapPets(fromPet, toPet)
    -- Check if both pets exist in the pet directory
    if lib.Directory.Pets[fromPet] and lib.Directory.Pets[toPet] then
        -- Get the pet data for 'toPet'
        local toPetData = lib.Directory.Pets[toPet]

        -- Clear the 'fromPet' data
        for i, v in pairs(lib.Directory.Pets[fromPet]) do
            lib.Directory.Pets[fromPet][i] = nil
        end

        -- Apply the 'toPet' data to 'fromPet' (visual change)
        for i, v in pairs(toPetData) do
            lib.Directory.Pets[fromPet][i] = v
        end

        -- Show success message
        resultLabel.Text = fromPet .. " is now visual " .. toPet
        resultLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        -- Show error message if pets are not found
        resultLabel.Text = "Pet not found in directory!"
        resultLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end

-- Function to handle button click event
swapButton.MouseButton1Click:Connect(function()
    local fromPet = fromPetTextBox.Text
    local toPet = toPetTextBox.Text

    -- Ensure the user entered valid pet names
    if fromPet ~= "" and toPet ~= "" then
        swapPets(fromPet, toPet)
    else
        resultLabel.Text = "Please enter valid pet names!"
        resultLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

print("UI Loaded! Click 'Swap Pets' to visually swap your pets.")
