-- ==============================================================================
-- // PHẦN 1: KHỞI TẠO HỆ THỐNG, CONFIG & CORE UI LIBRARY (hzayday_bloxfruit) //
-- ==============================================================================
local Env = (getgenv and getgenv()) or _G
Env.Hzayday = Env.Hzayday or {}
local H = Env.Hzayday

-- Hủy vòng lặp cũ nếu thực thi lại script nhiều lần
H.RunId = (H.RunId or 0) + 1
local CurrentRunId = H.RunId

do
    H.Services = {
        Players = game:GetService("Players"),
        TweenService = game:GetService("TweenService"),
        UserInputService = game:GetService("UserInputService"),
        RunService = game:GetService("RunService"),
        ReplicatedStorage = game:GetService("ReplicatedStorage"),
        Workspace = game:GetService("Workspace"),
        TeleportService = game:GetService("TeleportService"),
        HttpService = game:GetService("HttpService"),
        VirtualUser = game:GetService("VirtualUser"),
        CollectionService = game:GetService("CollectionService"),
        CoreGui = game:GetService("CoreGui")
    }

    H.LocalPlayer = H.Services.Players.LocalPlayer
    H.LogoId = "rbxassetid://138691340576184"
    H.HubName = "hzayday_bloxfruit"

    H.Config = {
        -- Farm Settings
        SelectWeapon = "Melee",
        AutoBuso = true,
        AutoKen = false,
        AutoRaceV3 = false,
        AutoRaceV4 = false,
        RemoveNotify = false,
        BringMob = true,
        AttackM1Fruit = false,
        AttackDragonstorm = false,
        AttackSoulGuitar = false,
        AttackPlayers = false,
        TweenSpeed = 180,
        BypassTeleport = false,
        FastTeleport = true,
        MasterySkills = {},
        HoldingSkill = false,
        HoldZ = 0, HoldX = 0, HoldC = 0, HoldV = 0,
        DistanceX = 0, DistanceY = 11, DistanceZ = 0,

        -- Main Tab
        AutoFarmLevel = false,
        AutoSecretQuests = false,
        SelectedSecretQuest = "Auto",
        AutoAwakenedBosses = false,
        SelectedAwakenedBosses = {
            ["Gorilla King"] = true, ["Chef"] = true, ["Yeti"] = true,
            ["Vice Admiral"] = true, ["Warden"] = true, ["Magma General"] = true,
            ["Fishman Lord"] = true, ["Sky Warlord"] = true, ["Lightning God"] = true, ["Cyborg"] = true
        },
        AwakenedBossMode = "Farm Repeatedly",
        HopAwakenedBosses = false,
        AutoDressrosa = false,
        AutoZou = false,
        AutoFishSlap = false,
        SelectBait = "None",
        AutoBuyBait = false,
        AutoSellFish = false,
        AutoFishing = false,
        AutoAcceptAngler = false,
        AutoCompleteAngler = false,
        AutoUseRodSkill = false,
        FishingPos = nil,
        AutoFarmTyrant = false,
        EscapeTyrantSkills = true,
        TyrantWeaponMode = "Rotate Weapons",
        JarCombatSettings = "Farm Settings",
        BossCombatSettings = "Farm Settings",
        SelectTyrantWeapon = "None",
        SelectTyrantSkill = {},
        AutoFarmDoughBoss = false,
        FarmCakeQuest = false,
        AutoSpawnCakeBoss = false,
        AutoTradeSweetChalice = false,
        AutoFarmBone = false,
        FarmBoneQuest = false,
        MasteryMethod = "Level",
        KillAtHP = 25,
        AutoFarmGunMastery = false,
        AutoFarmFruitMastery = false,
        SelectedBoss = "None",
        AutoFarmBoss = false,
        AutoAcceptBossQuest = true,
        AutoFarmChest = false,
        HopFarmChest = false,
        MobAura = false,

        -- Multi Farm Tab
        AutoFarmFactory = false,
        AutoFarmDarkbeard = false,
        FindChestDarkbeard = false,
        HopFarmDarkbeard = false,
        AutoCastleRaid = false,
        AutoFarmEliteHunter = false,
        HopFarmEliteHunter = false,
        StopHopGodChalice = false,
        AutoFarmSoulReaper = false,
        AutoSpawnSoulReaper = false,
        HopFarmSoulReaper = false,
        AutoSuperhuman = false,
        AutoDeathStep = false,
        AutoSharkmanKarate = false,
        AutoElectricClaw = false,
        AutoDragonTalon = false,
        AutoGodhuman = false,
        SelectedStats = {},
        AutoStats = false,

        -- Quests Tab
        AutoBartilo = false,
        AutoDojoQuest = false,
        KeepSailingDojo = false,
        AutoDragonHunter = false,
        AutoUpgradeKenV2 = false,
        AutoFarmKen = false,
        RejoinFarmKen = false,
        AutoRainbowHaki = false,
        AutoCitizenQuest = false,

        -- Items Tab
        AutoSkullGuitar = false,
        AutoCDK = false,
        AutoYama = false,
        AutoTushita = false,
        AutoSaber = false,
        AutoTTK = false,
        AutoRengoku = false,
        AutoMidnightBlade = false,
        AutoRipIndra = false,
        AutoTouchHakiPad = false,
        ItemFarmElite = false,
        ItemHopElite = false,
        AutoUpgradeSword = false,
        AutoUpgradeGun = false,
        AutoFarmUpgradeMat = false,
        AutoInventoryMastery = false,
        AutoRandomBone = false,
        AutoBuyHakiColor = false,
        AutoBuyLegSword = false,
        AutoCraftSharkAnchor = false,
        AutoCraftVolcanicMagnet = false,
        AutoFarmBerry = false,
        HopFarmBerry = false,
        SelectedMaterial = "None",
        AutoFarmMaterials = false,
        AutoFarmEctoplasm = false
    }

    H.StatusLabels = {}
    H.Tabs = {}
    H.ActiveTab = nil

    -- Tìm nơi gắn UI an toàn trên mọi Executor (gethui -> CoreGui -> PlayerGui)
    local ParentGui = nil
    pcall(function()
        if gethui then ParentGui = gethui() end
    end)
    if not ParentGui then
        local ok, cg = pcall(function() return H.Services.CoreGui end)
        if ok and cg then ParentGui = cg end
    end
    if not ParentGui then
        ParentGui = H.LocalPlayer:WaitForChild("PlayerGui")
    end

    if ParentGui:FindFirstChild("Hzayday_BloxFruit_UI") then
        ParentGui.Hzayday_BloxFruit_UI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Hzayday_BloxFruit_UI"
    ScreenGui.Parent = ParentGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    H.ScreenGui = ScreenGui

    local function MakeDraggable(dragHandle, targetFrame)
        local dragging, dragInput, dragStart, startPos
        dragHandle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = targetFrame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        dragHandle.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        H.Services.UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                targetFrame.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end)
    end

    local MainWindow = Instance.new("Frame")
    MainWindow.Name = "MainWindow"
    MainWindow.Parent = ScreenGui
    MainWindow.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
    MainWindow.Position = UDim2.new(0.5, -310, 0.5, -210)
    MainWindow.Size = UDim2.new(0, 620, 0, 420)
    MainWindow.ClipsDescendants = true
    Instance.new("UICorner", MainWindow).CornerRadius = UDim.new(0, 12)

    local MainStroke = Instance.new("UIStroke", MainWindow)
    MainStroke.Color = Color3.fromRGB(35, 40, 52)
    MainStroke.Thickness = 1.2

    local FloatingBtn = Instance.new("TextButton")
    FloatingBtn.Name = "FloatingToggle"
    FloatingBtn.Parent = ScreenGui
    FloatingBtn.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
    FloatingBtn.Position = UDim2.new(0.5, -75, 0.08, 0)
    FloatingBtn.Size = UDim2.new(0, 185, 0, 44)
    FloatingBtn.Text = ""
    FloatingBtn.AutoButtonColor = false
    Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(1, 0)

    local FloatStroke = Instance.new("UIStroke", FloatingBtn)
    FloatStroke.Color = Color3.fromRGB(45, 50, 65)
    FloatStroke.Thickness = 1.2

    local FloatIcon = Instance.new("ImageLabel")
    FloatIcon.Parent = FloatingBtn
    FloatIcon.BackgroundTransparency = 1
    FloatIcon.Position = UDim2.new(0, 10, 0.5, -14)
    FloatIcon.Size = UDim2.new(0, 28, 0, 28)
    FloatIcon.Image = H.LogoId
    Instance.new("UICorner", FloatIcon).CornerRadius = UDim.new(1, 0)

    local FloatText = Instance.new("TextLabel")
    FloatText.Parent = FloatingBtn
    FloatText.BackgroundTransparency = 1
    FloatText.Position = UDim2.new(0, 44, 0, 0)
    FloatText.Size = UDim2.new(1, -74, 1, 0)
    FloatText.Font = Enum.Font.GothamBold
    FloatText.Text = H.HubName
    FloatText.TextColor3 = Color3.fromRGB(240, 240, 245)
    FloatText.TextSize = 12
    FloatText.TextXAlignment = Enum.TextXAlignment.Left
    FloatText.TextTruncate = Enum.TextTruncate.AtEnd

    local StatusDot = Instance.new("Frame")
    StatusDot.Parent = FloatingBtn
    StatusDot.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    StatusDot.Position = UDim2.new(1, -22, 0.5, -5)
    StatusDot.Size = UDim2.new(0, 10, 0, 10)
    Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)

    MakeDraggable(FloatingBtn, FloatingBtn)
    FloatingBtn.MouseButton1Click:Connect(function()
        MainWindow.Visible = not MainWindow.Visible
        StatusDot.BackgroundColor3 = MainWindow.Visible and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
    end)

    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainWindow
    Sidebar.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
    Sidebar.Size = UDim2.new(0, 185, 1, 0)
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

    local SidebarLine = Instance.new("Frame")
    SidebarLine.Parent = Sidebar
    SidebarLine.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
    SidebarLine.BorderSizePixel = 0
    SidebarLine.Position = UDim2.new(1, -1, 0, 0)
    SidebarLine.Size = UDim2.new(0, 1, 1, 0)

    local BrandHeader = Instance.new("Frame")
    BrandHeader.Parent = Sidebar
    BrandHeader.BackgroundTransparency = 1
    BrandHeader.Size = UDim2.new(1, 0, 0, 62)

    local BrandLogo = Instance.new("ImageLabel")
    BrandLogo.Parent = BrandHeader
    BrandLogo.BackgroundTransparency = 1
    BrandLogo.Position = UDim2.new(0, 14, 0.5, -18)
    BrandLogo.Size = UDim2.new(0, 36, 0, 36)
    BrandLogo.Image = H.LogoId
    Instance.new("UICorner", BrandLogo).CornerRadius = UDim.new(0, 8)

    local BrandTitle = Instance.new("TextLabel")
    BrandTitle.Parent = BrandHeader
    BrandTitle.BackgroundTransparency = 1
    BrandTitle.Position = UDim2.new(0, 58, 0, 14)
    BrandTitle.Size = UDim2.new(1, -64, 0, 18)
    BrandTitle.Font = Enum.Font.GothamBold
    BrandTitle.Text = H.HubName
    BrandTitle.TextColor3 = Color3.fromRGB(245, 245, 250)
    BrandTitle.TextSize = 13
    BrandTitle.TextXAlignment = Enum.TextXAlignment.Left
    BrandTitle.TextTruncate = Enum.TextTruncate.AtEnd

    local BrandSub = Instance.new("TextLabel")
    BrandSub.Parent = BrandHeader
    BrandSub.BackgroundTransparency = 1
    BrandSub.Position = UDim2.new(0, 58, 0, 32)
    BrandSub.Size = UDim2.new(1, -64, 0, 16)
    BrandSub.Font = Enum.Font.GothamMedium
    BrandSub.Text = "[ Blox Fruits ]"
    BrandSub.TextColor3 = Color3.fromRGB(88, 145, 255)
    BrandSub.TextSize = 11
    BrandSub.TextXAlignment = Enum.TextXAlignment.Left

    MakeDraggable(BrandHeader, MainWindow)

    local SearchBoxFrame = Instance.new("Frame")
    SearchBoxFrame.Parent = Sidebar
    SearchBoxFrame.BackgroundColor3 = Color3.fromRGB(24, 27, 36)
    SearchBoxFrame.Position = UDim2.new(0, 12, 0, 66)
    SearchBoxFrame.Size = UDim2.new(1, -24, 0, 34)
    Instance.new("UICorner", SearchBoxFrame).CornerRadius = UDim.new(0, 8)
    local SearchStroke = Instance.new("UIStroke", SearchBoxFrame)
    SearchStroke.Color = Color3.fromRGB(36, 40, 54)

    local SearchInput = Instance.new("TextBox")
    SearchInput.Parent = SearchBoxFrame
    SearchInput.BackgroundTransparency = 1
    SearchInput.Position = UDim2.new(0, 12, 0, 0)
    SearchInput.Size = UDim2.new(1, -24, 1, 0)
    SearchInput.Font = Enum.Font.Gotham
    SearchInput.PlaceholderText = "Search..."
    SearchInput.PlaceholderColor3 = Color3.fromRGB(115, 122, 140)
    SearchInput.Text = ""
    SearchInput.TextColor3 = Color3.fromRGB(235, 235, 245)
    SearchInput.TextSize = 12
    SearchInput.TextXAlignment = Enum.TextXAlignment.Left

    local TabList = Instance.new("ScrollingFrame")
    TabList.Parent = Sidebar
    TabList.BackgroundTransparency = 1
    TabList.Position = UDim2.new(0, 10, 0, 110)
    TabList.Size = UDim2.new(1, -20, 1, -120)
    TabList.ScrollBarThickness = 0
    TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local TabListLayout = Instance.new("UIListLayout", TabList)
    TabListLayout.Padding = UDim.new(0, 6)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Parent = MainWindow
    ContentArea.BackgroundTransparency = 1
    ContentArea.Position = UDim2.new(0, 185, 0, 0)
    ContentArea.Size = UDim2.new(1, -185, 1, 0)

    local TopBar = Instance.new("Frame")
    TopBar.Parent = ContentArea
    TopBar.BackgroundTransparency = 1
    TopBar.Size = UDim2.new(1, 0, 0, 58)

    local TopTabTitle = Instance.new("TextLabel")
    TopTabTitle.Parent = TopBar
    TopTabTitle.BackgroundTransparency = 1
    TopTabTitle.Position = UDim2.new(0, 22, 0, 12)
    TopTabTitle.Size = UDim2.new(1, -40, 0, 20)
    TopTabTitle.Font = Enum.Font.GothamBold
    TopTabTitle.Text = "Main"
    TopTabTitle.TextColor3 = Color3.fromRGB(245, 245, 250)
    TopTabTitle.TextSize = 15
    TopTabTitle.TextXAlignment = Enum.TextXAlignment.Left

    local TopTabDesc = Instance.new("TextLabel")
    TopTabDesc.Parent = TopBar
    TopTabDesc.BackgroundTransparency = 1
    TopTabDesc.Position = UDim2.new(0, 22, 0, 32)
    TopTabDesc.Size = UDim2.new(1, -40, 0, 16)
    TopTabDesc.Font = Enum.Font.Gotham
    TopTabDesc.Text = "Farming and progression."
    TopTabDesc.TextColor3 = Color3.fromRGB(135, 142, 160)
    TopTabDesc.TextSize = 12
    TopTabDesc.TextXAlignment = Enum.TextXAlignment.Left

    local TopDivider = Instance.new("Frame")
    TopDivider.Parent = ContentArea
    TopDivider.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
    TopDivider.BorderSizePixel = 0
    TopDivider.Position = UDim2.new(0, 0, 0, 58)
    TopDivider.Size = UDim2.new(1, 0, 0, 1)

    MakeDraggable(TopBar, MainWindow)

    local PagesHolder = Instance.new("Frame")
    PagesHolder.Parent = ContentArea
    PagesHolder.BackgroundTransparency = 1
    PagesHolder.Position = UDim2.new(0, 0, 0, 60)
    PagesHolder.Size = UDim2.new(1, 0, 1, -60)

    SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
        local query = string.lower(SearchInput.Text)
        if H.ActiveTab and H.ActiveTab.Page then
            for _, item in ipairs(H.ActiveTab.Page:GetChildren()) do
                if item:IsA("Frame") and item:FindFirstChild("SearchKey") then
                    local key = string.lower(item.SearchKey.Value)
                    item.Visible = (query == "" or string.find(key, query, 1, true) ~= nil)
                end
            end
        end
    end)

    function H:CreateTab(name, desc)
        local TabObj = {}
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabList
        TabBtn.BackgroundColor3 = Color3.fromRGB(28, 34, 48)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Size = UDim2.new(1, 0, 0, 38)
        TabBtn.Text = ""
        TabBtn.AutoButtonColor = false
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

        local AccentBar = Instance.new("Frame")
        AccentBar.Parent = TabBtn
        AccentBar.BackgroundColor3 = Color3.fromRGB(88, 145, 255)
        AccentBar.Position = UDim2.new(0, 0, 0.2, 0)
        AccentBar.Size = UDim2.new(0, 3, 0.6, 0)
        AccentBar.Visible = false
        Instance.new("UICorner", AccentBar).CornerRadius = UDim.new(1, 0)

        local TabTitle = Instance.new("TextLabel")
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundTransparency = 1
        TabTitle.Position = UDim2.new(0, 14, 0, 0)
        TabTitle.Size = UDim2.new(1, -20, 1, 0)
        TabTitle.Font = Enum.Font.GothamMedium
        TabTitle.Text = name
        TabTitle.TextColor3 = Color3.fromRGB(160, 168, 185)
        TabTitle.TextSize = 13
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left

        local Page = Instance.new("ScrollingFrame")
        Page.Name = name .. "_Page"
        Page.Parent = PagesHolder
        Page.BackgroundTransparency = 1
        Page.Position = UDim2.new(0, 16, 0, 8)
        Page.Size = UDim2.new(1, -32, 1, -16)
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Color3.fromRGB(88, 145, 255)
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.Visible = false

        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder

        local function Activate()
            for _, t in ipairs(H.Tabs) do
                t.Page.Visible = false
                t.Btn.BackgroundTransparency = 1
                t.Accent.Visible = false
                t.Title.TextColor3 = Color3.fromRGB(160, 168, 185)
                t.Title.Font = Enum.Font.GothamMedium
            end
            Page.Visible = true
            TabBtn.BackgroundTransparency = 0
            AccentBar.Visible = true
            TabTitle.TextColor3 = Color3.fromRGB(245, 245, 250)
            TabTitle.Font = Enum.Font.GothamBold
            TopTabTitle.Text = name
            TopTabDesc.Text = desc
            H.ActiveTab = TabObj
        end

        TabBtn.MouseButton1Click:Connect(Activate)

        TabObj.Btn = TabBtn
        TabObj.Page = Page
        TabObj.Accent = AccentBar
        TabObj.Title = TabTitle
        TabObj.Activate = Activate
        table.insert(H.Tabs, TabObj)

        if #H.Tabs == 1 then Activate() end

        function TabObj:AddSection(titleText)
            local SecFrame = Instance.new("Frame")
            SecFrame.Parent = Page
            SecFrame.BackgroundTransparency = 1
            SecFrame.Size = UDim2.new(1, 0, 0, 26)

            local Key = Instance.new("StringValue", SecFrame)
            Key.Name = "SearchKey"
            Key.Value = titleText

            local Lbl = Instance.new("TextLabel")
            Lbl.Parent = SecFrame
            Lbl.BackgroundTransparency = 1
            Lbl.Position = UDim2.new(0, 2, 0, 6)
            Lbl.Size = UDim2.new(1, 0, 0, 18)
            Lbl.Font = Enum.Font.GothamMedium
            Lbl.Text = titleText
            Lbl.TextColor3 = Color3.fromRGB(130, 138, 158)
            Lbl.TextSize = 12
            Lbl.TextXAlignment = Enum.TextXAlignment.Left
        end

        function TabObj:AddToggle(titleText, subText, configKey, callback)
            local Card = Instance.new("Frame")
            Card.Parent = Page
            Card.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
            Card.Size = UDim2.new(1, 0, 0, subText ~= "" and 58 or 44)
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)
            local Stroke = Instance.new("UIStroke", Card)
            Stroke.Color = Color3.fromRGB(34, 38, 50)

            local Key = Instance.new("StringValue", Card)
            Key.Name = "SearchKey"
            Key.Value = titleText .. " " .. (subText or "")

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Parent = Card
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Position = UDim2.new(0, 14, 0, subText ~= "" and 10 or 12)
            TitleLbl.Size = UDim2.new(1, -80, 0, 18)
            TitleLbl.Font = Enum.Font.GothamBold
            TitleLbl.Text = titleText
            TitleLbl.TextColor3 = Color3.fromRGB(240, 240, 248)
            TitleLbl.TextSize = 13
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left

            if subText and subText ~= "" then
                local SubLbl = Instance.new("TextLabel")
                SubLbl.Parent = Card
                SubLbl.BackgroundTransparency = 1
                SubLbl.Position = UDim2.new(0, 14, 0, 30)
                SubLbl.Size = UDim2.new(1, -80, 0, 16)
                SubLbl.Font = Enum.Font.Gotham
                SubLbl.Text = subText
                SubLbl.TextColor3 = Color3.fromRGB(130, 138, 156)
                SubLbl.TextSize = 11
                SubLbl.TextXAlignment = Enum.TextXAlignment.Left
                SubLbl.TextTruncate = Enum.TextTruncate.AtEnd
            end

            local SwitchBg = Instance.new("TextButton")
            SwitchBg.Parent = Card
            SwitchBg.Position = UDim2.new(1, -56, 0.5, -12)
            SwitchBg.Size = UDim2.new(0, 42, 0, 24)
            SwitchBg.Text = ""
            SwitchBg.AutoButtonColor = false
            Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)

            local Knob = Instance.new("Frame")
            Knob.Parent = SwitchBg
            Knob.Size = UDim2.new(0, 18, 0, 18)
            Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

            local function UpdateVisual(state)
                if state then
                    SwitchBg.BackgroundColor3 = Color3.fromRGB(88, 145, 255)
                    Knob.Position = UDim2.new(1, -21, 0.5, -9)
                    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                else
                    SwitchBg.BackgroundColor3 = Color3.fromRGB(36, 40, 54)
                    Knob.Position = UDim2.new(0, 3, 0.5, -9)
                    Knob.BackgroundColor3 = Color3.fromRGB(140, 148, 168)
                end
            end

            UpdateVisual(H.Config[configKey])

            SwitchBg.MouseButton1Click:Connect(function()
                H.Config[configKey] = not H.Config[configKey]
                UpdateVisual(H.Config[configKey])
                if callback then task.spawn(callback, H.Config[configKey]) end
            end)
        end

        function TabObj:AddSlider(titleText, subText, configKey, minVal, maxVal, callback)
            local Card = Instance.new("Frame")
            Card.Parent = Page
            Card.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
            Card.Size = UDim2.new(1, 0, 0, 74)
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)
            local Stroke = Instance.new("UIStroke", Card)
            Stroke.Color = Color3.fromRGB(34, 38, 50)

            local Key = Instance.new("StringValue", Card)
            Key.Name = "SearchKey"
            Key.Value = titleText .. " " .. (subText or "")

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Parent = Card
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Position = UDim2.new(0, 14, 0, 10)
            TitleLbl.Size = UDim2.new(1, -80, 0, 18)
            TitleLbl.Font = Enum.Font.GothamBold
            TitleLbl.Text = titleText
            TitleLbl.TextColor3 = Color3.fromRGB(240, 240, 248)
            TitleLbl.TextSize = 13
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left

            local SubLbl = Instance.new("TextLabel")
            SubLbl.Parent = Card
            SubLbl.BackgroundTransparency = 1
            SubLbl.Position = UDim2.new(0, 14, 0, 28)
            SubLbl.Size = UDim2.new(1, -80, 0, 16)
            SubLbl.Font = Enum.Font.Gotham
            SubLbl.Text = subText or ""
            SubLbl.TextColor3 = Color3.fromRGB(130, 138, 156)
            SubLbl.TextSize = 11
            SubLbl.TextXAlignment = Enum.TextXAlignment.Left

            local ValBox = Instance.new("TextLabel")
            ValBox.Parent = Card
            ValBox.BackgroundColor3 = Color3.fromRGB(28, 32, 44)
            ValBox.Position = UDim2.new(1, -56, 0, 10)
            ValBox.Size = UDim2.new(0, 42, 0, 22)
            ValBox.Font = Enum.Font.GothamBold
            ValBox.Text = tostring(H.Config[configKey] or minVal)
            ValBox.TextColor3 = Color3.fromRGB(230, 235, 245)
            ValBox.TextSize = 11
            Instance.new("UICorner", ValBox).CornerRadius = UDim.new(0, 6)

            local Track = Instance.new("TextButton")
            Track.Parent = Card
            Track.BackgroundColor3 = Color3.fromRGB(36, 40, 54)
            Track.Position = UDim2.new(0, 14, 0, 54)
            Track.Size = UDim2.new(1, -28, 0, 6)
            Track.Text = ""
            Track.AutoButtonColor = false
            Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

            local Fill = Instance.new("Frame")
            Fill.Parent = Track
            Fill.BackgroundColor3 = Color3.fromRGB(88, 145, 255)
            Fill.Size = UDim2.new(0, 0, 1, 0)
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

            local Knob = Instance.new("Frame")
            Knob.Parent = Fill
            Knob.BackgroundColor3 = Color3.fromRGB(220, 230, 255)
            Knob.Position = UDim2.new(1, -6, 0.5, -6)
            Knob.Size = UDim2.new(0, 12, 0, 12)
            Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

            local function SetValue(v)
                v = math.clamp(math.floor(v + 0.5), minVal, maxVal)
                H.Config[configKey] = v
                ValBox.Text = tostring(v)
                local pct = (v - minVal) / math.max(1, (maxVal - minVal))
                Fill.Size = UDim2.new(pct, 0, 1, 0)
                if callback then task.spawn(callback, v) end
            end

            SetValue(H.Config[configKey] or minVal)

            local sliding = false
            local function UpdateFromInput(input)
                local rel = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                SetValue(minVal + (maxVal - minVal) * rel)
            end

            Track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = true
                    UpdateFromInput(input)
                end
            end)
            H.Services.UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = false
                end
            end)
            H.Services.UserInputService.InputChanged:Connect(function(input)
                if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateFromInput(input)
                end
            end)
        end

        function TabObj:AddDropdown(titleText, subText, configKey, optionsList, isMulti, callback)
            local Card = Instance.new("Frame")
            Card.Parent = Page
            Card.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
            Card.Size = UDim2.new(1, 0, 0, 58)
            Card.ClipsDescendants = true
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)
            local Stroke = Instance.new("UIStroke", Card)
            Stroke.Color = Color3.fromRGB(34, 38, 50)

            local Key = Instance.new("StringValue", Card)
            Key.Name = "SearchKey"
            Key.Value = titleText .. " " .. (subText or "")

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Parent = Card
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Position = UDim2.new(0, 14, 0, 10)
            TitleLbl.Size = UDim2.new(0.55, 0, 0, 18)
            TitleLbl.Font = Enum.Font.GothamBold
            TitleLbl.Text = titleText
            TitleLbl.TextColor3 = Color3.fromRGB(240, 240, 248)
            TitleLbl.TextSize = 13
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
            TitleLbl.TextTruncate = Enum.TextTruncate.AtEnd

            local SubLbl = Instance.new("TextLabel")
            SubLbl.Parent = Card
            SubLbl.BackgroundTransparency = 1
            SubLbl.Position = UDim2.new(0, 14, 0, 30)
            SubLbl.Size = UDim2.new(0.55, 0, 0, 16)
            SubLbl.Font = Enum.Font.Gotham
            SubLbl.Text = subText or ""
            SubLbl.TextColor3 = Color3.fromRGB(130, 138, 156)
            SubLbl.TextSize = 11
            SubLbl.TextXAlignment = Enum.TextXAlignment.Left
            SubLbl.TextTruncate = Enum.TextTruncate.AtEnd

            local SelectBtn = Instance.new("TextButton")
            SelectBtn.Parent = Card
            SelectBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 44)
            SelectBtn.Position = UDim2.new(1, -165, 0, 13)
            SelectBtn.Size = UDim2.new(0, 150, 0, 32)
            SelectBtn.Font = Enum.Font.GothamMedium
            SelectBtn.TextColor3 = Color3.fromRGB(220, 225, 238)
            SelectBtn.TextSize = 11
            SelectBtn.TextTruncate = Enum.TextTruncate.AtEnd
            Instance.new("UICorner", SelectBtn).CornerRadius = UDim.new(0, 6)
            local SelStroke = Instance.new("UIStroke", SelectBtn)
            SelStroke.Color = Color3.fromRGB(42, 48, 64)

            local DropSearch = Instance.new("TextBox")
            DropSearch.Parent = Card
            DropSearch.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
            DropSearch.Position = UDim2.new(0, 14, 0, 64)
            DropSearch.Size = UDim2.new(1, -28, 0, 30)
            DropSearch.Font = Enum.Font.Gotham
            DropSearch.PlaceholderText = "Search"
            DropSearch.PlaceholderColor3 = Color3.fromRGB(115, 122, 140)
            DropSearch.Text = ""
            DropSearch.TextColor3 = Color3.fromRGB(235, 235, 245)
            DropSearch.TextSize = 12
            Instance.new("UICorner", DropSearch).CornerRadius = UDim.new(0, 6)

            local ItemsScroll = Instance.new("ScrollingFrame")
            ItemsScroll.Parent = Card
            ItemsScroll.BackgroundTransparency = 1
            ItemsScroll.Position = UDim2.new(0, 14, 0, 100)
            ItemsScroll.Size = UDim2.new(1, -28, 0, 130)
            ItemsScroll.ScrollBarThickness = 2
            ItemsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
            ItemsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

            local ItemsLayout = Instance.new("UIListLayout", ItemsScroll)
            ItemsLayout.Padding = UDim.new(0, 4)

            local function GetSummaryText()
                if not isMulti then
                    return tostring(H.Config[configKey] or "None") .. "  v"
                else
                    local tbl = H.Config[configKey] or {}
                    local list = {}
                    for k, v in pairs(tbl) do
                        if v then table.insert(list, k) end
                    end
                    if #list == 0 then return "None  v" end
                    return table.concat(list, ", ") .. "  v"
                end
            end

            local OptionButtons = {}
            local function RefreshOptions()
                SelectBtn.Text = GetSummaryText()
                for optName, btnData in pairs(OptionButtons) do
                    local isSelected = false
                    if isMulti then
                        isSelected = (H.Config[configKey] and H.Config[configKey][optName] == true)
                    else
                        isSelected = (H.Config[configKey] == optName)
                    end
                    btnData.Check.Text = isSelected and "✓" or ""
                    btnData.Btn.BackgroundColor3 = isSelected and Color3.fromRGB(32, 38, 54) or Color3.fromRGB(26, 29, 40)
                end
            end

            for _, opt in ipairs(optionsList) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Name = opt
                OptBtn.Parent = ItemsScroll
                OptBtn.BackgroundColor3 = Color3.fromRGB(26, 29, 40)
                OptBtn.Size = UDim2.new(1, 0, 0, 32)
                OptBtn.Text = "   " .. opt
                OptBtn.Font = Enum.Font.GothamMedium
                OptBtn.TextColor3 = Color3.fromRGB(225, 230, 240)
                OptBtn.TextSize = 12
                OptBtn.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 6)

                local CheckMark = Instance.new("TextLabel")
                CheckMark.Parent = OptBtn
                CheckMark.BackgroundTransparency = 1
                CheckMark.Position = UDim2.new(1, -28, 0, 0)
                CheckMark.Size = UDim2.new(0, 24, 1, 0)
                CheckMark.Font = Enum.Font.GothamBold
                CheckMark.Text = ""
                CheckMark.TextColor3 = Color3.fromRGB(88, 145, 255)
                CheckMark.TextSize = 13

                OptionButtons[opt] = { Btn = OptBtn, Check = CheckMark }

                OptBtn.MouseButton1Click:Connect(function()
                    if isMulti then
                        H.Config[configKey] = H.Config[configKey] or {}
                        H.Config[configKey][opt] = not H.Config[configKey][opt]
                    else
                        H.Config[configKey] = opt
                    end
                    RefreshOptions()
                    if callback then task.spawn(callback, H.Config[configKey]) end
                end)
            end

            RefreshOptions()

            DropSearch:GetPropertyChangedSignal("Text"):Connect(function()
                local q = string.lower(DropSearch.Text)
                for optName, btnData in pairs(OptionButtons) do
                    btnData.Btn.Visible = (q == "" or string.find(string.lower(optName), q, 1, true) ~= nil)
                end
            end)

            local isOpen = false
            SelectBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                Card.Size = isOpen and UDim2.new(1, 0, 0, 240) or UDim2.new(1, 0, 0, 58)
            end)

            return { Refresh = RefreshOptions }
        end

        function TabObj:AddButton(titleText, subText, callback)
            local BtnCard = Instance.new("TextButton")
            BtnCard.Parent = Page
            BtnCard.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
            BtnCard.Size = UDim2.new(1, 0, 0, subText ~= "" and 54 or 42)
            BtnCard.Text = ""
            BtnCard.AutoButtonColor = false
            Instance.new("UICorner", BtnCard).CornerRadius = UDim.new(0, 8)
            local Stroke = Instance.new("UIStroke", BtnCard)
            Stroke.Color = Color3.fromRGB(34, 38, 50)

            local Key = Instance.new("StringValue", BtnCard)
            Key.Name = "SearchKey"
            Key.Value = titleText .. " " .. (subText or "")

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Parent = BtnCard
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Position = UDim2.new(0, 14, 0, subText ~= "" and 8 or 12)
            TitleLbl.Size = UDim2.new(1, -45, 0, 18)
            TitleLbl.Font = Enum.Font.GothamBold
            TitleLbl.Text = titleText
            TitleLbl.TextColor3 = Color3.fromRGB(240, 240, 248)
            TitleLbl.TextSize = 13
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left

            if subText and subText ~= "" then
                local SubLbl = Instance.new("TextLabel")
                SubLbl.Parent = BtnCard
                SubLbl.BackgroundTransparency = 1
                SubLbl.Position = UDim2.new(0, 14, 0, 28)
                SubLbl.Size = UDim2.new(1, -45, 0, 16)
                SubLbl.Font = Enum.Font.Gotham
                SubLbl.Text = subText
                SubLbl.TextColor3 = Color3.fromRGB(130, 138, 156)
                SubLbl.TextSize = 11
                SubLbl.TextXAlignment = Enum.TextXAlignment.Left
            end

            local Arrow = Instance.new("TextLabel")
            Arrow.Parent = BtnCard
            Arrow.BackgroundTransparency = 1
            Arrow.Position = UDim2.new(1, -30, 0, 0)
            Arrow.Size = UDim2.new(0, 20, 1, 0)
            Arrow.Font = Enum.Font.GothamBold
            Arrow.Text = ">"
            Arrow.TextColor3 = Color3.fromRGB(150, 158, 175)
            Arrow.TextSize = 14

            BtnCard.MouseButton1Click:Connect(function()
                if callback then task.spawn(callback) end
            end)
        end

        function TabObj:AddStatusCard(titleText, defaultVal, statusKey)
            local Card = Instance.new("Frame")
            Card.Parent = Page
            Card.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
            Card.Size = UDim2.new(1, 0, 0, 56)
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)
            local Stroke = Instance.new("UIStroke", Card)
            Stroke.Color = Color3.fromRGB(34, 38, 50)

            local Key = Instance.new("StringValue", Card)
            Key.Name = "SearchKey"
            Key.Value = titleText

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Parent = Card
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Position = UDim2.new(0, 14, 0, 9)
            TitleLbl.Size = UDim2.new(1, -28, 0, 18)
            TitleLbl.Font = Enum.Font.GothamBold
            TitleLbl.Text = titleText
            TitleLbl.TextColor3 = Color3.fromRGB(240, 240, 248)
            TitleLbl.TextSize = 13
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left

            local ValLbl = Instance.new("TextLabel")
            ValLbl.Parent = Card
            ValLbl.BackgroundTransparency = 1
            ValLbl.Position = UDim2.new(0, 14, 0, 29)
            ValLbl.Size = UDim2.new(1, -28, 0, 18)
            ValLbl.Font = Enum.Font.Gotham
            ValLbl.Text = defaultVal
            ValLbl.TextColor3 = Color3.fromRGB(140, 148, 168)
            ValLbl.TextSize = 11
            ValLbl.TextXAlignment = Enum.TextXAlignment.Left

            if statusKey then
                H.StatusLabels[statusKey] = ValLbl
            end
            return ValLbl
        end

        return TabObj
    end
