-- This script should be a LocalScript, placed in StarterPlayer -> StarterPlayerScripts

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local lib = require(ReplicatedStorage:WaitForChild("Library"))

-- Create a simple UI in the player's screen
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.Parent = screenGui
frame.ZIndex = 10  -- Ensure it's on top of other UI elements

-- Create text boxes for pet names
local fromPetLabel = Instance.new("TextLabel")
fromPetLabel.Size = UDim2.new(0, 250, 0, 30)
fromPetLabel.Position = UDim2.new(0, 25, 0, 50)
fromPetLabel.Text = "From Pet Name:"
fromPetLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
fromPetLabel.Parent = frame

local fromPetTextBox = Instance.new("TextBox")
fromPetTextBox.Size = UDim2.new(0, 250, 0, 30)
fromPetTextBox.Position = UDim2.new(0, 25, 0, 80)
fromPetTextBox.PlaceholderText = "Enter From Pet Name"
fromPetTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
fromPetTextBox.Parent = frame

local toPetLabel = Instance.new("TextLabel")
toPetLabel.Size = UDim2.new(0, 250, 0, 30)
toPetLabel.Position = UDim2.new(0, 25, 0, 120)
toPetLabel.Text = "To Pet Name:"
toPetLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
toPetLabel.Parent = frame

local toPetTextBox = Instance.new("TextBox")
toPetTextBox.Size = UDim2.new(0, 250, 0, 30)
toPetTextBox.Position = UDim2.new(0, 25, 0, 150)
toPetTextBox.PlaceholderText = "Enter To Pet Name"
toPetTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
toPetTextBox.Parent = frame

-- Create a button to trigger the swap
local swapButton = Instance.new("TextButton")
swapButton.Size = UDim2.new(0, 250, 0, 50)
swapButton.Position = UDim2.new(0, 25, 0, 200)
swapButton.Text = "Swap Pets"
swapButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
swapButton.Parent = frame
swapButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Create a text label to show messages
local resultLabel = Instance.new("TextLabel")
resultLabel.Size = UDim2.new(0, 250, 0, 30)
resultLabel.Position = UDim2.new(0, 25, 0, 270)
resultLabel.Text = ""
resultLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
resultLabel.Parent = frame

-- Function to swap pets
local function swapPets(fromPet, toPet)
    -- Ensure that both pets exist in the directory
    if lib.Directory.Pets[fromPet] and lib.Directory.Pets[toPet] then
        -- Create a backup of the 'toPet' data
        local toPetData = lib.Directory.Pets[toPet]

        -- Clear all existing data of 'fromPet'
        for i, v in pairs(lib.Directory.Pets[fromPet]) do
            lib.Directory.Pets[fromPet][i] = nil
        end

        -- Copy over 'toPet' data to 'fromPet'
        for i, v in pairs(toPetData) do
            lib.Directory.Pets[fromPet][i] = v
        end

        -- Show success message
        resultLabel.Text = fromPet .. " has been replaced with " .. toPet
        resultLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        -- Show error message if pets don't exist
        resultLabel.Text = "Pet not found in directory!"
        resultLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end

-- Connect button click to swapping function
swapButton.MouseButton1Click:Connect(function()
    local fromPet = fromPetTextBox.Text
    local toPet = toPetTextBox.Text
    if fromPet ~= "" and toPet ~= "" then
        swapPets(fromPet, toPet)
    else
        resultLabel.Text = "Please enter valid pet names!"
        resultLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)
