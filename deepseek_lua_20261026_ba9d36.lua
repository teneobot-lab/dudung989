--[[ Violence District — [N]yx v3.2 (BUG FIXED) ]]

print("[N]yx: starting...")

local ok, err = pcall(function()

local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local VU=game:GetService("VirtualUser")
local RS=game:GetService("ReplicatedStorage")
local WS=game:GetService("Workspace")
local LG=game:GetService("Lighting")
local CS=game:GetService("CollectionService")
local Stats=game:GetService("Stats")
local TW=game:GetService("TweenService")
local HS=game:GetService("HttpService")
local LP=Players.LocalPlayer
local PG=LP:WaitForChild("PlayerGui")

-- ═══════════ CONFIG (with avatarInput added) ═══════════
local DEFAULTS = {
    espKiller=false,espSurvivor=false,
    espKillerColor=Color3.fromRGB(255,60,60),espSurvivorColor=Color3.fromRGB(60,200,255),
    espDist=500,espGenerator=false,espPallet=false,espWindow=false,espHook=false,espGate=false,
    genColor=Color3.fromRGB(200,100,0),palletColor=Color3.fromRGB(53,189,166),
    windowColor=Color3.fromRGB(255,223,0),hookColor=Color3.fromRGB(252,116,116),gateColor=Color3.fromRGB(255,255,255),
    genProgress=false,genInfo=false,
    autoGen=false,autoGenMode="Normal",selfHeal=false,
    speedBoost=false,speedMult=0.3,speedV2=false,speedV2Mult=1.3,
    godMode=false,noclip=false,noSlowdown=false,
    antiBlind=false,killerWarn=false,fullbright=false,crosshair=false,moonwalk=false,
    silentAim=false,aimTarget="Killer",aimFov=150,aimPrediction=true,
    silentSpear=false,spearFov=150,spearPrediction=true,
    autoParry=false,parryRadius=10,radiusESP=false,
    noCooldown=false,mayersNoCD=false,infiniteLunge=false,
    aimlockM2=false,aimlockM2Smooth=1,
    aimLock=false,aimLockTarget="Survivor",aimLockPart="Torso",aimLockDist=700,aimLockSmooth=0.15,
    cameraVeil=false,antiLoopWindow=false,autoDropPallet=false,fastVault=false,
    hookCounter=false,killerPerksInfo=false,spectatorCount=false,
    stunTimer=false,stunTimerDist=250,flowstate=false,
    fakeQuickRecovery=false,fakePerfectLanding=false,fakeAdrenalineRush=false,
    potatoGraphics=false,antiAFK=false,forceCursor=false,
    skipEndScreen=false,skipLoading=false,
    perfMonitor=false,predictionMonitor=false,
    stretchedRes=false,stretchRatio=1.7777777777777777,
    cameraZoom=false,
    autoCrouch=false,autoCrouchRadius=18,shootWhileDowned=false,
    avatarInput="",
}
local C = {}
for k,v in pairs(DEFAULTS) do C[k]=v end

-- ═══════════ HELPERS ═══════════
local function isKiller(p) return p and p.Team and string.lower(p.Team.Name):find("killer")~=nil end
local function isSurvivor(p) return p and p.Team and not string.lower(p.Team.Name):find("killer") end
local function getRoot(c) return c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")) end
local function getHum(c) return c and c:FindFirstChildOfClass("Humanoid") end
local function isBusy(c)
    if not c then return true end
    if c:GetAttribute("IsHooked") or c:GetAttribute("IsCarried") or c:GetAttribute("Knocked") then return true end
    local h=getHum(c); return not h or h.Health<=0
end

-- ═══════════ CONFIG SAVE/LOAD ═══════════
local CFG_FOLDER="VD_Nyx"
local CFG_FILE=CFG_FOLDER.."/config.json"

local function cfgSerialize()
    local t={}
    for k,v in pairs(C) do
        if typeof(v)=="Color3" then t[k]={__c3=true,r=v.R,g=v.G,b=v.B}
        else t[k]=v end
    end
    return HS:JSONEncode(t)
end

local function cfgDeserialize(str)
    local t=HS:JSONDecode(str)
    for k,v in pairs(t) do
        if DEFAULTS[k]==nil then continue end
        if type(v)=="table" and v.__c3 then C[k]=Color3.new(v.r,v.g,v.b)
        elseif type(v)==type(DEFAULTS[k]) or DEFAULTS[k]==nil then C[k]=v end
    end
end

local function saveConfig()
    if not writefile then return false,"No writefile" end
    pcall(function() if makefolder and isfolder and not isfolder(CFG_FOLDER) then makefolder(CFG_FOLDER) end end)
    return pcall(writefile,CFG_FILE,cfgSerialize())
end

local function loadConfig()
    if not readfile or not isfile or not isfile(CFG_FILE) then return false,"Config belum ada" end
    local okk,data=pcall(readfile,CFG_FILE)
    if not okk or not data then return false,"Gagal baca" end
    return pcall(cfgDeserialize,data)
end

local function deleteConfig()
    if not delfile or not isfile or not isfile(CFG_FILE) then return false end
    pcall(delfile,CFG_FILE); return true
end

-- FIX #6: reset lengkap, semua DEFAULTS
local function resetConfig()
    for k,v in pairs(DEFAULTS) do C[k]=v end
end

-- ═══════════ ESP ═══════════
local espFolder=Instance.new("Folder"); espFolder.Name="__VD_ESP__"; espFolder.Parent=WS
local espData={}
local function createESP(p)
    if p==LP then return end
    local bb=Instance.new("BillboardGui"); bb.Name="E_"..p.Name; bb.AlwaysOnTop=true
    bb.Size=UDim2.fromOffset(150,18); bb.StudsOffset=Vector3.new(0,3.5,0)
    bb.MaxDistance=C.espDist; bb.Parent=espFolder
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.fromScale(1,1); lbl.BackgroundTransparency=1
    lbl.TextColor3=Color3.new(1,1,1); lbl.TextStrokeTransparency=0; lbl.TextStrokeColor3=Color3.new(0,0,0)
    lbl.TextSize=12; lbl.Font=Enum.Font.GothamBold; lbl.Text=p.Name; lbl.Parent=bb
    local hl=Instance.new("Highlight"); hl.FillTransparency=0.6; hl.OutlineTransparency=0
    hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent=espFolder
    espData[p]={bb=bb,lbl=lbl,hl=hl}
    if p.Character then local r=getRoot(p.Character); if r then bb.Adornee=r end; hl.Adornee=p.Character end
    p.CharacterAdded:Connect(function(ch)
        task.wait(0.2); local d=espData[p]
        if d then local r=getRoot(ch); if r then d.bb.Adornee=r end; d.hl.Adornee=ch end
    end)
end
local function removeESP(p)
    local d=espData[p]; if d then
        if d.bb then d.bb:Destroy() end
        if d.hl then d.hl:Destroy() end
        espData[p]=nil
    end
end
local function updateESP()
    for p,d in pairs(espData) do
        if not p.Parent then removeESP(p); continue end
        local k=isKiller(p)
        local vis=(k and C.espKiller) or (not k and C.espSurvivor)
        local col=k and C.espKillerColor or C.espSurvivorColor
        d.lbl.Text=p.Name; d.lbl.Visible=vis; d.bb.MaxDistance=C.espDist
        d.hl.FillColor=col; d.hl.OutlineColor=col; d.hl.Enabled=vis
        if p.Character then local r=getRoot(p.Character); if r then d.bb.Adornee=r end end
    end
end
for _,p in ipairs(Players:GetPlayers()) do createESP(p) end
Players.PlayerAdded:Connect(createESP); Players.PlayerRemoving:Connect(removeESP)

local objESP={}
local function mkObjHL(obj,col)
    if not obj or not obj.Parent then return end
    local hl=objESP[obj]
    if hl then hl.FillColor=col; hl.OutlineColor=col; return end
    hl=Instance.new("Highlight"); hl.Adornee=obj; hl.FillColor=col; hl.OutlineColor=col
    hl.FillTransparency=1; hl.OutlineTransparency=0
    hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent=obj; objESP[obj]=hl
end
local function rmObjHL(obj)
    local hl=objESP[obj]; if hl and hl.Parent then hl:Destroy() end; objESP[obj]=nil
end
local function scanObjects()
    local map=WS:FindFirstChild("Map"); if not map then return end
    local seen={}
    for _,obj in ipairs(map:GetDescendants()) do
        if obj.Name=="Generator" then seen[obj]=true; if C.espGenerator then mkObjHL(obj,C.genColor) else rmObjHL(obj) end
        elseif obj.Name=="Pallet" or obj.Name=="Palletwrong" then seen[obj]=true; if C.espPallet then mkObjHL(obj,C.palletColor) else rmObjHL(obj) end
        elseif obj.Name=="Window" then seen[obj]=true; if C.espWindow then mkObjHL(obj,C.windowColor) else rmObjHL(obj) end
        elseif obj.Name=="Hook" then seen[obj]=true; if C.espHook then mkObjHL(obj,C.hookColor) else rmObjHL(obj) end
        elseif obj.Name=="Gate" then seen[obj]=true; if C.espGate then mkObjHL(obj,C.gateColor) else rmObjHL(obj) end end
    end
    for o in pairs(objESP) do if not seen[o] or not o.Parent then rmObjHL(o) end end
end

local genBoards={}
local function updateGenProg()
    local map=WS:FindFirstChild("Map"); if not map then return end
    for _,obj in ipairs(map:GetDescendants()) do
        if obj.Name=="Generator" then
            if C.genProgress then
                local prog=obj:GetAttribute("RepairProgress") or obj:GetAttribute("Progress") or 0
                local done=prog>=100 or obj:GetAttribute("Completed")==true
                local bb=genBoards[obj]
                if done then if bb then bb:Destroy(); genBoards[obj]=nil end
                else
                    if not bb or not bb.Parent then
                        bb=Instance.new("BillboardGui"); bb.AlwaysOnTop=true
                        bb.Size=UDim2.fromOffset(110,16); bb.MaxDistance=260
                        local body=obj:FindFirstChildWhichIsA("BasePart",true)
                        if body then bb.Adornee=body; bb.StudsOffset=Vector3.new(0,body.Size.Y/2+3.5,0) end
                        bb.Parent=obj
                        local lbl=Instance.new("TextLabel"); lbl.Name="L"; lbl.Size=UDim2.fromScale(1,1)
                        lbl.BackgroundTransparency=1; lbl.RichText=true; lbl.TextSize=11
                        lbl.Font=Enum.Font.GothamBlack; lbl.Parent=bb; genBoards[obj]=bb
                    end
                    local lbl=bb:FindFirstChild("L")
                    if lbl then
                        local pct=math.floor(prog+0.5)
                        local col=pct<50 and "#FF6B35" or pct<100 and "#F4D03F" or "#64FF50"
                        local txt=string.format('<font color="%s">%d%%</font>',col,pct)
                        if C.genInfo then
                            local pc=obj:GetAttribute("PlayersRepairingCount") or 0
                            local kc=obj:GetAttribute("kickcount") or 0
                            txt=txt..string.format(' <font color="#555">│</font> <font color="#76D7C4">P:%d</font> <font color="#555">│</font> <font color="#FF6B6B">K:%d</font>',pc,kc)
                        end
                        lbl.Text=txt
                    end
                end
            else local bb=genBoards[obj]; if bb then bb:Destroy(); genBoards[obj]=nil end end
        end
    end
end

-- ═══════════ KILLER PERKS ═══════════
local kpiGui,kpiPanel,kpiRows
local function setupKPI()
    if kpiGui and kpiGui.Parent then kpiGui:Destroy() end
    kpiGui=Instance.new("ScreenGui"); kpiGui.Name="VD_KPI"; kpiGui.ResetOnSpawn=false
    kpiGui.DisplayOrder=48; kpiGui.Parent=PG
    kpiPanel=Instance.new("Frame"); kpiPanel.Size=UDim2.fromOffset(230,0)
    kpiPanel.AutomaticSize=Enum.AutomaticSize.Y; kpiPanel.Position=UDim2.new(1,-12,0,12)
    kpiPanel.AnchorPoint=Vector2.new(1,0); kpiPanel.BackgroundColor3=Color3.fromRGB(15,15,20)
    kpiPanel.BorderSizePixel=0; kpiPanel.Active=true; kpiPanel.Parent=kpiGui
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,10); c.Parent=kpiPanel
    local s=Instance.new("UIStroke"); s.Color=Color3.fromRGB(55,55,70); s.Thickness=1; s.Parent=kpiPanel
    local pad=Instance.new("UIPadding"); pad.PaddingLeft=UDim.new(0,10); pad.PaddingRight=UDim.new(0,10)
    pad.PaddingTop=UDim.new(0,8); pad.PaddingBottom=UDim.new(0,8); pad.Parent=kpiPanel
    local lay=Instance.new("UIListLayout"); lay.Padding=UDim.new(0,4); lay.Parent=kpiPanel
    local header=Instance.new("TextLabel"); header.Name="Header"; header.LayoutOrder=1
    header.BackgroundTransparency=1; header.Size=UDim2.new(1,0,0,16); header.Text="KILLER"
    header.TextColor3=Color3.new(1,1,1); header.TextSize=11; header.Font=Enum.Font.GothamBold
    header.TextXAlignment=Enum.TextXAlignment.Left; header.RichText=true; header.Parent=kpiPanel
    local div=Instance.new("Frame"); div.LayoutOrder=2; div.BackgroundColor3=Color3.fromRGB(55,55,70)
    div.Size=UDim2.new(1,0,0,1); div.BorderSizePixel=0; div.Parent=kpiPanel
    kpiRows=Instance.new("Frame"); kpiRows.LayoutOrder=3; kpiRows.BackgroundTransparency=1
    kpiRows.Size=UDim2.new(1,0,0,0); kpiRows.AutomaticSize=Enum.AutomaticSize.Y; kpiRows.Parent=kpiPanel
    local lay2=Instance.new("UIListLayout"); lay2.Padding=UDim.new(0,2); lay2.Parent=kpiRows
    local drag=false; local ds,dp
    header.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            drag=true; ds=i.Position; dp=kpiPanel.Position
        end
    end)
    header.InputChanged:Connect(function(i)
        if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local d=i.Position-ds; kpiPanel.Position=UDim2.new(1,dp.X.Offset+d.X,0,dp.Y.Offset+d.Y)
        end
    end)
    header.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
    end)
