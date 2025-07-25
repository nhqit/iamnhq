-- Auto Clicker Script with GUI for Roblox
-- Tạo bởi Copilot cho nhqit

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoClickerGUI"
ScreenGui.Parent = Player.PlayerGui

-- Tạo khung chính
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Tạo tiêu đề
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleLabel.BorderSizePixel = 0
TitleLabel.Text = "Trợ Giúp Tự Động Click"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Parent = MainFrame

-- Tạo nút bắt đầu/dừng
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0.8, 0, 0, 50)
ToggleButton.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "Bắt Đầu Click"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 20
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Parent = MainFrame

-- Hiển thị tốc độ click
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Name = "SpeedLabel"
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0.7, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Tốc độ click: 0.5 giây"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.Parent = MainFrame

-- Thanh điều chỉnh tốc độ
local SpeedSlider = Instance.new("Frame")
SpeedSlider.Name = "SpeedSlider"
SpeedSlider.Size = UDim2.new(0.8, 0, 0, 20)
SpeedSlider.Position = UDim2.new(0.1, 0, 0.8, 0)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
SpeedSlider.BorderSizePixel = 0
SpeedSlider.Parent = MainFrame

local SliderButton = Instance.new("TextButton")
SliderButton.Name = "SliderButton"
SliderButton.Size = UDim2.new(0.1, 0, 1, 0)
SliderButton.Position = UDim2.new(0.5, -10, 0, 0)
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderButton.BorderSizePixel = 0
SliderButton.Text = ""
SliderButton.Parent = SpeedSlider

-- Biến để theo dõi trạng thái
local isClicking = false
local clickSpeed = 0.5 -- Mặc định 0.5 giây mỗi lần click

-- Hàm thực hiện click
local function performClick()
    if isClicking then
        -- Mô phỏng click chuột
        mouse1click()
        -- Gọi lại sau một khoảng thời gian
        wait(clickSpeed)
        performClick()
    end
end

-- Xử lý nút bắt đầu/dừng
ToggleButton.MouseButton1Click:Connect(function()
    isClicking = not isClicking
    
    if isClicking then
        ToggleButton.Text = "Dừng Click"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        performClick()
    else
        ToggleButton.Text = "Bắt Đầu Click"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    end
end)

-- Xử lý thanh trượt tốc độ
local isDraggingSlider = false

SliderButton.MouseButton1Down:Connect(function()
    isDraggingSlider = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDraggingSlider = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDraggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local sliderPos = SpeedSlider.AbsolutePosition
        local sliderSize = SpeedSlider.AbsoluteSize
        
        local relativeX = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
        SliderButton.Position = UDim2.new(relativeX, -10, 0, 0)
        
        -- Tốc độ từ 0.1 đến 2 giây
        clickSpeed = 0.1 + relativeX * 1.9
        SpeedLabel.Text = "Tốc độ click: " .. string.format("%.1f", clickSpeed) .. " giây"
    end
end)

-- Chức năng đóng GUI
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    isClicking = false
    ScreenGui:Destroy()
end)

-- Phím tắt để hiện/ẩn GUI (Phím F)
local isGuiVisible = true

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        isGuiVisible = not isGuiVisible
        ScreenGui.Enabled = isGuiVisible
    end
end)

print("Auto Clicker GUI đã được tải!")
