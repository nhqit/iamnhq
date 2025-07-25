local Players = game:GetService('Players')
local player = Players.LocalPlayer
local playerGui = player:WaitForChild('PlayerGui')

-- Main GUI creation
local gui = Instance.new('ScreenGui')
gui.Name = 'ModularGUI'
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 10
gui.IgnoreGuiInset = true
gui.Parent = playerGui

-- Color scheme
local colors = {
    background = Color3.fromRGB(30, 30, 40),
    header = Color3.fromRGB(40, 40, 50),
    text = Color3.fromRGB(255, 255, 255),
    subtext = Color3.fromRGB(200, 200, 200),
    button = Color3.fromRGB(70, 70, 80),
    buttonHover = Color3.fromRGB(90, 90, 100),
    toggleOff = Color3.fromRGB(60, 60, 70),
    toggleOn = Color3.fromRGB(0, 170, 127),
    input = Color3.fromRGB(50, 50, 60),
}

-- Main container
local mainFrame = Instance.new('Frame')
mainFrame.Name = 'MainFrame'
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = colors.background
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, 300, 0, 0) -- Height will auto-adjust
mainFrame.Parent = gui

-- Round corners
local corner = Instance.new('UICorner')
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Shadow effect
local shadow = Instance.new('ImageLabel')
shadow.Name = 'Shadow'
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.BackgroundTransparency = 1
shadow.BorderSizePixel = 0
shadow.Position = UDim2.new(0.5, 0, 0.5, 4)
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Image = 'rbxassetid://1316045217'
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame
shadow.ZIndex = -1

-- Title bar
local titleBar = Instance.new('Frame')
titleBar.Name = 'TitleBar'
titleBar.BackgroundColor3 = colors.header
titleBar.BorderSizePixel = 0
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Parent = mainFrame

local titleCorner = Instance.new('UICorner')
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local title = Instance.new('TextLabel')
title.Name = 'Title'
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 10, 0, 0)
title.Size = UDim2.new(1, -40, 1, 0)
title.Font = Enum.Font.GothamSemibold
title.Text = 'BasicIsBetter! SUBSCRIBE!'
title.TextColor3 = colors.text
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Close button
local closeButton = Instance.new('TextButton')
closeButton.Name = 'CloseButton'
closeButton.AnchorPoint = Vector2.new(1, 0.5)
closeButton.BackgroundTransparency = 1
closeButton.Position = UDim2.new(1, -10, 0.5, 0)
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = 'X'
closeButton.TextColor3 = colors.text
closeButton.TextSize = 14
closeButton.Parent = titleBar

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Content frame
local contentFrame = Instance.new('Frame')
contentFrame.Name = 'ContentFrame'
contentFrame.BackgroundTransparency = 1
contentFrame.Position = UDim2.new(0, 10, 0, 40)
contentFrame.Size = UDim2.new(1, -20, 1, -50)
contentFrame.Parent = mainFrame

-- Auto-layout variables
local currentYPosition = 0
local elementPadding = 5
local sectionPadding = 15

-- Player name input (automatically added)
local playerInputFrame = Instance.new('Frame')
playerInputFrame.Name = 'PlayerInputFrame'
playerInputFrame.BackgroundTransparency = 1
playerInputFrame.Position = UDim2.new(0, 0, 0, currentYPosition)
playerInputFrame.Size = UDim2.new(1, 0, 0, 60)
playerInputFrame.Parent = contentFrame

local playerLabel = Instance.new('TextLabel')
playerLabel.Name = 'PlayerLabel'
playerLabel.BackgroundTransparency = 1
playerLabel.Position = UDim2.new(0, 0, 0, 0)
playerLabel.Size = UDim2.new(1, 0, 0, 20)
playerLabel.Font = Enum.Font.Gotham
playerLabel.Text = 'NO USE IN THIS GAME'
playerLabel.TextColor3 = colors.subtext
playerLabel.TextSize = 12
playerLabel.TextXAlignment = Enum.TextXAlignment.Left
playerLabel.Parent = playerInputFrame