end
local lastKSig=""
local function updateKPI()
    if not C.killerPerksInfo or not kpiGui or not kpiGui.Parent then return end
    local killer
    for _,p in ipairs(Players:GetPlayers()) do if isKiller(p) then killer=p; break end end
    local sig,body
    if not killer then sig="none"; body='<font color="rgb(160,160,175)">No killer.</font>'
    else
        local perks={}
        local function add(v) if type(v)=="string" and v~="" then perks[v:gsub("%s+",""):lower()]=v end end
        pcall(function()
            for k,v in pairs(killer:GetAttributes()) do add(v); add(k) end
            local ep=killer:FindFirstChild("EquippedPerks") or killer:FindFirstChild("Perks")
            if ep then for _,v in ipairs(ep:GetChildren()) do add(v.Name); if v:IsA("ValueBase") and type(v.Value)=="string" then add(v.Value) end end end
        end)
        local list={}; for k in pairs(perks) do table.insert(list,k) end; table.sort(list)
        sig=killer.Name.."|"..table.concat(list,",")
        local lines={}
        for _,k in ipairs(list) do table.insert(lines,'<font color="rgb(200,200,215)">• '..perks[k]..'</font>') end
        body=#lines>0 and table.concat(lines,"\n") or '<font color="rgb(160,160,175)">No perk.</font>'
    end
    if sig==lastKSig then return end
    lastKSig=sig
    local header=kpiPanel:FindFirstChild("Header")
    if header then header.Text=killer and ('KILLER  <font color="rgb(120,180,255)">'..killer.Name..'</font>') or "KILLER" end
    for _,v in ipairs(kpiRows:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end
    local idx=1
    for line in string.gmatch(body,"[^\n]+") do
        local lbl=Instance.new("TextLabel"); lbl.BackgroundTransparency=1
        lbl.AutomaticSize=Enum.AutomaticSize.XY; lbl.LayoutOrder=idx; idx=idx+1
        lbl.Text=line; lbl.TextColor3=Color3.fromRGB(200,200,215); lbl.TextSize=12
        lbl.Font=Enum.Font.Gotham; lbl.RichText=true; lbl.TextXAlignment=Enum.TextXAlignment.Left
        lbl.Parent=kpiRows
    end
end

-- ═══════════ HOOK COUNTER ═══════════
local function getHookCount(p)
    local v=p:GetAttribute("HookCount"); if type(v)=="number" then return v end
    local hv=p:FindFirstChild("HookCount"); if hv and hv:IsA("ValueBase") then return tonumber(hv.Value) or 0 end
    local ch=p.Character
    if ch then local cv=ch:GetAttribute("HookCount"); if type(cv)=="number" then return cv end end
    return 0
end
local function updateHookCounter()
    if not C.hookCounter then return end
    local pg=LP:FindFirstChild("PlayerGui"); if not pg then return end
    for _,gui in ipairs(pg:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name:match("%-mob$") then
            local frame=gui:FindFirstChild("Frame")
            if frame then
                for i=1,5 do
                    local surv=frame:FindFirstChild("Survivor"..i)
                    local img=surv and surv:FindFirstChild("ImageLabel")
                    local txt=surv and surv:FindFirstChild("TextLabel")
                    if img and txt then
                        local name=(txt.Text or ""):gsub("%s+","")
                        local ex=img:FindFirstChild("VD_HC")
                        if name~="" and not name:lower():find("waiting") then
                            local plr; for _,p in ipairs(Players:GetPlayers()) do if p.Name==name or p.DisplayName==name then plr=p; break end end
                            if plr then
                                local hc=getHookCount(plr)
                                if not ex then
                                    ex=Instance.new("TextLabel"); ex.Name="VD_HC"; ex.Size=UDim2.new(1,0,0.35,0)
                                    ex.Position=UDim2.new(0,0,0.65,0); ex.BackgroundColor3=Color3.new(0,0,0)
                                    ex.BackgroundTransparency=0.5; ex.TextColor3=Color3.new(1,1,1)
                                    ex.TextStrokeTransparency=0; ex.TextScaled=true
                                    ex.Font=Enum.Font.SourceSansBold; ex.BorderSizePixel=0; ex.Parent=img
                                end
                                if hc>=3 then ex.Text="DEAD"; ex.TextColor3=Color3.fromRGB(255,75,75)
                                elseif hc==2 then ex.Text="Hooks: 2"; ex.TextColor3=Color3.fromRGB(255,140,0)
                                elseif hc==1 then ex.Text="Hooks: 1"; ex.TextColor3=Color3.fromRGB(210,130,255)
                                else ex.Text="Hooks: 0"; ex.TextColor3=Color3.new(1,1,1) end
                                ex.Visible=true
                            elseif ex then ex.Visible=false end
                        elseif ex then ex.Visible=false end
                    end
                end
            end
        end
    end
end

-- ═══════════ SPECTATOR (FIX #1: proper declaration) ═══════════
local specGui, specLabel
local specDet = {}
local function isSpecTeam() return LP.Team and string.lower(LP.Team.Name):find("spectator")~=nil end
local function setupSpec()
    if specGui and specGui.Parent then return end
    specGui=Instance.new("ScreenGui"); specGui.Name="VD_Spec"; specGui.ResetOnSpawn=false
    specGui.DisplayOrder=49; specGui.Parent=PG
    local f=Instance.new("Frame"); f.Size=UDim2.fromOffset(170,28); f.AnchorPoint=Vector2.new(0,1)
    f.Position=UDim2.new(0,10,1,-10); f.BackgroundColor3=Color3.fromRGB(15,15,20)
    f.BorderSizePixel=0; f.Parent=specGui
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,8); c.Parent=f
    local s=Instance.new("UIStroke"); s.Color=Color3.fromRGB(55,55,70); s.Thickness=1; s.Parent=f
    specLabel=Instance.new("TextLabel"); specLabel.Size=UDim2.fromScale(1,1)
    specLabel.BackgroundTransparency=1; specLabel.Text="SPECTATORS 0"
    specLabel.TextColor3=Color3.fromRGB(200,200,215); specLabel.TextSize=12
    specLabel.Font=Enum.Font.GothamBold; specLabel.RichText=true; specLabel.Parent=f
end
local PARTS={"Head","Torso","UpperTorso","Left Arm","Right Arm","Left Leg","Right Leg","LeftUpperArm","LeftUpperLeg","LeftFoot","RightFoot"}
local function checkSpec(p)
    if p==LP or isSpecTeam() then specDet[p.UserId]=nil; return end
    local ch=p.Character; if not ch then specDet[p.UserId]=nil; return end
    for _,n in ipairs(PARTS) do
        local part=ch:FindFirstChild(n)
        if part and part:IsA("BasePart") and (part.Transparency>0.001 or part.LocalTransparencyModifier>0.001) then
            specDet[p.UserId]={Player=p}; return
        end
    end
    specDet[p.UserId]=nil
end
local function updateSpec()
    if not C.spectatorCount then if specGui then specGui.Enabled=false end; return end
    setupSpec(); specGui.Enabled=true
    local n=0; for _,v in pairs(specDet) do if v.Player and v.Player.Parent then n=n+1 end end
    local col=n>0 and "rgb(80,220,100)" or "rgb(150,150,165)"
    specLabel.Text=string.format('<font color="%s">SPECTATORS %d</font>',col,n)
end

-- ═══════════ STUN TIMER ═══════════
local STUN={StunAnimation=true,WallHitStun=true,WallHitStun2=true,WipeMachete=true,Parried=true}
local stunBoards={}
local function updateStun()
    if not C.stunTimer then for p,b in pairs(stunBoards) do if b then b:Destroy() end; stunBoards[p]=nil end; return end
    local ch=LP.Character; local r=getRoot(ch)
    local org=r and r.Position or (WS.CurrentCamera and WS.CurrentCamera.CFrame.Position)
    if not org then return end
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and isKiller(p) then
            local pch=p.Character
            local head=pch and (pch:FindFirstChild("Head") or getRoot(pch))
            if head and (head.Position-org).Magnitude<=C.stunTimerDist then
                local remain=0
                local h=getHum(pch); local a=h and h:FindFirstChildOfClass("Animator")
                if a then
                    for _,t in ipairs(a:GetPlayingAnimationTracks()) do
                        local nm=t.Animation and t.Animation.Name or t.Name
                        if t.IsPlaying and STUN[nm] then
                            local left=(t.Length-t.TimePosition)/math.max(0.01,math.abs(t.Speed))
                            if left>remain then remain=left end
                        end
                    end
                end
                if remain>0.05 then
                    local bb=stunBoards[p]
                    if not bb or not bb.Parent then
                        bb=Instance.new("BillboardGui"); bb.AlwaysOnTop=true
                        bb.Size=UDim2.fromOffset(110,30); bb.MaxDistance=C.stunTimerDist
                        bb.Adornee=head; bb.Parent=head
                        local lbl=Instance.new("TextLabel"); lbl.Name="L"; lbl.Size=UDim2.fromScale(1,1)
                        lbl.BackgroundTransparency=1; lbl.TextColor3=Color3.fromRGB(255,220,60)
                        lbl.TextStrokeTransparency=0; lbl.TextStrokeColor3=Color3.new(0,0,0)
                        lbl.TextSize=18; lbl.Font=Enum.Font.GothamBold; lbl.Parent=bb
                        stunBoards[p]=bb
                    end
                    local lbl=bb:FindFirstChild("L"); if lbl then lbl.Text=string.format("Stun %.1fs",remain) end
                    bb.Enabled=true
                else local bb=stunBoards[p]; if bb then bb.Enabled=false end end
            else local bb=stunBoards[p]; if bb then bb.Enabled=false end end
        end
    end
end

-- ═══════════ NO COOLDOWN (FIX #2: checkcaller guard) ═══════════
local delayHooked=false
local CDT={[25]=true,[17]=true,[30]=true,[67.8]=true,[2]=true,[4]=true,[0.25]=true,[70]=true,[0.65]=true}
local MAYERS={[1]=true,[10]=true}
local function getActiveKiller()
    local v=LP:GetAttribute("SelectedKiller")
    if type(v)~="string" then return nil end
    local n=v:lower()
    if n:find("hidden") then return "hidden" end
    if n:find("mayers") or n:find("stalker") then return "mayers" end
    return nil
end
local function installNoCD()
    if delayHooked or not hookfunction then return end
    pcall(function()
        local nc=newcclosure or function(f) return f end
        local hooked
        hooked=hookfunction(task.delay,nc(function(dt,cb)
            if not hooked then return task.spawn(cb) end
            -- FIX #2: skip if from our own script
            if checkcaller and checkcaller() then return hooked(dt,cb) end
            if not C.noCooldown then return hooked(dt,cb) end
            if CDT[dt] then return hooked(0,cb) end
            if MAYERS[dt] and getActiveKiller()=="mayers" then return hooked(0,cb) end
            return hooked(dt,cb)
        end))
        delayHooked=true
    end)
end
local function getNearestSurv(maxD)
    local ch=LP.Character; local r=getRoot(ch); if not r then return nil,math.huge end
    local best,bd=nil,maxD+0.01
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local pr=getRoot(p.Character); local ph=getHum(p.Character)
            if pr and ph and ph.Health>0 then
                local d=(pr.Position-r.Position).Magnitude
                if d<bd then bd=d; best=p.Character end
            end
        end
    end
    return best,bd
end
local function mayersDash()
    if getActiveKiller()~="mayers" then return end
    local ch=LP.Character; if not ch then return end
    local r=getRoot(ch); local h=getHum(ch); if not r or not h then return end
    local anim
    pcall(function()
        local a=Instance.new("Animation"); a.AnimationId="rbxassetid://77477445889320"
        anim=h:FindFirstChildOfClass("Animator"):LoadAnimation(a)
        anim.Priority=Enum.AnimationPriority.Action; anim:Play()
    end)
    pcall(function() RS.Remotes.SoundPlayer:FireServer("132736711620405",r,0.3,70) end)
    pcall(function() RS.Remotes.Attacks.BasicAttack:FireServer(true) end)
    task.spawn(function()
        local t0=tick()
        while tick()-t0<2 do
            RunService.Heartbeat:Wait()
            local tgt,dist=getNearestSurv(5)
            if tgt and dist<=5 then
                pcall(function() local g=RS.Remotes.Killers.Stalker:FindFirstChild("grab"); if g then g:FireServer(tgt) end end)
                if anim then pcall(function() anim:Stop(0.1) end) end
                break
            end
        end
    end)
end
UIS.InputBegan:Connect(function(i,gp)
    if gp then return end
    if i.KeyCode==Enum.KeyCode.Q and C.mayersNoCD then pcall(mayersDash) end
end)

-- ═══════════ SILENT AIM ═══════════
local tofFire
task.spawn(function()
    pcall(function()
        tofFire=RS:WaitForChild("Remotes",15):WaitForChild("Items",10):WaitForChild("Twist of Fate",10):WaitForChild("Fire",10)
    end)
end)
local aimT,aimV,aimH,aimL=nil,Vector3.zero,{},nil
local function pickAim()
    local ch=LP.Character; local r=getRoot(ch); local cam=WS.CurrentCamera
    if not r or not cam then return nil end
    local ctr=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)
    local best,bd=nil,C.aimFov
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LP then continue end
        if C.aimTarget=="Killer" and not isKiller(p) then continue end
        if C.aimTarget=="Survivor" and not isSurvivor(p) then continue end
        local pc=p.Character
        if pc then
            local pr=getRoot(pc); local ph=getHum(pc)
            if pr and ph and ph.Health>0 and not pc:GetAttribute("IsHooked") and not pc:GetAttribute("IsCarried") then
                local sp,on=cam:WorldToViewportPoint(pr.Position)
                if on then local d=(Vector2.new(sp.X,sp.Y)-ctr).Magnitude; if d<bd then bd=d; best=pr end end
            end
        end
    end
    return best
end
local function updateAim()
    if not C.silentAim then aimT=nil; aimV=Vector3.zero; aimH={}; aimL=nil; return end
    local t=pickAim()
    if not t then aimT=nil; return end
    if t~=aimL then aimH={}; aimV=Vector3.zero; aimL=t end
    local now=tick(); table.insert(aimH,{pos=t.Position,t=now})
    while #aimH>1 and aimH[1].t<now-0.4 do table.remove(aimH,1) end
    if #aimH>=2 then
        local a,b=aimH[#aimH-1],aimH[#aimH]; local dt=b.t-a.t
        if dt>0.001 then
            local v=(b.pos-a.pos)/dt; v=Vector3.new(v.X,0,v.Z)
            if v.Magnitude>65 then v=v.Unit*65 end
            aimV=aimV:Lerp(v,0.45)
        end
    end
    aimT=t
end
pcall(function()
    local orig
    orig=hookmetamethod(game,"__namecall",function(self,...)
        local m=getnamecallmethod()
        if m=="FireServer" and tofFire and rawequal(self,tofFire) and C.silentAim and aimT then
            local args=table.pack(...)
            local ch=LP.Character; local r=getRoot(ch)
            if r then
                local pred=aimT.Position
                if C.aimPrediction and aimV.Magnitude>1 then
                    local d=(aimT.Position-r.Position).Magnitude
                    local t1=d/200
                    local p1=aimT.Position+aimV*t1
                    local t2=(p1-r.Position).Magnitude/200
                    pred=aimT.Position+aimV*t2
                end
                local dir=pred-r.Position
                if dir.Magnitude>0.1 then
                    local ad=dir.Unit
                    if args.n>=3 and typeof(args[3])=="Vector3" then args[3]=ad
                    elseif args.n>=2 and typeof(args[2])=="Vector3" then args[2]=ad end
                end
            end
            return orig(self,table.unpack(args,1,args.n))
        end
        return orig(self,...)
    end)
end)

-- ═══════════ SILENT SPEAR ═══════════
local spearT,spearSp,spearG=nil,142.5,0.5
task.spawn(function()
    pcall(function()
        local rem=RS:WaitForChild("Remotes",15)
        spearT=rem:WaitForChild("Killers",10):WaitForChild("Veil",10):WaitForChild("Spearthrow",10)
        local vis=rem:FindFirstChild("Mechanics") and rem.Mechanics:FindFirstChild("visualize")
        if vis then
            vis.OnClientEvent:Connect(function(o,_,s,g)
                if o==LP.Character then
                    if type(s)=="number" and s>=15 and s<=800 then spearSp=s end
                    if type(g)=="number" and g>0.2 and g<=5 then spearG=g end
                end
            end)
        end
    end)
end)
local function solveSpear(s,e)
    local d=e-s; local flat=Vector3.new(d.X,0,d.Z); local dist=flat.Magnitude
    if dist<0.35 then return d.Unit,dist/spearSp end
    local unit=flat.Unit; local g=WS.Gravity*spearG; local sp=spearSp
    local best,bT,bD=math.huge,nil,nil
    for ang=-0.5,1.2,0.02 do
        local c=math.cos(ang)
        if c>0.015 then
            local t=dist/(sp*c)
            if t>0.025 and t<5 then
                local y=sp*math.sin(ang)*t-0.5*g*t*t
                local err=math.abs(y-d.Y)
                if err<best then
                    best=err; bT=t; local dir=unit*c+Vector3.new(0,math.sin(ang),0); bD=dir.Unit
                    if err<0.5 then return dir.Unit,t end
                end
            end
        end
    end
    return bD,bT
end
local spearTgt=nil
local function pickSpear()
    local ch=LP.Character; local r=getRoot(ch); local cam=WS.CurrentCamera
    if not r or not cam then return nil end
    local ctr=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)
    local best,bd=nil,C.spearFov
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LP or not isSurvivor(p) then continue end
        local pc=p.Character
        if pc then
            local pr=getRoot(pc); local ph=getHum(pc)
            if pr and ph and ph.Health>50 and not pc:GetAttribute("IsHooked") and not pc:GetAttribute("IsCarried") then
                local sp,on=cam:WorldToViewportPoint(pr.Position)
                if on then local d=(Vector2.new(sp.X,sp.Y)-ctr).Magnitude; if d<bd then bd=d; best=pr end end
            end
        end
    end
    return best
end
local function updateSpear()
    if not C.silentSpear then spearTgt=nil; return end
    spearTgt=pickSpear()
end
pcall(function()
    local orig
    orig=hookmetamethod(game,"__namecall",function(self,...)
        local m=getnamecallmethod()
        if m=="FireServer" and spearT and rawequal(self,spearT) and C.silentSpear and spearTgt then
            local args=table.pack(...); local cam=WS.CurrentCamera
            if cam and args.n>=2 and typeof(args[2])=="Vector3" then
                local tgt=spearTgt.Position
                if C.spearPrediction and spearTgt.Parent then
                    local pr=getRoot(spearTgt.Parent)
                    if pr then
                        local v=pr.AssemblyLinearVelocity; local flat=Vector3.new(v.X,0,v.Z)
                        if flat.Magnitude>1 then
                            local dist=(spearTgt.Position-cam.CFrame.Position).Magnitude
                            tgt=spearTgt.Position+flat*(dist/spearSp)
                        end
                    end
                end
                local dir=solveSpear(cam.CFrame.Position,tgt)
                if dir then args[2]=dir end
            end
            return orig(self,table.unpack(args,1,args.n))
        end
        return orig(self,...)
    end)
end)

-- ═══════════ AUTO PARRY ═══════════
local parryCD=0
local function processParry()
    if not C.autoParry then return end
    local now=tick(); if now<parryCD then return end
    local ch=LP.Character; local r=getRoot(ch)
    if not r or isBusy(ch) then return end
    local closest,cd=nil,C.parryRadius
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LP or not isKiller(p) then continue end
        local pc=p.Character; local pr=pc and getRoot(pc); local ph=pc and getHum(pc)
        if pr and ph and ph.Health>0 then
            local d=(pr.Position-r.Position).Magnitude; if d<cd then cd=d; closest=pc end
        end
    end
    if not closest then return end
    local sm=PG:FindFirstChild("Survivor-mob"); local ctrl=sm and sm:FindFirstChild("Controls")
    local act=ctrl and (ctrl:FindFirstChild("action") or ctrl:FindFirstChild("Gui-mob"))
    if act and firesignal then
        parryCD=now+0.3
        pcall(function()
            firesignal(act.MouseButton1Down)
            task.delay(0.05,function()
                if act and act.Parent then firesignal(act.MouseButton1Up); firesignal(act.MouseButton1Click) end
            end)
        end)
    end
end

-- ═══════════ RADIUS ═══════════
local radParts={}
local function buildRadius()
    for _,p in ipairs(radParts) do if p then p:Destroy() end end; radParts={}
    if not C.radiusESP then return end
    for i=1,48 do
        local part=Instance.new("Part"); part.Anchored=true; part.CanCollide=false
        part.CanQuery=false; part.CastShadow=false; part.Material=Enum.Material.Neon
        part.Color=Color3.fromRGB(255,220,60); part.Transparency=0.3
        part.Size=Vector3.new(0.15,0.15,0.15); part.Parent=WS
        radParts[i]=part
    end
end
RunService.RenderStepped:Connect(function()
    if not C.radiusESP then return end
    local ch=LP.Character; local r=getRoot(ch); if not r then return end
    if #radParts==0 then buildRadius() end
    local ang=2*math.pi/#radParts
    for i,part in ipairs(radParts) do
        if part and part.Parent then
            local a=ang*(i-1)
            part.CFrame=CFrame.new(r.Position+Vector3.new(math.cos(a)*C.parryRadius,-2.5,math.sin(a)*C.parryRadius))
        end
    end
end)

-- ═══════════ ANTI BLIND ═══════════
local abHooked=false
local function installAB()
    if abHooked or not hookmetamethod then return end
    pcall(function()
        local gb=RS:WaitForChild("Remotes",10):WaitForChild("Items",5):WaitForChild("Flashlight",5):WaitForChild("GotBlinded",5)
        if gb and gb:IsA("RemoteEvent") then
            local orig
            orig=hookmetamethod(game,"__namecall",function(self,...)
                if not checkcaller() and C.antiBlind and rawequal(self,gb) and getnamecallmethod()=="FireServer" then return end
                return orig(self,...)
            end)
            abHooked=true
        end
    end)
end
task.spawn(function() task.wait(3); installAB() end)
PG.DescendantAdded:Connect(function(o)
    if not C.antiBlind then return end
    if o.Name=="Blind" then
        if o:IsA("ScreenGui") then o.Enabled=false
        elseif o:IsA("GuiObject") then o.Visible=false; o.BackgroundTransparency=1 end
    end
end)

-- ═══════════ KILLER WARN ═══════════
local warnGui=nil
local function updateWarn()
    local ch=LP.Character; local r=getRoot(ch)
    if not r or not C.killerWarn then if warnGui then warnGui:Destroy(); warnGui=nil end; return end
    local near=math.huge
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LP or not isKiller(p) then continue end
        local pr=getRoot(p.Character); if pr then local d=(pr.Position-r.Position).Magnitude; if d<near then near=d end end
    end
    if near<=60 then
        local txt,col
        if near<=20 then txt="!!!"; col=Color3.fromRGB(255,0,0)
        elseif near<=40 then txt="!!"; col=Color3.fromRGB(255,80,0)
        else txt="!"; col=Color3.fromRGB(255,160,0) end
        if not warnGui or not warnGui.Parent then
            warnGui=Instance.new("BillboardGui"); warnGui.AlwaysOnTop=true
            warnGui.Size=UDim2.fromOffset(40,40); warnGui.StudsOffset=Vector3.new(0,3.5,0)
            local lbl=Instance.new("TextLabel"); lbl.Name="L"; lbl.Size=UDim2.fromScale(1,1)
            lbl.BackgroundTransparency=1; lbl.TextStrokeTransparency=0; lbl.TextStrokeColor3=Color3.new(0,0,0)
            lbl.TextSize=22; lbl.Font=Enum.Font.GothamBold; lbl.Parent=warnGui
        end
        warnGui.Adornee=r; warnGui.Parent=r
        local lbl=warnGui:FindFirstChild("L"); if lbl then lbl.Text=txt; lbl.TextColor3=col end
    elseif warnGui then warnGui:Destroy(); warnGui=nil end
end

-- ═══════════ VISUAL ═══════════
local savedLight={}
local function setFB(on)
    if on then
        if not savedLight.A then
            savedLight={A=LG.Ambient,OA=LG.OutdoorAmbient,B=LG.Brightness,CT=LG.ClockTime,GS=LG.GlobalShadows,FS=LG.FogStart,FE=LG.FogEnd,EC=LG.ExposureCompensation}
        end
        LG.Ambient=Color3.fromRGB(178,178,178); LG.OutdoorAmbient=Color3.fromRGB(178,178,178)
        LG.Brightness=3; LG.ClockTime=12; LG.GlobalShadows=false
        LG.FogStart=9e9; LG.FogEnd=9e9; LG.ExposureCompensation=0
    else
        local map={A="Ambient",OA="OutdoorAmbient",B="Brightness",CT="ClockTime",GS="GlobalShadows",FS="FogStart",FE="FogEnd",EC="ExposureCompensation"}
        for k,v in pairs(savedLight) do pcall(function() LG[map[k]]=v end) end
        savedLight={}
    end
end
local savedQ=nil
local function applyPotato(on)
    if on then
        if not savedQ then pcall(function() savedQ=settings().Rendering.QualityLevel end) end
        pcall(function() settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end)
        LG.GlobalShadows=false; LG.FogEnd=1000000
        for _,v in ipairs(LG:GetChildren()) do if v:IsA("PostEffect") then pcall(function() v.Enabled=false end) end end
        for _,v in ipairs(WS:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Beam") or v:IsA("Fire") then pcall(function() v.Enabled=false end)
            elseif v:IsA("Decal") or v:IsA("Texture") then pcall(function() v.Transparency=1 end) end
        end
    else
        pcall(function() if savedQ then settings().Rendering.QualityLevel=savedQ end end)
        LG.GlobalShadows=true; LG.FogEnd=100000
    end
end
local chGui
local function updateCh()
    if not C.crosshair then if chGui then chGui.Enabled=false end; return end
    if not chGui then
        chGui=Instance.new("ScreenGui"); chGui.Name="VD_Ch"; chGui.ResetOnSpawn=false
        chGui.IgnoreGuiInset=true; chGui.DisplayOrder=999; chGui.Parent=PG
        local dot=Instance.new("Frame"); dot.Size=UDim2.fromOffset(6,6)
        dot.AnchorPoint=Vector2.new(0.5,0.5); dot.Position=UDim2.fromScale(0.5,0.5)
        dot.BackgroundColor3=Color3.new(1,1,1); dot.BorderSizePixel=0; dot.Parent=chGui
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(1,0); c.Parent=dot
        local s=Instance.new("UIStroke"); s.Color=Color3.new(0,0,0); s.Thickness=1; s.Parent=dot
    end
    chGui.Enabled=true
end

-- ═══════════ MOONWALK ═══════════
local mwDir=0
local function setupMW()
    local ex=PG:FindFirstChild("VD_MW"); if ex then ex:Destroy() end
    local sg=Instance.new("ScreenGui"); sg.Name="VD_MW"; sg.ResetOnSpawn=false; sg.Parent=PG
    local f=Instance.new("Frame"); f.AnchorPoint=Vector2.new(1,1); f.Position=UDim2.new(1,-18,1,-170)
    f.Size=UDim2.fromOffset(46,96); f.BackgroundTransparency=1; f.Parent=sg
    local function mk(rot,y,dir)
        local b=Instance.new("ImageButton"); b.BackgroundTransparency=1; b.BorderSizePixel=0
        b.AnchorPoint=Vector2.new(0.5,0); b.Position=UDim2.new(0.5,0,0,y); b.Size=UDim2.fromOffset(42,42)
        b.Image="rbxassetid://125598796341580"; b.ImageColor3=Color3.fromRGB(170,170,170)
        b.ImageTransparency=0.25; b.Rotation=rot; b.Parent=f
        b.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
                mwDir=dir; b.ImageColor3=Color3.new(1,1,1); b.ImageTransparency=0
            end
        end)
        b.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
                mwDir=0; b.ImageColor3=Color3.fromRGB(170,170,170); b.ImageTransparency=0.25
            end
        end)
    end
    mk(-90,0,1); mk(90,50,-1)
end
local function updateMW()
    if not C.moonwalk then local h=getHum(LP.Character); if h then h.AutoRotate=true end; return end
    local ch=LP.Character; local r=getRoot(ch); local h=getHum(ch); local cam=WS.CurrentCamera
    if not r or not h or not cam then return end
    h.AutoRotate=false
    local dir=mwDir; if dir==0 then return end
    local look=cam.CFrame.LookVector; local flat=Vector3.new(look.X,0,look.Z)
    if flat.Magnitude>0.001 then
        flat=flat.Unit; local tgt=dir>0 and flat or -flat
        local al=r:FindFirstChild("VD_MWAlign")
        if not al then
            local at=Instance.new("Attachment"); at.Name="VD_MWAtt"; at.Parent=r
            al=Instance.new("AlignOrientation"); al.Name="VD_MWAlign"
            al.Mode=Enum.OrientationAlignmentMode.OneAttachment; al.Attachment0=at
            al.MaxTorque=6000000; al.Responsiveness=65; al.Parent=r
        end
        al.CFrame=CFrame.lookAt(Vector3.zero,tgt)
    end
end

-- ═══════════ HEAL / SPEED / GOD / NOCLIP ═══════════
local healR
task.spawn(function()
    pcall(function() healR=RS:WaitForChild("Remotes",10):WaitForChild("Healing",10):WaitForChild("HealEvent",10) end)
end)
local healingOn=false
local function processHeal()
    if not C.selfHeal then
        if healingOn and healR then local r=getRoot(LP.Character); if r then pcall(function() healR:FireServer(r,false) end) end; healingOn=false end
        return
    end
    if not healR then return end
    local ch=LP.Character; local r=getRoot(ch); if not r or isBusy(ch) then return end
    local prog=ch:GetAttribute("HealProgress")
    if not prog or prog<95 then
        if not healingOn then pcall(function() healR:FireServer(r,true) end); healingOn=true end
    else if healingOn then pcall(function() healR:FireServer(r,false) end); healingOn=false end end
end
local savedHP=nil
local function processSpeed()
    local ch=LP.Character; local h=getHum(ch); if not h then return end
    if C.speedV2 then
        local cur=ch:GetAttribute("speedboost") or 1
        if math.abs(cur-C.speedV2Mult)>0.01 then pcall(function() ch:SetAttribute("speedboost",C.speedV2Mult) end) end
        return
    end
    local base=17; local tgt=C.speedBoost and (base*(1+C.speedMult)) or base
    if math.abs(h.WalkSpeed-tgt)>0.1 then pcall(function() h.WalkSpeed=tgt end) end
end
local function processGod()
    local h=getHum(LP.Character); if not h then return end
    if not C.godMode then pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Dead,true); h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true) end); return end
    if savedHP and h.Health<savedHP and h.Health>0 then pcall(function() h.Health=h.MaxHealth end) end
    savedHP=h.Health
    pcall(function()
        h:SetStateEnabled(Enum.HumanoidStateType.Dead,false); h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        if h:GetState()==Enum.HumanoidStateType.Dead then h.Health=h.MaxHealth; h:ChangeState(Enum.HumanoidStateType.Running) end
    end)
