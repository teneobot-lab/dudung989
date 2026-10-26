--[[ VD Premium Hub - Redesigned UI ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RillBoys/bolong.catui/refs/heads/main/b0longUi.lua"))()

local str = "v1.0.0"
local color3 = Color3.fromRGB(255, 255, 255)

local function fn2(arg2, content, delay)
    library:MakeNotify({
        Title = arg2 or "VD-HUB",
        Description = "Info",
        Content = content or "",
        Color = color3,
        Time = 0.4,
        Delay = delay or 2,
    })
end

-- Config
local tbl = {
    flag1 = false, flag64 = true, flag65 = true,
    color31 = Color3.fromRGB(255, 60, 60),
    flag66 = false, flag67 = true, flag68 = true,
    color37 = Color3.fromRGB(60, 200, 255),
    maxDistance = 500, num1 = 500, num113 = 500,
    fillTransparency = 0.6,
    flag69 = false, flag70 = true, num114 = 500,
    color38 = Color3.fromRGB(200, 60, 255),
    flag71 = false, cameraZoomValue = 1000,
    flag72 = false, num115 = 5,
    flag73 = false, num116 = 1.7777777777777777,
    flag74 = false, warnDist1 = 60, warnDist2 = 40, warnDist3 = 20,
    num117 = 70, flag75 = false, flag76 = true, str1 = "Instant",
    flag77 = false, flag78 = false, flag79 = false,
    str11 = "Zombie", num118 = 700, num119 = 1,
    str12 = "Always Lock", str13 = "Torso",
    flag80 = false, flag81 = false,
    color39 = Color3.fromRGB(200, 100, 0),
    flag82 = false, color310 = Color3.fromRGB(255, 223, 0),
    flag83 = false, color311 = Color3.fromRGB(53, 189, 166),
    flag84 = false, color312 = Color3.fromRGB(252, 116, 116),
    flag85 = false, color313 = Color3.fromRGB(255, 255, 255),
    flag86 = false, flag87 = false,
    cameraVeilMaxDistance = 175, cameraVeilSmoothness = 1,
    cameraVeilSpearSpeed = 220, cameraVeilGravityMult = 0.5,
    cameraVeilTargetType = "Survivor",
    flag88 = false, flag89 = false,
    num120 = 150, str14 = "Killer",
    flag90 = true, flag91 = true, num121 = 150,
    flag92 = true, flag93 = true,
    spearPingLead = 1, spearSnaplineMaxDistance = 400,
    flag94 = true, flag95 = false, num122 = 18,
    flag96 = false, flag97 = false, flag98 = false,
    flag99 = false, str15 = "Classic",
    num123 = 0.55, num124 = 6,
    flag100 = false, flag101 = false, flag102 = false,
    num125 = 15, flag103 = false, flag104 = false,
    flag105 = false, flag106 = false, flag107 = false,
}

local tbl2 = {
    espObjects = {}, outlineObjects = {}, playerRoles = {},
    playerTeamConns = {}, playerCharConns = {},
    list1 = {Generators = {}, Pallets = {}, Hooks = {}, Gates = {}},
    list2 = {}, list3 = {}, list4 = {}, list5 = {},
    num126 = 1, field1 = nil, connection1 = nil, flag108 = false,
    list6 = {}, flag109 = false, SpeedBoost = false,
    num127 = 0.3, flag110 = true, flag111 = false,
    safeModeSpeed = true, flag112 = true, flag113 = false,
    flag114 = false, num128 = 1.3, flag115 = true,
    str16 = "Both", num129 = 0,
    scpEspObjects = {}, flag116 = false, flag117 = false,
    num130 = 10, num131 = 0, list7 = {},
    num132 = 1.5, num133 = 0, list8 = {},
    killerCharacters = {}, num134 = 1,
    flag118 = false, flag119 = false,
    list9 = {}, list10 = {}, flag120 = false,
    num135 = 50, flag121 = false, flag122 = false,
    health1 = nil, flag123 = false, num136 = 0, num137 = 0,
    flag124 = false, cameraMaxZoomDistance1 = nil,
    fieldOfView1 = nil, cursorBackupIcon = nil,
    cursorBackupBehavior = nil, connection9 = nil,
    connection10 = nil, mouseIconEnabled1 = nil,
    mouseBehavior1 = nil, field2 = nil,
    flag125 = false, list11 = {},
    pnameNameConns = {}, pnameSlotConns = {},
    connection11 = nil, connection12 = nil,
    field3 = nil, field4 = nil, field5 = nil,
    flag126 = false, avatarUiSlotConns = {},
    connection13 = nil, connection14 = nil,
    flag127 = false, field6 = nil, flag128 = false,
    flag129 = false, flag130 = false,
    unit1 = nil, field7 = nil, field8 = nil,
    field9 = nil, field10 = nil, field11 = nil,
    num138 = 0, num139 = -99, flag131 = false,
    num140 = -99, field12 = nil, num141 = -99,
    field13 = nil, field14 = nil, field15 = nil, field16 = nil,
    list12 = {}, connection15 = nil, connection16 = nil,
    connection17 = nil, connection18 = nil, list13 = {},
    CV_RenderStepName = "VD_CameraVeil",
    skipEndScreenConns = {}, flag132 = false, flag133 = false,
    flag134 = false, field17 = nil,
    vector31 = nil, vector358 = Vector3.new(0,0,0),
    vector359 = Vector3.new(0,0,0),
    list14 = {}, field18 = nil, field19 = nil,
    list15 = nil, flag135 = true, flag136 = false,
    field20 = nil, field21 = nil, frame1 = nil,
    flag137 = false, flag138 = false, field22 = nil,
    vector360 = Vector3.new(0,0,0), field23 = nil,
    flag139 = false, flag140 = false, flag141 = false,
    now1 = nil, num142 = 142.5, num143 = 0.5, num144 = 1,
    SPEAR_SNAPLINE = {enabled = false, flag142 = false, field24 = nil, str17 = "", huge1 = math.huge, lockPulse = 0},
    frame17 = nil, field25 = nil, textLabel1 = nil,
    textLabel10 = nil, frame18 = nil, frame19 = nil,
    screenGui1 = nil, frame20 = nil, frame21 = nil,
    textLabel11 = nil, flag143 = false,
    autoCrouchActiveSlashers = {}, autoCrouchAnimConns = {},
    _hookedMobButtons = {}, _hookedSlasherButtons = {},
    num145 = 0, num146 = 0, flag144 = false, flag145 = false,
    movConns = {antiFall = nil, noSlow = nil},
    field26 = nil, connection19 = nil, field27 = nil,
    connection20 = nil, field28 = nil, num147 = 0,
    field29 = nil, ghostGateOriginals = {},
    flag146 = false, field30 = nil, field31 = nil,
    flag147 = false, str18 = "Unknown",
    field32 = nil, connection21 = nil,
    flag148 = false, list16 = nil, num148 = 0,
    flag149 = false, num149 = 0, flag150 = false,
    flag151 = false, field33 = nil, num150 = 0,
    num151 = 1, num152 = 0,
    fastVaultPoints = {}, fastVaultLastScan = 0,
    num153 = 0, num154 = 0, flag152 = true,
    list17 = {}, hookCounterAttrConns = {},
    connection22 = nil, connection23 = nil, connection24 = nil,
    flag153 = false, num155 = 250,
    stunTimerBoards = {}, stunTimerForced = {},
    stunTimerAnim = {}, stunTimerConns = {},
    flag154 = false, stunTimerLens = {},
    flag155 = false, flag156 = false, num156 = 0.35,
    flag157 = false, list18 = nil, flag158 = false,
    connection25 = nil, num157 = 0, num158 = 0, num159 = 0,
    flag159 = false, num160 = 1, num161 = 0,
    connection26 = nil, flag160 = false, flag161 = false,
    flag162 = false, list19 = {}, connection27 = nil,
    connection28 = nil, list20 = {}, connection29 = nil,
    flag163 = false, flag164 = false, field34 = nil,
    specConns = {}, specDetected = {}, specStreamTimes = {},
    flag165 = false, potatoProcessed = {}, potatoPallets = {},
    list21 = {}, field35 = nil, num162 = 1,
    list22 = {}, num163 = 1, num164 = 0,
    list23 = {}, list24 = {}, list25 = {}, list26 = {},
    qualityLevel1 = nil, globalShadows1 = nil, fogEnd1 = nil,
    list27 = {}, flag166 = false,
}

-- ESP Folder
local folder = Instance.new("Folder")
folder.Name = "__VDESP__"
folder.Parent = workspace

local function fn4()
    if folder and folder.Parent then return folder end
    folder = Instance.new("Folder")
    folder.Name = "__VDESP__"
    folder.Parent = workspace
    return folder
end

-- Task scheduler
local tbl5 = {}
local function fn5(name, interval, fn)
    tbl5[#tbl5 + 1] = {name = name, interval = interval, timer = 0, fn = fn}
end

-- Role detection
local function fn10(player)
    local var62, var63 = pcall(function()
        return player.Team and player.Team.Name:lower() or ""
    end)
    tbl2.playerRoles[player] = var62 and var63:find("killer") and "killer" or "survivor"
end

local function fn9(player)
    return tbl2.playerRoles[player] or "survivor"
end

-- ESP Functions
local function fn39(isKiller)
    return isKiller and tbl.num1 or tbl.num113
end

local function CreateBillboardTag(arg33, color, size, arg34)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.AlwaysOnTop = true
    billboardGui.Size = size or UDim2.new(0, 40, 0, 40)
    billboardGui.StudsOffset = Vector3.new(0, 3.5, 0)
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "Label"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = arg33
    textLabel.TextColor3 = color
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextSize = arg34 or 22
    textLabel.Font = Enum.Font.GothamBold
    textLabel.RichText = true
    textLabel.Parent = billboardGui
    return billboardGui
end

local function GetCamPosition()
    local currentCamera = workspace.CurrentCamera
    if currentCamera then return currentCamera.CFrame.Position end
    return nil
end

local function AttachESPToChar(player, char)
    local var214 = tbl2.espObjects[player]
    if not var214 then return end
    if not char or not char.Parent or player.Character ~= char then return end
    local var215 = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Head")
    if not var215 then return end
    if var214.billboard then
        var214.billboard.Adornee = var215
        var214.billboard.Enabled = true
    end
    if var214.itemBillboard then
        var214.itemBillboard.Adornee = var215
        var214.itemBillboard.Enabled = true
    end
end

local function AttachOutlineToChar(player, char)
    local var219 = tbl2.outlineObjects[player]
    if not var219 then return end
    if not char or not char.Parent or player.Character ~= char then return end
    local var220 = fn9(player)
    local isKiller = var220 == "killer"
    local color = isKiller and tbl.color31 or tbl.color37
    local var221 = isKiller and tbl.flag64 or not isKiller and tbl.flag67
    local var222 = isKiller and tbl.flag65 or not isKiller and tbl.flag68
    var219.Adornee = char
    var219.FillColor = color
    var219.OutlineColor = color
    var219.FillTransparency = var222 and 1 or tbl.fillTransparency
    var219.OutlineTransparency = 0
    var219.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    var219.Enabled = var221
end

local function var198()
    for player, v7 in pairs(tbl2.espObjects) do
        if v7 and v7.billboard and v7.billboard.Parent then
            local var199 = fn9(player)
            local isKiller = var199 == "killer"
            v7.nameLabel.Visible = isKiller and tbl.flag1 or not isKiller and tbl.flag66
            v7.nameLabel.Text = tbl2.flag125 and (tbl2.list11[player] or player.Name) or player.Name
            v7.billboard.MaxDistance = fn39(isKiller)
            if v7.itemBillboard then
                v7.itemBillboard.MaxDistance = fn39(isKiller)
            end
        end
    end
    for player, v8 in pairs(tbl2.outlineObjects) do
        if v8 and v8.Parent then
            local var200 = fn9(player)
            local isKiller = var200 == "killer"
            local color = isKiller and tbl.color31 or tbl.color37
            local var201 = isKiller and tbl.flag64 or not isKiller and tbl.flag67
            local var202 = isKiller and tbl.flag65 or not isKiller and tbl.flag68
            v8.FillColor = color
            v8.OutlineColor = color
            v8.Enabled = var201
            v8.FillTransparency = var202 and 1 or tbl.fillTransparency
        end
    end
end

local function var195(player)
    if player == localPlayer then return end
    fn10(player)
    local var233 = fn9(player)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_BB_" .. player.Name
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 150, 0, 18)
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.MaxDistance = fn39(var233 == "killer")
    billboard.Parent = fn4()
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.TextSize = 12
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Text = tbl2.flag125 and (tbl2.list11[player] or player.Name) or player.Name
    nameLabel.Visible = var233 == "killer" and tbl.flag1 or var233 ~= "killer" and tbl.flag66
    nameLabel.Parent = billboard
    local itemBillboard = Instance.new("BillboardGui")
    itemBillboard.Name = "ESP_Item_" .. player.Name
    itemBillboard.AlwaysOnTop = true
    itemBillboard.Size = UDim2.new(1.5, 0, 1.5, 0)
    itemBillboard.StudsOffset = Vector3.new(0, -5, 0)
    itemBillboard.MaxDistance = fn39(var233 == "killer")
    itemBillboard.Parent = fn4()
    local itemImage = Instance.new("ImageLabel")
    itemImage.Name = "ItemImage"
    itemImage.Size = UDim2.new(1, 0, 1, 0)
    itemImage.BackgroundTransparency = 1
    itemImage.Visible = false
    itemImage.Parent = itemBillboard
    tbl2.espObjects[player] = {billboard = billboard, nameLabel = nameLabel, itemBillboard = itemBillboard, itemImage = itemImage}
    if player.Character then AttachESPToChar(player, player.Character) end
    if not tbl2.playerTeamConns[player] then
        tbl2.playerTeamConns[player] = player:GetPropertyChangedSignal("Team"):Connect(function()
            fn10(player)
            var198()
        end)
    end
end

local function var196(player)
    if player == localPlayer then return end
    local highlight = Instance.new("Highlight")
    highlight.Parent = fn4()
    tbl2.outlineObjects[player] = highlight
    if player.Character then AttachOutlineToChar(player, player.Character) end
end

local function ForceRefreshAllESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            if tbl2.espObjects[player] then
                if tbl2.espObjects[player].billboard then tbl2.espObjects[player].billboard:Destroy() end
                if tbl2.espObjects[player].itemBillboard then tbl2.espObjects[player].itemBillboard:Destroy() end
                tbl2.espObjects[player] = nil
            end
            if tbl2.outlineObjects[player] then
                tbl2.outlineObjects[player]:Destroy()
                tbl2.outlineObjects[player] = nil
            end
            tbl2.playerRoles[player] = nil
            if tbl2.playerTeamConns[player] then
                tbl2.playerTeamConns[player]:Disconnect()
                tbl2.playerTeamConns[player] = nil
            end
            var195(player)
            var196(player)
        end
    end
end

local function ValidateAndReattachESP(player)
    if player == localPlayer then return end
    if not player or not player.Parent then return end
    local var223 = tbl2.espObjects[player]
    local var224 = tbl2.outlineObjects[player]
    if not var223 and not var224 then return end
    if var223 and var223.billboard and not var223.billboard.Parent or var224 and not var224.Parent then
        ForceRefreshAllESP()
        return
    end
    local char = player.Character
    if not char or not char.Parent then
        if var223 and var223.billboard then var223.billboard.Adornee = nil end
        if var223 and var223.itemBillboard then var223.itemBillboard.Adornee = nil end
        if var224 then var224.Adornee = nil; var224.Enabled = false end
        return
    end
    local var225 = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Head")
    if not var225 then return end
    AttachESPToChar(player, char)
    AttachOutlineToChar(player, char)
end

-- Item ESP
local tbl3 = {
    ["Adrenaline Shot"] = "rbxassetid://135388781922226",
    Bandage = "rbxassetid://97791520639443",
    Flashlight = "rbxassetid://103299939715311",
    Gate = "rbxassetid://131249244284700",
    ["Holy Water"] = "rbxassetid://86130208614143",
    ["Motion Tracker"] = "rbxassetid://92303584765773",
    ["Parrying Dagger"] = "rbxassetid://76822757630703",
    ["Riot Shield"] = "rbxassetid://95718705901699",
    ["Shadow Clone"] = "rbxassetid://134088840518889",
    ["Twist of Fate"] = "rbxassetid://98397448432071",
    ["WaxBound Candle"] = "rbxassetid://110413686590821",
}

local function fn3(arg3)
    if not arg3 or type(arg3) ~= "string" then return nil end
    arg3 = arg3:match("^%s*(.-)%s*$")
    local var52 = tbl3[arg3]
    if var52 then return var52 end
    for name, id in pairs(tbl3) do
        if name:lower() == arg3:lower() then return id end
    end
    return nil
end

-- Object ESP
local function fn42(object, color)
    if not object or not object.Parent then return end
    local __VDHL__ = object:FindFirstChild("__VDHL__")
    if not __VDHL__ then
        __VDHL__ = Instance.new("Highlight")
        __VDHL__.Name = "__VDHL__"
        __VDHL__.Adornee = object
        __VDHL__.FillTransparency = 1
        __VDHL__.OutlineTransparency = 0
        __VDHL__.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        __VDHL__.FillColor = color
        __VDHL__.OutlineColor = color
        __VDHL__.Parent = object
        return
    end
    if __VDHL__.FillColor ~= color then
        __VDHL__.FillColor = color
        __VDHL__.OutlineColor = color
    end
    if not __VDHL__.Enabled then __VDHL__.Enabled = true end
end

local function fn43(object)
    if not object then return end
    local __VDHL__2 = object:FindFirstChild("__VDHL__")
    if __VDHL__2 then __VDHL__2:Destroy() end
end

local function fn44(generator)
    if not generator or not generator.Parent then return true end
    if tbl2.list4[generator] then return true end
    local var237 = generator:GetAttribute("RepairProgress") or generator:GetAttribute("Progress") or 0
    local var238 = var237 >= 100 or generator:GetAttribute("Completed") == true
    local billboard = generator:FindFirstChild("__VDGenProgress__")
    if var238 then
        if billboard then billboard:Destroy() end
        fn43(generator)
        tbl2.list4[generator] = true
        tbl2.list5[generator] = nil
        return var238
    end
    if tbl.flag80 then fn42(generator, tbl.color39) else fn43(generator) end
    if tbl.flag81 then
        local var239 = generator:GetAttribute("PlayersRepairingCount") or 0
        local var240 = generator:GetAttribute("kickcount") or 0
        local var241 = math.floor(var237 + 0.5)
        var244 = tbl2.list5[generator] or 1
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "__VDGenProgress__"
            billboard.AlwaysOnTop = true
            billboard.LightInfluence = 0
            billboard.ResetOnSpawn = false
            billboard.MaxDistance = 260
            billboard.Size = UDim2.new(0, 100, 0, 14)
            billboard.Parent = generator
            local textLabel2 = Instance.new("TextLabel")
            textLabel2.Name = "Label"
            textLabel2.BackgroundTransparency = 1
            textLabel2.Size = UDim2.new(1, 0, 1, 0)
            textLabel2.Font = Enum.Font.GothamBlack
            textLabel2.TextSize = 11
            textLabel2.RichText = true
            textLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel2.TextXAlignment = Enum.TextXAlignment.Center
            textLabel2.Parent = billboard
        end
        local label = billboard:FindFirstChild("Label")
        if label then
            local var248 = string.format("%d%%", var241)
            label.Text = string.format("GEN%d | %s", var244, var248)
            if tbl.flag78 then
                label.Text = label.Text .. string.format(" | P:%d K:%d", var239, var240)
            end
        end
    else
        if billboard then billboard:Destroy() end
    end
    return false
end

local function fn45(generator)
    local function fn46()
        if not tbl.flag80 and not tbl.flag81 then return end
        fn44(generator)
    end
    pcall(function()
        generator:GetAttributeChangedSignal("RepairProgress"):Connect(fn46)
        generator:GetAttributeChangedSignal("Progress"):Connect(fn46)
        generator:GetAttributeChangedSignal("Completed"):Connect(fn46)
        generator:GetAttributeChangedSignal("PlayersRepairingCount"):Connect(fn46)
        generator:GetAttributeChangedSignal("kickcount"):Connect(fn46)
    end)
end

local function onDescendantAdded2(arg39)
    local n = arg39.Name
    if n == "Generator" then
        table.insert(tbl2.list1.Generators, arg39)
        if not tbl2.list5[arg39] then
            if next(tbl2.list5) == nil then tbl2.num126 = 1 end
            tbl2.list5[arg39] = tbl2.num126
            tbl2.num126 = tbl2.num126 + 1
        end
        if tbl.flag80 then fn44(arg39); fn45(arg39) end
    elseif n == "Hook" then
        table.insert(tbl2.list1.Hooks, arg39)
        local tbl11 = {}
        local m = arg39:FindFirstChild("Model")
        if m then
            local function fn49(arg40)
                for _, v13 in ipairs(arg40:GetChildren()) do
                    if v13:IsA("MeshPart") then table.insert(tbl11, v13) end
                    fn49(v13)
                end
            end
            fn49(m)
        end
        tbl2.list3[arg39] = tbl11
        if tbl.flag84 then
            if #tbl11 > 0 then
                for _, v14 in ipairs(tbl11) do fn42(v14, tbl.color312) end
            else
                fn42(arg39, tbl.color312)
            end
        end
    elseif n == "Gate" then
        table.insert(tbl2.list1.Gates, arg39)
        if tbl.flag85 then fn42(arg39, tbl.color313) end
    elseif n == "Pallet" or n == "Palletwrong" then
        table.insert(tbl2.list1.Pallets, arg39)
        local part = arg39:IsA("Model") and arg39.PrimaryPart or arg39:FindFirstChildWhichIsA("BasePart", true) or arg39:IsA("BasePart") and arg39
        local fake = n:lower():find("fake") or n:lower():find("broken")
        local tbl12 = {part = part, isFake = fake and true or false}
        tbl2.list2[arg39] = tbl12
        if tbl.flag83 and not tbl12.isFake then fn42(arg39, tbl.color311) end
    end
end

local function onDescendantRemoving(arg41)
    local n = arg41.Name
    if n == "Generator" then
        for i5, v15 in ipairs(tbl2.list1.Generators) do
            if v15 == arg41 then table.remove(tbl2.list1.Generators, i5) break end
        end
        tbl2.list5[arg41] = nil
        tbl2.list4[arg41] = nil
        fn43(arg41)
    elseif n == "Hook" then
        for i6, v16 in ipairs(tbl2.list1.Hooks) do
            if v16 == arg41 then table.remove(tbl2.list1.Hooks, i6) break end
        end
        fn43(arg41)
        tbl2.list3[arg41] = nil
    elseif n == "Gate" then
        for i7, v18 in ipairs(tbl2.list1.Gates) do
            if v18 == arg41 then table.remove(tbl2.list1.Gates, i7) break end
        end
        fn43(arg41)
    elseif n == "Pallet" or n == "Palletwrong" then
        for i8, v19 in ipairs(tbl2.list1.Pallets) do
            if v19 == arg41 then table.remove(tbl2.list1.Pallets, i8) break end
        end
        fn43(arg41)
        tbl2.list2[arg41] = nil
    end
end

local function fn51(arg43)
    if not arg43 then return end
    tbl2.list1 = {Generators = {}, Pallets = {}, Hooks = {}, Gates = {}}
    tbl2.list2 = {}; tbl2.list3 = {}; tbl2.list4 = {}; tbl2.list5 = {}
    tbl2.num126 = 1
    for _, obj in ipairs(arg43:GetDescendants()) do onDescendantAdded2(obj) end
    arg43.DescendantAdded:Connect(onDescendantAdded2)
    arg43.DescendantRemoving:Connect(onDescendantRemoving)
    tbl2.flag108 = true
end

local function var234()
    if not tbl2.flag108 then return end
    if tbl.flag80 or tbl.flag81 then
        for _, obj in ipairs(tbl2.list1.Generators) do
            if obj and obj.Parent then fn44(obj) end
        end
    else
        for _, obj in ipairs(tbl2.list1.Generators) do
            if obj and obj.Parent then
                fn43(obj)
                local __VDGenProgress__ = obj:FindFirstChild("__VDGenProgress__")
                if __VDGenProgress__ then __VDGenProgress__:Destroy() end
            end
        end
    end
    if tbl.flag83 then
        for _, pallet in ipairs(tbl2.list1.Pallets) do
            if pallet and pallet.Parent then
                local var267 = tbl2.list2[pallet]
                if var267 and not var267.isFake then fn42(pallet, tbl.color311) end
            end
        end
    else
        for _, pallet in ipairs(tbl2.list1.Pallets) do if pallet then fn43(pallet) end end
    end
    if tbl.flag84 then
        for _, v20 in ipairs(tbl2.list1.Hooks) do
            if v20 and v20.Parent then
                local var268 = tbl2.list3[v20]
                if var268 then
                    for _, v21 in ipairs(var268) do fn42(v21, tbl.color312) end
                else fn42(v20, tbl.color312) end
            end
        end
    else
        for _, v22 in ipairs(tbl2.list1.Hooks) do
            if v22 and v22.Parent then
                local var269 = tbl2.list3[v22]
                if var269 then
                    for _, v23 in ipairs(var269) do fn43(v23) end
                else fn43(v22) end
            end
        end
    end
    if tbl.flag85 then
        for _, v24 in ipairs(tbl2.list1.Gates) do
            if v24 and v24.Parent then fn42(v24, tbl.color313) end
        end
    else
        for _, v25 in ipairs(tbl2.list1.Gates) do
            if v25 and v25.Parent then fn43(v25) end
        end
    end
end

-- Window ESP
tbl2.list6 = {}
tbl2._windowParts = {}
tbl2._windowPartMap = {}

local function fn52(part)
    if not part or not part.Parent or tbl2.list6[part] then return end
    local color = tbl.color310
    local boxHandleAdornment = Instance.new("BoxHandleAdornment")
    boxHandleAdornment.Name = "WindowESP_Box"
    boxHandleAdornment.Adornee = part
    boxHandleAdornment.Color3 = color
    boxHandleAdornment.Transparency = 0.3
    boxHandleAdornment.Size = part.Size
    boxHandleAdornment.AlwaysOnTop = true
    boxHandleAdornment.ZIndex = 10
    boxHandleAdornment.Parent = fn4()
    tbl2.list6[part] = boxHandleAdornment
end

local function fn53(part)
    local var260 = tbl2.list6[part]
    if var260 then
        pcall(function() var260:Destroy() end)
        tbl2.list6[part] = nil
    end
end

local function fn54(arg44)
    if typeof(arg44) ~= "Instance" then return nil end
    local n = string.lower(arg44.Name)
    if n == "window" and arg44:IsA("Model") then
        local bottom = arg44:FindFirstChild("Bottom", true)
        if bottom and bottom:IsA("BasePart") then return bottom end
        return arg44.PrimaryPart
    end
    if n == "bottom" and arg44:IsA("BasePart") then
        if arg44.Parent and string.lower(arg44.Parent.Name) == "window" then return arg44 end
    end
    return nil
end

local function fn55(arg45)
    local var261 = fn54(arg45)
    if var261 then
        if not tbl2._windowPartMap[var261] then
            tbl2._windowPartMap[var261] = true
            table.insert(tbl2._windowParts, var261)
        end
        if tbl.flag82 and not tbl2.list6[var261] then fn52(var261) end
    end
end

Workspace.DescendantAdded:Connect(function(arg46) fn55(arg46) end)
Workspace.DescendantRemoving:Connect(function(arg47)
    local var262 = fn54(arg47) or arg47
    if tbl2._windowPartMap[var262] then
        tbl2._windowPartMap[var262] = nil
        for i9, e in ipairs(tbl2._windowParts) do
            if e == var262 then table.remove(tbl2._windowParts, i9) break end
        end
    end
    if tbl2.list6[var262] then fn53(var262) end
end)

-- Zombie/SCP ESP
local var399 = {}
local zombieCacheTime = 0
tbl2._zombieCacheReady = false

local function fn87(name)
    if type(name) ~= "string" or name == "" then return false end
    local var400 = name:lower()
    if var400:find("zombie") then return true end
    if var400 == "scp" then return true end
    for i19 = 1, 9 do
        if var400 == "scp" .. i19 or var400:find("^scp%-" .. i19) then return true end
    end
    return false
end

local function GetScpModelRoot(model)
    local primaryPart = model.PrimaryPart
    if not primaryPart then
        local humanoidRootPart8 = model:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart8 and humanoidRootPart8:IsA("BasePart") then primaryPart = humanoidRootPart8 end
    end
    if not primaryPart then
        for _, v57 in ipairs(model:GetChildren()) do
            if v57:IsA("BasePart") then primaryPart = v57 break end
        end
    end
    return primaryPart
end

local function fn89()
    if tbl2._zombieCacheReady then return end
    tbl2._zombieCacheReady = true
    local tbl25 = {}
    local function onDescendantAdded4(model)
        if not model:IsA("Model") then return end
        if localPlayer.Character and model == localPlayer.Character then return end
        for _, v58 in ipairs(Players:GetPlayers()) do
            if v58.Character and model == v58.Character then return end
        end
        if not fn87(model.Name) then return end
        if tbl25[model] then return end
        tbl25[model] = true
        table.insert(var399, model)
    end
    local function onDescendantRemoving2(model)
        if not tbl25[model] then return end
        tbl25[model] = nil
        for i20, v59 in ipairs(var399) do
            if v59 == model then table.remove(var399, i20) break end
        end
        local var401 = tbl2.scpEspObjects[model]
        if var401 then
            if var401.highlight and var401.highlight.Parent then var401.highlight:Destroy() end
            if var401.billboard and var401.billboard.Parent then var401.billboard:Destroy() end
            tbl2.scpEspObjects[model] = nil
        end
    end
    Workspace.DescendantAdded:Connect(onDescendantAdded4)
    Workspace.DescendantRemoving:Connect(onDescendantRemoving2)
    local tbl26 = {}
    for _, v60 in ipairs(Players:GetPlayers()) do
        if v60.Character then tbl26[v60.Character] = true end
    end
    for _, model in ipairs(workspace:GetDescendants()) do
        if model:IsA("Model") and not tbl26[model] and fn87(model.Name) then
            tbl25[model] = true
            table.insert(var399, model)
        end
    end
    zombieCacheTime = tick()
end

fn89()

local function RefreshZombieCache()
    fn89()
    zombieCacheTime = tick()
end

local function RefreshScpEsp()
    if not tbl2.scpEspObjects then return end
    local var402 = GetCamPosition()
    local tbl27 = {}
    for model, v61 in pairs(tbl2.scpEspObjects) do
        if not model or not model.Parent then
            tbl27[#tbl27 + 1] = model
        else
            local flag12 = true
            if var402 then
                local var403 = GetScpModelRoot(model)
                if var403 then flag12 = (var403.Position - var402).Magnitude <= tbl.num114 end
            end
            if v61.highlight and v61.highlight.Parent then
                if v61.highlight.FillColor ~= tbl.color38 then
                    v61.highlight.FillColor = tbl.color38
                    v61.highlight.OutlineColor = tbl.color38
                end
                if v61.highlight.Enabled ~= flag12 then v61.highlight.Enabled = flag12 end
            end
            if v61.billboard then
                v61.billboard.MaxDistance = tbl.num114
                if v61.billboard.Enabled ~= flag12 then v61.billboard.Enabled = flag12 end
            end
        end
    end
    for i21 = 1, #tbl27 do
        local model = tbl27[i21]
        local var401 = tbl2.scpEspObjects[model]
        if var401 then
            if var401.highlight and var401.highlight.Parent then var401.highlight:Destroy() end
            if var401.billboard and var401.billboard.Parent then var401.billboard:Destroy() end
            tbl2.scpEspObjects[model] = nil
        end
    end
end

fn5("ScpESP", 0.5, function()
    if not tbl.flag69 then
        for model, _ in pairs(tbl2.scpEspObjects) do
            local var401 = tbl2.scpEspObjects[model]
            if var401 then
                if var401.highlight and var401.highlight.Parent then var401.highlight:Destroy() end
                if var401.billboard and var401.billboard.Parent then var401.billboard:Destroy() end
                tbl2.scpEspObjects[model] = nil
            end
        end
        return
    end
    for i23 = 1, #var399 do
        local model = var399[i23]
        if model and model.Parent and not tbl2.scpEspObjects[model] then
            local highlight2 = Instance.new("Highlight")
            highlight2.Name = "__VDScpHl__"
            highlight2.Adornee = model
            highlight2.FillColor = tbl.color38
            highlight2.OutlineColor = tbl.color38
            highlight2.FillTransparency = 1
            highlight2.OutlineTransparency = 0
            highlight2.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight2.Enabled = true
            highlight2.Parent = fn4()
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "__VDScpBb__"
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(0, 140, 0, 18)
            billboard.StudsOffset = Vector3.new(0, 4, 0)
            billboard.MaxDistance = tbl.num114
            billboard.Parent = fn4()
            local textLabel3 = Instance.new("TextLabel")
            textLabel3.Size = UDim2.new(1, 0, 1, 0)
            textLabel3.BackgroundTransparency = 1
            textLabel3.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel3.TextStrokeTransparency = 0
            textLabel3.TextStrokeColor3 = Color3.new(0, 0, 0)
            textLabel3.TextSize = 12
            textLabel3.Font = Enum.Font.GothamBold
            textLabel3.Text = tbl.flag70 and "zombie" or ""
            textLabel3.Parent = billboard
            tbl2.scpEspObjects[model] = {highlight = highlight2, billboard = billboard, label = textLabel3}
        end
    end
    RefreshScpEsp()
end)

-- ESP Validator & Item ESP loops
fn5("ESPValidator", 1, function()
    if not folder or not folder.Parent then
        ForceRefreshAllESP()
        return
    end
    for player, _ in pairs(tbl2.espObjects) do ValidateAndReattachESP(player) end
end)

fn5("EspDistCull", 0.25, function()
    if tbl2.espObjects then
        local var205 = GetCamPosition()
        if not var205 then return end
        for player, v9 in pairs(tbl2.espObjects) do
            if player and player.Parent then
                local char = player.Character
                local var206 = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
                if var206 then
                    local dist = (var206.Position - var205).Magnitude
                    local isKiller = fn9(player) == "killer"
                    local var207 = fn39(isKiller)
                    local var208 = dist <= var207
                    local var209 = tbl2.outlineObjects[player]
                    if var209 then
                        local var210 = isKiller and tbl.flag64 or not isKiller and tbl.flag67
                        local var211 = var210 and var208
                        if var209.Enabled ~= var211 then var209.Enabled = var211 end
                    end
                    if v9 then
                        if v9.billboard then
                            local var212 = isKiller and tbl.flag1 or not isKiller and tbl.flag66
                            local var213 = var208 and var212
                            if v9.billboard.Enabled ~= var213 then v9.billboard.Enabled = var213 end
                            v9.billboard.MaxDistance = var207
                        end
                    end
                end
            end
        end
    end
end)

fn5("ItemESP", 0.2, function()
    if not tbl.flag97 then
        for _, v55 in pairs(tbl2.espObjects) do
            if v55 and v55.itemImage and v55.itemImage.Visible then v55.itemImage.Visible = false end
        end
        return
    end
    local character7 = localPlayer.Character
    local var393 = character7 and character7:FindFirstChild("HumanoidRootPart")
    for player, v56 in pairs(tbl2.espObjects) do
        if v56 and v56.billboard and v56.billboard.Parent and v56.itemBillboard then
            if fn9(player) == "killer" then
                if v56.itemImage.Visible then v56.itemImage.Visible = false end
                continue
            end
            local char = player.Character
            local var394 = nil
            if char then
                local var395 = char:GetAttribute("EquippedItem") or char:GetAttribute("Equippedltem")
                if type(var395) == "string" then var394 = var395
                elseif typeof(var395) == "Instance" then var394 = var395.Name end
            end
            local var397 = fn3(var394)
            if var397 then
                if v56.itemImage.Image ~= var397 then v56.itemImage.Image = var397 end
                v56.itemImage.Visible = true
            else
                if v56.itemImage.Visible then v56.itemImage.Visible = false end
            end
        end
    end
end)

-- Killer Warn
fn5("KillerWarn", 0.1, function()
    if not tbl.flag74 then
        local character4 = localPlayer.Character
        local var356 = character4 and character4:FindFirstChild("HumanoidRootPart")
        if var356 then
            local killerWarn = var356:FindFirstChild("KillerWarn")
            if killerWarn then killerWarn:Destroy() end
        end
        return
    end
    local character5 = localPlayer.Character
    local var357 = character5 and character5:FindFirstChild("HumanoidRootPart")
    if not var357 then return end
    local huge4 = math.huge
    for player, _ in pairs(tbl2.espObjects) do
        if player and player.Parent then
            local var358 = fn9(player)
            if var358 == "killer" then
                local char = player.Character
                local var359 = char and char:FindFirstChild("HumanoidRootPart")
                if var359 then
                    local dist = (var359.Position - var357.Position).Magnitude
                    if dist < huge4 then huge4 = dist end
                end
            end
        end
    end
    local killerWarn2 = var357:FindFirstChild("KillerWarn")
    if huge4 <= tbl.warnDist1 then
        local var360, col
        if huge4 <= tbl.warnDist3 then
            var360 = "!!!"
            col = Color3.fromRGB(255, 0, 0)
        elseif huge4 <= tbl.warnDist2 then
            var360 = "!!"
            col = Color3.fromRGB(255, 80, 0)
        else
            var360 = "!"
            col = Color3.fromRGB(255, 160, 0)
        end
        if not killerWarn2 then
            killerWarn2 = CreateBillboardTag(var360, col, UDim2.new(0, 40, 0, 40), 22)
            killerWarn2.Name = "KillerWarn"
            killerWarn2.Parent = var357
        else
            killerWarn2.Label.Text = var360
            killerWarn2.Label.TextColor3 = col
        end
    elseif killerWarn2 then
        killerWarn2:Destroy()
    end
end)

-- Auto Generator
local var327 = nil
local function fn74()
    if var327 and var327.Parent then return var327 end
    local survivorMob = playerGui:FindFirstChild("Survivor-mob", true)
    if not survivorMob then return nil end
    local controls2 = survivorMob:FindFirstChild("Controls", true)
    if not controls2 then return nil end
    local action = controls2:FindFirstChild("action")
    if action and action:IsA("GuiButton") then var327 = action; return action end
    action = controls2:FindFirstChild("Gui-mob")
    if action and action:IsA("GuiButton") then var327 = action; return action end
    return nil
end

local function var326()
    local var328 = fn74()
    if var328 and type(firesignal) == "function" then
        firesignal(var328.MouseButton1Down)
        task.delay(0.05, function()
            if var328 and var328.Parent then
                firesignal(var328.MouseButton1Up)
                firesignal(var328.MouseButton1Click)
            end
        end)
        return
    end
    local check2 = playerGui:FindFirstChild("check", true)
    if check2 and check2:IsA("GuiObject") and check2.Visible then
        local absolutePosition = check2.AbsolutePosition
        local absoluteSize = check2.AbsoluteSize
        local var329 = GuiService:GetGuiInset()
        local var330 = absolutePosition.X + absoluteSize.X / 2 + var329.X
        local var331 = absolutePosition.Y + absoluteSize.Y / 2 + var329.Y
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(var330, var331, 0, true, game, 1)
            task.wait(0.01)
            VirtualInputManager:SendMouseButtonEvent(var330, var331, 0, false, game, 1)
        end)
    else
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        task.wait()
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    end
end

local function fn73()
    for _, name in ipairs({"SkillCheckPromptGui", "SkillCheckPromptGui-con"}) do
        local gui = playerGui:FindFirstChild(name, true)
        if gui then
            local check = gui:FindFirstChild("Check", true)
            if check and check.Visible then
                return check:FindFirstChild("Line", true), check:FindFirstChild("Goal", true)
            end
        end
    end
end

fn5("Generator", 0, function()
    if not tbl.flag76 then return end
    local var332, goal = fn73()
    if not (var332 and goal) then
        tbl2.flag123 = false
        tbl2.lastGoalRot = nil
        tbl2.prevLr = nil
        return
    end
    local rotation2 = goal.Rotation
    local rotation3 = var332.Rotation
    local now4 = tick()
    if now4 - tbl2.num136 < 0.1 then
        tbl2.prevLr = rotation3
        return
    end
    if tbl.str1 == "Instant" then
        if not tbl2.flag123 or rotation2 ~= tbl2.lastGoalRot then
            var332.Rotation = rotation2 + 109
            tbl2.lastGoalRot = rotation2
            tbl2.flag123 = true
            tbl2.num136 = now4
            var326()
        end
    else
        local var334 = (rotation3 - rotation2) % 360
        local num15 = -1
        if tbl2.prevLr and tbl2.lastGoalRot == rotation2 then
            num15 = (tbl2.prevLr - rotation2) % 360
        end
        tbl2.lastGoalRot = rotation2
        local var335, zoneEnd
        if tbl.str1 == "Perfect" then
            var335 = 102; zoneEnd = 116
        elseif tbl.str1 == "Normal" then
            var335 = 116; zoneEnd = 159
        elseif tbl.str1 == "Random" then
            if not tbl2.flag124 then var335 = 102; zoneEnd = 116
            else var335 = 116; zoneEnd = 159 end
        else return end
        local var336 = var334 >= var335 and var334 <= zoneEnd
        local var337 = num15 >= 0 and num15 < var335 and var334 > zoneEnd
        if var336 or var337 then
            if var337 then var332.Rotation = rotation2 + (var335 + zoneEnd) / 2 end
            tbl2.num136 = now4
            var326()
            if tbl.str1 == "Random" then tbl2.flag124 = not tbl2.flag124 end
        end
    end
    tbl2.prevLr = rotation3
end)

-- Speed Boost
local num7 = 17
local function var300()
    if tbl2.SpeedBoost then
        return num7 * (1 + math.clamp(tonumber(tbl2.num127) or 0.3, 0, 2))
    end
    return num7
end

local function _ApplySpeed(arg56, arg57)
    if not arg56 or not arg56.Parent then return end
    if math.abs(arg56.WalkSpeed - arg57) > 0.05 then
        pcall(function() arg56.WalkSpeed = arg57 end)
    end
end

fn5("SpeedBoost", 0, function()
    if not tbl2.SpeedBoost then return end
    local char = localPlayer.Character
    if not char then return end
    local humanoid7 = char:FindFirstChildOfClass("Humanoid")
    if not humanoid7 then return end
    if tbl2.safeModeSpeed and (char:GetAttribute("IsHooked") or char:GetAttribute("IsCarried") or humanoid7.Health <= 50) then return end
    local var407 = var300()
    if var407 <= 0 then return end
    tbl2._jitterFlip = not tbl2._jitterFlip
    local var409 = num7 * math.clamp(tonumber(tbl2.num127) or 0.3, 0, 2)
    local target = tbl2._jitterFlip and var407 + var409 or var407
    if math.abs(humanoid7.WalkSpeed - target) > 0.1 then
        pcall(function() humanoid7.WalkSpeed = target end)
    end
end)

local function var406(arg80)
    tbl2.SpeedBoost = arg80 and true or false
    local char = localPlayer.Character
    local var410 = char and char:FindFirstChildOfClass("Humanoid")
    if not arg80 then
        if var410 then _ApplySpeed(var410, num7) end
        return
    end
    if var410 then
        local var407 = var300()
        _ApplySpeed(var410, var407)
    end
end

-- God Mode
local function fn71()
    tbl2.flag122 = true
    tbl2.health1 = nil
    local char = localPlayer.Character
    local var323 = char and char:FindFirstChildOfClass("Humanoid")
    if var323 then
        pcall(function()
            var323:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            var323:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            var323:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        end)
    end
end

local function fn72()
    tbl2.flag122 = false
    tbl2.health1 = nil
    local char = localPlayer.Character
    local var324 = char and char:FindFirstChildOfClass("Humanoid")
    if var324 then
        pcall(function()
            var324:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
            var324:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            var324:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        end)
    end
end

fn5("GodMode", 0.2, function()
    if not tbl2.flag122 then return end
    local char = localPlayer.Character
    if not char then return end
    local humanoid5 = char:FindFirstChildOfClass("Humanoid")
    if not humanoid5 then return end
    local maxHealth = humanoid5.MaxHealth
    local health = humanoid5.Health
    if tbl2.health1 ~= nil and health < tbl2.health1 and health > 0 then
        pcall(function() humanoid5.Health = maxHealth end)
    end
    tbl2.health1 = humanoid5.Health
    pcall(function()
        local var325 = humanoid5:GetState()
        if var325 == Enum.HumanoidStateType.Dead then
            humanoid5.Health = maxHealth
            humanoid5:ChangeState(Enum.HumanoidStateType.Running)
            tbl2.health1 = maxHealth
        elseif var325 == Enum.HumanoidStateType.Ragdoll or var325 == Enum.HumanoidStateType.FallingDown then
            humanoid5:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
end)

-- Noclip
local var1102 = nil
local tbl90 = {}
local function fn286(char, collideOn)
    if not char then return end
    if not tbl90[char] then tbl90[char] = {} end
    local var1104 = tbl90[char]
    if collideOn then
        for part, _ in pairs(var1104) do
            if part and part.Parent then pcall(function() part.CanCollide = true end) end
        end
        tbl90[char] = {}
    else
        for _, v129 in ipairs(char:GetDescendants()) do
            if v129:IsA("BasePart") and var1104[v129] == nil then
                local var1105, cur = pcall(function() return v129.CanCollide end)
                if var1105 and cur then
                    var1104[v129] = true
                    pcall(function() v129.CanCollide = false end)
                end
            end
        end
    end
end

local function var1100()
    tbl2.flag166 = true
    var1102 = RunService.Stepped:Connect(function()
        if not tbl2.flag166 then return end
        local char = localPlayer.Character
        if char then fn286(char, false) end
    end)
end

local function StopNoclip()
    tbl2.flag166 = false
    if var1102 then pcall(function() var1102:Disconnect() end); var1102 = nil end
    local char = localPlayer.Character
    if char then fn286(char, true) end
end

-- Anti AFK
local var88 = nil
local function var82(arg12)
    if arg12 then
        if not var88 then
            var88 = localPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    else
        if var88 then var88:Disconnect(); var88 = nil end
    end
end

-- Camera Zoom
local function fn106(value)
    if tbl2.cameraMaxZoomDistance1 == nil then
        tbl2.cameraMaxZoomDistance1 = localPlayer.CameraMaxZoomDistance
    end
    localPlayer.CameraMaxZoomDistance = value
end

local function fn107()
    if tbl2.cameraMaxZoomDistance1 ~= nil then
        localPlayer.CameraMaxZoomDistance = tbl2.cameraMaxZoomDistance1
    end
    tbl2.cameraMaxZoomDistance1 = nil
end

-- FOV Lock
local function fn111(value)
    local currentCamera9 = workspace.CurrentCamera
    if not currentCamera9 then return end
    if tbl2.fieldOfView1 == nil then tbl2.fieldOfView1 = currentCamera9.FieldOfView end
    currentCamera9.FieldOfView = value
end

local function fn112()
    local currentCamera10 = workspace.CurrentCamera
    if currentCamera10 and tbl2.fieldOfView1 then
        currentCamera10.FieldOfView = tbl2.fieldOfView1
    end
    tbl2.fieldOfView1 = nil
end

-- Fullbright & Visual Effects
local tbl80 = {
    Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
    ColorShift_Bottom = Lighting.ColorShift_Bottom, ColorShift_Top = Lighting.ColorShift_Top,
    Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
    GlobalShadows = Lighting.GlobalShadows, FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd, FogColor = Lighting.FogColor,
    ExposureCompensation = Lighting.ExposureCompensation,
    EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
    EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
}
local tbl81 = {}

local function var888()
    Lighting.Ambient = Color3.fromRGB(178, 178, 178)
    Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
    Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
    Lighting.ColorShift_Top = Color3.new(0, 0, 0)
    Lighting.Brightness = 3
    Lighting.ClockTime = 12
    Lighting.GlobalShadows = false
    Lighting.FogStart = 9000000000
    Lighting.FogEnd = 9000000000
    Lighting.ExposureCompensation = 0
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
end

local function restoreLighting()
    for k17, v117 in pairs(tbl80) do
        pcall(function() Lighting[k17] = v117 end)
    end
end

local function removeVisualEffects()
    tbl81 = {}
    for _, v118 in ipairs(Lighting:GetChildren()) do
        if v118:IsA("PostEffect") or v118:IsA("Clouds") or v118:IsA("Atmosphere") or v118:IsA("Sky") then
            tbl81[v118] = {Enabled = v118.Enabled, Parent = v118.Parent}
            pcall(function()
                if v118:IsA("Sky") then v118.Parent = nil
                else v118.Enabled = false end
            end)
        end
    end
end

local function restoreVisualEffects()
    for k18, v119 in pairs(tbl81) do
        if k18 then
            pcall(function()
                if k18:IsA("Sky") then k18.Parent = v119.Parent
                else k18.Enabled = v119.Enabled end
            end)
        end
    end
    tbl81 = {}
end

fn5("LightingEnforcer", 0.5, function()
    if tbl2.flag132 then var888() end
    if tbl2.flag133 then
        for _, v120 in ipairs(Lighting:GetChildren()) do
            if v120:IsA("PostEffect") or v120:IsA("Clouds") or v120:IsA("Atmosphere") or v120:IsA("Sky") then
                pcall(function()
                    if v120:IsA("Sky") then
                        if v120.Parent then v120.Parent = nil end
                    else
                        if v120.Enabled then v120.Enabled = false end
                    end
                end)
            end
        end
    end
end)

-- Skip End Screen
local function fn154(darknessMode)
    darknessMode = darknessMode or false
    local currentCamera15 = Workspace.CurrentCamera
    local skipEndScreenConns = tbl2.skipEndScreenConns
    local flag18 = false
    local flag19 = false
    local flag20 = false
    pcall(function()
        local remotes9 = ReplicatedStorage:FindFirstChild("Remotes")
        if not remotes9 then return end
        local function fn155(remote)
            if remote and remote:IsA("RemoteEvent") then
                for _, v89 in ipairs(getconnections(remote.OnClientEvent)) do
                    v89:Disable()
                    v89:Disconnect()
                end
            end
        end
        local game3 = remotes9:FindFirstChild("Game")
        if game3 then
            for _, name in ipairs({"cutscene", "cutsceneEnd", "cutsceneEnd2", "endscreencutscene", "cutsceneEndwithownchar", "shake"}) do
                fn155(game3:FindFirstChild(name))
            end
        end
        local killers = remotes9:FindFirstChild("Killers")
        if killers then fn155(killers:FindFirstChild("Startmori")) end
        if darknessMode then fn155(remotes9:FindFirstChild("Darkness2")) end
    end)
    local function fn156()
        if not currentCamera15 then return end
        if currentCamera15.CameraType == Enum.CameraType.Scriptable then
            flag18 = true
            currentCamera15.CameraType = Enum.CameraType.Custom
            flag18 = false
        end
    end
    if currentCamera15 then
        fn156()
        table.insert(skipEndScreenConns, currentCamera15:GetPropertyChangedSignal("CameraType"):Connect(function()
            if not flag18 then fn156() end
        end))
    end
    table.insert(skipEndScreenConns, Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        currentCamera15 = Workspace.CurrentCamera
        if currentCamera15 then fn156() end
    end))
    local function fn157()
        local map4 = Workspace:FindFirstChild("Map")
        if map4 then
            local endscreen = map4:FindFirstChild("endscreen")
            if endscreen then pcall(function() endscreen.Parent = nil end) end
        end
        local backgroundSounds = Workspace:FindFirstChild("BackgroundSounds")
        if backgroundSounds then pcall(function() backgroundSounds:Destroy() end) end
    end
    fn157()
    table.insert(skipEndScreenConns, Workspace.DescendantAdded:Connect(function(arg125)
        if arg125.Name == "endscreen" and arg125.Parent and arg125.Parent.Name == "Map" then
            task.wait(0.01)
            pcall(function() arg125.Parent = nil end)
        elseif arg125.Name == "BackgroundSounds" then
            pcall(function() arg125:Destroy() end)
        end
    end))
    local function fn158(gui)
        if not gui or not gui.Parent then return end
        pcall(function()
            if darknessMode and gui.Name == "Darkness" and gui:IsA("ScreenGui") then
                gui.Enabled = false
            end
            local function fn159(arg126)
                if arg126:IsA("VideoFrame") then arg126:Destroy()
                elseif arg126:IsA("Frame") and (arg126.Name == "Frame2" or arg126.Name == "blackout") then
                    arg126.BackgroundTransparency = 1
                elseif arg126:IsA("ParticleEmitter") or arg126:IsA("Beam") or arg126:IsA("Trail") then
                    arg126.Enabled = false
                end
                for _, v90 in ipairs(arg126:GetChildren()) do fn159(v90) end
            end
            fn159(gui)
        end)
    end
    for _, v91 in ipairs(playerGui:GetChildren()) do
        local n = v91.Name
        if n == "Darkness" or n == "EndScreen" or n == "Cutscene" or n == "Results" then
            fn158(v91)
        end
    end
    table.insert(skipEndScreenConns, playerGui.ChildAdded:Connect(function(arg127)
        local n = arg127.Name
        if n == "Darkness" or n == "EndScreen" or n == "Cutscene" or n == "Results" then
            task.wait(0.05)
            fn158(arg127)
        end
    end))
end

local function fn160()
    for _, v92 in ipairs(tbl2.skipEndScreenConns) do
        pcall(function() v92:Disconnect() end)
    end
    table.clear(tbl2.skipEndScreenConns)
end

-- Teleport Escape
local function fn241()
    local char = localPlayer.Character
    local var865 = char and char:FindFirstChild("HumanoidRootPart")
    if not var865 then fn2("Teleport", "Karakter tidak ditemukan!", 2) return end
    local fininshline = workspace:FindFirstChild("Fininshline", true)
    if not fininshline then fn2("Teleport", "Fininshline tidak ditemukan!", 2) return end
    pcall(function() var865.CFrame = fininshline.CFrame end)
end

-- Ghost Gate
local function ApplyGhostGateToObj(arg37, enabled)
    if not arg37 or not arg37.Parent then return end
    local var257 = arg37:IsA("BasePart") and {arg37} or {}
    if not arg37:IsA("BasePart") then
        local function fn48(arg38)
            for _, v12 in ipairs(arg38:GetChildren()) do
                if v12:IsA("BasePart") then table.insert(var257, v12) end
                fn48(v12)
            end
        end
        fn48(arg37)
    end
    for _, part in ipairs(var257) do
        if part:IsA("BasePart") then
            if enabled then
                if not tbl2.ghostGateOriginals[part] then
                    tbl2.ghostGateOriginals[part] = {CanCollide = part.CanCollide, Transparency = part.Transparency}
                end
                part.CanCollide = false
                part.Transparency = 0.6
            else
                if tbl2.ghostGateOriginals[part] then
                    part.CanCollide = tbl2.ghostGateOriginals[part].CanCollide
                    part.Transparency = tbl2.ghostGateOriginals[part].Transparency
                end
            end
        end
    end
end

local function fn240()
    for _, v110 in ipairs(tbl2.list1.Gates) do
        ApplyGhostGateToObj(v110, tbl2.flag145)
    end
end

-- Player setup
local function fn289(player, char)
    if player == localPlayer then return end
    if not char or not char.Parent or player.Character ~= char then return end
    AttachESPToChar(player, char)
    AttachOutlineToChar(player, char)
end

local function onPlayerAdded2(player)
    if player == localPlayer then return end
    fn10(player)
    var195(player)
    var196(player)
    player:GetPropertyChangedSignal("Team"):Connect(function() fn10(player) end)
    if player.Character then
        task.spawn(function() fn289(player, player.Character) end)
    end
    player.CharacterAdded:Connect(function(char)
        task.spawn(function() fn289(player, char) end)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded2)
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then onPlayerAdded2(player) end
end

-- Map init
local map2 = workspace:FindFirstChild("Map")
if map2 then fn51(map2) end
workspace.ChildAdded:Connect(function(arg50)
    if arg50.Name == "Map" then task.wait(2); fn51(arg50) end
end)
workspace.ChildRemoved:Connect(function(arg51)
    if arg51.Name == "Map" then
        tbl2.list1 = {Generators = {}, Pallets = {}, Hooks = {}, Gates = {}}
        tbl2.list2 = {}; tbl2.list3 = {}; tbl2.list4 = {}
        tbl2.flag108 = false
        tbl2.list5 = {}; tbl2.num126 = 1
    end
end)

fn5("GenESPUpdater", 0.2, function()
    if not tbl.flag80 and not tbl.flag81 then return end
    for _, obj in ipairs(tbl2.list1.Generators) do
        if obj and obj.Parent and not tbl2.list4[obj] then fn44(obj) end
    end
end)

-- Main heartbeat
RunService.Heartbeat:Connect(function(arg228)
    for i42 = 1, #tbl5 do
        local t = tbl5[i42]
        t.timer = t.timer + arg228
        if t.timer >= t.interval then
            t.timer = 0
            t.fn(arg228)
        end
    end
end)

-- ═══════════════════════════════════════
-- GUI CREATION (b0lngUi library)
-- ═══════════════════════════════════════
local function fn354()
    local var1209 = library:Window({
        Title = "VD-HUB",
        Image = "84034353458936",
        Footer = "Violence District",
        Author = "Premium Hub",
        Color = color3,
        Version = 1,
        Search = true,
        Folder = "VDHub",
    })

    var1209:InfoTab({
        Name = "Info",
        Icon = "info",
        SectionTitle = "Information",
        Banner = "79662603577585",
        BannerAspectRatio = 3.2,
        Version = str,
        DiscordLink = "https://discord.gg/vdhub",
        DiscordName = "VD Hub Community",
        DiscordText = "Join for updates & support.",
        DiscordDesc = "features: Killer & Survivor ESP, Auto Aim, Auto Generator, Killer Warn, Camera Veil, and many more.",
    })

    local var1210 = var1209:AddTab({Name = "Exclusive", Icon = "sparkles"})
    local var1211 = var1209:AddTab({Name = "Killer", Icon = "swords"})
    local var1212 = var1209:AddTab({Name = "Survivor", Icon = "user"})
    local var1213 = var1209:AddTab({Name = "Visual", Icon = "eye"})
    local var1214 = var1209:AddTab({Name = "Misc", Icon = "settings"})
    local var1215 = var1209:AddTab({Name = "Config", Icon = "save"})

    -- EXCLUSIVE TAB
    do
        local var1216 = var1210:AddSection("God Mode", nil)
        var1216:AddToggle({
            Title = "Enable God Mode",
            Default = false,
            Callback = function(arg264)
                if arg264 then fn71() else fn72() end
            end,
        })

        local var1217 = var1210:AddSection("Auto Aim (Legit)", nil)
        var1217:AddToggle({
            Title = "Enable Aim Lock",
            Default = false,
            Callback = function(arg272)
                tbl.flag79 = arg272
                if not arg272 then tbl2.field28 = nil end
            end,
        })
        var1217:AddDropdown({
            Title = "Lock Target",
            Options = {"Zombie", "Survivor", "Killer"},
            Default = tbl.str11,
            Callback = function(arg273) tbl.str11 = arg273 end,
        })
        var1217:AddDropdown({
            Title = "Aim Part",
            Options = {"Torso", "Head"},
            Default = "Torso",
            Callback = function(arg274) tbl.str13 = arg274 end,
        })
        var1217:AddDropdown({
            Title = "Lock Mode",
            Options = {"Always Lock", "Hold to Lock"},
            Default = "Always Lock",
            Callback = function(arg275) tbl.str12 = arg275 end,
        })
        var1217:AddSlider({
            Title = "Max Distance",
            Min = 20, Max = 700, Default = tbl.num118, Increment = 5,
            Callback = function(arg276) tbl.num118 = arg276 end,
        })
        var1217:AddSlider({
            Title = "Camera Smoothness",
            Min = 0.01, Max = 1, Default = tbl.num119, Increment = 0.01,
            Callback = function(arg277) tbl.num119 = arg277 end,
        })

        local var1218 = var1210:AddSection("Silent Aim (Twist of Fate)", nil)
        var1218:AddToggle({
            Title = "Silent Aim",
            Default = false,
            Callback = function(arg250) tbl2.flag134 = arg250 end,
        })
        var1218:AddDropdown({
            Title = "Target Type",
            Options = {"Killer", "Survivor", "Zombie"},
            Default = tbl.str14,
            Callback = function(arg251) tbl.str14 = arg251 end,
        })
        var1218:AddToggle({
            Title = "FOV Circle",
            Default = false,
            Callback = function(arg252) tbl2.flag137 = arg252 end,
        })
        var1218:AddToggle({
            Title = "Laser ESP",
            Default = false,
            Callback = function(arg253) tbl2.flag135 = arg253 end,
        })
        var1218:AddToggle({
            Title = "Auto Prediction",
            Default = true,
            Callback = function(arg254) tbl.flag90 = arg254 end,
        })
        var1218:AddToggle({
            Title = "Adaptive Damping",
            Default = true,
            Callback = function(arg255) tbl.flag91 = arg255 end,
        })
        var1218:AddSlider({
            Title = "Aim FOV Radius",
            Min = 30, Max = 500, Default = 150, Step = 5,
            Callback = function(arg256) tbl.num120 = arg256 end,
        })

        local var1219 = var1210:AddSection("Shoot While Downed", nil)
        var1219:AddToggle({
            Title = "Enable Shoot While Downed",
            Default = false,
            Callback = function(arg257) tbl.flag107 = arg257 end,
        })

        local var1220 = var1210:AddSection("Crosshair", nil)
        var1220:AddToggle({
            Title = "Enable Crosshair",
            Default = false,
            Callback = function(arg258) tbl2.flag143 = arg258 end,
        })
        var1220:AddSlider({
            Title = "Size",
            Min = 1, Max = 100, Default = 20, Increment = 1,
            Callback = function(arg260) tbl.num122 = arg260 end,
        })
        var1220:AddColorPicker({
            Title = "Crosshair Color",
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(color) end,
        })

        local var1221 = var1210:AddSection("Self Heal & Bandage", nil)
        var1221:AddToggle({
            Title = "No-Anim Self Heal",
            Default = false,
            Callback = function(arg265) end,
        })
        var1221:AddToggle({
            Title = "Self Heal",
            Default = false,
            Callback = function(arg266) end,
        })
        var1221:AddToggle({
            Title = "Bandage Boost",
            Default = false,
            Callback = function(arg267) end,
        })

        local var1222 = var1210:AddSection("Aimlock Flashlight", nil)
        var1222:AddToggle({
            Title = "Enable Aimlock Flashlight",
            Default = false,
            Callback = function(arg270) tbl2.flag155 = arg270 end,
        })
        var1222:AddSlider({
            Title = "Smoothness",
            Min = 0.05, Max = 1, Default = 0.35, Step = 0.01,
            Callback = function(arg271) tbl2.num156 = tonumber(arg271) or 0.35 end,
        })
    end

    -- KILLER TAB
    do
        local var1242 = var1211:AddSection("Killer No Cooldown", nil)
        var1242:AddToggle({
            Title = "Enable No Cooldown",
            Content = "Hidden, Abysswalker, Masked, More",
            Default = false,
            Callback = function(arg280) end,
        })
        local var1243 = var1242:AddHStack()
        var1243:AddButton({
            Title = "Fire Corrupt (Abyss)",
            Callback = function()
                pcall(function()
                    local corrupt = ReplicatedStorage.Remotes.Killers.Abysswalker.corrupt
                    corrupt:FireServer()
                end)
            end,
        })
        var1243:AddButton({
            Title = "Fire Slash (Abyss)",
            Callback = function()
                pcall(function()
                    local basicAttack = ReplicatedStorage.Remotes.Attacks.BasicAttack
                    basicAttack:FireServer(true)
                end)
            end,
        })

        local var1244 = var1211:AddSection("Mayers No Cooldown", nil)
        var1244:AddToggle({
            Title = "Enable Mayers No Cooldown",
            Default = false,
            Callback = function(arg281) tbl2.flag160 = arg281 end,
        })
        var1244:AddToggle({
            Title = "Stalk While Moving",
            Default = false,
            Callback = function(arg282) tbl2.flag161 = arg282 end,
        })

        local var1246 = var1211:AddSection("Infinite Lunge", nil)
        var1246:AddToggle({
            Title = "Enable Infinite Lunge",
            Default = tbl.flag100,
            Callback = function(arg283) tbl.flag100 = arg283 end,
        })

        local var1248 = var1211:AddSection("Aimlock M2 Hidden", nil)
        var1248:AddToggle({
            Title = "Enable AIMLOCK M2",
            Default = false,
            Callback = function(arg284) tbl2.flag159 = arg284 end,
        })
        var1248:AddSlider({
            Title = "Smoothness",
            Min = 0.05, Max = 1, Default = 1, Step = 0.01,
            Callback = function(arg285) tbl2.num160 = tonumber(arg285) or 1 end,
        })

        local var1249 = var1211:AddSection("Masked Skill Spammer", nil)
        var1249:AddDropdown({
            Title = "Select Mask Power",
            Options = {"Alex", "Brandon", "Cobra", "Rabbit", "Richter", "Tony"},
            Default = "Cobra",
            Callback = function(arg286) end,
        })
        local var1250 = var1249:AddHStack()
        var1250:AddButton({
            Title = "Activate Power",
            Callback = function()
                pcall(function()
                    local activatepower = ReplicatedStorage.Remotes.Killers.Masked.Activatepower
                    activatepower:FireServer("Cobra")
                end)
            end,
        })
        var1250:AddButton({
            Title = "Deactivate Power",
            Callback = function()
                pcall(function()
                    local deactivatepower = ReplicatedStorage.Remotes.Killers.Masked.Deactivatepower
                    deactivatepower:FireServer()
                end)
            end,
        })

        local var1251 = var1211:AddSection("Anti Blind", nil)
        var1251:AddToggle({
            Title = "Anti Flashlight Blind",
            Default = false,
            Callback = function(arg287) tbl.flag96 = arg287 end,
        })

        local var1252 = var1211:AddSection("Anti Looping", nil)
        var1252:AddToggle({
            Title = "Anti Loop Window",
            Default = false,
            Callback = function(arg288) tbl2.flag146 = arg288 end,
        })
        var1252:AddButton({
            Title = "Auto Drop All Pallets",
            Callback = function() end,
        })

        local var1253 = var1211:AddSection("Killer Perks Info", nil)
        var1253:AddToggle({
            Title = "Enable Killer Perks Info",
            Default = tbl.flag104,
            Callback = function(arg289) tbl.flag104 = arg289 end,
        })

        local var1255 = var1211:AddSection("Hook Counter", nil)
        var1255:AddToggle({
            Title = "Show Hook Counter",
            Default = tbl.flag105,
            Callback = function(arg290) tbl.flag105 = arg290 end,
        })
    end

    -- SURVIVOR TAB
    do
        local var1256 = var1212:AddSection("Auto Generator", nil)
        var1256:AddToggle({
            Title = "Auto Generator",
            Default = tbl.flag76,
            Callback = function(arg291) tbl.flag76 = arg291 end,
        })
        var1256:AddDropdown({
            Title = "Mode",
            Options = {"Instant", "Perfect", "Normal", "Random"},
            Default = tbl.str1,
            Callback = function(arg292) tbl.str1 = arg292 end,
        })

        local var1257 = var1212:AddSection("Generator Boost", nil)
        var1257:AddToggle({
            Title = "Show GenBoost Button",
            Default = false,
            Callback = function(arg293) tbl.flag77 = arg293 end,
        })

        local var1258 = var1212:AddSection("Anti Fall Slow", nil)
        var1258:AddToggle({
            Title = "Anti Fall Slow",
            Default = false,
            Callback = function(arg294) tbl2.flag111 = arg294 end,
        })

        local var1260 = var1212:AddSection("Speed Boost V1", nil)
        var1260:AddToggle({
            Title = "Speed Boost",
            Default = false,
            Callback = function(arg295) var406(arg295) end,
        })
        var1260:AddSlider({
            Title = "Boost Multiplier",
            Min = 0, Max = 2, Default = 0.3, Increment = 0.01,
            Callback = function(arg296) tbl2.num127 = arg296 end,
        })
        var1260:AddToggle({
            Title = "Count Speed Perks",
            Default = true,
            Callback = function(arg297) tbl2.flag110 = arg297 end,
        })
        var1260:AddToggle({
            Title = "Pause when Crouching",
            Default = false,
            Callback = function(arg298) tbl2.flag113 = arg298 end,
        })

        local var1262 = var1212:AddSection("Speed Boost V2", nil)
        var1262:AddToggle({
            Title = "Speed Boost V2",
            Default = false,
            Callback = function(arg300) tbl2.flag114 = arg300 end,
        })
        var1262:AddDropdown({
            Title = "Team Filter",
            Options = {"Both", "Survivors", "Killer"},
            Default = "Both",
            Callback = function(arg301) tbl2.str16 = arg301 end,
        })
        var1262:AddSlider({
            Title = "Boost Multiplier x",
            Min = 1, Max = 3, Default = 1.3, Increment = 0.01,
            Callback = function(arg302) tbl2.num128 = arg302 end,
        })
        var1262:AddToggle({
            Title = "Count Speed Perks",
            Default = true,
            Callback = function(arg303) tbl2.flag115 = arg303 end,
        })

        local var1263 = var1212:AddSection("No Slowdown", nil)
        var1263:AddToggle({
            Title = "No Slowdown",
            Default = false,
            Callback = function(arg305) tbl2.flag109 = arg305 end,
        })
        var1263:AddToggle({
            Title = "Safe Mode",
            Default = true,
            Callback = function(arg306) tbl2.flag112 = arg306 end,
        })

        local var1266 = var1212:AddSection("Auto Crouch (Abyss)", nil)
        var1266:AddToggle({
            Title = "Auto Crouch",
            Default = false,
            Callback = function(arg307) tbl.flag95 = arg307 end,
        })
        var1266:AddSlider({
            Title = "Crouch Radius (Stud)",
            Min = 4, Max = 40, Default = 18, Increment = 1,
            Callback = function(arg308) tbl.num122 = arg308 end,
        })

        local var1267 = var1212:AddSection("Auto Drop Pallet", nil)
        var1267:AddToggle({
            Title = "Auto Drop Nearby Pallet",
            Default = false,
            Callback = function(arg309) tbl2.flag148 = arg309 end,
        })

        local var1268 = var1212:AddSection("Moonwalk", nil)
        var1268:AddToggle({
            Title = "Enable Moonwalk",
            Default = false,
            Callback = function(arg310) tbl.flag99 = arg310 end,
        })
        var1268:AddDropdown({
            Title = "Moonwalk Mode",
            Options = {"Classic", "Sway"},
            Default = "Classic",
            Callback = function(arg311) tbl.str15 = arg311 end,
        })
        var1268:AddSlider({
            Title = "Sway Width",
            Min = 0.1, Max = 1.5, Default = 0.55, Increment = 0.05,
            Callback = function(arg312) tbl.num123 = arg312 end,
        })
        var1268:AddSlider({
            Title = "Sway Speed",
            Min = 1, Max = 12, Default = 6, Increment = 0.5,
            Callback = function(arg313) tbl.num124 = arg313 end,
        })

        local var1269 = var1212:AddSection("Fast Vault", nil)
        var1269:AddToggle({
            Title = "Always Fast Vault",
            Default = false,
            Callback = function(arg314) tbl.flag101 = arg314 end,
        })

        local var1270 = var1212:AddSection("Flowstate", nil)
        var1270:AddToggle({
            Title = "Force Flowstate Perk",
            Default = false,
            Callback = function(arg315) tbl.flag102 = arg315 end,
        })
        var1270:AddSlider({
            Title = "Flowstate Cooldown (s)",
            Min = 0, Max = 60, Default = 15, Increment = 1,
            Callback = function(arg316) tbl.num125 = arg316 end,
        })
        var1270:AddToggle({
            Title = "Hide Flowstate UI",
            Default = false,
            Callback = function(arg317) tbl.flag103 = arg317 end,
        })

        local var1271 = var1212:AddSection("Fake Perks", nil)
        var1271:AddSlider({
            Title = "Perk Cooldown",
            Min = 0, Max = 60, Default = 10, Increment = 1,
            Callback = function(arg318) end,
        })
        var1271:AddToggle({
            Title = "Quick Recovery",
            Default = false,
            Callback = function(arg319) end,
        })
        var1271:AddToggle({
            Title = "Perfect Landing",
            Default = false,
            Callback = function(arg320) end,
        })
        var1271:AddToggle({
            Title = "Adrenaline Rush",
            Default = false,
            Callback = function(arg321) end,
        })

        local var1272 = var1212:AddSection("Escape Gate", nil)
        var1272:AddButton({
            Title = "Auto Escape (Teleport)",
            Callback = function() fn241() end,
        })
        var1272:AddToggle({
            Title = "Ghost Gate (Legit)",
            Default = false,
            Callback = function(arg322)
                tbl2.flag145 = arg322
                fn240()
            end,
        })

        local var1273 = var1212:AddSection("Lock FOV", nil)
        var1273:AddToggle({
            Title = "Lock FOV",
            Default = tbl.flag75,
            Callback = function(arg323)
                tbl.flag75 = arg323
                if arg323 then fn111(tbl.num117) else fn112() end
            end,
        })
        var1273:AddSlider({
            Title = "FOV Value",
            Min = 30, Max = 120, Default = tbl.num117, Increment = 1,
            Callback = function(arg324)
                tbl.num117 = arg324
                if tbl.flag75 then fn111(arg324) end
            end,
        })
    end

    -- VISUAL TAB
    do
        local var1276 = var1213:AddSection("Killer ESP", nil)
        local var1277 = var1276:AddHStack()
        var1277:AddToggle({
            Title = "Show Name",
            Default = tbl.flag1,
            Callback = function(arg325) tbl.flag1 = arg325; var198() end,
        })
        var1277:AddToggle({
            Title = "Show Outline",
            Default = tbl.flag64,
            Callback = function(arg326) tbl.flag64 = arg326; var198() end,
        })
        var1276:AddColorPicker({
            Title = "Killer Color",
            Default = tbl.color31,
            Callback = function(color) tbl.color31 = color; var198() end,
        })

        local var1278 = var1213:AddSection("Survivor ESP", nil)
        local var1279 = var1278:AddHStack()
        var1279:AddToggle({
            Title = "Show Name",
            Default = tbl.flag66,
            Callback = function(arg327) tbl.flag66 = arg327; var198() end,
        })
        var1279:AddToggle({
            Title = "Show Outline",
            Default = tbl.flag67,
            Callback = function(arg328) tbl.flag67 = arg328; var198() end,
        })
        var1278:AddColorPicker({
            Title = "Survivor Color",
            Default = tbl.color37,
            Callback = function(color) tbl.color37 = color; var198() end,
        })

        local var1280 = var1213:AddSection("Zombie / SCP ESP", nil)
        var1280:AddToggle({
            Title = "Enable SCP ESP",
            Default = tbl.flag69,
            Callback = function(arg329) tbl.flag69 = arg329 end,
        })
        local var1281 = var1280:AddHStack()
        var1281:AddToggle({
            Title = "Show Name",
            Default = tbl.flag70,
            Callback = function(arg330) tbl.flag70 = arg330; RefreshScpEsp() end,
        })
        var1280:AddColorPicker({
            Title = "SCP Color",
            Default = tbl.color38,
            Callback = function(color) tbl.color38 = color end,
        })
        var1280:AddSlider({
            Title = "SCP ESP Distance",
            Min = 25, Max = 600, Default = tbl.num114, Live = true,
            Callback = function(arg331) tbl.num114 = arg331; RefreshScpEsp() end,
        })

        local var1282 = var1213:AddSection("Player ESP Settings", nil)
        var1282:AddToggle({
            Title = "Outline Only",
            Default = tbl.flag65,
            Callback = function(arg332)
                tbl.flag65 = arg332
                tbl.flag68 = arg332
                var198()
            end,
        })
        var1282:AddButton({
            Title = "Refresh All ESP",
            Callback = function() ForceRefreshAllESP() end,
        })
        var1282:AddSlider({
            Title = "Killer ESP Distance",
            Min = 25, Max = 600, Default = tbl.num1, Live = true,
            Callback = function(arg333) tbl.num1 = arg333; var198() end,
        })
        var1282:AddSlider({
            Title = "Survivor ESP Distance",
            Min = 25, Max = 600, Default = tbl.num113, Live = true,
            Callback = function(arg334) tbl.num113 = arg334; var198() end,
        })

        local var1283 = var1213:AddSection("Show Item Survivor", nil)
        var1283:AddToggle({
            Title = "Show Equipped Item",
            Default = false,
            Callback = function(arg335) tbl.flag97 = arg335 end,
        })

        local var1284 = var1213:AddSection("Object ESP", nil)
        local var1285 = var1284:AddHStack()
        var1285:AddToggle({
            Title = "ESP Generator",
            Default = tbl.flag80,
            Callback = function(arg336) tbl.flag80 = arg336; var234() end,
        })
        var1285:AddToggle({
            Title = "Progress Gen",
            Default = tbl.flag81,
            Callback = function(arg337) tbl.flag81 = arg337; var234() end,
        })
        var1284:AddToggle({
            Title = "Show Generator Info",
            Default = tbl.flag78,
            Callback = function(arg338) tbl.flag78 = arg338 end,
        })
        local var1286 = var1284:AddHStack()
        var1286:AddToggle({
            Title = "ESP Window",
            Default = tbl.flag82,
            Callback = function(arg339) tbl.flag82 = arg339 end,
        })
        var1286:AddToggle({
            Title = "ESP Pallet",
            Default = tbl.flag83,
            Callback = function(arg340) tbl.flag83 = arg340; var234() end,
        })
        local var1287 = var1284:AddHStack()
        var1287:AddToggle({
            Title = "ESP Hook",
            Default = tbl.flag84,
            Callback = function(arg341) tbl.flag84 = arg341; var234() end,
        })
        var1287:AddToggle({
            Title = "ESP Gate",
            Default = tbl.flag85,
            Callback = function(arg342) tbl.flag85 = arg342; var234() end,
        })
        local var1288 = var1284:AddHStack()
        var1288:AddColorPicker({
            Title = "Generator Color",
            Default = tbl.color39,
            Callback = function(color) tbl.color39 = color end,
        })
        var1288:AddColorPicker({
            Title = "Window Color",
            Default = tbl.color310,
            Callback = function(color) tbl.color310 = color end,
        })
        local var1289 = var1284:AddHStack()
        var1289:AddColorPicker({
            Title = "Pallet Color",
            Default = tbl.color311,
            Callback = function(color) tbl.color311 = color end,
        })
        var1289:AddColorPicker({
            Title = "Hook Color",
            Default = tbl.color312,
            Callback = function(color) tbl.color312 = color end,
        })
        local var1291 = var1284:AddHStack()
        var1291:AddColorPicker({
            Title = "Gate Color",
            Default = tbl.color313,
            Callback = function(color) tbl.color313 = color end,
        })

        local var1292 = var1213:AddSection("Prediction Map & Killer", nil)
        var1292:AddToggle({
            Title = "Show Prediction Monitor",
            Default = false,
            Callback = function(arg343) end,
        })

        local var1293 = var1213:AddSection("World Settings", nil)
        var1293:AddToggle({
            Title = "Fullbright",
            Default = false,
            Callback = function(arg344)
                tbl2.flag132 = arg344
                if arg344 then var888() else restoreLighting() end
            end,
        })
        var1293:AddToggle({
            Title = "Remove Visual Effects",
            Default = false,
            Callback = function(arg345)
                tbl2.flag133 = arg345
                if arg345 then removeVisualEffects() else restoreVisualEffects() end
            end,
        })
    end

    -- MISC TAB
    do
        local var1296 = var1214:AddSection("Potato Graphics", nil)
        var1296:AddButton({
            Title = "Apply Potato Graphics",
            Callback = function()
                tbl.flag106 = true
                fn2("Potato Graphics", "Potato mode diterapkan", 2)
            end,
        })

        local var1297 = var1214:AddSection("Anti AFK", nil)
        var1297:AddToggle({
            Title = "Enable Anti AFK",
            Default = false,
            Callback = function(arg346) var82(arg346) end,
        })

        local var1298 = var1214:AddSection("Killer Warn", nil)
        var1298:AddToggle({
            Title = "Enable Killer Warn",
            Default = tbl.flag74,
            Callback = function(arg347) tbl.flag74 = arg347 end,
        })

        local var1299 = var1214:AddSection("Stun Timer", nil)
        var1299:AddToggle({
            Title = "Enable Stun Timer",
            Default = false,
            Callback = function(arg348) end,
        })
        var1299:AddSlider({
            Title = "Max Distance",
            Min = 50, Max = 500, Default = 250, Increment = 10,
            Callback = function(arg349) tbl2.num155 = arg349 end,
        })

        local var1300 = var1214:AddSection("Performance Monitor", nil)
        var1300:AddToggle({
            Title = "Show Performance Window",
            Default = false,
            Callback = function(arg350) end,
        })

        local var1301 = var1214:AddSection("Spectator Count", nil)
        var1301:AddToggle({
            Title = "Show Spectator Counter",
            Default = false,
            Callback = function(arg351) end,
        })

        local var1302 = var1214:AddSection("Camera Zoom", nil)
        var1302:AddToggle({
            Title = "Max Camera Zoom",
            Default = tbl.flag71,
            Callback = function(arg352)
                tbl.flag71 = arg352
                if arg352 then fn106(tbl.cameraZoomValue) else fn107() end
            end,
        })

        local var1303 = var1214:AddSection("Camera Stiffness", nil)
        var1303:AddToggle({
            Title = "Smooth Camera",
            Default = tbl.flag72,
            Callback = function(arg353) tbl.flag72 = arg353 end,
        })
        var1303:AddSlider({
            Title = "Stiffness",
            Min = 1, Max = 10, Default = 5, Increment = 0.1,
            Callback = function(arg354) tbl.num115 = arg354 end,
        })

        local var1304 = var1214:AddSection("Aspect Ratio", nil)
        var1304:AddToggle({
            Title = "Stretched Res",
            Default = tbl.flag73,
            Callback = function(arg355) tbl.flag73 = arg355 end,
        })
        var1304:AddDropdown({
            Title = "Preset",
            Options = {"Normal 16:9", "4:3 Stretched", "16:10", "21:9 Ultrawide"},
            Default = "Normal 16:9",
            Callback = function(arg356)
                local tbl112 = {
                    ["Normal 16:9"] = 1.7777777777777777,
                    ["4:3 Stretched"] = 1.3333333333333333,
                    ["16:10"] = 1.6,
                    ["21:9 Ultrawide"] = 2.3333333333333335,
                }
                tbl.num116 = tbl112[arg356] or 1.7777777777777777
            end,
        })
        var1304:AddSlider({
            Title = "Custom Ratio",
            Min = 0.8, Max = 2.5, Default = 1.7777777777777777, Increment = 0.01,
            Callback = function(arg357) tbl.num116 = arg357 end,
        })

        local var1307 = var1214:AddSection("Force Cursor (PC)", nil)
        var1307:AddToggle({
            Title = "Force Mouse Cursor",
            Default = false,
            Callback = function(arg358) tbl.flag98 = arg358 end,
        })

        local var1310 = var1214:AddSection("Protect Name", nil)
        var1310:AddToggle({
            Title = "Enable Protect Name",
            Default = false,
            Callback = function(arg359) end,
        })

        local var1311 = var1214:AddSection("Skip Cutscene", nil)
        var1311:AddToggle({
            Title = "Skip End Screen",
            Default = false,
            Callback = function(arg360)
                tbl.flag88 = arg360
                if arg360 then fn154(false) else fn160() end
            end,
        })
        var1311:AddToggle({
            Title = "Skip Loading & End Screen",
            Default = false,
            Callback = function(arg361)
                tbl.flag89 = arg361
                if arg361 then fn154(true) else fn160() end
            end,
        })

        local var1313 = var1214:AddSection("Avatar Copy", nil)
        var1313:AddInput({
            Title = "Username / ID",
            Default = "",
            Placeholder = "Enter username or ID",
            Callback = function(arg362) end,
        })
        var1313:AddButton({
            Title = "Copy Avatar",
            Callback = function()
                fn2("Avatar", "Copy avatar executed", 2)
            end,
        })

        local var1314 = var1214:AddSection("Jerk Off (Fun)", nil)
        var1314:AddToggle({
            Title = "Enable Jerk Off",
            Default = false,
            Callback = function(arg363) end,
        })

        local var1315 = var1214:AddSection("Noclip & Fly", nil)
        var1315:AddToggle({
            Title = "Enable Noclip",
            Default = false,
            Callback = function(arg364)
                if arg364 then var1100() else StopNoclip() end
            end,
        })
        var1315:AddToggle({
            Title = "Fly GUI",
            Default = false,
            Callback = function(arg365) tbl2.flag144 = arg365 end,
        })

        local var1316 = var1214:AddSection("Hop Server / Respawn", nil)
        var1316:AddButton({
            Title = "Hop Server",
            Callback = function()
                pcall(function()
                    game:GetService("TeleportService"):Teleport(game.PlaceId, localPlayer)
                end)
            end,
        })
        var1316:AddButton({
            Title = "Rejoin Server",
            Callback = function()
                pcall(function()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
                end)
            end,
        })
        var1316:AddButton({
            Title = "Respawn",
            Callback = function()
                pcall(function()
                    local char = localPlayer.Character
                    local var1319 = char and char:FindFirstChildOfClass("Humanoid")
                    if var1319 then var1319.Health = 0 end
                end)
            end,
        })
    end

    -- CONFIG TAB
    do
        local var1322 = var1215:AddSection("Configuration", true)
        var1322:AddConfig()
    end
end

fn354()
print("VD HUB LOADED!")
