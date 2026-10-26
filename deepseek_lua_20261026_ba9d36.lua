-- Violence District Premium Hub
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Cleanup existing
if PlayerGui:FindFirstChild("VD_Premium") then
    PlayerGui:FindFirstChild("VD_Premium"):Destroy()
end

-- Config
local Config = {
    -- ESP
    killerESP = true,
    killerColor = Color3.fromRGB(255, 60, 60),
    killerDistance = 500,
    survivorESP = true,
    survivorColor = Color3.fromRGB(60, 200, 255),
    survivorDistance = 500,
    zombieESP = false,
    zombieColor = Color3.fromRGB(200, 60, 255),
    zombieDistance = 500,
    objectESP = false,
    generatorESP = false,
    palletESP = false,
    hookESP = false,
    gateESP = false,
    
    -- Combat
    aimbot = false,
    aimbotFOV = 150,
    aimbotTarget = "Killer",
    aimbotSmooth = 0.5,
    silentAim = false,
    silentAimFOV = 150,
    silentAimTarget = "Killer",
    
    -- Movement
    speedBoost = false,
    speedMultiplier = 1.3,
    noclip = false,
    fly = false,
    
    -- Misc
    godMode = false,
    antiAFK = false,
    fullbright = false,
    noFog = false,
    autoGenerator = false,
    genMode = "Instant",
    
    -- Visual
    crosshair = false,
    crosshairColor = Color3.fromRGB(255, 255, 255),
    crosshairSize = 20,
    fovCircle = false,
    fovRadius = 150,
}

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VD_Premium"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 500)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(100, 100, 150)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 15)
TopBarFix.Position = UDim2.new(0, 0, 1, -15)
TopBarFix.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 220, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ VD Premium Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -45, 0.5, -17.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- Tab Container
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(1, -20, 0, 45)
TabContainer.Position = UDim2.new(0, 10, 0, 60)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)
TabLayout.Parent = TabContainer

-- Content Container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -20, 1, -115)
ContentContainer.Position = UDim2.new(0, 10, 0, 110)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, 0, 1, 0)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 3
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentScroll.Parent = ContentContainer

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.Parent = ContentScroll

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 5)
ContentPadding.PaddingBottom = UDim.new(0, 5)
ContentPadding.Parent = ContentScroll

-- Drag Functionality
local dragging = false
local dragInput, mousePos, framePos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        MainFrame.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

-- Close Button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tab System
local tabs = {}
local currentTab = nil

local function createTab(name, order)
    local Tab = Instance.new("TextButton")
    Tab.Name = name .. "Tab"
    Tab.Size = UDim2.new(0, 75, 1, 0)
    Tab.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    Tab.Text = name
    Tab.TextColor3 = Color3.fromRGB(180, 180, 200)
    Tab.TextSize = 12
    Tab.Font = Enum.Font.GothamSemibold
    Tab.LayoutOrder = order
    Tab.Parent = TabContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = Tab
    
    local TabContent = Instance.new("Frame")
    TabContent.Name = name .. "Content"
    TabContent.Size = UDim2.new(1, 0, 0, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.Parent = ContentScroll
    
    local TabContentLayout = Instance.new("UIListLayout")
    TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabContentLayout.Padding = UDim.new(0, 8)
    TabContentLayout.Parent = TabContent
    
    tabs[name] = {
        button = Tab,
        content = TabContent
    }
    
    Tab.MouseButton1Click:Connect(function()
        if currentTab then
            tabs[currentTab].button.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
            tabs[currentTab].button.TextColor3 = Color3.fromRGB(180, 180, 200)
            tabs[currentTab].content.Visible = false
        end
        
        Tab.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
        Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabContent.Visible = true
        currentTab = name
    end)
    
    return TabContent
end

-- Toggle Button Creator
local function createToggle(parent, name, description, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 65)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Color3.fromRGB(60, 60, 80)
    ToggleStroke.Thickness = 1
    ToggleStroke.Parent = ToggleFrame
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(0, 220, 0, 25)
    NameLabel.Position = UDim2.new(0, 15, 0, 10)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.TextSize = 14
    NameLabel.Font = Enum.Font.GothamSemibold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = ToggleFrame
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(0, 220, 0, 20)
    DescLabel.Position = UDim2.new(0, 15, 0, 35)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
    DescLabel.TextSize = 10
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 50, 0, 25)
    ToggleButton.Position = UDim2.new(1, -65, 0.5, -12.5)
    ToggleButton.BackgroundColor3 = default and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(80, 80, 100)
    ToggleButton.Text = ""
    ToggleButton.AutoButtonColor = false
    ToggleButton.Parent = ToggleFrame
    
    local ToggleButtonCorner = Instance.new("UICorner")
    ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
    ToggleButtonCorner.Parent = ToggleButton
    
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Size = UDim2.new(0, 21, 0, 21)
    ToggleCircle.Position = default and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleCircle.BorderSizePixel = 0
    ToggleCircle.Parent = ToggleButton
    
    local ToggleCircleCorner = Instance.new("UICorner")
    ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCircleCorner.Parent = ToggleCircle
    
    local enabled = default
    
    ToggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        TweenService:Create(ToggleButton, tweenInfo, {
            BackgroundColor3 = enabled and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(80, 80, 100)
        }):Play()
        
        TweenService:Create(ToggleCircle, tweenInfo, {
            Position = enabled and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
        }):Play()
        
        if callback then
            callback(enabled)
        end
    end)
    
    return ToggleButton