end
local function processNoclip()
    local ch=LP.Character; if not ch then return end
    if C.noclip then for _,p in ipairs(ch:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then p.CanCollide=false end end end
end
local noSlowConn=nil
local function applyNoSlow()
    if noSlowConn then noSlowConn:Disconnect(); noSlowConn=nil end
    if not C.noSlowdown then return end
    if isKiller(LP) then return end
    local ch=LP.Character; local h=ch and getHum(ch); if not h then return end
    noSlowConn=h:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if not C.noSlowdown or isKiller(LP) then return end
        local h2=getHum(LP.Character); if not h2 then return end
        local tgt=C.speedBoost and (17*(1+C.speedMult)) or 17
        if h2.WalkSpeed<tgt-0.05 then pcall(function() h2.WalkSpeed=tgt end) end
    end)
end

-- ═══════════ AUTO GEN ═══════════
local lastGR,prevLR,lastF=nil,nil,0
local function getSkill()
    for _,n in ipairs({"SkillCheckPromptGui","SkillCheckPromptGui-con"}) do
        local g=PG:FindFirstChild(n,true)
        if g then
            local c=g:FindFirstChild("Check",true)
            if c and c.Visible then return c:FindFirstChild("Line",true),c:FindFirstChild("Goal",true) end
        end
    end