local playerInput = Instance.new('TextBox')
playerInput.Name = 'PlayerInput'
playerInput.BackgroundColor3 = colors.input
playerInput.BorderSizePixel = 0
playerInput.Position = UDim2.new(0, 0, 0, 25)
playerInput.Size = UDim2.new(1, 0, 0, 30)
playerInput.Font = Enum.Font.Gotham
playerInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
playerInput.PlaceholderText = 'USELESS/DONT TOUCH'
playerInput.Text = ''
playerInput.TextColor3 = colors.text
playerInput.TextSize = 14
playerInput.TextXAlignment = Enum.TextXAlignment.Left
playerInput.Parent = playerInputFrame

local inputCorner = Instance.new('UICorner')
inputCorner.CornerRadius = UDim.new(0, 4)
inputCorner.Parent = playerInput

local inputPadding = Instance.new('UIPadding')
inputPadding.PaddingLeft = UDim.new(0, 8)
inputPadding.Parent = playerInput

currentYPosition = currentYPosition + 60 + sectionPadding

-- Function to update main frame size
local function UpdateFrameSize()
    local totalHeight = 40 + currentYPosition + 10 -- Title bar + content + bottom padding
    mainFrame.Size = UDim2.new(0, 300, 0, totalHeight)
end

--[[
    ELEMENT CREATION FUNCTIONS
]]

-- Create a new section label
function CreateSection(titleText)
    local sectionFrame = Instance.new('Frame')
    sectionFrame.Name = titleText .. 'Section'
    sectionFrame.BackgroundTransparency = 1
    sectionFrame.Position = UDim2.new(0, 0, 0, currentYPosition)
    sectionFrame.Size = UDim2.new(1, 0, 0, 20)
    sectionFrame.Parent = contentFrame

    local label = Instance.new('TextLabel')
    label.Name = 'Label'
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = titleText
    label.TextColor3 = colors.subtext
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sectionFrame

    currentYPosition = currentYPosition + 20 + elementPadding
    UpdateFrameSize()

    return sectionFrame
end

-- Create a new button
function CreateButton(buttonName, callback)
    local button = Instance.new('TextButton')
    button.Name = buttonName
    button.BackgroundColor3 = colors.button
    button.BorderSizePixel = 0
    button.Position = UDim2.new(0, 0, 0, currentYPosition)
    button.Size = UDim2.new(1, 0, 0, 35)
    button.Font = Enum.Font.GothamSemibold
    button.Text = buttonName
    button.TextColor3 = colors.text
    button.TextSize = 14
    button.Parent = contentFrame

    -- Add corner rounding
    local buttonCorner = Instance.new('UICorner')
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button

    -- Hover effects
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = colors.buttonHover
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = colors.button
    end)

    -- Click handler
    button.MouseButton1Click:Connect(function()
        callback(playerInput.Text) -- Pass the player input to the callback
    end)

    currentYPosition = currentYPosition + 35 + elementPadding
    UpdateFrameSize()

    return button
end

-- Create a new toggle
function CreateToggle(toggleName, defaultState, callback)
    local toggleFrame = Instance.new('Frame')
    toggleFrame.Name = toggleName .. 'Toggle'
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Position = UDim2.new(0, 0, 0, currentYPosition)
    toggleFrame.Size = UDim2.new(1, 0, 0, 30)
    toggleFrame.Parent = contentFrame

    local label = Instance.new('TextLabel')
    label.Name = 'Label'
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = toggleName
    label.TextColor3 = colors.text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame

    local toggleButton = Instance.new('TextButton')
    toggleButton.Name = 'ToggleButton'
    toggleButton.AnchorPoint = Vector2.new(1, 0.5)
    toggleButton.BackgroundColor3 = defaultState and colors.toggleOn
        or colors.toggleOff
    toggleButton.BorderSizePixel = 0
    toggleButton.Position = UDim2.new(1, 0, 0.5, 0)
    toggleButton.Size = UDim2.new(0, 50, 0, 25)
    toggleButton.Font = Enum.Font.Gotham
    toggleButton.Text = defaultState and 'ON' or 'OFF'
    toggleButton.TextColor3 = colors.text
    toggleButton.TextSize = 12
    toggleButton.Parent = toggleFrame

    local toggleCorner = Instance.new('UICorner')
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggleButton

    toggleButton.MouseButton1Click:Connect(function()
        local newState = not (toggleButton.Text == 'ON')
        toggleButton.Text = newState and 'ON' or 'OFF'
        toggleButton.BackgroundColor3 = newState and colors.toggleOn
            or colors.toggleOff
        callback(newState, playerInput.Text) -- Pass state and player input to callback
    end)

    currentYPosition = currentYPosition + 30 + elementPadding
    UpdateFrameSize()

    return toggleFrame