end

-- Slider Creator
local function createSlider(parent, name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 55)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 8)
    SliderCorner.Parent = SliderFrame
    
    local SliderStroke = Instance.new("UIStroke")
    SliderStroke.Color = Color3.fromRGB(60, 60, 80)
    SliderStroke.Thickness = 1
    SliderStroke.Parent = SliderFrame
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(0, 220, 0, 20)
    NameLabel.Position = UDim2.new(0, 15, 0, 8)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.TextSize = 13
    NameLabel.Font = Enum.Font.GothamSemibold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 50, 0, 20)
    ValueLabel.Position = UDim2.new(1, -60, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
    ValueLabel.TextSize = 12
    ValueLabel.Font = Enum.Font.Gotham
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = SliderFrame
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -30, 0, 6)
    SliderBar.Position = UDim2.new(0, 15, 1, -20)
    SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = SliderFrame
    
    local SliderBarCorner = Instance.new("UICorner")
    SliderBarCorner.CornerRadius = UDim.new(1, 0)
    SliderBarCorner.Parent = SliderBar
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBar
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(1, 0, 1, 10)
    SliderButton.Position = UDim2.new(0, 0, 0, -5)
    SliderButton.BackgroundTransparency = 1
    SliderButton.Text = ""
    SliderButton.Parent = SliderBar
    
    local dragging = false
    
    SliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    SliderButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local mouseX = input.Position.X
            local barPos = SliderBar.AbsolutePosition.X
            local barWidth = SliderBar.AbsoluteSize.X
            
            local relativeX = math.clamp((mouseX - barPos) / barWidth, 0, 1)
            local value = math.floor(min + (max - min) * relativeX)
            
            SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            ValueLabel.Text = tostring(value)
            
            if callback then
                callback(value)
            end
        end
    end)
    
    return SliderBar
end