end

-- ==============================================================================
-- // PHẦN 2: DỰNG GIAO DIỆN TAB STATUS, FARM SETTINGS & MAIN //
-- ==============================================================================
do
    H.TabStatus = H:CreateTab("Status", "Character progress and server information.")
    H.TabFarmSettings = H:CreateTab("Farm Settings", "Combat and farming preferences.")
    H.TabMain = H:CreateTab("Main", "Farming and progression.")
    H.TabMultiFarm = H:CreateTab("Multi Farm", "Combine farming targets and activities.")
    H.TabQuests = H:CreateTab("Quests", "Quest completion and special unlocks.")
    H.TabItems = H:CreateTab("Items", "Collect and manage equipment and materials.")

    local TStatus = H.TabStatus
    TStatus:AddStatusCard("Place Id", tostring(game.PlaceId), "PlaceId")
    TStatus:AddStatusCard("Session Time", "0 Minute(s), 0 Second(s)", "SessionTime")
    TStatus:AddStatusCard("Server Age", "0 Hr(s), 0 Min(s), 0 Sec(s)", "ServerAge")
    TStatus:AddSection("Local Stats")
    TStatus:AddStatusCard("Elite Progress", "N/A", "EliteProgress")
    TStatus:AddStatusCard("Ken Level", "N/A", "KenLevel")
    TStatus:AddStatusCard("Cake Prince", "N/A", "CakePrince")
    TStatus:AddStatusCard("Mystic Island", "N/A", "MysticIsland")
    TStatus:AddStatusCard("Moon Status", "Phase: 4/8 | 0 Sec", "MoonStatus")
    TStatus:AddStatusCard("Prehistoric Island", "N/A", "PrehistoricIsland")
    TStatus:AddStatusCard("Spy Status", "N/A", "SpyStatus")
    TStatus:AddStatusCard("Awakened Bosses", "Auto Awakened Bosses is off", "AwakenedBosses")
    TStatus:AddStatusCard("Race Tier", "N/A", "RaceTier")
    TStatus:AddStatusCard("Pull Lever", "❌", "PullLever")

    local TFarm = H.TabFarmSettings
    TFarm:AddDropdown("Select Weapon", "Choose which weapon type...", "SelectWeapon", {"Melee", "Sword", "Gun", "Blox Fruit"}, false)
    TFarm:AddSection("Character Settings")
    TFarm:AddToggle("Auto Use Buso", "Auto-activates Buso (Armament) Haki.", "AutoBuso")
    TFarm:AddToggle("Auto Use Ken", "Auto-activates Ken (Observation) Haki to...", "AutoKen")
    TFarm:AddSection("Race Ability Settings")
    TFarm:AddToggle("Auto Turn On Race V3", "Auto-activates your V3 race ability.", "AutoRaceV3")
    TFarm:AddToggle("Auto Turn On Race V4", "Auto-activates your V4 race transformation...", "AutoRaceV4")
    TFarm:AddSection("Farm Settings")
    TFarm:AddToggle("Remove Notify Text", "Hides the game's in-game notification popups.", "RemoveNotify")
    TFarm:AddToggle("Bring Mob", "Pulls nearby mobs to you while farming.", "BringMob")
    TFarm:AddToggle("Allow Attack M1 Fruits", "Uses your Blox Fruit's M1 (left-click) to attack...", "AttackM1Fruit")
    TFarm:AddToggle("Allow Dragonstorm Attack", "Uses the Dragonstorm gun to attack; requires...", "AttackDragonstorm")
    TFarm:AddToggle("Allow Soul Guitar Attack", "Shoots with the Soul Guitar; needs the guitar...", "AttackSoulGuitar")
    TFarm:AddToggle("Allow Attack Players", "Also attacks nearby players while farming.", "AttackPlayers")
    TFarm:AddSlider("Tween Speed", "Travel speed of the farm tween (studs/sec). Lower =...", "TweenSpeed", 50, 350)
    TFarm:AddToggle("Bypass Teleport", "Crosses the map by setting your spawn point...", "BypassTeleport")
    TFarm:AddToggle("Fast Teleport", "Warp across the map through island...", "FastTeleport")
    TFarm:AddSection("Mastery Skill Settings")
    TFarm:AddDropdown("Select Skill", "Pick which skill keys...", "MasterySkills", {"Z", "X", "C", "V", "F"}, true)
    TFarm:AddToggle("Holding", "Holds skill keys for the set duration instead of...", "HoldingSkill")
    TFarm:AddSlider("Hold Z", "Seconds to hold skill Z (0 = tap).", "HoldZ", 0, 5)
    TFarm:AddSlider("Hold X", "Seconds to hold skill X (0 = tap).", "HoldX", 0, 5)
    TFarm:AddSlider("Hold C", "Seconds to hold skill C (0 = tap).", "HoldC", 0, 5)
    TFarm:AddSlider("Hold V", "Seconds to hold skill V (0 = tap).", "HoldV", 0, 5)
    TFarm:AddSection("Distance Settings")
    TFarm:AddSlider("Distance X", "X-axis offset from the target while farming.", "DistanceX", -30, 30)
    TFarm:AddSlider("Distance Y", "Y-axis (height) offset from the target while farming.", "DistanceY", -30, 30)
    TFarm:AddSlider("Distance Z", "Z-axis offset from the target while farming.", "DistanceZ", -30, 30)

    local TMain = H.TabMain
    TMain:AddToggle("Auto Farm Level", "Automatically farms mobs to level up your...", "AutoFarmLevel")
    TMain:AddSection("Secret Quests")
    TMain:AddToggle("Auto Secret Quests", "Completes available Secret Quests until...", "AutoSecretQuests")

    local SecretQuestList = {
        "Auto",
        "Middle Town | Early Access", "Middle Town | Lookout Duty", "Middle Town | X Marks the Spot",
        "Jungle | Zipline Repair", "Jungle | The Thieving Monkey", "Jungle | Awakened Gorilla King",
        "Pirate Village | Free the Windmill", "Pirate Village | Tavern Brawl", "Pirate Village | Awakened Chef",
        "Desert | Save Hasan", "Desert | Rune Cleanup", "Desert | Prickly Harvest",
        "Frozen Village | Breaking the Ice", "Frozen Village | Build A Snowman", "Frozen Village | Awakened Yeti",
        "Marine Fortress | Raise the Flag", "Marine Fortress | Pirate Raid", "Marine Fortress | Awakened Vice Admiral",
        "Lower Skylands | Missing Lightning Bolt", "Lower Skylands | Return the Treasure", "Lower Skylands | Unexpected Guest",
        "Prison | Prison Break", "Prison | Mysterious Key", "Prison | Awakened Warden",
        "Colosseum | Gladiatorial Combat", "Colosseum | Previous Champions", "Colosseum | Crowded Colosseum",
        "Magma Village | Magma Nest", "Magma Village | Magma Ore Extraction", "Magma Village | Awakened Magma General",
        "Underwater City | Ride the Bubble", "Underwater City | Scattered Light", "Underwater City | Awakened Fishman Lord",
        "Upper Skylands | The Old Temple", "Upper Skylands | Awakened Sky Warlord", "Upper Skylands | Awakened Lightning God",
        "Fountain City | Pipe Repairs", "Fountain City | Sewer Gang", "Fountain City | Awakened Cyborg"
    }
    TMain:AddDropdown("Secret Quest", "Auto follows quest progressi...", "SelectedSecretQuest", SecretQuestList, false)
    TMain:AddStatusCard("Secret Quest Status", "0/39 | Released 0/39 | Secret Quests | Auto Secret Quests is off", "SecretQuestStatus")

    TMain:AddSection("Awakened Bosses")
    TMain:AddToggle("Auto Awakened Bosses", "Travels to Sea 1, completes the active boss...", "AutoAwakenedBosses")
    local AwakenedBossList = {"Gorilla King", "Chef", "Yeti", "Vice Admiral", "Warden", "Magma General", "Fishman Lord", "Sky Warlord", "Lightning God", "Cyborg"}
    local AwkDrop = TMain:AddDropdown("Select...", "Choose which Awakened Bosses...", "SelectedAwakenedBosses", AwakenedBossList, true)
    TMain:AddButton("Select All Awakened Bosses", "", function()
        for _, b in ipairs(AwakenedBossList) do H.Config.SelectedAwakenedBosses[b] = true end
        AwkDrop.Refresh()
    end)
    TMain:AddButton("Clear Awakened Boss Selection", "", function()
        H.Config.SelectedAwakenedBosses = {}
        AwkDrop.Refresh()
    end)
    TMain:AddDropdown("Awakened Boss Mode", "Choose farming mode...", "AwakenedBossMode", {"Farm Repeatedly", "Unfinished Only"}, false)
    TMain:AddToggle("Hop For Selected Awakened Bosses", "Changes server only when a fresh boss hint...", "HopAwakenedBosses")
    TMain:AddStatusCard("Awakened Boss Status", "Auto Awakened Bosses is off", "MainAwakenedBossStatus")

    TMain:AddSection("Word Quest")
    TMain:AddToggle("Auto Dressrosa Quest", "Automatically completes the Dressrosa (World...", "AutoDressrosa")
    TMain:AddToggle("Auto Zou Quest", "Automatically completes the Zou (World 3)...", "AutoZou")

    TMain:AddSection("Arena")
    TMain:AddToggle("Auto Fish Slap Minigame", "Automatically plays the Fish Slap arena...", "AutoFishSlap")

    TMain:AddSection("Fishing")
    local BaitList = {"None", "Abyssal Bait", "Basic Bait", "Carnivore Bait", "Epic Bait", "Good Bait", "Kelp Bait", "Frozen Bait"}
    TMain:AddDropdown("Select Bait", "Selects which fishing bait to...", "SelectBait", BaitList, false)
    TMain:AddToggle("Auto Buy Bait", "Automatically buys fishing bait.", "AutoBuyBait")
    TMain:AddToggle("Auto Sell Fish", "Automatically sells caught fish.", "AutoSellFish")
    TMain:AddToggle("Auto Fishing", "Automatically fishes at your set position.", "AutoFishing")
    TMain:AddToggle("Auto Accept Angler Quest", "Accepts a new Angler quest when available...", "AutoAcceptAngler")
    TMain:AddToggle("Auto Complete Angler Quest", "Fishes, uses charged rod skills and claims...", "AutoCompleteAngler")
    TMain:AddToggle("Auto Use Rod Skill", "Uses the equipped fishing rod's skill at full...", "AutoUseRodSkill")
    TMain:AddButton("Set Fishing Position", "Saves your current position as the auto-fishing spot.", function()
        if H.LocalPlayer.Character and H.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            H.Config.FishingPos = H.LocalPlayer.Character.HumanoidRootPart.CFrame
        end
    end)

    TMain:AddSection("Tyrant")
    TMain:AddToggle("Auto Farm Tyrant", "Automatically farms the Tyrant (bird) boss.", "AutoFarmTyrant")
    TMain:AddToggle("Escape Tyrant Skills", "Dodges Tyrant skill animations, then resumes.", "EscapeTyrantSkills")
    TMain:AddDropdown("Tyrant Weapon Mode", "Single Weapon keeps the...", "TyrantWeaponMode", {"Single Weapon", "Rotate Weapons"}, false)
    TMain:AddDropdown("Jar Combat Settings", "Choose Farm Settings or the...", "JarCombatSettings", {"Farm Settings", "Tyrant Settings"}, false)
    TMain:AddDropdown("Boss Combat Settings", "Choose Farm Settings...", "BossCombatSettings", {"Farm Settings", "Tyrant Settings"}, false)
    TMain:AddDropdown("Select Tyrant Weapon", "Shared by jars and the boss...", "SelectTyrantWeapon", {"Melee", "Sword", "Gun", "Blox Fruit"}, false)
    TMain:AddDropdown("Select Tyrant Skill", "Pick skill keys...", "SelectTyrantSkill", {"Z", "X", "C", "V"}, true)

    TMain:AddSection("Cake Prince")
    TMain:AddToggle("Auto Farm Dough Boss", "Automatically farms the Dough boss.", "AutoFarmDoughBoss")
    TMain:AddToggle("Farm Cake Quest", "Automatically farms the Cake Land quest.", "FarmCakeQuest")
    TMain:AddToggle("Auto Spawn Boss", "Automatically spawns the Cake Prince boss.", "AutoSpawnCakeBoss")
    TMain:AddToggle("Auto Trade Sweet Chalice", "Automatically trades in the Sweet Chalice.", "AutoTradeSweetChalice")

    TMain:AddSection("Bone")
    TMain:AddToggle("Auto Farm Bone", "Automatically farms Bones.", "AutoFarmBone")
    TMain:AddToggle("Farm Bone Quest", "Automatically farms the Bone quest.", "FarmBoneQuest")

    TMain:AddSection("Mastery")
    TMain:AddDropdown("Select Method", "Selects the mastery farming...", "MasteryMethod", {"Cake", "Bone", "Level"}, false)
    TMain:AddSlider("Kill At", "Sets the enemy HP percentage at which to finish it off.", "KillAtHP", 1, 100)
    TMain:AddToggle("Auto Farm Gun Mastery", "Automatically farms gun mastery.", "AutoFarmGunMastery")
    TMain:AddToggle("Auto Farm Fruit Mastery", "Automatically farms Devil Fruit mastery.", "AutoFarmFruitMastery")

    TMain:AddSection("Boss")
    local BossList = {"None", "Fishman Lord", "Mob Leader", "Chef", "Gorilla King", "Mob Boss", "Yeti", "Cyborg", "Vice Admiral", "Warden", "Magma General", "Lightning God", "Saber Expert", "Sky Warlord"}
    TMain:AddDropdown("Select Boss", "Selects which bosses to...", "SelectedBoss", BossList, false)
    TMain:AddToggle("Auto Farm Boss", "Automatically farms the selected bosses.", "AutoFarmBoss")
    TMain:AddToggle("Auto Accept Boss Quest", "Automatically accepts boss quests.", "AutoAcceptBossQuest")

    TMain:AddSection("Chest")
    TMain:AddToggle("Auto Farm Chest", "Automatically collects chests around the map.", "AutoFarmChest")
    TMain:AddToggle("Hop Farm Chest", "Server-hops to farm chests continuously.", "HopFarmChest")

    TMain:AddSection("Mob")
    TMain:AddToggle("Mob Aura", "Automatically attacks all nearby mobs.", "MobAura")

    H.TabMain.Activate()