end
local function fireSkill()
    local sm=PG:FindFirstChild("Survivor-mob",true); local ctrl=sm and sm:FindFirstChild("Controls",true)
    local a=ctrl and (ctrl:FindFirstChild("action") or ctrl:FindFirstChild("Gui-mob"))
    if a and firesignal then
        pcall(function()
            firesignal(a.MouseButton1Down)
            task.delay(0.05,function() if a and a.Parent then firesignal(a.MouseButton1Up) end end)
        end)
    end
end
local function processAutoGen()
    if not C.autoGen then return end
    local line,goal=getSkill()
    if not (line and goal) then lastGR=nil; prevLR=nil; return end
    local now=tick(); if now-lastF<0.1 then return end
    local gr,lr=goal.Rotation,line.Rotation
    if C.autoGenMode=="Instant" then
        if gr~=lastGR then line.Rotation=gr+109; lastGR=gr; lastF=now; fireSkill() end
        return
    end
    local diff=(lr-gr)%360; local zs,ze
    if C.autoGenMode=="Perfect" then zs,ze=102,116
    elseif C.autoGenMode=="Normal" then zs,ze=116,159
    elseif C.autoGenMode=="Random" then zs,ze=102,116
    else return end
    local inZ=diff>=zs and diff<=ze
    local inC=prevLR and ((prevLR-gr)%360)<zs and diff>ze
    if inZ or inC then
        if inC then line.Rotation=gr+(zs+ze)/2 end
        lastF=now; lastGR=gr; fireSkill()
    end
    prevLR=lr
end

-- ═══════════ GEN BOOST ═══════════
local function genBoost()
    local ch=LP.Character; local r=getRoot(ch); if not r then return end
    local ci=ch:FindFirstChild("CheckInterractable")
    if not (ci and ci:GetAttribute("isRepairing")) then return end
    local near,bd=nil,math.huge
    for _,obj in ipairs(WS:GetDescendants()) do
        if obj.Name:match("^GeneratorPoint%d+$") then
            local pos=obj:IsA("BasePart") and obj.Position
            if not pos then local p=obj:FindFirstChildWhichIsA("BasePart",true); if p then pos=p.Position end end
            if pos then local d=(pos-r.Position).Magnitude; if d<bd then bd=d; near=obj end end
        end
    end
    if not near then return end
    local rep=RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("Generator") and RS.Remotes.Generator:FindFirstChild("RepairEvent")
    if not rep then return end
    task.spawn(function()
        rep:FireServer(near,true); task.wait(0.4); rep:FireServer(near,false)
        local p=near:IsA("BasePart") and near or near:FindFirstChildWhichIsA("BasePart",true)
        if p then pcall(function() r.CFrame=CFrame.new(p.Position+Vector3.new(0,3,0)) end) end
    end)
end

-- ═══════════ AIMLOCK ═══════════
local aimLockConn=nil
local function startAimLock()
    if aimLockConn then aimLockConn:Disconnect() end
    aimLockConn=RunService.RenderStepped:Connect(function()
        if not C.aimLock then return end
        local ch=LP.Character; local r=getRoot(ch); local cam=WS.CurrentCamera
        if not r or not cam then return end
        local best,bd=nil,math.huge
        for _,p in ipairs(Players:GetPlayers()) do
            if p==LP then continue end
            if C.aimLockTarget=="Killer" and not isKiller(p) then continue end
            if C.aimLockTarget=="Survivor" and not isSurvivor(p) then continue end
            local pc=p.Character
            if pc then
                local pr=getRoot(pc); local ph=getHum(pc)
                if pr and ph and ph.Health>50 and not pc:GetAttribute("IsHooked") then
                    local d=(pr.Position-r.Position).Magnitude
                    if d<bd and d<=C.aimLockDist then bd=d; best=pc end
                end
            end
        end
        if best then
            local tgt= C.aimLockPart=="Head" and best:FindFirstChild("Head") and best.Head.Position or getRoot(best).Position
            local pos=cam.CFrame.Position; local look=cam.CFrame.LookVector
            local nl=look:Lerp((tgt-pos).Unit,C.aimLockSmooth)
            if nl.Magnitude>0.001 then cam.CFrame=CFrame.new(pos,pos+nl.Unit) end
        end
    end)
end

-- ═══════════ M2 AIMLOCK ═══════════
local m2U=0
local m2Hooked=false
local function installM2()
    if m2Hooked then return end
    pcall(function()
        local prep=RS:WaitForChild("Remotes",10):WaitForChild("Killers",5):WaitForChild("Hidden",5):WaitForChild("preparem2",5)
        if prep then
            local conn=prep:IsA("BindableEvent") and prep.Event or prep.OnClientEvent
            if conn then conn:Connect(function() if C.aimlockM2 and isKiller(LP) then m2U=tick()+1.5 end end); m2Hooked=true end
        end
    end)
end
task.spawn(function() task.wait(4); installM2() end)
local function processM2()
    if not C.aimlockM2 or tick()>m2U or not isKiller(LP) then return end
    local ch=LP.Character; local r=getRoot(ch); local cam=WS.CurrentCamera
    if not r or not cam then return end
    local best,bd=nil,50
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LP or not isSurvivor(p) then continue end
        local pc=p.Character; local pr=pc and getRoot(pc)
        if pr and not isBusy(pc) then local d=(pr.Position-r.Position).Magnitude; if d<bd then bd=d; best=pr end end
    end
    if best then
        local pos=cam.CFrame.Position; local look=cam.CFrame.LookVector
        local nl=look:Lerp((best.Position-pos).Unit,C.aimlockM2Smooth)
        if nl.Magnitude>0.001 then cam.CFrame=CFrame.new(pos,pos+nl.Unit) end
    end
end

-- ═══════════ CAMERA VEIL ═══════════
local function processCV()
    if not C.cameraVeil then return end
    local ch=LP.Character; if not ch or not ch:GetAttribute("spearmode") then return end
    local cam=WS.CurrentCamera; local r=getRoot(ch); if not cam or not r then return end
    local best,bd=nil,C.aimFov
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LP or not isSurvivor(p) then continue end
        local pc=p.Character; local pr=pc and getRoot(pc); local ph=pc and getHum(pc)
        if pr and ph and ph.Health>50 and not isBusy(pc) then
            local sp,on=cam:WorldToViewportPoint(pr.Position)
            if on then
                local d=(Vector2.new(sp.X,sp.Y)-Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)).Magnitude
                if d<bd then bd=d; best=pr end
            end
        end
    end
    if best then
        local pred=best.Position
        if C.spearPrediction then
            local v=best.AssemblyLinearVelocity; local flat=Vector3.new(v.X,0,v.Z)
            if flat.Magnitude>1 then
                local dist=(best.Position-cam.CFrame.Position).Magnitude
                pred=best.Position+flat*(dist/spearSp)
            end
        end
        local dir=solveSpear(cam.CFrame.Position,pred)
        if dir then local pos=cam.CFrame.Position; cam.CFrame=CFrame.new(pos,pos+dir) end
    end
end

-- ═══════════ AUTO DROP PALLET / FAST VAULT ═══════════
local function autoDrop()
    if not C.autoDropPallet then return end
    local ch=LP.Character; local r=getRoot(ch); if not r then return end
    local rep=RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("Pallet") and RS.Remotes.Pallet:FindFirstChild("PalletDropEvent")
    if not rep then return end
    local best,bd=nil,4
    for _,obj in ipairs(WS:GetDescendants()) do
        if obj.Name:match("^PalletPoint") or obj.Name=="palletDropPoint" or obj.Name=="PalletPointSlide" then
            local pos=obj:IsA("BasePart") and obj.Position
            if pos then local d=(pos-r.Position).Magnitude; if d<bd then bd=d; best=obj end end
        end
    end
    if best then pcall(function() rep:FireServer(best) end) end
end
local fvHooked=false
local function installFV()
    if fvHooked then return end
    pcall(function()
        local mods=RS:FindFirstChild("Modules",true); local sa=mods and mods:FindFirstChild("SurvivorActions",true)
        if sa then
            local okk,mod=pcall(require,sa)
            if okk and mod and mod.startVault then
                local orig=mod.startVault
                mod.startVault=newcclosure(function(ctrl,vp)
                    if C.fastVault then
                        pcall(function()
                            local ch=ctrl and ctrl.character
                            if ch then
                                ch:SetAttribute("Sprinting",true); ch:SetAttribute("IsRunning",true)
                                local r=getRoot(ch)
                                if r and vp then
                                    local vpp=vp.Position or (vp.PrimaryPart and vp.PrimaryPart.Position)
                                    if vpp then local d=vpp-r.Position; d=Vector3.new(d.X,0,d.Z); if d.Magnitude>0.05 then r.AssemblyLinearVelocity=d.Unit*22 end end
                                end
                            end
                        end)
                    end
                    return orig(ctrl,vp)
                end)
                fvHooked=true
            end
        end
    end)
end
task.spawn(function() task.wait(5); installFV() end)
local function toggleLoop(on)
    pcall(function()
        local rem=RS:FindFirstChild("Remotes"); local win=rem and rem:FindFirstChild("Window"); if not win then return end
        local v=win:FindFirstChild("VaultEvent"); local c=win:FindFirstChild("VaultCompleteEvent")
        if not v or not c then return end
        task.spawn(function()
            for _,obj in ipairs(WS:GetDescendants()) do
                if obj.Name=="Window" or obj.Name=="VaultPoint" then
                    if on then pcall(function() v:FireServer(obj,true) end) else pcall(function() c:FireServer(obj,false) end) end
                    task.wait(0.05)
                end
            end
        end)
    end)
end

-- ═══════════ FAKE PERKS / FLOWSTATE ═══════════
local fpB={}
local fpL=0
local function applyFP()
    if isKiller(LP) then return end
    local ch=LP.Character; if not ch then return end
    local now=tick(); local tot=0
    for _,v in pairs(fpB) do if now<v.e then tot=tot+v.a end end
    pcall(function() ch:SetAttribute("speedboost",tot>0 and 1+tot/14 or 1) end)
end
local function tryBuff(n,a,d)
    if isKiller(LP) or fpB[n] then return end
    if tick()-fpL<10 and next(fpB)==nil then return end
    fpB[n]={a=a,e=tick()+d}; applyFP()
