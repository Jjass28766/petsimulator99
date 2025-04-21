-- Solara LocalScript for Pet UI

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local lib = require(ReplicatedStorage:WaitForChild("Library"))

-- Create the UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 500)
frame.Position = UDim2.new(0.5, -200, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.Parent = screenGui
frame.ZIndex = 10  -- Ensure it's above other UI elements

-- Pet Name Selection UI
local fromPetLabel = Instance.new("TextLabel")
fromPetLabel.Size = UDim2.new(0, 350, 0, 30)
fromPetLabel.Position = UDim2.new(0, 25, 0, 50)
fromPetLabel.Text = "Select Your Pet:"
fromPetLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
fromPetLabel.Parent = frame

local fromPetTextBox = Instance.new("TextBox")
fromPetTextBox.Size = UDim2.new(0, 350, 0, 30)
fromPetTextBox.Position = UDim2.new(0, 25, 0, 90)
fromPetTextBox.PlaceholderText = "Enter Pet Name"
fromPetTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
fromPetTextBox.Parent = frame

local toPetLabel = Instance.new("TextLabel")
toPetLabel.Size = UDim2.new(0, 350, 0, 30)
toPetLabel.Position = UDim2.new(0, 25, 0, 130)
toPetLabel.Text = "Select Visual Pet:"
toPetLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
toPetLabel.Parent = frame

local toPetTextBox = Instance.new("TextBox")
toPetTextBox.Size = UDim2.new(0, 350, 0, 30)
toPetTextBox.Position = UDim2.new(0, 25, 0, 170)
toPetTextBox.PlaceholderText = "Enter Visual Pet Name"
toPetTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
toPetTextBox.Parent = frame

-- Create a button to trigger the swap
local swapButton = Instance.new("TextButton")
swapButton.Size = UDim2.new(0, 350, 0, 50)
swapButton.Position = UDim2.new(0, 25, 0, 220)
swapButton.Text = "Swap Pets"
swapButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
swapButton.Parent = frame
swapButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Create a text label to show messages
local resultLabel = Instance.new("TextLabel")
resultLabel.Size = UDim2.new(0, 350, 0, 30)
resultLabel.Position = UDim2.new(0, 25, 0, 300)
resultLabel.Text = ""
resultLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
resultLabel.Parent = frame

-- Function to swap pets visually
local function swapPets(fromPet, toPet)
    -- Check if the pet exists in the directory
    if lib.Directory.Pets[fromPet] and lib.Directory.Pets[toPet] then
        -- Backup 'toPet' data for visual swapping
        local toPetData = lib.Directory.Pets[toPet]

        -- Clear the 'fromPet' visual data and apply the 'toPet' data
        for i, v in pairs(lib.Directory.Pets[fromPet]) do
            lib.Directory.Pets[fromPet][i] = nil
        end
        for i, v in pairs(toPetData) do
            lib.Directory.Pets[fromPet][i] = v
        end

        -- Show a success message
        resultLabel.Text = fromPet .. " has been swapped visually with " .. toPet
        resultLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        -- Show an error message if the pet doesn't exist
        resultLabel.Text = "Pet not found in directory!"
        resultLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end

-- Connect the button to the swap function
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

print("UI and script are ready.")