end

-- ==============================================================================
-- // PHẦN 3: DỰNG GIAO DIỆN TAB MULTI FARM, QUESTS & ITEMS //
-- ==============================================================================
do
    local TMulti = H.TabMultiFarm
    TMulti:AddSection("Main World2")
    TMulti:AddToggle("Auto Farm Factory", "Automatically farms the Factory.", "AutoFarmFactory")
    TMulti:AddSection("Darkbeard")
    TMulti:AddToggle("Auto Farm Darkbeard", "Automatically farms the Darkbeard boss.", "AutoFarmDarkbeard")
    TMulti:AddToggle("Find Chest Farm Darkbeard", "Farms chests to find where Darkbeard spawns.", "FindChestDarkbeard")
    TMulti:AddToggle("Hop Farm Darkbeard", "Hops servers to keep farming Darkbeard.", "HopFarmDarkbeard")

    TMulti:AddSection("Main World3")
    TMulti:AddToggle("Auto Castle Raid", "Automatically farms mobs at the Castle raid.", "AutoCastleRaid")
    TMulti:AddSection("Elite Quest")
    TMulti:AddToggle("Auto Farm Elite Hunter", "Automatically farms Elite enemies.", "AutoFarmEliteHunter")
    TMulti:AddToggle("Hop Farm Elite Hunter", "Server-hops while farming Elite Hunters.", "HopFarmEliteHunter")
    TMulti:AddToggle("Stop Hop While Have God's Chalice", "Stops server-hopping once you have the God's...", "StopHopGodChalice")

    TMulti:AddSection("Soul Reaper")
    TMulti:AddToggle("Auto Farm Soul Reaper", "Automatically farms the Soul Reaper boss.", "AutoFarmSoulReaper")
    TMulti:AddToggle("Auto Spawn Soul Reaper", "Automatically spawns the Soul Reaper boss.", "AutoSpawnSoulReaper")
    TMulti:AddToggle("Hop Farm Soul Reaper", "Hops servers to keep farming Soul Reaper.", "HopFarmSoulReaper")

    TMulti:AddSection("Fighting Styles")
    TMulti:AddToggle("Auto Get Superhuman", "Automatically unlocks the Superhuman...", "AutoSuperhuman")
    TMulti:AddToggle("Auto Get Death Step", "Automatically unlocks the Death Step fighting...", "AutoDeathStep")
    TMulti:AddToggle("Auto Get Sharkman Karate", "Automatically unlocks the Sharkman Karate...", "AutoSharkmanKarate")
    TMulti:AddToggle("Auto Get Electric Claw", "Automatically unlocks the Electric Claw...", "AutoElectricClaw")
    TMulti:AddToggle("Auto Get Dragon Talon", "Automatically unlocks the Dragon Talon...", "AutoDragonTalon")
    TMulti:AddToggle("Auto Get Godhuman", "Automatically unlocks the Godhuman fighting...", "AutoGodhuman")

    TMulti:AddSection("Stats")
    TMulti:AddDropdown("Select Stats", "Selects which stats to...", "SelectedStats", {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}, true)
    TMulti:AddToggle("Auto Stats", "Automatically spends points on the selected...", "AutoStats")

    local TQuests = H.TabQuests
    TQuests:AddSection("Bartilo Quest")
    TQuests:AddToggle("Auto Bartilo Quest", "Automatically completes the Bartilo quest.", "AutoBartilo")
    TQuests:AddSection("Dragon Quest")
    TQuests:AddToggle("Auto Dojo Quest", "Automatically completes the Dojo quest.", "AutoDojoQuest")
    TQuests:AddToggle("Keep Sailing During Dojo Training", "Keeps sailing beyond Beyond The Horizon...", "KeepSailingDojo")
    TQuests:AddToggle("Auto Dragon Hunter", "Automatically farms fireballs for the Dragon...", "AutoDragonHunter")
    TQuests:AddSection("Ken")
    TQuests:AddToggle("Auto Upgrade Ken V2", "Automatically upgrades Observation Haki...", "AutoUpgradeKenV2")
    TQuests:AddToggle("Auto Farm Ken", "Automatically farms Observation Haki (Ken)...", "AutoFarmKen")
    TQuests:AddToggle("Rejoin Farm Ken", "Rejoins the server to keep farming Ken.", "RejoinFarmKen")
    TQuests:AddSection("Rainbow Haki")
    TQuests:AddToggle("Auto Rainbow Haki Quest", "Automatically completes the Rainbow Haki...", "AutoRainbowHaki")
    TQuests:AddSection("Citizen Quest")
    TQuests:AddToggle("Auto Citizen Quest", "Automatically completes the Citizen quest for...", "AutoCitizenQuest")

    local TItems = H.TabItems
    TItems:AddSection("World 3")
    TItems:AddToggle("Auto Get Skull Guitar", "Automatically gets the Skull Guitar.", "AutoSkullGuitar")
    TItems:AddToggle("Auto Get CDK", "Automatically gets the Cursed Dual Katana.", "AutoCDK")
    TItems:AddToggle("Auto Get Yama", "Automatically gets the Yama sword.", "AutoYama")
    TItems:AddToggle("Auto Get Tushita", "Automatically gets the Tushita sword.", "AutoTushita")
    TItems:AddSection("World 1")
    TItems:AddToggle("Auto Get Saber", "Automatically gets the Saber sword.", "AutoSaber")
    TItems:AddSection("World 2")
    TItems:AddToggle("Auto Get True Triple Katana", "Trains owned Saddi, Oroshi and Shizu to 300...", "AutoTTK")
    TItems:AddToggle("Auto Rengoku", "Automatically gets the Rengoku sword.", "AutoRengoku")
    TItems:AddToggle("Auto Midnight Blade", "Automatically gets the Midnight Blade using...", "AutoMidnightBlade")
    TItems:AddSection("Indra Boss")
    TItems:AddToggle("Auto Rip Indra", "Automatically fights the Indra admin boss.", "AutoRipIndra")
    TItems:AddToggle("Auto Touch Haki Pad", "Automatically steps on the Haki color pads.", "AutoTouchHakiPad")
    TItems:AddToggle("Farm Elite Hunter", "Farms Elite Hunters to get trophies.", "ItemFarmElite")
    TItems:AddToggle("Hop Farm Elite Hunter", "Server-hops while farming Elite Hunters.", "ItemHopElite")
    TItems:AddSection("Upgrade Weapon")
    TItems:AddToggle("Auto Upgrade Sword Inventory", "Automatically upgrades the swords in your...", "AutoUpgradeSword")
    TItems:AddToggle("Auto Upgrade Gun Inventory", "Automatically upgrades the guns in your...", "AutoUpgradeGun")
    TItems:AddToggle("Auto Farm Upgrade Materials", "Farms missing materials for enabled...", "AutoFarmUpgradeMat")
    TItems:AddSection("Mastery")
    TItems:AddToggle("Auto Farm Inventory Items Mastery", "Automatically trains owned swords and guns...", "AutoInventoryMastery")
    TItems:AddSection("Pay")
    TItems:AddToggle("Auto Random Bone", "Automatically buys Random Bone from the...", "AutoRandomBone")
    TItems:AddSection("Legend NPC")
    TItems:AddToggle("Auto Buy Haki Color", "Automatically buys Haki color from the dealer.", "AutoBuyHakiColor")
    TItems:AddToggle("Auto Buy Legendary Sword", "Automatically buys the Legendary Sword from...", "AutoBuyLegSword")
    TItems:AddSection("Craft")
    TItems:AddToggle("Auto Craft Shark Anchor", "Automatically crafts the Shark Anchor.", "AutoCraftSharkAnchor")
    TItems:AddToggle("Auto Craft Volcanic Magnet", "Automatically crafts the Volcanic Magnet.", "AutoCraftVolcanicMagnet")
    TItems:AddSection("Berry")
    TItems:AddToggle("Auto Farm Berry", "Automatically farms Berries.", "AutoFarmBerry")
    TItems:AddToggle("Hop Farm Berry", "Server-hops while farming Berries.", "HopFarmBerry")
    TItems:AddSection("Materials")
    TItems:AddDropdown("Select Materials", "Selects which material to...", "SelectedMaterial", {"None", "Leather", "Scrap Metal", "Angel Wings", "Magma Ore", "Fish Tail", "Mystic Droplet", "Vampire Fang", "Demonic Wisp", "Dragon Scale", "Conjured Cocoa", "Mini Tusk"}, false)
    TItems:AddToggle("Auto Farm Materials", "Automatically farms the selected material.", "AutoFarmMaterials")
    TItems:AddToggle("Auto Farm Ectoplasm", "Automatically farms Ectoplasm.", "AutoFarmEctoplasm")