end
task.spawn(function()
    pcall(function()
        local v=RS:WaitForChild("Remotes",10):WaitForChild("Window",5):WaitForChild("Vaultbindable",5)
        if v and v:IsA("BindableEvent") then v.Event:Connect(function(_,s) if C.fakeQuickRecovery and s then tryBuff("QR",5.6,3) end end) end
    end)
end)
local function processFP()
    local now=tick(); local cl=false
    for k,v in pairs(fpB) do if now>=v.e then fpB[k]=nil; cl=true end end
    if cl and next(fpB)==nil then fpL=now end
    applyFP()
end
local function processFlow()
    if not C.flowstate or isKiller(LP) then return end
    local ch=LP.Character; if not ch then return end
    local t={LP,ch}
    for _,nm in ipairs({"climb_obsessing","climb_collisoning","climb_collisioning","climb_colliding"}) do
        local r=WS:FindFirstChild(nm); if r then local m=r:FindFirstChild(LP.Name); if m then table.insert(t,m) end end
    end
    for _,tg in ipairs(t) do pcall(function() tg:SetAttribute("Flowstate",true) end) end
end

-- ═══════════ FIX #3: MISSING FEATURE LOGIC ═══════════

-- Infinite Lunge
local lungeConn = nil
local function installInfiniteLunge()
    if lungeConn then lungeConn:Disconnect(); lungeConn=nil end
    if not C.infiniteLunge then return end
    local function apply(ch)
        if ch then pcall(function() ch:SetAttribute("lungeboost", 999999) end) end
    end
    apply(LP.Character)
    pcall(function()
        local ld = RS.Remotes.Attacks:FindFirstChild("LungeDetect")
        if ld and getconnections then
            for _,c in ipairs(getconnections(ld.OnClientEvent)) do
                pcall(function() c:Disable() end)
            end
        end
    end)
    lungeConn = LP.CharacterAdded:Connect(function(ch)
        task.wait(0.5); if C.infiniteLunge then apply(ch) end
    end)
end

-- Shoot While Downed
UIS.InputBegan:Connect(function(i,gp)
    if gp or not C.shootWhileDowned then return end
    if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    local ch = LP.Character
    if not ch then return end
    local hum = getHum(ch)
    local downed = ch:GetAttribute("IsHooked") or ch:GetAttribute("IsCarried") or LP:GetAttribute("IsDead") or (hum and hum.Health < hum.MaxHealth*0.5)
    if not downed then return end
    local cam = WS.CurrentCamera
    local item = ch:FindFirstChild("Twist of Fate")
    if tofFire and cam and item then
        pcall(function() tofFire:FireServer(item, cam.CFrame.LookVector) end)
    end
end)

-- Perfect Landing
local plConn = nil
local function hookPerfectLanding()
    if plConn then plConn:Disconnect(); plConn=nil end
    if not C.fakePerfectLanding then return end
    local ch = LP.Character
    local h = ch and getHum(ch)
    if not h then return end
    local wasFalling, fallStart, fallY = false, 0, 0
    plConn = h.StateChanged:Connect(function(_, new)
        if not C.fakePerfectLanding then return end
        local root = getRoot(LP.Character)
        if new == Enum.HumanoidStateType.Freefall then
            wasFalling = true; fallStart = tick(); fallY = root and root.Position.Y or 0
        elseif wasFalling and (new == Enum.HumanoidStateType.Landed or new == Enum.HumanoidStateType.Running) then
            wasFalling = false
            if tick() - fallStart < 0.25 then return end
            if root and (fallY - root.Position.Y) < 3 then return end
            tryBuff("PerfectLanding", 5.6, 3)
        end
    end)
end

-- Adrenaline Rush
local adrConn = nil
local function hookAdrenaline()
    if adrConn then adrConn:Disconnect(); adrConn=nil end
    if not C.fakeAdrenalineRush then return end
    local ch = LP.Character
    local h = ch and getHum(ch)
    if not h then return end
    local last = h.Health
    adrConn = h.HealthChanged:Connect(function(nh)
        if C.fakeAdrenalineRush and nh < last and nh <= 50 and nh > 0 then
            tryBuff("AdrenalineRush", 4, 5)
        end
        last = nh
    end)
end

-- re-arm on character respawn
LP.CharacterAdded:Connect(function()
    task.wait(1)
    if C.infiniteLunge then installInfiniteLunge() end
    if C.fakePerfectLanding then hookPerfectLanding() end
    if C.fakeAdrenalineRush then hookAdrenaline() end
end)

-- ═══════════ AUTO CROUCH ═══════════
local ABY="80411309607666"
local crouched=false
local slashers={}
task.spawn(function()
    task.wait(2)
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local h=getHum(p.Character)
            if h then
                h.AnimationPlayed:Connect(function(t)
                    if t.Animation and t.Animation.AnimationId:find(ABY) then
                        slashers[p.Character]=true
                        t.Stopped:Connect(function() task.wait(0.2); slashers[p.Character]=nil end)
                    end
                end)
            end
        end
    end
end)
local function setCrouch(on)
    if crouched==on then return end
    crouched=on
    local ch=LP.Character
    if ch then pcall(function() ch:SetAttribute("Crouchingserver",on); ch:SetAttribute("Crouching",on) end) end
    pcall(function()
        RS.Remotes.Mechanics.ChangeAttribute:FireServer("Crouchingserver",on)
        RS.Remotes.Mechanics.ChangeAttribute:FireServer("Crouching",on)
    end)
end
local function processCrouch()
    if not C.autoCrouch then if crouched then setCrouch(false) end; return end
    local ch=LP.Character; local r=getRoot(ch); if not r then return end
    local should=false
    for k in pairs(slashers) do
        if k and k.Parent then
            local kr=getRoot(k); local kh=getHum(k)
            if kr and kh and kh.Health>0 then
                if (kr.Position-r.Position).Magnitude<=C.autoCrouchRadius then should=true; break end
            else slashers[k]=nil end
        else slashers[k]=nil end
    end
    setCrouch(should)
end

-- ═══════════ MISC ═══════════
local afkConn=nil
local function toggleAFK(on)
    if afkConn then afkConn:Disconnect(); afkConn=nil end
    if not on then return end
    afkConn=LP.Idled:Connect(function() VU:CaptureController(); VU:ClickButton2(Vector2.new()) end)
end
local savedCur=nil
local function toggleCur(on)
    if on then
        if not savedCur then savedCur={i=UIS.MouseIconEnabled,b=UIS.MouseBehavior} end
        UIS.MouseIconEnabled=true; UIS.MouseBehavior=Enum.MouseBehavior.Default
    elseif savedCur then
        UIS.MouseIconEnabled=savedCur.i; UIS.MouseBehavior=savedCur.b; savedCur=nil
    end
end
local function skipCut(dark)
    pcall(function()
        local rem=RS:FindFirstChild("Remotes"); if not rem then return end
        local function dis(r)
            if r and r:IsA("RemoteEvent") and getconnections then
                for _,c in ipairs(getconnections(r.OnClientEvent)) do pcall(function() c:Disable(); c:Disconnect() end) end
            end
        end
        local g=rem:FindFirstChild("Game")
        if g then for _,n in ipairs({"cutscene","cutsceneEnd","cutsceneEnd2","endscreencutscene","cutsceneEndwithownchar","shake"}) do dis(g:FindFirstChild(n)) end end
        local k=rem:FindFirstChild("Killers"); if k then dis(k:FindFirstChild("Startmori")) end
        if dark then dis(rem:FindFirstChild("Darkness2")) end
    end)
    local cam=WS.CurrentCamera
    if cam and cam.CameraType==Enum.CameraType.Scriptable then cam.CameraType=Enum.CameraType.Custom end
    local map=WS:FindFirstChild("Map")
    if map then local es=map:FindFirstChild("endscreen"); if es then pcall(function() es.Parent=nil end) end end
    pcall(function() local bg=WS:FindFirstChild("BackgroundSounds"); if bg then bg:Destroy() end end)
end

-- ═══════════ PERF/PRED ═══════════
local perfG,perfL,fpsC,fpsT=nil,nil,0,0
local function updatePerf(dt)
    if not C.perfMonitor then if perfG then perfG.Enabled=false end; return end
    if not perfG then
        perfG=Instance.new("ScreenGui"); perfG.Name="VD_Perf"; perfG.ResetOnSpawn=false
        perfG.DisplayOrder=50; perfG.Parent=PG
        local f=Instance.new("Frame"); f.Size=UDim2.fromOffset(160,28); f.AnchorPoint=Vector2.new(1,0)
        f.Position=UDim2.new(1,-10,0,10); f.BackgroundColor3=Color3.fromRGB(15,15,20)
        f.BorderSizePixel=0; f.Parent=perfG
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,8); c.Parent=f
        local s=Instance.new("UIStroke"); s.Color=Color3.fromRGB(55,55,70); s.Thickness=1; s.Parent=f
        perfL=Instance.new("TextLabel"); perfL.Size=UDim2.fromScale(1,1); perfL.BackgroundTransparency=1
        perfL.TextColor3=Color3.fromRGB(200,200,215); perfL.TextSize=12
        perfL.Font=Enum.Font.GothamBold; perfL.RichText=true; perfL.Parent=f
    end
    perfG.Enabled=true; fpsC=fpsC+1; fpsT=fpsT+dt
    if fpsT>=0.5 then
        local fps=math.floor(fpsC/fpsT)
        local p=math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        local fc=fps>=50 and "rgb(80,220,100)" or fps>=30 and "rgb(255,200,60)" or "rgb(255,70,70)"
        local pc=p<=80 and "rgb(80,220,100)" or p<=150 and "rgb(255,200,60)" or "rgb(255,70,70)"
        perfL.Text=string.format('<font color="%s">FPS %d</font> <font color="rgb(60,60,75)">|</font> <font color="%s">PING %d</font>',fc,fps,pc,p)
        fpsC,fpsT=0,0
    end
end
local predG,predL
local function updatePred()
    if not C.predictionMonitor then if predG then predG.Enabled=false end; return end
    if not predG then
        predG=Instance.new("ScreenGui"); predG.Name="VD_Pred"; predG.ResetOnSpawn=false
        predG.DisplayOrder=51; predG.IgnoreGuiInset=true; predG.Parent=PG
        predL=Instance.new("TextLabel"); predL.AnchorPoint=Vector2.new(0.5,0)
        predL.Position=UDim2.new(0.5,0,0,50); predL.BackgroundTransparency=1
        predL.AutomaticSize=Enum.AutomaticSize.XY; predL.TextColor3=Color3.fromRGB(252,235,229)
        predL.TextSize=14; predL.Font=Enum.Font.GothamBold; predL.RichText=true; predL.Parent=predG
    end
    predG.Enabled=true
    local ps=Players:GetPlayers()
    table.sort(ps,function(a,b) return (a:GetAttribute("KillerChance") or 0)>(b:GetAttribute("KillerChance") or 0) end)
    local top=ps[1]; local kn="—"
    if top then
        kn=top==LP and "YOU" or top.Name
        local sk=top:GetAttribute("SelectedKiller"); if sk then kn=kn.." ("..sk..")" end
    end
    predL.Text=string.format('<font color="rgb(255,210,60)">Killer:</font> <font color="rgb(252,235,229)">%s</font>',kn)
end

-- ═══════════ STRETCH/ZOOM ═══════════
local function applyStretch(on)
    pcall(function()
        RunService:UnbindFromRenderStep("VD_Stretch")
        if on then
            RunService:BindToRenderStep("VD_Stretch",Enum.RenderPriority.Camera.Value+2,function()
                if not C.stretchedRes then return end
                local cam=WS.CurrentCamera; if not cam then return end
                local vs=cam.ViewportSize; if vs.Y<1 then return end
                local curr=vs.X/vs.Y; local tgt=C.stretchRatio
                if math.abs(curr-tgt)<0.03 then return end
                local m,n=1,1
                if tgt<curr then n=tgt/curr else m=curr/tgt end
                local cf=cam.CFrame
                cam.CFrame=CFrame.fromMatrix(cf.Position,cf.RightVector.Unit,cf.UpVector.Unit)*CFrame.new(0,0,0,m,0,0,0,n,0,0,0,1)
            end)
        end
    end)
end
local savedZoom=nil
local function toggleZoom(on)
    if on then if not savedZoom then savedZoom=LP.CameraMaxZoomDistance end; LP.CameraMaxZoomDistance=1000
    elseif savedZoom then LP.CameraMaxZoomDistance=savedZoom; savedZoom=nil end
end

print("[N]yx: gameplay modules ok")

-- ═══════════════════════════════════════════════════════
-- UI + FIX #4/#5: UI REGISTRY
-- ═══════════════════════════════════════════════════════
local COL={
    bgDark=Color3.fromRGB(12,12,16), bgSurface=Color3.fromRGB(20,20,28),
    bgElevated=Color3.fromRGB(28,28,38), bgHover=Color3.fromRGB(36,36,48),
    accent=Color3.fromRGB(139,92,246), accentDim=Color3.fromRGB(90,60,160),
    accentLight=Color3.fromRGB(180,140,255), text=Color3.fromRGB(232,232,240),
    textDim=Color3.fromRGB(140,140,158), success=Color3.fromRGB(74,222,128),
    danger=Color3.fromRGB(248,113,113), warning=Color3.fromRGB(251,191,36),
    border=Color3.fromRGB(48,48,62),
}

-- FIX #4: Registry for UI sync
local uiRegistry = {}
local function registerUI(key, updater)
    uiRegistry[key] = uiRegistry[key] or {}
    table.insert(uiRegistry[key], updater)
end
local function refreshUIKey(key)
    local list = uiRegistry[key]
    if not list then return end
    for _,upd in ipairs(list) do pcall(upd) end
end
local function refreshAllUI()
    for key in pairs(uiRegistry) do refreshUIKey(key) end
end

local sg=Instance.new("ScreenGui")
sg.Name="VD_Nyx"; sg.ResetOnSpawn=false; sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
sg.IgnoreGuiInset=true; sg.DisplayOrder=100; sg.Parent=PG

local main=Instance.new("Frame")
main.Name="Main"; main.Size=UDim2.fromOffset(680,520)
main.Position=UDim2.new(0.5,-340,0.5,-260)
main.BackgroundColor3=COL.bgDark; main.BorderSizePixel=0
main.Active=true; main.ClipsDescendants=true; main.Parent=sg
local mCn=Instance.new("UICorner"); mCn.CornerRadius=UDim.new(0,12); mCn.Parent=main
local mSt=Instance.new("UIStroke"); mSt.Color=COL.border; mSt.Thickness=1; mSt.Parent=main
local grad=Instance.new("UIGradient")
grad.Color=ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(16,16,22)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(10,10,14)),
})
grad.Rotation=90; grad.Parent=main