-- Dropdown Creator
local function createDropdown(parent, name, options, default, callback)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Size = UDim2.new(1, 0, 0, 55)
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Parent = parent
    
    local DropdownCorner = Instance.new("UICorner")
    DropdownCorner.CornerRadius = UDim.new(0, 8)
    DropdownCorner.Parent = DropdownFrame
    
    local DropdownStroke = Instance.new("UIStroke")
    DropdownStroke.Color = Color3.fromRGB(60, 60, 80)
    DropdownStroke.Thickness = 1
    DropdownStroke.Parent = DropdownFrame
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(0, 220, 0, 20)
    NameLabel.Position = UDim2.new(0, 15, 0, 8)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.TextSize = 13
    NameLabel.Font = Enum.Font.GothamSemibold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = DropdownFrame
    
    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(1, -30, 0, 25)
    DropdownButton.Position = UDim2.new(0, 15, 1, -32)
    DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    DropdownButton.Text = default
    DropdownButton.TextColor3 = Color3.fromRGB(200, 200, 220)
    DropdownButton.TextSize = 12
    DropdownButton.Font = Enum.Font.Gotham
    DropdownButton.Parent = DropdownFrame
    
    local DropdownButtonCorner = Instance.new("UICorner")
    DropdownButtonCorner.CornerRadius = UDim.new(0, 6)
    DropdownButtonCorner.Parent = DropdownButton
    
    local expanded = false
    local optionButtons = {}
    
    DropdownButton.MouseButton1Click:Connect(function()
        expanded = not expanded
        
        for _, btn in ipairs(optionButtons) do
            btn:Destroy()
        end
        optionButtons = {}
        
        if expanded then
            for i, option in ipairs(options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Size = UDim2.new(1, -30, 0, 25)
                OptionButton.Position = UDim2.new(0, 15, 1, -32 + (i * 27))
                OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
                OptionButton.Text = option
                OptionButton.TextColor3 = Color3.fromRGB(200, 200, 220)
                OptionButton.TextSize = 12
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.ZIndex = 10
                OptionButton.Parent = DropdownFrame
                
                local OptionCorner = Instance.new("UICorner")
                OptionCorner.CornerRadius = UDim.new(0, 6)
                OptionCorner.Parent = OptionButton
                
                OptionButton.MouseButton1Click:Connect(function()
                    DropdownButton.Text = option
                    expanded = false
                    for _, btn in ipairs(optionButtons) do
                        btn:Destroy()
                    end
                    optionButtons = {}
                    if callback then
                        callback(option)
                    end
                end)
                
                table.insert(optionButtons, OptionButton)
            end
        end
    end)
    
    return DropdownButton
end

-- Create Tabs
local espTab = createTab("ESP", 1)
local combatTab = createTab("Combat", 2)
local movementTab = createTab("Move", 3)
local visualTab = createTab("Visual", 4)
local miscTab = createTab("Misc", 5)

-- ESP Tab
createToggle(espTab, "Killer ESP", "Show killer outline & name", Config.killerESP, function(enabled)
    Config.killerESP = enabled
end)

createToggle(espTab, "Survivor ESP", "Show survivor outline & name", Config.survivorESP, function(enabled)
    Config.survivorESP = enabled
end)

createToggle(espTab, "Zombie/SCP ESP", "Show zombie entities", Config.zombieESP, function(enabled)
    Config.zombieESP = enabled
end)

createToggle(espTab, "Generator ESP", "Highlight generators", Config.generatorESP, function(enabled)
    Config.generatorESP = enabled
end)

createToggle(espTab, "Pallet ESP", "Highlight pallets", Config.palletESP, function(enabled)
    Config.palletESP = enabled
end)

createToggle(espTab, "Hook ESP", "Highlight hooks", Config.hookESP, function(enabled)
    Config.hookESP = enabled
end)

createToggle(espTab, "Gate ESP", "Highlight escape gates", Config.gateESP, function(enabled)
    Config.gateESP = enabled
end)

createSlider(espTab, "ESP Distance", 50, 1000, 500, function(value)
    Config.killerDistance = value
    Config.survivorDistance = value
    Config.zombieDistance = value
end)

-- Combat Tab
createToggle(combatTab, "Aimbot", "Auto aim at targets", Config.aimbot, function(enabled)
    Config.aimbot = enabled
end)

createSlider(combatTab, "Aimbot FOV", 30, 500, 150, function(value)
    Config.aimbotFOV = value
end)

createDropdown(combatTab, "Aimbot Target", {"Killer", "Survivor", "Zombie"}, "Killer", function(value)
    Config.aimbotTarget = value
end)

createSlider(combatTab, "Aimbot Smooth", 0.1, 1, 0.5, function(value)
    Config.aimbotSmooth = value / 10
end)

createToggle(combatTab, "Silent Aim", "Bypass hit detection", Config.silentAim, function(enabled)
    Config.silentAim = enabled
end)

createSlider(combatTab, "Silent Aim FOV", 30, 500, 150, function(value)
    Config.silentAimFOV = value
end)

createDropdown(combatTab, "Silent Aim Target", {"Killer", "Survivor", "Zombie"}, "Killer", function(value)
    Config.silentAimTarget = value
end)

-- Movement Tab
createToggle(movementTab, "Speed Boost", "Increase walk speed", Config.speedBoost, function(enabled)
    Config.speedBoost = enabled
end)

createSlider(movementTab, "Speed Multiplier", 1, 3, 1.3, function(value)
    Config.speedMultiplier = value / 10
end)

createToggle(movementTab, "Noclip", "Walk through walls", Config.noclip, function(enabled)
    Config.noclip = enabled
end)

createToggle(movementTab, "Fly", "Enable flight", Config.fly, function(enabled)
    Config.fly = enabled
end)

-- Visual Tab
createToggle(visualTab, "Crosshair", "Custom crosshair", Config.crosshair, function(enabled)
    Config.crosshair = enabled
end)

createToggle(visualTab, "FOV Circle", "Show aim FOV circle", Config.fovCircle, function(enabled)
    Config.fovCircle = enabled
end)

createSlider(visualTab, "FOV Radius", 30, 500, 150, function(value)
    Config.fovRadius = value
end)

createToggle(visualTab, "Fullbright", "Remove darkness", Config.fullbright, function(enabled)
    Config.fullbright = enabled
    if enabled then
        Lighting.Brightness = 3
        Lighting.ClockTime = 12
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 14
        Lighting.FogEnd = 10000
        Lighting.GlobalShadows = true
    end
end)

createToggle(visualTab, "No Fog", "Remove fog effect", Config.noFog, function(enabled)
    Config.noFog = enabled
    if enabled then
        Lighting.FogEnd = 100000
    else
        Lighting.FogEnd = 10000
    end
end)

-- Misc Tab
createToggle(miscTab, "God Mode", "Infinite health", Config.godMode, function(enabled)
    Config.godMode = enabled
end)

createToggle(miscTab, "Anti AFK", "Prevent AFK kick", Config.antiAFK, function(enabled)
    Config.antiAFK = enabled
end)

createToggle(miscTab, "Auto Generator", "Auto repair generators", Config.autoGenerator, function(enabled)
    Config.autoGenerator = enabled
end)

createDropdown(miscTab, "Gen Mode", {"Instant", "Perfect", "Normal", "Random"}, "Instant", function(value)
    Config.genMode = value
end)

-- Initialize first tab
tabs["ESP"].button.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
tabs["ESP"].button.TextColor3 = Color3.fromRGB(255, 255, 255)
tabs["ESP"].content.Visible = true
currentTab = "ESP"

-- ESP Implementation
local espFolder = Instance.new("Folder")
espFolder.Name = "VD_ESP"
espFolder.Parent = Workspace

local function getRole(player)
    if player.Team then
        local teamName = player.Team.Name:lower()
        if teamName:find("killer") then
            return "killer"
        end
    end
    return "survivor"
end

local function createESP(player)
    if player == LocalPlayer then return end
    
    local role = getRole(player)
    local isKiller = role == "killer"
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "VD_Highlight_" .. player.Name
    highlight.Adornee = player.Character
    highlight.FillColor = isKiller and Config.killerColor or Config.survivorColor
    highlight.OutlineColor = isKiller and Config.killerColor or Config.survivorColor
    highlight.FillTransparency = 0.6
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Enabled = isKiller and Config.killerESP or Config.survivorESP
    highlight.Parent = espFolder
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "VD_Billboard_" .. player.Name
    billboard.Adornee = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
    billboard.Size = UDim2.new(0, 150, 0, 20)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = isKiller and Config.killerDistance or Config.survivorDistance
    billboard.Enabled = isKiller and Config.killerESP or Config.survivorESP
    billboard.Parent = espFolder
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name .. " [" .. role:upper() .. "]"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboard
    
    return {highlight = highlight, billboard = billboard, nameLabel = nameLabel}
end

-- Setup ESP for existing players
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character then
        createESP(player)
    end
end

-- Setup ESP for new players
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(1)
        createESP(player)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    local highlight = espFolder:FindFirstChild("VD_Highlight_" .. player.Name)
    local billboard = espFolder:FindFirstChild("VD_Billboard_" .. player.Name)
    if highlight then highlight:Destroy() end
    if billboard then billboard:Destroy() end
end)