end

-- ==============================================================================
-- // PHẦN 4: HỆ THỐNG STATUS, REMOTE, NHẬN DIỆN SEA CHUẨN & SERVER HOP //
-- ==============================================================================
do
    H.StartTime = os.time()

    -- Nhận diện Sea chuẩn xác cho mọi sub-place của Blox Fruits v30+
    local pid = game.PlaceId
    H.CurrentSea = 1
    if pid == 4442272183 or pid == 79091703265657 then
        H.CurrentSea = 2
    elseif pid == 7449423635 or pid == 100117331123089 then
        H.CurrentSea = 3
    end

    H.LocalPlayer.Idled:Connect(function()
        pcall(function()
            H.Services.VirtualUser:CaptureController()
            H.Services.VirtualUser:ClickButton2(Vector2.new())
        end)
    end)

    function H:InvokeCommF(...)
        local args = {...}
        local ok, res = pcall(function()
            local rem = H.Services.ReplicatedStorage:WaitForChild("Remotes", 3)
            local comm = rem and rem:FindFirstChild("CommF_")
            if comm then
                return comm:InvokeServer(unpack(args))
            end
        end)
        return ok and res or nil
    end

    function H:HasItem(itemName)
        local bp = H.LocalPlayer:FindFirstChild("Backpack")
        local char = H.LocalPlayer.Character
        if bp and bp:FindFirstChild(itemName) then return true end
        if char and char:FindFirstChild(itemName) then return true end
        return false
    end

    H.IsHopping = false
    function H:HopServer()
        if H.IsHopping then return end
        if H.Config.StopHopGodChalice and (H:HasItem("God's Chalice") or H:HasItem("Sweet Chalice")) then
            return
        end
        H.IsHopping = true
        task.spawn(function()
            local cursor = ""
            for _ = 1, 4 do
                local ok, res = pcall(function()
                    local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Desc&limit=100"
                    if cursor ~= "" then url = url .. "&cursor=" .. cursor end
                    return H.Services.HttpService:JSONDecode(game:HttpGet(url))
                end)
                if ok and res and res.data then
                    for _, srv in ipairs(res.data) do
                        if type(srv) == "table" and tonumber(srv.playing) and tonumber(srv.maxPlayers) then
                            if srv.playing < (srv.maxPlayers - 1) and srv.id ~= game.JobId then
                                pcall(function()
                                    H.Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, H.LocalPlayer)
                                end)
                                task.wait(2.5)
                            end
                        end
                    end
                    if res.nextPageCursor then cursor = res.nextPageCursor else break end
                else
                    break
                end
                task.wait(0.4)
            end
            task.wait(3)
            H.IsHopping = false
        end)
    end

    task.spawn(function()
        while H.RunId == CurrentRunId and task.wait(1) do
            if not H.ScreenGui or not H.ScreenGui.Parent then break end
            pcall(function()
                local elapsed = os.time() - H.StartTime
                if H.StatusLabels.SessionTime then
                    H.StatusLabels.SessionTime.Text = string.format("%d Minute(s), %d Second(s)", math.floor(elapsed / 60), elapsed % 60)
                end

                local srvTime = math.floor(H.Services.Workspace.DistributedGameTime)
                if H.StatusLabels.ServerAge then
                    H.StatusLabels.ServerAge.Text = string.format("%d Hr(s), %d Min(s), %d Sec(s)", math.floor(srvTime / 3600), math.floor((srvTime % 3600) / 60), srvTime % 60)
                end

                local awkText = H.Config.AutoAwakenedBosses and "Running Auto Awakened Bosses..." or "Auto Awakened Bosses is off"
                if H.StatusLabels.AwakenedBosses then H.StatusLabels.AwakenedBosses.Text = awkText end
                if H.StatusLabels.MainAwakenedBossStatus then H.StatusLabels.MainAwakenedBossStatus.Text = awkText end

                if H.StatusLabels.SecretQuestStatus then
                    local sqState = H.Config.AutoSecretQuests and ("Running (" .. tostring(H.Config.SelectedSecretQuest) .. ")") or "Auto Secret Quests is off"
                    H.StatusLabels.SecretQuestStatus.Text = "0/39 | Released 0/39 | Secret Quests | " .. sqState
                end

                local data = H.LocalPlayer:FindFirstChild("Data")
                if data and data:FindFirstChild("Race") and H.StatusLabels.RaceTier then
                    H.StatusLabels.RaceTier.Text = tostring(data.Race.Value)
                end
            end)
        end
    end)