local topBar=Instance.new("Frame")
topBar.Size=UDim2.new(1,0,0,40); topBar.BackgroundColor3=COL.bgSurface
topBar.BorderSizePixel=0; topBar.Parent=main
local tbC=Instance.new("UICorner"); tbC.CornerRadius=UDim.new(0,12); tbC.Parent=topBar
local tbFix=Instance.new("Frame"); tbFix.Size=UDim2.new(1,0,0,12)
tbFix.Position=UDim2.new(0,0,1,-12); tbFix.BackgroundColor3=COL.bgSurface
tbFix.BorderSizePixel=0; tbFix.Parent=topBar
local dotF=Instance.new("Frame")
dotF.Size=UDim2.fromOffset(10,10); dotF.Position=UDim2.new(0,16,0.5,-5)
dotF.BackgroundColor3=COL.accent; dotF.BorderSizePixel=0; dotF.Parent=topBar
local dc=Instance.new("UICorner"); dc.CornerRadius=UDim.new(1,0); dc.Parent=dotF
local tLbl=Instance.new("TextLabel")
tLbl.Size=UDim2.new(1,-200,1,0); tLbl.Position=UDim2.new(0,34,0,0)
tLbl.BackgroundTransparency=1; tLbl.Text="Violence District"
tLbl.TextColor3=COL.text; tLbl.TextSize=13; tLbl.Font=Enum.Font.GothamBold
tLbl.TextXAlignment=Enum.TextXAlignment.Left; tLbl.Parent=topBar
local verLbl=Instance.new("TextLabel")
verLbl.Size=UDim2.fromOffset(60,20); verLbl.Position=UDim2.new(0,155,0.5,-10)
verLbl.BackgroundTransparency=1; verLbl.Text="v3.2"
verLbl.TextColor3=COL.textDim; verLbl.TextSize=10; verLbl.Font=Enum.Font.Gotham
verLbl.TextXAlignment=Enum.TextXAlignment.Left; verLbl.Parent=topBar

local function topBtn(icon,posX,col)
    local b=Instance.new("TextButton")
    b.Size=UDim2.fromOffset(26,26); b.Position=UDim2.new(1,posX,0.5,-13)
    b.BackgroundColor3=COL.bgElevated; b.BorderSizePixel=0; b.Text=icon
    b.TextColor3=col; b.TextSize=14; b.Font=Enum.Font.GothamBold
    b.AutoButtonColor=false; b.Parent=topBar
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,6); c.Parent=b
    b.MouseEnter:Connect(function() TW:Create(b,TweenInfo.new(0.15),{BackgroundColor3=COL.bgHover}):Play() end)
    b.MouseLeave:Connect(function() TW:Create(b,TweenInfo.new(0.15),{BackgroundColor3=COL.bgElevated}):Play() end)
    return b
end
local closeBtn=topBtn("✕",-34,COL.danger)
local minBtn=topBtn("—",-68,COL.textDim)
closeBtn.MouseButton1Click:Connect(function() sg.Enabled=false end)

local drag=false; local dS,dP
topBar.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        drag=true; dS=i.Position; dP=main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-dS
        main.Position=UDim2.new(dP.X.Scale,dP.X.Offset+d.X,dP.Y.Scale,dP.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
end)

local sideW=150
local sidebar=Instance.new("Frame")
sidebar.Name="Sidebar"; sidebar.Size=UDim2.new(0,sideW,1,-80)
sidebar.Position=UDim2.new(0,0,0,40); sidebar.BackgroundColor3=COL.bgSurface
sidebar.BorderSizePixel=0; sidebar.Parent=main
local sidePad=Instance.new("UIPadding")
sidePad.PaddingTop=UDim.new(0,8); sidePad.PaddingBottom=UDim.new(0,8)
sidePad.PaddingLeft=UDim.new(0,8); sidePad.PaddingRight=UDim.new(0,8); sidePad.Parent=sidebar
local sideLay=Instance.new("UIListLayout")
sideLay.Padding=UDim.new(0,4); sideLay.Parent=sidebar
local sideHeader=Instance.new("TextLabel")
sideHeader.Size=UDim2.new(1,0,0,20); sideHeader.BackgroundTransparency=1
sideHeader.Text="CATEGORIES"; sideHeader.TextColor3=COL.textDim
sideHeader.TextSize=9; sideHeader.Font=Enum.Font.GothamBold
sideHeader.TextXAlignment=Enum.TextXAlignment.Left; sideHeader.Parent=sidebar
local shPad=Instance.new("UIPadding"); shPad.PaddingLeft=UDim.new(0,6); shPad.Parent=sideHeader

local content=Instance.new("Frame")
content.Name="Content"; content.Size=UDim2.new(1,-sideW-1,1,-80)
content.Position=UDim2.new(0,sideW+1,0,40)
content.BackgroundColor3=COL.bgDark; content.BorderSizePixel=0
content.ClipsDescendants=true; content.Parent=main

local searchBar=Instance.new("Frame")
searchBar.Size=UDim2.new(1,-20,0,32); searchBar.Position=UDim2.fromOffset(10,10)
searchBar.BackgroundColor3=COL.bgSurface; searchBar.BorderSizePixel=0
searchBar.Parent=content
local sbC=Instance.new("UICorner"); sbC.CornerRadius=UDim.new(0,6); sbC.Parent=searchBar
local sbSt=Instance.new("UIStroke"); sbSt.Color=COL.border; sbSt.Thickness=1; sbSt.Parent=searchBar
local searchIcon=Instance.new("TextLabel")
searchIcon.Size=UDim2.fromOffset(20,32); searchIcon.Position=UDim2.fromOffset(8,0)
searchIcon.BackgroundTransparency=1; searchIcon.Text="⌕"; searchIcon.TextColor3=COL.textDim
searchIcon.TextSize=16; searchIcon.Font=Enum.Font.GothamBold; searchIcon.Parent=searchBar
local searchInput=Instance.new("TextBox")
searchInput.Size=UDim2.new(1,-40,1,0); searchInput.Position=UDim2.fromOffset(30,0)
searchInput.BackgroundTransparency=1; searchInput.Text=""
searchInput.PlaceholderText="Search features..." searchInput.PlaceholderColor3=COL.textDim
searchInput.TextColor3=COL.text; searchInput.TextSize=12; searchInput.Font=Enum.Font.Gotham
searchInput.TextXAlignment=Enum.TextXAlignment.Left; searchInput.ClearTextOnFocus=false
searchInput.Parent=searchBar

local pageHolder=Instance.new("Frame")
pageHolder.Size=UDim2.new(1,-20,1,-54); pageHolder.Position=UDim2.fromOffset(10,50)
pageHolder.BackgroundTransparency=1; pageHolder.ClipsDescendants=true; pageHolder.Parent=content

local botBar=Instance.new("Frame")
botBar.Name="BottomBar"; botBar.Size=UDim2.new(0,sideW,0,40)
botBar.Position=UDim2.new(0,0,1,-40); botBar.BackgroundColor3=COL.bgSurface
botBar.BorderSizePixel=0; botBar.Parent=main
local bbPad=Instance.new("UIPadding")
bbPad.PaddingLeft=UDim.new(0,8); bbPad.PaddingRight=UDim.new(0,8)
bbPad.PaddingTop=UDim.new(0,8); bbPad.PaddingBottom=UDim.new(0,8); bbPad.Parent=botBar
local bbLay=Instance.new("UIListLayout")
bbLay.FillDirection=Enum.FillDirection.Horizontal; bbLay.Padding=UDim.new(0,4); bbLay.Parent=botBar

local notifFrame=nil
local function notify(text,color)
    if notifFrame and notifFrame.Parent then notifFrame:Destroy() end
    notifFrame=Instance.new("Frame")
    notifFrame.Size=UDim2.fromOffset(260,36)
    notifFrame.Position=UDim2.new(0.5,-130,0,60)
    notifFrame.BackgroundColor3=COL.bgElevated
    notifFrame.BorderSizePixel=0; notifFrame.Parent=sg
    local nc=Instance.new("UICorner"); nc.CornerRadius=UDim.new(0,6); nc.Parent=notifFrame
    local ns=Instance.new("UIStroke"); ns.Color=color; ns.Thickness=1.5; ns.Parent=notifFrame
    local nl=Instance.new("TextLabel")
    nl.Size=UDim2.fromScale(1,1); nl.BackgroundTransparency=1
    nl.Text=text; nl.TextColor3=color; nl.TextSize=12
    nl.Font=Enum.Font.GothamBold; nl.Parent=notifFrame
    local f=notifFrame
    task.delay(2,function()
        if f and f.Parent then
            TW:Create(f,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
            task.wait(0.3); if f then f:Destroy() end
        end
    end)
end

local function applyConfigEffects()
    if C.fullbright then setFB(true) else setFB(false) end
    if C.potatoGraphics then applyPotato(true) else applyPotato(false) end
    if C.noSlowdown then applyNoSlow() end
    if C.noCooldown or C.mayersNoCD then installNoCD() end
    if C.fastVault then installFV() end
    if C.antiBlind then installAB() end
    if C.aimLock then startAimLock() end
    if C.stretchedRes then applyStretch(true) else applyStretch(false) end
    if C.antiAFK then toggleAFK(true) end
    if C.forceCursor then toggleCur(true) end
    if C.cameraZoom then toggleZoom(true) end
    if C.radiusESP then buildRadius() end
    if C.moonwalk then setupMW() end
    if C.spectatorCount then setupSpec() end
    if C.killerPerksInfo then setupKPI() end
    if C.infiniteLunge then installInfiniteLunge() end
    if C.fakePerfectLanding then hookPerfectLanding() end
    if C.fakeAdrenalineRush then hookAdrenaline() end
end

local function loadAndApply()
    local okk,er=loadConfig()
    if okk then
        refreshAllUI()
        applyConfigEffects()
    end
    return okk,er
end

local function botBtn(txt,col,cb)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(1/3,-3,1,0); b.BackgroundColor3=COL.bgElevated
    b.BorderSizePixel=0; b.Text=txt; b.TextColor3=col
    b.TextSize=10; b.Font=Enum.Font.GothamBold; b.AutoButtonColor=false; b.Parent=botBar
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,5); c.Parent=b
    b.MouseButton1Click:Connect(cb)
    b.MouseEnter:Connect(function() TW:Create(b,TweenInfo.new(0.15),{BackgroundColor3=COL.bgHover}):Play() end)
    b.MouseLeave:Connect(function() TW:Create(b,TweenInfo.new(0.15),{BackgroundColor3=COL.bgElevated}):Play() end)
    return b
end

botBtn("SAVE",COL.success,function()
    local okk,er=saveConfig()
    notify(okk and "Config saved!" or ("Save failed: "..tostring(er)),okk and COL.success or COL.danger)
end)
botBtn("LOAD",COL.accentLight,function()
    local okk,er=loadAndApply()
    notify(okk and "Config loaded!" or ("Load failed: "..tostring(er)),okk and COL.success or COL.danger)
end)
botBtn("RESET",COL.warning,function()
    resetConfig(); deleteConfig(); refreshAllUI()
    notify("Config reset (refresh UI applied)",COL.warning)
end)

local grip=Instance.new("Frame")
grip.Name="Grip"; grip.Size=UDim2.fromOffset(16,16)
grip.Position=UDim2.new(1,-18,1,-18)
grip.BackgroundColor3=COL.bgElevated; grip.BorderSizePixel=0
grip.Parent=main
local gC=Instance.new("UICorner"); gC.CornerRadius=UDim.new(0,4); gC.Parent=grip
local gripDot=Instance.new("TextLabel")
gripDot.Size=UDim2.fromScale(1,1); gripDot.BackgroundTransparency=1
gripDot.Text="◢"; gripDot.TextColor3=COL.textDim; gripDot.TextSize=12
gripDot.Parent=grip

local resizing=false; local rsS,rsP
grip.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        resizing=true; rsS=i.Position; rsP=main.AbsoluteSize
    end
end)
UIS.InputChanged:Connect(function(i)
    if resizing and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-rsS
        main.Size=UDim2.fromOffset(math.max(500,rsP.X+d.X),math.max(360,rsP.Y+d.Y))
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then resizing=false end
end)

local minimized=false
minBtn.MouseButton1Click:Connect(function()
    minimized=not minimized
    if minimized then
        main.Size=UDim2.fromOffset(680,40)
        sidebar.Visible=false; content.Visible=false; botBar.Visible=false; grip.Visible=false
    else
        main.Size=UDim2.fromOffset(680,520)
        sidebar.Visible=true; content.Visible=true; botBar.Visible=true; grip.Visible=true
    end
end)

local tabs={}
local currentTab=nil

local function createPage(name)
    local s=Instance.new("ScrollingFrame")
    s.Name=name; s.Size=UDim2.new(1,0,1,0)
    s.BackgroundTransparency=1; s.BorderSizePixel=0
    s.CanvasSize=UDim2.new(); s.AutomaticCanvasSize=Enum.AutomaticSize.Y
    s.ScrollBarThickness=4; s.ScrollBarImageColor3=COL.accentDim
    s.Visible=false; s.Parent=pageHolder
    local l=Instance.new("UIListLayout"); l.Padding=UDim.new(0,6); l.Parent=s
    local p=Instance.new("UIPadding"); p.PaddingRight=UDim.new(0,6); p.Parent=s
    return s
end

local function makeTab(name)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(1,0,0,32); b.BackgroundColor3=COL.bgElevated
    b.BorderSizePixel=0; b.Text=""; b.AutoButtonColor=false; b.Parent=sidebar
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,6); c.Parent=b
    local accentBar=Instance.new("Frame")
    accentBar.Size=UDim2.new(0,3,0,16); accentBar.Position=UDim2.new(0,0,0.5,-8)
    accentBar.BackgroundColor3=COL.accent; accentBar.BorderSizePixel=0
    accentBar.BackgroundTransparency=1; accentBar.Parent=b
    local ac=Instance.new("UICorner"); ac.CornerRadius=UDim.new(1,0); ac.Parent=accentBar
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-16,1,0); lbl.Position=UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency=1; lbl.Text=name
    lbl.TextColor3=COL.textDim; lbl.TextSize=12; lbl.Font=Enum.Font.GothamBold
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=b
    return {btn=b,accent=accentBar,lbl=lbl,name=name}