-- Main Loop
local VirtualUser = game:GetService("VirtualUser")

RunService.Heartbeat:Connect(function()
    -- Anti AFK
    if Config.antiAFK then
        LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
    
    -- God Mode
    if Config.godMode then
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = humanoid.MaxHealth
            end
        end
    end
    
    -- Speed Boost
    if Config.speedBoost then
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16 * Config.speedMultiplier
            end
        end
    else
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.WalkSpeed ~= 16 then
                humanoid.WalkSpeed = 16
            end
        end
    end
    
    -- Noclip
    if Config.noclip then
        local character = LocalPlayer.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Fly Implementation
local flyBodyVelocity, flyBodyGyro

local function startFly()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    flyBodyVelocity.Parent = humanoidRootPart
    
    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    flyBodyGyro.P = 9e4
    flyBodyGyro.Parent = humanoidRootPart
end

local function stopFly()
    if flyBodyVelocity then
        flyBodyVelocity:Destroy()
        flyBodyVelocity = nil
    end
    if flyBodyGyro then
        flyBodyGyro:Destroy()
        flyBodyGyro = nil
    end
end

-- Fly Controls
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not Config.fly then return end
    
    if input.KeyCode == Enum.KeyCode.W then
        if flyBodyVelocity then
            flyBodyVelocity.Velocity = Workspace.CurrentCamera.CFrame.LookVector * 50
        end
    elseif input.KeyCode == Enum.KeyCode.S then
        if flyBodyVelocity then
            flyBodyVelocity.Velocity = -Workspace.CurrentCamera.CFrame.LookVector * 50
        end
    elseif input.KeyCode == Enum.KeyCode.A then
        if flyBodyVelocity then
            flyBodyVelocity.Velocity = -Workspace.CurrentCamera.CFrame.RightVector * 50
        end
    elseif input.KeyCode == Enum.KeyCode.D then
        if flyBodyVelocity then
            flyBodyVelocity.Velocity = Workspace.CurrentCamera.CFrame.RightVector * 50
        end
    elseif input.KeyCode == Enum.KeyCode.Space then
        if flyBodyVelocity then
            flyBodyVelocity.Velocity = Vector3.new(0, 50, 0)
        end
    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        if flyBodyVelocity then
            flyBodyVelocity.Velocity = Vector3.new(0, -50, 0)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not Config.fly then return end
    
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S or 
       input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D or
       input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftShift then
        if flyBodyVelocity then
            flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

-- Toggle fly
local flyEnabled = false
createToggle(movementTab, "Enable Fly", "WASD + Space/Shift", false, function(enabled)
    flyEnabled = enabled
    if enabled then
        startFly()
    else
        stopFly()
    end
end)

-- Crosshair
local crosshairFrame
local function createCrosshair()
    if crosshairFrame then
        crosshairFrame:Destroy()
    end
    
    crosshairFrame = Instance.new("Frame")
    crosshairFrame.Name = "Crosshair"
    crosshairFrame.Size = UDim2.new(0, Config.crosshairSize, 0, Config.crosshairSize)
    crosshairFrame.Position = UDim2.new(0.5, -Config.crosshairSize/2, 0.5, -Config.crosshairSize/2)
    crosshairFrame.BackgroundColor3 = Config.crosshairColor
    crosshairFrame.BackgroundTransparency = 0.3
    crosshairFrame.BorderSizePixel = 0
    crosshairFrame.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = crosshairFrame
end

-- FOV Circle
local fovCircleFrame
local function createFOVCircle()
    if fovCircleFrame then
        fovCircleFrame:Destroy()
    end
    
    fovCircleFrame = Instance.new("Frame")
    fovCircleFrame.Name = "FOVCircle"
    fovCircleFrame.Size = UDim2.new(0, Config.fovRadius * 2, 0, Config.fovRadius * 2)
    fovCircleFrame.Position = UDim2.new(0.5, -Config.fovRadius, 0.5, -Config.fovRadius)
    fovCircleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    fovCircleFrame.BackgroundTransparency = 0.9
    fovCircleFrame.BorderSizePixel = 0
    fovCircleFrame.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = fovCircleFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.5
    stroke.Parent = fovCircleFrame
end

-- Update crosshair and FOV circle
RunService.RenderStepped:Connect(function()
    if Config.crosshair and not crosshairFrame then
        createCrosshair()
    elseif not Config.crosshair and crosshairFrame then
        crosshairFrame:Destroy()
        crosshairFrame = nil
    end
    
    if Config.fovCircle and not fovCircleFrame then
        createFOVCircle()
    elseif not Config.fovCircle and fovCircleFrame then
        fovCircleFrame:Destroy()
        fovCircleFrame = nil
    end
end)

-- Auto Generator
local function autoGenerator()
    if not Config.autoGenerator then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local repairEvent = ReplicatedStorage:FindFirstChild("Remotes") and 
                         ReplicatedStorage.Remotes:FindFirstChild("Generator") and 
                         ReplicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
    
    if not repairEvent then return end
    
    -- Find nearest generator point
    local nearestPoint = nil
    local nearestDistance = math.huge
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name:match("^GeneratorPoint") and obj:IsA("BasePart") then
            local distance = (obj.Position - humanoidRootPart.Position).Magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestPoint = obj
            end
        end
    end
    
    if nearestPoint and nearestDistance < 10 then
        pcall(function()
            repairEvent:FireServer(nearestPoint, true)
            wait(0.1)
            repairEvent:FireServer(nearestPoint, false)
        end)
    end
end

-- Auto Generator Loop
RunService.Heartbeat:Connect(function()
    if Config.autoGenerator then
        autoGenerator()
    end
end)

print("VD Premium Hub loaded successfully!")