end

-- ==============================================================================
-- // PHẦN 5: HỆ THỐNG TWEEN CFRAME CHUẨN, ĐA NGÔN NGỮ VŨ KHÍ & FAST ATTACK //
-- ==============================================================================
do
    H.ActiveTween = nil
    H.ActiveTweenPart = nil
    H.LastTweenGoal = nil

    function H:IsAnyFarmActive()
        local c = H.Config
        return c.AutoFarmLevel or c.AutoSecretQuests or c.AutoAwakenedBosses or c.AutoDressrosa
            or c.AutoZou or c.AutoFarmTyrant or c.AutoFarmDoughBoss or c.FarmCakeQuest
            or c.AutoFarmBone or c.FarmBoneQuest or c.AutoFarmGunMastery or c.AutoFarmFruitMastery
            or c.AutoFarmBoss or c.AutoFarmChest or c.HopFarmChest or c.MobAura
            or c.AutoFarmFactory or c.AutoFarmDarkbeard or c.FindChestDarkbeard
            or c.AutoCastleRaid or c.AutoFarmEliteHunter or c.ItemFarmElite
            or c.AutoFarmSoulReaper or c.AutoBartilo or c.AutoDojoQuest
            or c.AutoRainbowHaki or c.AutoCitizenQuest or c.AutoSkullGuitar
            or c.AutoCDK or c.AutoYama or c.AutoTushita or c.AutoSaber
            or c.AutoRengoku or c.AutoRipIndra or c.AutoFarmBerry
            or c.AutoFarmMaterials or c.AutoFarmEctoplasm or c.AutoFishing
    end

    -- Noclip + Giữ nhân vật lơ lửng không bị rơi tự do khi đang Farm
    H.Services.RunService.Stepped:Connect(function()
        if H.RunId ~= CurrentRunId then return end
        local char = H.LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")

        if H:IsAnyFarmActive() then
            if hum then
                if hum.Sit then hum.Sit = false end
                hum.PlatformStand = false
            end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
            if hrp then
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
                local bv = hrp:FindFirstChild("Hzayday_Velocity")
                if not bv then
                    bv = Instance.new("BodyVelocity")
                    bv.Name = "Hzayday_Velocity"
                    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                    bv.Velocity = Vector3.zero
                    bv.Parent = hrp
                else
                    bv.Velocity = Vector3.zero
                end
            end
        else
            if hrp and hrp:FindFirstChild("Hzayday_Velocity") then
                hrp.Hzayday_Velocity:Destroy()
            end
            if H.ActiveTween then
                pcall(function() H.ActiveTween:Cancel() end)
                H.ActiveTween = nil
                H.ActiveTweenPart = nil
                H.LastTweenGoal = nil
            end
        end
    end)

    -- Hàm Tween Mới: Tự động nâng độ cao khi di chuyển xa và snap mượt mà khi tới gần
    function H:TweenTo(targetCF, applyOffset)
        local char = H.LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 or not targetCF then return false end

        local goalPos = targetCF.Position
        if applyOffset then
            goalPos = goalPos + Vector3.new(
                tonumber(H.Config.DistanceX) or 0,
                tonumber(H.Config.DistanceY) or 11,
                tonumber(H.Config.DistanceZ) or 0
            )
        end
        local goalCF = CFrame.new(goalPos)

        local dist = (hrp.Position - goalPos).Magnitude

        -- Khi đã áp sát mục tiêu (<= 22 studs) hoặc bật FastTeleport ở cự ly gần (<= 180 studs)
        if dist <= 22 or (H.Config.FastTeleport and dist <= 180) then
            if H.ActiveTween then
                pcall(function() H.ActiveTween:Cancel() end)
                H.ActiveTween = nil
            end
            hrp.CFrame = goalCF
            return true
        end

        -- Nếu đang bay mượt tới cùng toạ độ trên cùng 1 nhân vật thì giữ nguyên Tween
        if H.ActiveTween and H.ActiveTweenPart == hrp and H.LastTweenGoal and (H.LastTweenGoal - goalPos).Magnitude < 6 then
            if H.ActiveTween.PlaybackState == Enum.PlaybackState.Playing then
                return false
            end
        end

        if H.ActiveTween then
            pcall(function() H.ActiveTween:Cancel() end)
        end

        local speed = math.clamp(tonumber(H.Config.TweenSpeed) or 180, 60, 350)
        local duration = math.max(0.05, dist / speed)

        H.ActiveTweenPart = hrp
        H.LastTweenGoal = goalPos
        H.ActiveTween = H.Services.TweenService:Create(
            hrp,
            TweenInfo.new(duration, Enum.EasingStyle.Linear),
            { CFrame = goalCF }
        )
        H.ActiveTween:Play()
        return false
    end

    -- Nhận diện vũ khí đa ngôn ngữ (Tiếng Việt: Võ Tân Binh, Kiếm, Súng, Trái Ác Quỷ + Tiếng Anh)
    local WeaponKeywords = {
        ["Melee"] = { "melee", "cận chiến", "võ", "combat", "black leg", "electro", "fishman karate", "dragon breath", "superhuman", "death step", "sharkman karate", "electric claw", "dragon talon", "godhuman", "sanguine" },
        ["Sword"] = { "sword", "kiếm", "katana", "cutlass", "saber", "yama", "tushita", "cursed dual", "rengoku", "midnight", "shark anchor", "bisento", "pole", "pipe", "trident" },
        ["Gun"] = { "gun", "súng", "slingshot", "nạn", "musket", "flintlock", "kabucha", "acidum", "bizarre", "soul guitar", "skull guitar", "dragonstorm", "cannon" },
        ["Blox Fruit"] = { "blox fruit", "demon fruit", "trái ác quỷ", "trái", "fruit", "-" }
    }

    local function MatchTool(tool, wType)
        if not tool:IsA("Tool") then return false end
        local tip = string.lower(tool.ToolTip or "")
        local name = string.lower(tool.Name or "")
        local list = WeaponKeywords[wType]
        if not list then return false end

        for _, kw in ipairs(list) do
            if tip == kw or string.find(tip, kw, 1, true) or string.find(name, kw, 1, true) then
                return true
            end
        end
        return false
    end

    function H:EquipWeapon(overrideType)
        local wType = overrideType or H.Config.SelectWeapon or "Melee"
        if wType == "None" then return end

        local char = H.LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local bp = H.LocalPlayer:FindFirstChild("Backpack")
        if not char or not hum or hum.Health <= 0 or not bp then return end

        local current = char:FindFirstChildOfClass("Tool")
        if current and MatchTool(current, wType) then return end

        for _, tool in ipairs(bp:GetChildren()) do
            if MatchTool(tool, wType) then
                hum:EquipTool(tool)
                return
            end
        end

        if not current then
            local fallback = bp:FindFirstChildOfClass("Tool")
            if fallback then hum:EquipTool(fallback) end
        end
    end

    function H:UpdateCharacterBuffs()
        local char = H.LocalPlayer.Character
        if not char then return end

        if H.Config.AutoBuso and not char:FindFirstChild("HasBuso") then
            H:InvokeCommF("Buso")
        end
        if H.Config.AutoKen then
            pcall(function() H.Services.ReplicatedStorage.Remotes.CommE:FireServer("Ken", true) end)
        end
        if H.Config.AutoRaceV3 then
            pcall(function() H.Services.ReplicatedStorage.Remotes.CommE:FireServer("ActivateAbility") end)
        end
        if H.Config.AutoRaceV4 then
            local awk = H.LocalPlayer.Backpack:FindFirstChild("Awakening") or char:FindFirstChild("Awakening")
            if awk and awk:FindFirstChild("RemoteFunction") then
                pcall(function() awk.RemoteFunction:InvokeServer(true) end)
            end
        end

        local pgui = H.LocalPlayer:FindFirstChild("PlayerGui")
        local notif = pgui and pgui:FindFirstChild("Notifications")
        if notif then notif.Enabled = not H.Config.RemoveNotify end
    end

    local function CleanMobName(n)
        if not n then return "" end
        return (string.gsub(n, "%s*%[Lv%.%s*%d+%]", ""))
    end
    H.CleanMobName = CleanMobName

    -- Gom quái (Bring Mob) ngay dưới chân nhân vật để M1 & Skill trúng 100%
    function H:BringNearbyMobs(mobFilterName, targetCF)
        if not H.Config.BringMob or not targetCF then return end
        local enemies = H.Services.Workspace:FindFirstChild("Enemies")
        if not enemies then return end

        pcall(function()
            if sethiddenproperty then sethiddenproperty(H.LocalPlayer, "SimulationRadius", math.huge) end
        end)

        local cleanFilter = mobFilterName and CleanMobName(mobFilterName) or nil
        for _, mob in ipairs(enemies:GetChildren()) do
            local hum = mob:FindFirstChildOfClass("Humanoid")
            local hrp = mob:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local cleanMob = CleanMobName(mob.Name)
                local match = (not cleanFilter) or (cleanMob == cleanFilter) or (string.find(cleanMob, cleanFilter, 1, true) ~= nil)
                if match and (hrp.Position - targetCF.Position).Magnitude <= 300 then
                    hrp.CFrame = targetCF
                    hrp.CanCollide = false
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hum.WalkSpeed = 0
                    hum.JumpPower = 0
                    if hum:FindFirstChild("Animator") then hum.Animator:Destroy() end
                end
            end
        end
    end

    -- Đánh nhanh (Fast Attack Net v30.0.11 + Tool:Activate + VirtualUser)
    function H:AttackTarget(useSkillTable)
        local char = H.LocalPlayer.Character
        local myHRP = char and char:FindFirstChild("HumanoidRootPart")
        if not char or not myHRP then return end

        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            pcall(function() tool:Activate() end)
        end

        pcall(function()
            local modules = H.Services.ReplicatedStorage:FindFirstChild("Modules")
            local net = modules and modules:FindFirstChild("Net")
            if net then
                local regAttack = net:FindFirstChild("RE/RegisterAttack")
                local regHit = net:FindFirstChild("RE/RegisterHit")
                local enemies = H.Services.Workspace:FindFirstChild("Enemies")
                if enemies and regAttack and regHit then
                    local targets = {}
                    local basePart = nil
                    for _, mob in ipairs(enemies:GetChildren()) do
                        local hum = mob:FindFirstChildOfClass("Humanoid")
                        local hitPart = mob:FindFirstChild("Head") or mob:FindFirstChild("HumanoidRootPart")
                        if hum and hitPart and hum.Health > 0 and (hitPart.Position - myHRP.Position).Magnitude <= 65 then
                            basePart = basePart or hitPart
                            table.insert(targets, { mob, hitPart })
                        end
                    end
                    if basePart then
                        regAttack:FireServer(0)
                        regHit:FireServer(basePart, targets)
                    end
                end
            end
        end)

        pcall(function()
            H.Services.VirtualUser:CaptureController()
            H.Services.VirtualUser:ClickButton1(Vector2.new(600, 400))
        end)

        local skills = useSkillTable or H.Config.MasterySkills
        if type(skills) == "table" then
            local vim = game:GetService("VirtualInputManager")
            for keyName, enabled in pairs(skills) do
                if enabled and vim then
                    local holdTime = H.Config.HoldingSkill and (tonumber(H.Config["Hold" .. keyName]) or 0) or 0
                    pcall(function()
                        vim:SendKeyEvent(true, Enum.KeyCode[keyName], false, game)
                        if holdTime > 0 then task.wait(holdTime) end
                        vim:SendKeyEvent(false, Enum.KeyCode[keyName], false, game)
                    end)
                end
            end
        end
    end