end

local function switchTab(name)
    for _,t in pairs(tabs) do
        t.page.Visible=false; t.btn.BackgroundColor3=COL.bgElevated
        t.accent.BackgroundTransparency=1; t.lbl.TextColor3=COL.textDim
    end
    local t=tabs[name]
    if t then
        t.page.Visible=true; t.btn.BackgroundColor3=COL.accentDim
        t.accent.BackgroundTransparency=0; t.lbl.TextColor3=COL.text
        currentTab=name
    end
end

local tabList={"Combat","Visual","Killer","Survivor","Misc","Config"}
for _,name in ipairs(tabList) do
    local page=createPage(name)
    local tb=makeTab(name)
    tabs[name]={page=page,btn=tb.btn,accent=tb.accent,lbl=tb.lbl,name=name}
    tb.btn.MouseButton1Click:Connect(function() switchTab(name) end)
    tb.btn.MouseEnter:Connect(function()
        if currentTab~=name then TW:Create(tb.btn,TweenInfo.new(0.15),{BackgroundColor3=COL.bgHover}):Play() end
    end)
    tb.btn.MouseLeave:Connect(function()
        if currentTab~=name then TW:Create(tb.btn,TweenInfo.new(0.15),{BackgroundColor3=COL.bgElevated}):Play() end
    end)
end
switchTab("Combat")

local sectionParents={}
local allRows={}
local searchText=""

searchInput:GetPropertyChangedSignal("Text"):Connect(function()
    searchText=searchInput.Text:lower()
    for _,row in ipairs(allRows) do
        if row.label then
            row.frame.Visible = searchText=="" or row.label:lower():find(searchText,1,true)~=nil
        end
    end
end)

local function getPage(name) return tabs[name] and tabs[name].page end
local function getTarget(name) return sectionParents[name] or getPage(name) end

local function addSection(pageName,text)
    local p=getPage(pageName); if not p then return end
    local wrap=Instance.new("Frame")
    wrap.Size=UDim2.new(1,0,0,0); wrap.AutomaticSize=Enum.AutomaticSize.Y
    wrap.BackgroundTransparency=1; wrap.Parent=p
    local wl=Instance.new("UIListLayout"); wl.Padding=UDim.new(0,4); wl.Parent=wrap
    local header=Instance.new("TextButton")
    header.Size=UDim2.new(1,0,0,30); header.BackgroundColor3=COL.bgSurface
    header.BorderSizePixel=0; header.Text=""; header.AutoButtonColor=false; header.Parent=wrap
    local hc=Instance.new("UICorner"); hc.CornerRadius=UDim.new(0,6); hc.Parent=header
    local hSt=Instance.new("UIStroke"); hSt.Color=COL.border; hSt.Thickness=1; hSt.Parent=header
    local bar=Instance.new("Frame")
    bar.Size=UDim2.new(0,3,0,16); bar.Position=UDim2.new(0,10,0.5,-8)
    bar.BackgroundColor3=COL.accent; bar.BorderSizePixel=0; bar.Parent=header
    local bc=Instance.new("UICorner"); bc.CornerRadius=UDim.new(1,0); bc.Parent=bar
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-60,1,0); lbl.Position=UDim2.new(0,22,0,0)
    lbl.BackgroundTransparency=1; lbl.Text=text
    lbl.TextColor3=COL.accentLight; lbl.TextSize=12; lbl.Font=Enum.Font.GothamBold
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=header
    local arrow=Instance.new("TextLabel")
    arrow.Size=UDim2.fromOffset(20,20); arrow.Position=UDim2.new(1,-28,0.5,-10)
    arrow.BackgroundTransparency=1; arrow.Text="▼"
    arrow.TextColor3=COL.textDim; arrow.TextSize=10; arrow.Font=Enum.Font.GothamBold
    arrow.Parent=header
    local body=Instance.new("Frame")
    body.Size=UDim2.new(1,0,0,0); body.AutomaticSize=Enum.AutomaticSize.Y
    body.BackgroundTransparency=1; body.Parent=wrap
    local bl=Instance.new("UIListLayout"); bl.Padding=UDim.new(0,4); bl.Parent=body
    local collapsed=false
    header.MouseButton1Click:Connect(function()
        collapsed=not collapsed; body.Visible=not collapsed
        arrow.Text=collapsed and "▶" or "▼"
        TW:Create(header,TweenInfo.new(0.15),{BackgroundColor3=collapsed and COL.bgSurface or COL.bgElevated}):Play()
    end)
    header.MouseEnter:Connect(function() TW:Create(header,TweenInfo.new(0.15),{BackgroundColor3=COL.bgElevated}):Play() end)
    header.MouseLeave:Connect(function() if not collapsed then TW:Create(header,TweenInfo.new(0.15),{BackgroundColor3=COL.bgSurface}):Play() end end)
    sectionParents[pageName]=body
end

-- FIX #4/#5: add* functions now take key, register with registry
local function addToggle(pageName,text,key,cb)
    local p=getTarget(pageName); if not p then return end
    local row=Instance.new("Frame")
    row.Size=UDim2.new(1,0,0,34); row.BackgroundColor3=COL.bgElevated
    row.BorderSizePixel=0; row.Parent=p
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,6); c.Parent=row
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-60,1,0); lbl.Position=UDim2.new(0,12,0,0)
    lbl.BackgroundTransparency=1; lbl.Text=text; lbl.TextColor3=COL.text
    lbl.TextSize=12; lbl.Font=Enum.Font.Gotham; lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Parent=row
    local sw=Instance.new("Frame")
    sw.Size=UDim2.fromOffset(34,16); sw.Position=UDim2.new(1,-46,0.5,-8)
    sw.BackgroundColor3=Color3.fromRGB(50,50,65); sw.BorderSizePixel=0; sw.Parent=row
    local sc=Instance.new("UICorner"); sc.CornerRadius=UDim.new(1,0); sc.Parent=sw
    local knob=Instance.new("Frame")
    knob.Size=UDim2.fromOffset(12,12); knob.Position=UDim2.new(0,2,0.5,-6)
    knob.BackgroundColor3=COL.textDim; knob.BorderSizePixel=0; knob.Parent=sw
    local kc=Instance.new("UICorner"); kc.CornerRadius=UDim.new(1,0); kc.Parent=knob
    
    local function refresh()
        if C[key] then
            TW:Create(sw,TweenInfo.new(0.15),{BackgroundColor3=COL.accent}):Play()
            TW:Create(knob,TweenInfo.new(0.15),{Position=UDim2.new(1,-14,0.5,-6),BackgroundColor3=Color3.new(1,1,1)}):Play()
        else
            TW:Create(sw,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(50,50,65)}):Play()
            TW:Create(knob,TweenInfo.new(0.15),{Position=UDim2.new(0,2,0.5,-6),BackgroundColor3=COL.textDim}):Play()
        end
    end
    refresh()
    registerUI(key, refresh)
    
    row.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            C[key] = not C[key]
            refreshUIKey(key)  -- sync duplicates
            if cb then pcall(cb,C[key]) end
        end
    end)
    row.MouseEnter:Connect(function() TW:Create(row,TweenInfo.new(0.15),{BackgroundColor3=COL.bgHover}):Play() end)
    row.MouseLeave:Connect(function() TW:Create(row,TweenInfo.new(0.15),{BackgroundColor3=COL.bgElevated}):Play() end)
    table.insert(allRows,{frame=row,label=text})
end

local function addButton(pageName,text,cb)
    local p=getTarget(pageName); if not p then return end
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(1,0,0,34); b.BackgroundColor3=COL.bgElevated
    b.BorderSizePixel=0; b.Text=""; b.AutoButtonColor=false; b.Parent=p
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,6); c.Parent=b
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-16,1,0); lbl.Position=UDim2.fromOffset(12,0)
    lbl.BackgroundTransparency=1; lbl.Text=text; lbl.TextColor3=COL.accentLight
    lbl.TextSize=12; lbl.Font=Enum.Font.GothamBold; lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Parent=b
    b.MouseButton1Click:Connect(function()
        pcall(cb)
        TW:Create(b,TweenInfo.new(0.1),{BackgroundColor3=COL.accentDim}):Play()
        task.delay(0.15,function() TW:Create(b,TweenInfo.new(0.15),{BackgroundColor3=COL.bgElevated}):Play() end)
    end)
    b.MouseEnter:Connect(function() TW:Create(b,TweenInfo.new(0.15),{BackgroundColor3=COL.bgHover}):Play() end)
    b.MouseLeave:Connect(function() TW:Create(b,TweenInfo.new(0.15),{BackgroundColor3=COL.bgElevated}):Play() end)
    table.insert(allRows,{frame=b,label=text})
end

local function addSlider(pageName,text,key,mn,mx,cb)
    local p=getTarget(pageName); if not p then return end
    local f=Instance.new("Frame")
    f.Size=UDim2.new(1,0,0,44); f.BackgroundColor3=COL.bgElevated
    f.BorderSizePixel=0; f.Parent=p
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,6); c.Parent=f
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-90,0,20); lbl.Position=UDim2.fromOffset(12,6)
    lbl.BackgroundTransparency=1; lbl.Text=text; lbl.TextColor3=COL.text
    lbl.TextSize=12; lbl.Font=Enum.Font.Gotham; lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Parent=f
    local pill=Instance.new("TextLabel")
    pill.Size=UDim2.fromOffset(60,20); pill.Position=UDim2.new(1,-72,0,6)
    pill.BackgroundColor3=COL.bgDark; pill.BorderSizePixel=0
    pill.Text=string.format("%.2f",C[key] or mn); pill.TextColor3=COL.accentLight
    pill.TextSize=11; pill.Font=Enum.Font.GothamBold; pill.Parent=f
    local pc=Instance.new("UICorner"); pc.CornerRadius=UDim.new(0,4); pc.Parent=pill
    local bar=Instance.new("Frame")
    bar.Size=UDim2.new(1,-24,0,6); bar.Position=UDim2.fromOffset(12,30)
    bar.BackgroundColor3=COL.bgDark; bar.BorderSizePixel=0; bar.Parent=f
    local bc=Instance.new("UICorner"); bc.CornerRadius=UDim.new(1,0); bc.Parent=bar
    local fill=Instance.new("Frame")
    fill.Size=UDim2.fromScale((math.clamp((C[key] or mn)-mn,0,mx-mn))/(mx-mn),1)
    fill.BackgroundColor3=COL.accent; fill.BorderSizePixel=0; fill.Parent=bar
    local fc=Instance.new("UICorner"); fc.CornerRadius=UDim.new(1,0); fc.Parent=fill
    
    local function refresh()
        local v = C[key] or mn
        local rel = math.clamp((v-mn)/(mx-mn),0,1)
        fill.Size=UDim2.fromScale(rel,1)
        pill.Text=string.format("%.2f",v)
    end
    refresh()
    registerUI(key, refresh)
    
    local drg=false
    local function upd(x)
        local rel=math.clamp((x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
        C[key]=mn+(mx-mn)*rel
        refreshUIKey(key)
        if cb then pcall(cb,C[key]) end
    end
    bar.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            drg=true; upd(i.Position.X)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then upd(i.Position.X) end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drg=false end
    end)
    table.insert(allRows,{frame=f,label=text})
end

local function addDropdown(pageName,text,key,options,cb)
    local p=getTarget(pageName); if not p then return end
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(1,0,0,34); b.BackgroundColor3=COL.bgElevated
    b.BorderSizePixel=0; b.Text=""; b.AutoButtonColor=false; b.Parent=p
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,6); c.Parent=b
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-140,1,0); lbl.Position=UDim2.fromOffset(12,0)
    lbl.BackgroundTransparency=1; lbl.Text=text; lbl.TextColor3=COL.text
    lbl.TextSize=12; lbl.Font=Enum.Font.Gotham; lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Parent=b
    local pill=Instance.new("TextLabel")
    pill.Size=UDim2.fromOffset(110,22); pill.Position=UDim2.new(1,-122,0.5,-11)
    pill.BackgroundColor3=COL.bgDark; pill.BorderSizePixel=0
    pill.Text=C[key] or options[1]; pill.TextColor3=COL.accentLight
    pill.TextSize=11; pill.Font=Enum.Font.GothamBold; pill.Parent=b
    local pc=Instance.new("UICorner"); pc.CornerRadius=UDim.new(0,4); pc.Parent=pill
    
    local function refresh() pill.Text = C[key] or options[1] end
    refresh()
    registerUI(key, refresh)
    
    b.MouseButton1Click:Connect(function()
        local cur = C[key] or options[1]
        local idx=1
        for i,v in ipairs(options) do if v==cur then idx=i; break end end
        idx=idx%#options+1
        C[key]=options[idx]
        refreshUIKey(key)
        if cb then pcall(cb,C[key]) end
    end)
    b.MouseEnter:Connect(function() TW:Create(b,TweenInfo.new(0.15),{BackgroundColor3=COL.bgHover}):Play() end)
    b.MouseLeave:Connect(function() TW:Create(b,TweenInfo.new(0.15),{BackgroundColor3=COL.bgElevated}):Play() end)
    table.insert(allRows,{frame=b,label=text})
end

local function addInput(pageName,text,key,placeholder,cb)
    local p=getTarget(pageName); if not p then return end
    local f=Instance.new("Frame")
    f.Size=UDim2.new(1,0,0,34); f.BackgroundColor3=COL.bgElevated
    f.BorderSizePixel=0; f.Parent=p
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,6); c.Parent=f
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.fromOffset(80,1); lbl.Position=UDim2.fromOffset(12,0)
    lbl.BackgroundTransparency=1; lbl.Text=text; lbl.TextColor3=COL.text
    lbl.TextSize=12; lbl.Font=Enum.Font.Gotham; lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Parent=f
    local tb=Instance.new("TextBox")
    tb.Size=UDim2.new(1,-110,1,-8); tb.Position=UDim2.fromOffset(100,4)
    tb.BackgroundColor3=COL.bgDark; tb.BorderSizePixel=0
    tb.Text=C[key] or ""; tb.PlaceholderText=placeholder; tb.PlaceholderColor3=COL.textDim
    tb.TextColor3=COL.text; tb.TextSize=11; tb.Font=Enum.Font.Gotham; tb.Parent=f
    local tc=Instance.new("UICorner"); tc.CornerRadius=UDim.new(0,4); tc.Parent=tb
    
    registerUI(key, function() if tb.Text ~= (C[key] or "") then tb.Text = C[key] or "" end end)
    
    tb:GetPropertyChangedSignal("Text"):Connect(function()
        C[key] = tb.Text
        if cb then pcall(cb,tb.Text) end
    end)
    table.insert(allRows,{frame=f,label=text})
