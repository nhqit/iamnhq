-- ===================================================================
-- SCRIPT MENU UI KIỂM THỬ GAME
-- Phiên bản cải tiến với thanh trượt tốc độ và giao diện kéo thả.
-- Đặt script này trong một LocalScript trong StarterPlayerScripts.
-- ===================================================================

-- ===== PHẦN CẤU HÌNH (SỬA Ở ĐÂY) =====
-- !!! THAY ĐỔI DÒNG NÀY: Trỏ đến RemoteEvent của bạn trong ReplicatedStorage
local increaseStrengthEvent = game:GetService("ReplicatedStorage"):WaitForChild("IncreaseStrengthEvent") 

local MIN_CPS = 1 -- Tốc độ click chậm nhất (Clicks Per Second)
local MAX_CPS = 20 -- Tốc độ click nhanh nhất (Clicks Per Second)

-- ===== PHẦN LOGIC (Không cần sửa từ đây trở xuống) =====
local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")

local isAutoClicking = false
local clickDelay = 1 / MIN_CPS
local isDragging = false

-- 1. TẠO GIAO DIỆN (GUI)
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "TestMenuGUI"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 220, 0, 120)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 37, 40)
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 24)
titleBar.BackgroundColor3 = Color3.fromRGB(48, 51, 56)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -24, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
titleLabel.Font = Enum.Font.SourceSansSemibold
titleLabel.Text = "  Dev Test Menu"
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local toggleMenuButton = Instance.new("TextButton")
toggleMenuButton.Name = "ToggleMenuButton"
toggleMenuButton.Size = UDim2.new(0, 24, 1, 0)
toggleMenuButton.Position = UDim2.new(1, -24, 0, 0)
toggleMenuButton.BackgroundColor3 = titleBar.BackgroundColor3
toggleMenuButton.BackgroundTransparency = 0
toggleMenuButton.TextColor3 = Color3.fromRGB(220, 220, 220)
toggleMenuButton.Font = Enum.Font.SourceSansBold
toggleMenuButton.Text = "-"
toggleMenuButton.Parent = titleBar

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -24)
contentFrame.Position = UDim2.new(0, 0, 0, 24)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local autoClickButton = Instance.new("TextButton")
autoClickButton.Name = "AutoClickButton"
autoClickButton.Size = UDim2.new(1, -20, 0, 25)
autoClickButton.Position = UDim2.new(0, 10, 0, 10)
autoClickButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
autoClickButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoClickButton.Font = Enum.Font.SourceSans
autoClickButton.Text = "Bật Auto-Click"
autoClickButton.Parent = contentFrame

local sliderLabel = Instance.new("TextLabel")
sliderLabel.Name = "SliderLabel"
sliderLabel.Size = UDim2.new(1, -20, 0, 20)
sliderLabel.Position = UDim2.new(0, 10, 0, 45)
sliderLabel.BackgroundTransparency = 1
sliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
sliderLabel.Font = Enum.Font.SourceSans
sliderLabel.Text = "Tốc độ: " .. MIN_CPS .. " CPS"
sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
sliderLabel.Parent = contentFrame

local sliderTrack = Instance.new("Frame")
sliderTrack.Name = "SliderTrack"
sliderTrack.Size = UDim2.new(1, -20, 0, 8)
sliderTrack.Position = UDim2.new(0, 10, 0, 65)
sliderTrack.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
sliderTrack.BorderSizePixel = 0
sliderTrack.Parent = contentFrame

local sliderHandle = Instance.new("TextButton")
sliderHandle.Name = "SliderHandle"
sliderHandle.Size = UDim2.new(0, 12, 0, 12)
sliderHandle.Position = UDim2.new(0, -6, 0.5, -6)
sliderHandle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
sliderHandle.BorderSizePixel = 0
sliderHandle.Draggable = true
sliderHandle.Text = ""
sliderHandle.Parent = sliderTrack

-- 2. LOGIC VÀ SỰ KIỆN

-- Hàm bật/tắt auto-click
local function toggleAutoClicker()
	isAutoClicking = not isAutoClicking
	if isAutoClicking then
		autoClickButton.Text = "Tắt Auto-Click (Đang Chạy...)"
		autoClickButton.BackgroundColor3 = Color3.fromRGB(86, 152, 69) -- Xanh lá
		task.spawn(function()
			while isAutoClicking do
				increaseStrengthEvent:FireServer()
				task.wait(clickDelay)
			end
		end)
	else
		autoClickButton.Text = "Bật Auto-Click"
		autoClickButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- Xám
	end
end

-- Hàm cập nhật thanh trượt tốc độ
local function updateSlider(input)
	local percentage = math.clamp((mouse.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X, 0, 1)
	sliderHandle.Position = UDim2.new(percentage, -sliderHandle.AbsoluteSize.X / 2, 0.5, -6)
	
	local cps = MIN_CPS + (MAX_CPS - MIN_CPS) * percentage
	clickDelay = 1 / cps
	sliderLabel.Text = string.format("Tốc độ: %.1f CPS", cps)
end

-- Hàm ẩn/hiện menu
local function toggleMenu()
	contentFrame.Visible = not contentFrame.Visible
	if contentFrame.Visible then
		mainFrame.Size = UDim2.new(0, 220, 0, 120)
		toggleMenuButton.Text = "-"
	else
		mainFrame.Size = UDim2.new(0, 220, 0, 24)
		toggleMenuButton.Text = "+"
	end
end

-- Kết nối các sự kiện
autoClickButton.MouseButton1Click:Connect(toggleAutoClicker)
toggleMenuButton.MouseButton1Click:Connect(toggleMenu)

sliderHandle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		updateSlider()
	end
end)

sliderHandle.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		updateSlider()
	end
end)