end

-- ==============================================================================
-- // PHẦN 6: LOGIC TAB MAIN (AUTO FARM LEVEL, CHEST V30+, BOSS, MASTERY) //
-- ==============================================================================
do
    -- Tìm quái còn sống trong Workspace.Enemies
    function H:GetAliveEnemy(nameFilter)
        local enemies = H.Services.Workspace:FindFirstChild("Enemies")
        if not enemies then return nil end

        local closest, minDist = nil, math.huge
        local myPos = (H.LocalPlayer.Character and H.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and H.LocalPlayer.Character.HumanoidRootPart.Position) or Vector3.zero

        for _, mob in ipairs(enemies:GetChildren()) do
            local hum = mob:FindFirstChildOfClass("Humanoid")
            local hrp = mob:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local cleanMob = H.CleanMobName(mob.Name)
                local match = false

                if not nameFilter or nameFilter == "" then
                    match = true
                elseif type(nameFilter) == "string" then
                    local cleanFilter = H.CleanMobName(nameFilter)
                    match = (cleanMob == cleanFilter or string.find(cleanMob, cleanFilter, 1, true) ~= nil)
                elseif type(nameFilter) == "table" then
                    for k, v in pairs(nameFilter) do
                        if v and (cleanMob == k or string.find(cleanMob, k, 1, true) ~= nil) then
                            match = true
                            break
                        end
                    end
                end

                if match then
                    local d = (hrp.Position - myPos).Magnitude
                    if d < minDist then
                        minDist = d
                        closest = mob
                    end
                end
            end
        end
        return closest
    end

    -- Quét tuần tự danh sách điểm Spawn của quái để nhân vật bay vòng quanh bãi quái khi chờ quái hồi sinh
    H.SpawnCycleIndex = 1
    H.LastSpawnCycleTime = 0
    function H:GetMobSpawnCFrame(mobName, fallbackCF)
        if not mobName or mobName == "" then return fallbackCF end
        local cleanTarget = string.lower(H.CleanMobName(mobName))
        local spawnList = {}

        local wo = H.Services.Workspace:FindFirstChild("_WorldOrigin")
        local spawns = wo and wo:FindFirstChild("EnemySpawns")
        if spawns then
            for _, sp in ipairs(spawns:GetChildren()) do
                local cleanSp = string.lower(H.CleanMobName(sp.Name))
                if cleanSp == cleanTarget or string.find(cleanSp, cleanTarget, 1, true) then
                    local cf = sp:IsA("BasePart") and sp.CFrame or (sp:IsA("Model") and sp:GetPivot())
                    if cf then table.insert(spawnList, cf) end
                end
            end
        end

        if #spawnList > 0 then
            if os.clock() - H.LastSpawnCycleTime > 2.5 then
                H.SpawnCycleIndex = (H.SpawnCycleIndex % #spawnList) + 1
                H.LastSpawnCycleTime = os.clock()
            end
            return spawnList[math.clamp(H.SpawnCycleIndex, 1, #spawnList)]
        end

        for _, obj in ipairs(H.Services.ReplicatedStorage:GetChildren()) do
            if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
                local cleanObj = string.lower(H.CleanMobName(obj.Name))
                if cleanObj == cleanTarget or string.find(cleanObj, cleanTarget, 1, true) then
                    return obj.HumanoidRootPart.CFrame
                end
            end
        end

        return fallbackCF
    end

    -- Bảng dữ liệu Quest toàn diện cho cả 3 Sea
    local QuestDatabase = {
        -- SEA 1
        { Sea = 1, MinLv = 1, MaxLv = 9, QuestName = "BanditQuest1", QuestLv = 1, Mob = "Bandit", NPCPos = CFrame.new(1059, 16, 1549), MobPos = CFrame.new(1145, 17, 1634) },
        { Sea = 1, MinLv = 10, MaxLv = 14, QuestName = "JungleQuest", QuestLv = 1, Mob = "Monkey", NPCPos = CFrame.new(-1598, 36, 153), MobPos = CFrame.new(-1448, 50, 63) },
        { Sea = 1, MinLv = 15, MaxLv = 29, QuestName = "JungleQuest", QuestLv = 2, Mob = "Gorilla", NPCPos = CFrame.new(-1598, 36, 153), MobPos = CFrame.new(-1129, 40, -525) },
        { Sea = 1, MinLv = 30, MaxLv = 39, QuestName = "BuggyQuest1", QuestLv = 1, Mob = "Pirate", NPCPos = CFrame.new(-1140, 4, 3828), MobPos = CFrame.new(-1201, 40, 3905) },
        { Sea = 1, MinLv = 40, MaxLv = 59, QuestName = "BuggyQuest1", QuestLv = 2, Mob = "Brute", NPCPos = CFrame.new(-1140, 4, 3828), MobPos = CFrame.new(-1140, 55, 4322) },
        { Sea = 1, MinLv = 60, MaxLv = 74, QuestName = "DesertQuest", QuestLv = 1, Mob = "Desert Bandit", NPCPos = CFrame.new(894, 6, 4392), MobPos = CFrame.new(924, 7, 4481) },
        { Sea = 1, MinLv = 75, MaxLv = 89, QuestName = "DesertQuest", QuestLv = 2, Mob = "Desert Officer", NPCPos = CFrame.new(894, 6, 4392), MobPos = CFrame.new(1608, 9, 4371) },
        { Sea = 1, MinLv = 90, MaxLv = 99, QuestName = "SnowQuest", QuestLv = 1, Mob = "Snow Bandit", NPCPos = CFrame.new(1389, 87, -1298), MobPos = CFrame.new(1354, 87, -1393) },
        { Sea = 1, MinLv = 100, MaxLv = 119, QuestName = "SnowQuest", QuestLv = 2, Mob = "Snowman", NPCPos = CFrame.new(1389, 87, -1298), MobPos = CFrame.new(1201, 144, -1550) },
        { Sea = 1, MinLv = 120, MaxLv = 149, QuestName = "MarineQuest2", QuestLv = 1, Mob = "Chief Petty Officer", NPCPos = CFrame.new(-5039, 28, 4324), MobPos = CFrame.new(-4881, 22, 4273) },
        { Sea = 1, MinLv = 150, MaxLv = 174, QuestName = "SkyQuest", QuestLv = 1, Mob = "Sky Bandit", NPCPos = CFrame.new(-4839, 717, -2617), MobPos = CFrame.new(-4953, 295, -2899) },
        { Sea = 1, MinLv = 175, MaxLv = 189, QuestName = "SkyQuest", QuestLv = 2, Mob = "Dark Master", NPCPos = CFrame.new(-4839, 717, -2617), MobPos = CFrame.new(-5259, 391, -2229) },
        { Sea = 1, MinLv = 190, MaxLv = 209, QuestName = "PrisonerQuest", QuestLv = 1, Mob = "Prisoner", NPCPos = CFrame.new(5308, 2, 474), MobPos = CFrame.new(5098, -0, 474) },
        { Sea = 1, MinLv = 210, MaxLv = 249, QuestName = "PrisonerQuest", QuestLv = 2, Mob = "Dangerous Prisoner", NPCPos = CFrame.new(5308, 2, 474), MobPos = CFrame.new(5654, 15, 866) },
        { Sea = 1, MinLv = 250, MaxLv = 299, QuestName = "ColosseumQuest", QuestLv = 1, Mob = "Toga Warrior", NPCPos = CFrame.new(-1580, 7, -2986), MobPos = CFrame.new(-1820, 51, -2740) },
        { Sea = 1, MinLv = 300, MaxLv = 324, QuestName = "MagmaQuest", QuestLv = 1, Mob = "Military Soldier", NPCPos = CFrame.new(-5313, 12, 8515), MobPos = CFrame.new(-5411, 11, 8454) },
        { Sea = 1, MinLv = 325, MaxLv = 374, QuestName = "MagmaQuest", QuestLv = 2, Mob = "Military Spy", NPCPos = CFrame.new(-5313, 12, 8515), MobPos = CFrame.new(-5802, 86, 8828) },
        { Sea = 1, MinLv = 375, MaxLv = 399, QuestName = "FishmanQuest", QuestLv = 1, Mob = "Fishman Warrior", NPCPos = CFrame.new(61122, 18, 1569), MobPos = CFrame.new(60878, 18, 1543) },
        { Sea = 1, MinLv = 400, MaxLv = 449, QuestName = "FishmanQuest", QuestLv = 2, Mob = "Fishman Commando", NPCPos = CFrame.new(61122, 18, 1569), MobPos = CFrame.new(61922, 18, 1493) },
        { Sea = 1, MinLv = 450, MaxLv = 474, QuestName = "SkyExp1Quest", QuestLv = 1, Mob = "God's Guard", NPCPos = CFrame.new(-4721, 845, -1950), MobPos = CFrame.new(-4710, 845, -1927) },
        { Sea = 1, MinLv = 475, MaxLv = 524, QuestName = "SkyExp1Quest", QuestLv = 2, Mob = "Shanda", NPCPos = CFrame.new(-7859, 5545, -381), MobPos = CFrame.new(-7678, 5566, -497) },
        { Sea = 1, MinLv = 525, MaxLv = 549, QuestName = "SkyExp2Quest", QuestLv = 1, Mob = "Royal Squad", NPCPos = CFrame.new(-7906, 5634, -1411), MobPos = CFrame.new(-7624, 5658, -1467) },
        { Sea = 1, MinLv = 550, MaxLv = 624, QuestName = "SkyExp2Quest", QuestLv = 2, Mob = "Royal Soldier", NPCPos = CFrame.new(-7906, 5634, -1411), MobPos = CFrame.new(-7836, 5645, -1790) },
        { Sea = 1, MinLv = 625, MaxLv = 649, QuestName = "FountainQuest", QuestLv = 1, Mob = "Galley Pirate", NPCPos = CFrame.new(5259, 38, 4050), MobPos = CFrame.new(5551, 78, 3930) },
        { Sea = 1, MinLv = 650, MaxLv = 9999, QuestName = "FountainQuest", QuestLv = 2, Mob = "Galley Captain", NPCPos = CFrame.new(5259, 38, 4050), MobPos = CFrame.new(5441, 42, 4950) },

        -- SEA 2
        { Sea = 2, MinLv = 700, MaxLv = 724, QuestName = "Area1Quest", QuestLv = 1, Mob = "Raider", NPCPos = CFrame.new(-429, 72, 1836), MobPos = CFrame.new(-728, 52, 2345) },
        { Sea = 2, MinLv = 725, MaxLv = 774, QuestName = "Area1Quest", QuestLv = 2, Mob = "Mercenary", NPCPos = CFrame.new(-