end

-- Create a label
function CreateLabel(labelText)
    local label = Instance.new('TextLabel')
    label.Name = labelText .. 'Label'
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 0, 0, currentYPosition)
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Font = Enum.Font.Gotham
    label.Text = labelText
    label.TextColor3 = colors.text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = contentFrame

    currentYPosition = currentYPosition + 20 + elementPadding
    UpdateFrameSize()

    return label
end

function CreateDropdown(name, options, callback)
    local dropdownHeight = 30
    local optionHeight = 30
    local expandedHeight = dropdownHeight + (optionHeight * #options)

    -- Store original Y position before any dropdown expansion
    local originalYPosition = currentYPosition

    -- Create main container frame
    local dropdownContainer = Instance.new('Frame')
    dropdownContainer.Name = name .. 'DropdownContainer'
    dropdownContainer.BackgroundTransparency = 1
    dropdownContainer.Position = UDim2.new(0, 0, 0, originalYPosition)
    dropdownContainer.Size = UDim2.new(1, 0, 0, dropdownHeight)
    dropdownContainer.ClipsDescendants = true
    dropdownContainer.Parent = contentFrame

    -- Create the selected option button
    local selectedButton = Instance.new('TextButton')
    selectedButton.Name = 'SelectedButton'
    selectedButton.BackgroundColor3 = colors.input
    selectedButton.Size = UDim2.new(1, 0, 0, dropdownHeight)
    selectedButton.Font = Enum.Font.Gotham
    selectedButton.Text = 'Select ' .. name
    selectedButton.TextColor3 = colors.text
    selectedButton.TextSize = 14
    selectedButton.TextXAlignment = Enum.TextXAlignment.Left
    selectedButton.ZIndex = 2
    selectedButton.Parent = dropdownContainer

    local selectedCorner = Instance.new('UICorner')
    selectedCorner.CornerRadius = UDim.new(0, 4)
    selectedCorner.Parent = selectedButton

    local selectedPadding = Instance.new('UIPadding')
    selectedPadding.PaddingLeft = UDim.new(0, 8)
    selectedPadding.Parent = selectedButton

    -- Create dropdown frame that will contain all options
    local dropdownFrame = Instance.new('Frame')
    dropdownFrame.Name = 'DropdownFrame'
    dropdownFrame.BackgroundColor3 = colors.background
    dropdownFrame.BackgroundTransparency = 0
    dropdownFrame.Position = UDim2.new(0, 0, 0, dropdownHeight)
    dropdownFrame.Size = UDim2.new(1, 0, 0, 0)
    dropdownFrame.Visible = false
    dropdownFrame.ZIndex = 10
    dropdownFrame.Parent = dropdownContainer

    local dropdownFrameCorner = Instance.new('UICorner')
    dropdownFrameCorner.CornerRadius = UDim.new(0, 4)
    dropdownFrameCorner.Parent = dropdownFrame

    -- Create options
    for i, option in ipairs(options) do
        local optionButton = Instance.new('TextButton')
        optionButton.Name = option
        optionButton.BackgroundColor3 = colors.input
        optionButton.BorderSizePixel = 0
        optionButton.Position = UDim2.new(0, 0, 0, (i - 1) * optionHeight)
        optionButton.Size = UDim2.new(1, 0, 0, optionHeight)
        optionButton.Font = Enum.Font.Gotham
        optionButton.Text = option
        optionButton.TextColor3 = colors.text
        optionButton.TextSize = 14
        optionButton.TextXAlignment = Enum.TextXAlignment.Left
        optionButton.ZIndex = 11
        optionButton.Parent = dropdownFrame

        local corner = Instance.new('UICorner')
        corner.CornerRadius = UDim.new(0, 4)
        corner.Parent = optionButton

        local padding = Instance.new('UIPadding')
        padding.PaddingLeft = UDim.new(0, 8)
        padding.Parent = optionButton

        optionButton.MouseButton1Click:Connect(function()
            selectedButton.Text = option
            dropdownFrame.Visible = false
            dropdownContainer.Size = UDim2.new(1, 0, 0, dropdownHeight)
            callback(option, playerInput.Text)
        end)
    end

    -- Toggle dropdown visibility
    local isExpanded = false
    selectedButton.MouseButton1Click:Connect(function()
        isExpanded = not isExpanded

        if isExpanded then
            -- Show all options
            dropdownFrame.Visible = true
            dropdownFrame.Size = UDim2.new(1, 0, 0, optionHeight * #options)
            dropdownContainer.Size = UDim2.new(1, 0, 0, expandedHeight)

            -- Bring to front
            dropdownContainer.ZIndex = 10
            selectedButton.ZIndex = 11
            dropdownFrame.ZIndex = 10
        else
            -- Collapse the dropdown
            dropdownFrame.Visible = false
            dropdownFrame.Size = UDim2.new(1, 0, 0, 0)
            dropdownContainer.Size = UDim2.new(1, 0, 0, dropdownHeight)

            -- Reset ZIndex
            dropdownContainer.ZIndex = 1
            selectedButton.ZIndex = 2
            dropdownFrame.ZIndex = 1
        end
    end)

    -- Close dropdown when clicking elsewhere
    local inputConnection
    inputConnection = game
        :GetService('UserInputService').InputBegan
        :Connect(function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseButton1
                and isExpanded
            then
                local mousePos = input.Position
                local absolutePos = dropdownContainer.AbsolutePosition
                local absoluteSize = dropdownContainer.AbsoluteSize

                -- Check if click was outside the dropdown
                if
                    not (
                        mousePos.X >= absolutePos.X
                        and mousePos.X <= absolutePos.X + absoluteSize.X
                        and mousePos.Y >= absolutePos.Y
                        and mousePos.Y <= absolutePos.Y + absoluteSize.Y
                    )
                then
                    isExpanded = false
                    dropdownFrame.Visible = false
                    dropdownFrame.Size = UDim2.new(1, 0, 0, 0)
                    dropdownContainer.Size = UDim2.new(1, 0, 0, dropdownHeight)

                    -- Reset ZIndex
                    dropdownContainer.ZIndex = 1
                    selectedButton.ZIndex = 2
                    dropdownFrame.ZIndex = 1
                end
            end
        end)

    -- Clean up the connection when the dropdown is destroyed
    dropdownContainer.Destroying:Connect(function()
        if inputConnection then
            inputConnection:Disconnect()
        end
    end)

    currentYPosition = currentYPosition + dropdownHeight + elementPadding
    UpdateFrameSize()

    return dropdownContainer
end

function CreateUpdatingDropdown(name, optionsGetter, callback, refreshTime)
    -- First create the section properly in the layout
    local sectionFrame = Instance.new('Frame')
    sectionFrame.Name = name .. 'Section'
    sectionFrame.BackgroundTransparency = 1
    sectionFrame.Size = UDim2.new(1, 0, 0, 50) -- Initial size (will adjust)
    sectionFrame.Parent = contentFrame
    sectionFrame.Position = UDim2.new(0, 0, 0, currentYPosition)
    sectionFrame.ZIndex = 1 -- Base z-index for the section

    -- Update the layout position tracker
    currentYPosition = currentYPosition + 50 + elementPadding
    UpdateFrameSize()

    -- Section label
    local sectionLabel = Instance.new('TextLabel')
    sectionLabel.Name = 'Label'
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.Size = UDim2.new(1, 0, 0, 20)
    sectionLabel.Font = Enum.Font.Gotham
    sectionLabel.Text = name
    sectionLabel.TextColor3 = colors.subtext
    sectionLabel.TextSize = 12
    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    sectionLabel.ZIndex = 1
    sectionLabel.Parent = sectionFrame

    -- Dropdown container (positioned below label)
    local dropdownContainer = Instance.new('Frame')
    dropdownContainer.Name = 'DropdownContainer'
    dropdownContainer.BackgroundTransparency = 1
    dropdownContainer.Position = UDim2.new(0, 0, 0, 25) -- Below label
    dropdownContainer.Size = UDim2.new(1, 0, 0, 30) -- Initial height
    dropdownContainer.ClipsDescendants = true
    dropdownContainer.ZIndex = 1 -- Base z-index
    dropdownContainer.Parent = sectionFrame

    -- Selected option button
    local selectedButton = Instance.new('TextButton')
    selectedButton.Name = 'SelectedButton'
    selectedButton.BackgroundColor3 = colors.input
    selectedButton.Size = UDim2.new(1, 0, 0, 30)
    selectedButton.Font = Enum.Font.Gotham
    selectedButton.Text = 'Select ' .. name
    selectedButton.TextColor3 = colors.text
    selectedButton.TextSize = 14
    selectedButton.TextXAlignment = Enum.TextXAlignment.Left
    selectedButton.ZIndex = 2 -- Higher than container
    selectedButton.Parent = dropdownContainer

    -- UI decoration (corners, padding)
    local selectedCorner = Instance.new('UICorner')
    selectedCorner.CornerRadius = UDim.new(0, 4)
    selectedCorner.Parent = selectedButton

    local selectedPadding = Instance.new('UIPadding')
    selectedPadding.PaddingLeft = UDim.new(0, 8)
    selectedPadding.Parent = selectedButton

    -- Options frame - this needs to be at the highest z-index
    local dropdownFrame = Instance.new('Frame')
    dropdownFrame.Name = 'DropdownFrame'
    dropdownFrame.BackgroundColor3 = colors.background
    dropdownFrame.Position = UDim2.new(0, 0, 0, 30)
    dropdownFrame.Size = UDim2.new(1, 0, 0, 0)
    dropdownFrame.Visible = false
    dropdownFrame.ZIndex = 100 -- Very high z-index to ensure it's on top
    dropdownFrame.Parent = dropdownContainer

    local dropdownFrameCorner = Instance.new('UICorner')
    dropdownFrameCorner.CornerRadius = UDim.new(0, 4)
    dropdownFrameCorner.Parent = dropdownFrame

    -- Update options function
    local function updateOptions()
        -- Clear old options
        for _, child in ipairs(dropdownFrame:GetChildren()) do
            if child:IsA('TextButton') then
                child:Destroy()
            end
        end

        -- Get new options
        local options = optionsGetter() or {}

        -- Create option buttons with high z-index
        for i, option in ipairs(options) do
            local optionButton = Instance.new('TextButton')
            optionButton.Text = tostring(option)
            optionButton.BackgroundColor3 = colors.input
            optionButton.Size = UDim2.new(1, 0, 0, 30)
            optionButton.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
            optionButton.Font = Enum.Font.Gotham
            optionButton.TextColor3 = colors.text
            optionButton.TextSize = 14
            optionButton.TextXAlignment = Enum.TextXAlignment.Left
            optionButton.ZIndex = 101 -- Even higher than dropdown frame
            optionButton.Parent = dropdownFrame

            -- Add UI decorations
            Instance.new('UICorner', optionButton).CornerRadius = UDim.new(0, 4)
            Instance.new('UIPadding', optionButton).PaddingLeft = UDim.new(0, 8)

            -- Selection handler
            optionButton.MouseButton1Click:Connect(function()
                selectedButton.Text = option
                dropdownFrame.Visible = false
                dropdownContainer.Size = UDim2.new(1, 0, 0, 30)
                sectionFrame.Size = UDim2.new(1, 0, 0, 55) -- Label + dropdown
                callback(option, playerInput.Text)
            end)
        end

        -- Update dropdown size
        dropdownFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    end

    -- Toggle visibility with proper z-index management
    selectedButton.MouseButton1Click:Connect(function()
        local isExpanding = not dropdownFrame.Visible
        dropdownFrame.Visible = isExpanding

        if isExpanding then
            -- Bring to front when expanding
            sectionFrame.ZIndex = 100
            dropdownContainer.ZIndex = 100
            selectedButton.ZIndex = 101
            dropdownFrame.ZIndex = 102
            for _, option in ipairs(dropdownFrame:GetChildren()) do
                if option:IsA('TextButton') then
                    option.ZIndex = 103
                end
            end

            dropdownContainer.Size = UDim2.new(
                1,
                0,
                0,
                30 + #dropdownFrame:GetChildren() * 30
            )
            sectionFrame.Size = UDim2.new(
                1,
                0,
                0,
                25 + dropdownContainer.Size.Y.Offset
            )
        else
            -- Reset z-indices when collapsing
            sectionFrame.ZIndex = 1
            dropdownContainer.ZIndex = 1
            selectedButton.ZIndex = 2
            dropdownFrame.ZIndex = 100

            dropdownContainer.Size = UDim2.new(1, 0, 0, 30)
            sectionFrame.Size = UDim2.new(1, 0, 0, 55)
        end
    end)

    -- Initial update
    updateOptions()

    -- Set up periodic refresh if needed
    if refreshTime then
        spawn(function()
            while wait(refreshTime) do
                updateOptions()
            end
        end)
    end

    return {
        container = sectionFrame,
        update = updateOptions,
        destroy = function()
            -- Adjust layout position
            currentYPosition = currentYPosition
                - (sectionFrame.Size.Y.Offset + elementPadding)
            UpdateFrameSize()
            sectionFrame:Destroy()
        end,
    }
end

-- Draggable window functionality
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

titleBar.InputBegan:Connect(function(input)
    if
        input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch
    then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    then
        dragInput = input
    end
end)

game:GetService('UserInputService').InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

CreateSection('ESP')
local RunService = game:GetService('RunService')
local oreESPObjects = {}
local oreESPConnection

CreateToggle('Ore ESP', false, function(state)
    -- Clear existing ESPs and disconnect updater
    for _, gui in pairs(oreESPObjects) do
        if gui and gui.Parent then
            gui:Destroy()
        end
    end
    oreESPObjects = {}

    if oreESPConnection then
        oreESPConnection:Disconnect()
        oreESPConnection = nil
    end

    if state then
        oreESPConnection = RunService.Heartbeat:Connect(function()
            -- Clean up missing ESPs
            for i = #oreESPObjects, 1, -1 do
                local gui = oreESPObjects[i]
                if
                    not gui
                    or not gui.Parent
                    or not gui.Adornee
                    or not gui.Adornee.Parent
                then
                    table.remove(oreESPObjects, i)
                    if gui then
                        gui:Destroy()
                    end
                end
            end

            -- Add ESPs to new ores
            for _, v in pairs(game.Workspace.Items:GetChildren()) do
                if v:IsA('MeshPart') and v.Name then
                    local alreadyHasESP = false
                    for _, gui in pairs(oreESPObjects) do
                        if gui.Adornee == v then
                            alreadyHasESP = true
                            break
                        end
                    end

                    if not alreadyHasESP then
                        local billboard = Instance.new('BillboardGui')
                        billboard.Adornee = v
                        billboard.Size = UDim2.new(0, 100, 0, 40)
                        billboard.AlwaysOnTop = true

                        local label = Instance.new('TextLabel')
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.BackgroundTransparency = 1
                        local readableName = v.Name:match(
                            '^(.-)_%d+_%d+_%-?%d+_%1_'
                        ) or v.Name:match(
                            '^(.-)_%d+_%d+_%-?%d+'
                        )
                        label.Text = readableName or v.Name
                        label.TextColor3 = Color3.new(1, 1, 0)
                        label.TextStrokeTransparency = 0
                        label.TextScaled = true
                        label.Font = Enum.Font.GothamSemibold
                        label.Parent = billboard

                        billboard.Parent = v
                        table.insert(oreESPObjects, billboard)
                    end
                end
            end
        end)
    end
end)

CreateSection('Main')

local CollectItem =
    game:GetService('ReplicatedStorage')['shared/network/MiningNetwork@GlobalMiningEvents'].CollectItem
local collectConnection

CreateToggle('Collect Nearby ores', false, function(state)
    if state then
        collectConnection = game
            :GetService('RunService').Heartbeat
            :Connect(function()
                for _, v in pairs(game.Workspace.Items:GetChildren()) do
                    if v and v:IsA('MeshPart') and v.Name then
                        pcall(function()
                            CollectItem:FireServer(v.Name)
                        end)
                    end
                end
            end)
    else
        if collectConnection then
            collectConnection:Disconnect()
            collectConnection = nil
        end
    end
end)

local namecallHookEnabled = false
local originalNamecall
local metatableLocked = false

CreateToggle('Perfect Mine', false, function(state)
    if state then
        -- Enable the hook
        if not metatableLocked then
            local a = getrawmetatable(game)
            originalNamecall = a.__namecall
            setreadonly(a, false)
            
            a.__namecall = newcclosure(function(self, ...)
                local args = {...}
                if namecallHookEnabled and getnamecallmethod() == 'FireServer' and tostring(self) == 'Mine' then
                    if args[2] ~= 1 then
                        args[2] = 1
                    end
                    return originalNamecall(self, unpack(args))
                end
                return originalNamecall(self, ...)
            end)
            
            setreadonly(a, true)
            metatableLocked = true
        end
        namecallHookEnabled = true
    else
        -- Disable the hook (just stops modifying args, doesn't restore original)
        namecallHookEnabled = false
    end
end)

-- Function to get current ores
local function getOreOptions()
    local ores = {}
    for _, v in pairs(game.Workspace.Items:GetChildren()) do
        if v:IsA('MeshPart') and v.Name then
            local readable = v.Name:match('^(.-)_%d+_%d+_%-?%d+_%1_')
                or v.Name:match('^(.-)_%d+_%d+_%-?%d+')
                or v.Name
            local displayName = string.format(
                '%s (%.0f, %.0f, %.0f)',
                readable,
                v.Position.X,
                v.Position.Y,
                v.Position.Z
            )
            table.insert(ores, displayName)
        end
    end
    return ores
end

-- Function to handle ore selection
local function handleOreSelection(selectedDisplayName)
    for _, v in pairs(game.Workspace.Items:GetChildren()) do
        if v:IsA('MeshPart') and v.Name then
            local readable = v.Name:match('^(.-)_%d+_%d+_%-?%d+_%1_')
                or v.Name:match('^(.-)_%d+_%d+_%-?%d+')
                or v.Name
            local compName = string.format(
                '%s (%.0f, %.0f, %.0f)',
                readable,
                v.Position.X,
                v.Position.Y,
                v.Position.Z
            )
            if compName == selectedDisplayName then
                pcall(function()
                    CollectItem:FireServer(v.Name)
                end)
                break
            end
        end
    end
end


local oreDropdown = CreateUpdatingDropdown(
    'Nearby Ores',
    getOreOptions,
    handleOreSelection,
    3--three second delay, dont mess with if silly
)

CreateSection('Information')
CreateLabel('Status: Ready')
CreateLabel('Players Online: ' .. #Players:GetPlayers())
--LIKE AND SUBSCRIBE!!! :3