end

print("[N]yx: component builders ready")

-- ═══ COMBAT ═══
addSection("Combat","Silent Aim")
addToggle("Combat","Enable Silent Aim","silentAim",function(v) end)
addDropdown("Combat","Target","aimTarget",{"Killer","Survivor"},function(v) end)
addToggle("Combat","Prediction","aimPrediction",function(v) end)
addSlider("Combat","Aim FOV","aimFov",30,500,function(v) end)

addSection("Combat","Silent Spear")
addToggle("Combat","Enable Silent Spear","silentSpear",function(v) end)
addToggle("Combat","Prediction","spearPrediction",function(v) end)
addSlider("Combat","Spear FOV","spearFov",30,500,function(v) end)
addToggle("Combat","Camera Veil","cameraVeil",function(v) end)

addSection("Combat","Auto Parry")
addToggle("Combat","Enable Auto Parry","autoParry",function(v) end)
addSlider("Combat","Parry Radius","parryRadius",4,40,function(v) end)
addToggle("Combat","Radius ESP","radiusESP",function(v) if v then buildRadius() end end)

addSection("Combat","Aimlock")
addToggle("Combat","Aim Lock Camera","aimLock",function(v) if v then startAimLock() end end)
addDropdown("Combat","Lock Target","aimLockTarget",{"Survivor","Killer"},function(v) end)
addDropdown("Combat","Lock Part","aimLockPart",{"Torso","Head"},function(v) end)
addSlider("Combat","Lock Distance","aimLockDist",50,700,function(v) end)
addSlider("Combat","Lock Smooth","aimLockSmooth",0.01,1,function(v) end)
addToggle("Combat","Aimlock M2 (Hidden)","aimlockM2",function(v) if v then installM2() end end)
addSlider("Combat","M2 Smooth","aimlockM2Smooth",0.05,1,function(v) end)

addSection("Combat","No Cooldown")
addToggle("Combat","No Cooldown (All)","noCooldown",function(v) if v then installNoCD() end end)
addToggle("Combat","Mayers No Cooldown","mayersNoCD",function(v) if v then installNoCD() end end)
addToggle("Combat","Infinite Lunge","infiniteLunge",function(v) installInfiniteLunge() end)

addSection("Combat","Anti")
addToggle("Combat","Anti Blind","antiBlind",function(v) if v then installAB() end end)
addToggle("Combat","Anti Loop Window","antiLoopWindow",function(v) toggleLoop(v) end)

-- ═══ VISUAL ═══
addSection("Visual","Player ESP")
addToggle("Visual","Killer ESP","espKiller",function(v) end)
addToggle("Visual","Survivor ESP","espSurvivor",function(v) end)
addSlider("Visual","ESP Distance","espDist",50,1000,function(v) end)

addSection("Visual","Object ESP")
addToggle("Visual","Generator ESP","espGenerator",function(v) scanObjects() end)
addToggle("Visual","Generator Progress","genProgress",function(v) end)
addToggle("Visual","Generator Info","genInfo",function(v) end)
addToggle("Visual","Pallet ESP","espPallet",function(v) scanObjects() end)
addToggle("Visual","Window ESP","espWindow",function(v) scanObjects() end)
addToggle("Visual","Hook ESP","espHook",function(v) scanObjects() end)
addToggle("Visual","Gate ESP","espGate",function(v) scanObjects() end)

addSection("Visual","World")
addToggle("Visual","Fullbright","fullbright",function(v) setFB(v) end)
addToggle("Visual","Potato Graphics","potatoGraphics",function(v) applyPotato(v) end)
addToggle("Visual","Crosshair","crosshair",function(v) end)
addToggle("Visual","Killer Warn","killerWarn",function(v) end)
addToggle("Visual","Stretched Res","stretchedRes",function(v) applyStretch(v) end)
addSlider("Visual","Stretch Ratio","stretchRatio",0.8,2.5,function(v) end)

addSection("Visual","Overlays")
addToggle("Visual","Hook Counter","hookCounter",function(v) end)
addToggle("Visual","Spectator Count","spectatorCount",function(v) if v then setupSpec() end end)
addToggle("Visual","Stun Timer","stunTimer",function(v) end)
addSlider("Visual","Stun Distance","stunTimerDist",50,500,function(v) end)
addToggle("Visual","Performance Monitor","perfMonitor",function(v) end)
addToggle("Visual","Prediction Monitor","predictionMonitor",function(v) end)

-- ═══ KILLER ═══
addSection("Killer","Perks Info")
addToggle("Killer","Killer Perks Info","killerPerksInfo",function(v) if v then setupKPI() end end)

addSection("Killer","Movement")
addToggle("Killer","Infinite Lunge","infiniteLunge",function(v) installInfiniteLunge() end)

addSection("Killer","Spear System")
addToggle("Killer","Silent Spear","silentSpear",function(v) end)
addToggle("Killer","Spear Prediction","spearPrediction",function(v) end)
addSlider("Killer","Spear FOV","spearFov",30,500,function(v) end)

-- ═══ SURVIVOR ═══
addSection("Survivor","Auto Generator")
addToggle("Survivor","Auto Generator","autoGen",function(v) end)
addDropdown("Survivor","Mode","autoGenMode",{"Instant","Perfect","Normal","Random"},function(v) end)
addButton("Survivor","Gen Boost",genBoost)

addSection("Survivor","Healing")
addToggle("Survivor","Self Heal","selfHeal",function(v) end)

addSection("Survivor","Movement")
addToggle("Survivor","Speed Boost V1","speedBoost",function(v) end)
addSlider("Survivor","V1 Multiplier","speedMult",0,2,function(v) end)
addToggle("Survivor","Speed Boost V2","speedV2",function(v) end)
addSlider("Survivor","V2 Multiplier","speedV2Mult",1,3,function(v) end)
addToggle("Survivor","No Slowdown","noSlowdown",function(v) applyNoSlow() end)
addToggle("Survivor","God Mode","godMode",function(v) end)
addToggle("Survivor","Noclip","noclip",function(v) end)
addToggle("Survivor","Fast Vault","fastVault",function(v) if v then installFV() end end)
addToggle("Survivor","Auto Drop Pallet","autoDropPallet",function(v) end)
addToggle("Survivor","Moonwalk","moonwalk",function(v) if v then setupMW() end end)

addSection("Survivor","Combat")
addToggle("Survivor","Silent Aim (ToF)","silentAim",function(v) end)
addDropdown("Survivor","Aim Target","aimTarget",{"Killer","Survivor"},function(v) end)
addSlider("Survivor","Aim FOV","aimFov",30,500,function(v) end)
addToggle("Survivor","Auto Parry","autoParry",function(v) end)
addSlider("Survivor","Parry Radius","parryRadius",4,40,function(v) end)
addToggle("Survivor","Shoot While Downed","shootWhileDowned",function(v) end)

addSection("Survivor","Perks & Abyss")
addToggle("Survivor","Flowstate","flowstate",function(v) end)
addToggle("Survivor","Quick Recovery","fakeQuickRecovery",function(v) end)
addToggle("Survivor","Perfect Landing","fakePerfectLanding",function(v) if v then hookPerfectLanding() end end)
addToggle("Survivor","Adrenaline Rush","fakeAdrenalineRush",function(v) if v then hookAdrenaline() end end)
addToggle("Survivor","Auto Crouch (Abyss)","autoCrouch",function(v) end)
addSlider("Survivor","Crouch Radius","autoCrouchRadius",4,40,function(v) end)

-- ═══ MISC ═══
addSection("Misc","Camera")
addToggle("Misc","Max Zoom","cameraZoom",function(v) toggleZoom(v) end)

addSection("Misc","Utilities")
addToggle("Misc","Anti AFK","antiAFK",function(v) toggleAFK(v) end)
addToggle("Misc","Force Cursor","forceCursor",function(v) toggleCur(v) end)
addToggle("Misc","Skip End Screen","skipEndScreen",function(v) if v then skipCut(false) end end)
addToggle("Misc","Skip Loading+Dark","skipLoading",function(v) if v then skipCut(true) end end)

addSection("Misc","Avatar")
addInput("Misc","Avatar","avatarInput","Username / UserId",function(v) end)
addButton("Misc","Copy Avatar",function()
    local input = C.avatarInput or ""
    if input=="" then return end
    task.spawn(function()
        local id=tonumber(input)
        if not id then local okk; okk,id=pcall(function() return Players:GetUserIdFromNameAsync(input) end); if not okk then return end end
        local ch=LP.Character; local h=ch and getHum(ch); if not ch or not h then return end
        local d=Players:GetHumanoidDescriptionFromUserId(id); if not d then return end
        local m=Players:CreateHumanoidModelFromDescription(d,h.RigType); if not m then return end
        for _,o in ipairs(ch:GetChildren()) do
            if o:IsA("Accessory") or o:IsA("Shirt") or o:IsA("Pants") or o:IsA("ShirtGraphic") or o:IsA("BodyColors") then o:Destroy() end
        end
        local bc=m:FindFirstChildOfClass("BodyColors"); if bc then bc:Clone().Parent=ch end
        for _,o in ipairs(m:GetChildren()) do
            if o:IsA("Shirt") or o:IsA("Pants") or o:IsA("ShirtGraphic") then o:Clone().Parent=ch end
        end
        m:Destroy()
    end)
end)

addSection("Misc","Server")
addButton("Misc","Rejoin Server",function() pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,LP) end) end)
addButton("Misc","Hop Server",function() pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId,LP) end) end)
addButton("Misc","Respawn",function() local h=getHum(LP.Character); if h then h.Health=0 end end)

-- ═══ CONFIG ═══
addSection("Config","Configuration")
addButton("Config","Save Config",function()
    local okk,er=saveConfig()
    notify(okk and "Config saved!" or ("Failed: "..tostring(er)),okk and COL.success or COL.danger)
end)
addButton("Config","Load Config",function()
    local okk,er=loadAndApply()
    notify(okk and "Config loaded!" or ("Failed: "..tostring(er)),okk and COL.success or COL.danger)
end)
addButton("Config","Delete Config File",function()
    local okk=deleteConfig()
    notify(okk and "Config file deleted" or "No config file",COL.warning)
end)
addButton("Config","Reset All Settings",function()
    resetConfig(); refreshAllUI()
    notify("Config reset",COL.warning)
end)

addSection("Config","Info")
local infoFrame=Instance.new("Frame")
infoFrame.Size=UDim2.new(1,0,0,100); infoFrame.BackgroundColor3=COL.bgElevated
infoFrame.BorderSizePixel=0; infoFrame.Parent=getTarget("Config")
local ic=Instance.new("UICorner"); ic.CornerRadius=UDim.new(0,6); ic.Parent=infoFrame
local iLbl=Instance.new("TextLabel")
iLbl.Size=UDim2.new(1,-20,1,-16); iLbl.Position=UDim2.fromOffset(12,8)
iLbl.BackgroundTransparency=1; iLbl.RichText=true
iLbl.TextColor3=COL.textDim; iLbl.TextSize=11; iLbl.Font=Enum.Font.Gotham
iLbl.TextXAlignment=Enum.TextXAlignment.Left; iLbl.TextYAlignment=Enum.TextYAlignment.Top
iLbl.Text="<b>Shortcuts</b>\n• RightShift — toggle UI\n• Drag title to move\n• Drag ◢ to resize\n• Click header to collapse\n• Search filters all features\n• Config → VD_Nyx/config.json\n• Duplicate toggles (Silent Aim, Auto Parry) sinkron otomatis"
iLbl.Parent=infoFrame

print("[N]yx: all tabs built")

UIS.InputBegan:Connect(function(i,gp)
    if gp then return end
    if i.KeyCode==Enum.KeyCode.RightShift then sg.Enabled=not sg.Enabled end
end)

task.spawn(function()
    task.wait(1.5)
    if isfile and readfile and isfile(CFG_FILE) then
        local okk=loadAndApply()
        if okk then notify("Auto-loaded saved config",COL.success) end
    end
end)

-- ═══════════ MAIN LOOPS ═══════════
local eA,gA,sA,kA,hA=0,0,0,0,0
RunService.Heartbeat:Connect(function(dt)
    eA=eA+dt; if eA>=0.15 then eA=0; updateESP(); updateWarn(); updateCh(); updateStun() end
    gA=gA+dt; if gA>=1 then gA=0; scanObjects(); updateGenProg() end
    sA=sA+dt; if sA>=0.25 then sA=0; if C.spectatorCount then for _,p in ipairs(Players:GetPlayers()) do checkSpec(p) end; updateSpec() end end
    kA=kA+dt; if kA>=2 then kA=0; updateKPI() end
    hA=hA+dt; if hA>=0.5 then hA=0; updateHookCounter() end
    processSpeed(); processGod(); processNoclip(); processFP(); processFlow(); processCrouch()
    updatePerf(dt)
end)
RunService.RenderStepped:Connect(function()
    processAutoGen(); processHeal(); processParry()
    updateMW(); processCV(); processM2()
end)
task.spawn(function() while true do task.wait(0.02); updateAim(); updateSpear() end end)
task.spawn(function() while true do task.wait(0.2); if C.autoDropPallet then autoDrop() end end end)
task.spawn(function() while true do task.wait(1); updatePred() end end)
task.spawn(function() while true do task.wait(0.5); if C.noSlowdown then applyNoSlow() end end end)

local function onChar(ch)
    task.wait(0.5); applyNoSlow()
    if C.speedV2 then pcall(function() ch:SetAttribute("speedboost",C.speedV2Mult) end) end
end
if LP.Character then task.spawn(onChar,LP.Character) end
LP.CharacterAdded:Connect(onChar)

print("[N]yx v3.2 loaded successfully. RightShift to toggle UI.")

end)

if not ok then
    warn("[N]yx FATAL ERROR: "..tostring(err))
    pcall(function() warn(debug.traceback()) end)
end