-- ==============================================================================
-- // PHẦN 1: KHỞI TẠO HỆ THỐNG, CONFIG & CORE UI LIBRARY (hzayday_bloxfruit) //
-- ==============================================================================
do
    local Env = (getgenv and getgenv()) or _G
    Env.Hzayday = Env.Hzayday or {}
    local H = Env.Hzayday

    -- Dịch vụ Roblox
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
        CoreGui = game:GetService("CoreGui")
    }

    H.LocalPlayer = H.Services.Players.LocalPlayer
    H.LogoId = "rbxassetid://138691340576184"
    H.HubName = "hzayday_bloxfruit"

    -- Bảng lưu toàn bộ cấu hình (Flags/Config)
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
        TweenSpeed = 140,
        BypassTeleport = false,
        FastTeleport = false,
        MasterySkills = {},
        HoldingSkill = false,
        HoldZ = 0, HoldX = 0, HoldC = 0, HoldV = 0,
        DistanceX = 0, DistanceY = 15, DistanceZ = 0,

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
        MasteryMethod = "None",
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

    -- Xóa GUI cũ nếu chạy lại
    local ParentGui = (gethui and gethui()) or H.Services.CoreGui
    if ParentGui:FindFirstChild("Hzayday_BloxFruit_UI") then
        ParentGui.Hzayday_BloxFruit_UI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Hzayday_BloxFruit_UI"
    ScreenGui.Parent = ParentGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    H.ScreenGui = ScreenGui

    -- Hàm hỗ trợ Kéo Thả (Draggable)
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

    -- Khung cửa sổ chính (Main Window)
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

    -- Nút Nổi Bật/Tắt (Floating Pill Button giống hệt video)
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

    -- ================= SIDEBAR TRÁI =================
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

    -- Header Logo & Tên Hub
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

    -- Thanh Search bên Sidebar
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

    -- Danh sách Tab
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

    -- ================= KHUNG NỘI DUNG PHẢI =================
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

    -- Lọc các mục trong Tab hiện tại khi gõ vào ô Search
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

    -- ================= BỘ HÀM TẠO TAB & COMPONENTS =================
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

        if #H.Tabs == 1 then
            Activate()
        end

        -- 1. Tiêu đề Nhóm (Section)
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

        -- 2. Nút Bật/Tắt (Toggle)
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

        -- 3. Thanh Trượt (Slider)
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

        -- 4. Danh Sách Chọn (Dropdown: Hỗ trợ Single & Multi + Thanh Search bên trong)
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

            -- Ô Search bên trong Dropdown
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

        -- 5. Nút Hành Động (Button)
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

        -- 6. Thẻ Trạng Thái (Status Card)
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
    local H = ((getgenv and getgenv()) or _G).Hzayday

    -- Khởi tạo đủ 6 Tab theo đúng thứ tự Sidebar trong video
    H.TabStatus = H:CreateTab("Status", "Character progress and server information.")
    H.TabFarmSettings = H:CreateTab("Farm Settings", "Combat and farming preferences.")
    H.TabMain = H:CreateTab("Main", "Farming and progression.")
    H.TabMultiFarm = H:CreateTab("Multi Farm", "Combine farming targets and activities.")
    H.TabQuests = H:CreateTab("Quests", "Quest completion and special unlocks.")
    H.TabItems = H:CreateTab("Items", "Collect and manage equipment and materials.")

    -- 1. ĐỔ DỮ LIỆU TAB STATUS
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

    -- 2. ĐỔ DỮ LIỆU TAB FARM SETTINGS
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

    -- 3. ĐỔ DỮ LIỆU TAB MAIN
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

    -- Mặc định mở Tab Main giống trong video
    H.TabMain.Activate()
end

-- ==============================================================================
-- // PHẦN 3: DỰNG GIAO DIỆN TAB MULTI FARM, QUESTS & ITEMS //
-- ==============================================================================
do
    local H = ((getgenv and getgenv()) or _G).Hzayday

    -- 4. ĐỔ DỮ LIỆU TAB MULTI FARM
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

    -- 5. ĐỔ DỮ LIỆU TAB QUESTS
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

    -- 6. ĐỔ DỮ LIỆU TAB ITEMS
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
-- // PHẦN 4 (FIX V2): THANH TỐC ĐỘ BAY, STATUS, REMOTE & SERVER HOP //
-- ==============================================================================
do
    local H = ((getgenv and getgenv()) or _G).Hzayday
    H.StartTime = os.time()
    H.Config.TweenSpeed = H.Config.TweenSpeed or 200

    -- Nhận diện Sea hiện tại
    local placeId = game.PlaceId
    H.CurrentSea = 1
    if placeId == 4442272183 then
        H.CurrentSea = 2
    elseif placeId == 7449423635 then
        H.CurrentSea = 3
    end

    -- Tự động thêm thanh chỉnh "Fly Speed (Tốc Độ Bay)" lên ĐẦU TAB MAIN
    if H.TabMain and H.TabMain.Page then
        local beforeCount = #H.TabMain.Page:GetChildren()
        H.TabMain:AddSlider(
            "Fly Speed (Tốc Độ Bay)",
            "Chỉnh tốc độ bay khi Farm Lv, Nhặt Rương, Săn Boss (100 - 400).",
            "TweenSpeed",
            100,
            400
        )
        local children = H.TabMain.Page:GetChildren()
        local newest = children[#children]
        if newest and newest:IsA("Frame") and #children > beforeCount then
            newest.LayoutOrder = -100 -- Đẩy lên vị trí đầu tiên của Tab Main
        end
    end

    -- Chống văng game khi treo máy (Anti-AFK)
    H.LocalPlayer.Idled:Connect(function()
        pcall(function()
            H.Services.VirtualUser:CaptureController()
            H.Services.VirtualUser:ClickButton2(Vector2.new())
        end)
    end)

    -- Gọi Remote CommF_ an toàn
    function H:InvokeCommF(...)
        local args = {...}
        local ok, res = pcall(function()
            local rem = H.Services.ReplicatedStorage:WaitForChild("Remotes", 5)
            if rem and rem:FindFirstChild("CommF_") then
                return rem.CommF_:InvokeServer(unpack(args))
            end
        end)
        return ok and res or nil
    end

    -- Kiểm tra vật phẩm trong Balo hoặc Nhân vật
    function H:HasItem(itemName)
        local bp = H.LocalPlayer:FindFirstChild("Backpack")
        local char = H.LocalPlayer.Character
        if bp and bp:FindFirstChild(itemName) then return true end
        if char and char:FindFirstChild(itemName) then return true end
        return false
    end

    -- Hàm Đổi Server (Server Hop)
    H.IsHopping = false
    function H:HopServer()
        if H.IsHopping then return end
        if H.Config.StopHopGodChalice and (H:HasItem("God's Chalice") or H:HasItem("Sweet Chalice")) then
            return
        end
        H.IsHopping = true
        task.spawn(function()
            local cursor = ""
            for _ = 1, 5 do
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
                                task.wait(3)
                            end
                        end
                    end
                    if res.nextPageCursor then
                        cursor = res.nextPageCursor
                    else
                        break
                    end
                else
                    break
                end
                task.wait(0.5)
            end
            task.wait(4)
            H.IsHopping = false
        end)
    end

    -- Vòng lặp cập nhật Tab Status
    task.spawn(function()
        while task.wait(1) do
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

                local map = H.Services.Workspace:FindFirstChild("_WorldOrigin") or H.Services.Workspace:FindFirstChild("Map")
                if H.StatusLabels.MysticIsland then
                    local hasMirage = map and (map:FindFirstChild("MysticIsland") or (map:FindFirstChild("Locations") and map.Locations:FindFirstChild("Mirage Island")))
                    H.StatusLabels.MysticIsland.Text = hasMirage and "Spawned ✅" or "N/A"
                end
                if H.StatusLabels.PrehistoricIsland then
                    local hasPre = map and map:FindFirstChild("PrehistoricIsland")
                    H.StatusLabels.PrehistoricIsland.Text = hasPre and "Spawned ✅" or "N/A"
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
-- // PHẦN 5 (FIX V2): NOCLIP CHẠY NGẦM CHỐNG RƠI MAP, TWEEN BAY & CHIẾN ĐẤU //
-- ==============================================================================
do
    local H = ((getgenv and getgenv()) or _G).Hzayday
    H.ActiveTween = nil
    H.LastTweenTarget = nil
    H.WasFarming = false

    -- Kiểm tra xem có bất kỳ chức năng hoạt động nào đang bật hay không
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

    -- Hàm dừng bay ngay lập tức
    function H:StopTween()
        if H.ActiveTween then
            pcall(function() H.ActiveTween:Cancel() end)
            H.ActiveTween = nil
        end
        H.LastTweenTarget = nil
    end

    -- HỆ THỐNG NOCLIP CHẠY NGẦM & CHỐNG RƠI MAP 100%
    -- Chỉ bật khi có chức năng đang chạy, tự động trả lại va chạm (CanCollide = true) khi tắt!
    H.Services.RunService.Stepped:Connect(function()
        local char = H.LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end

        local active = H:IsAnyFarmActive()

        if active then
            H.WasFarming = true

            -- Không cho nhân vật bị kẹt vào ghế ngồi
            if hum.Sit then hum.Sit = false end

            -- 1. Giữ nhân vật lơ lửng trước khi tắt va chạm để KHÔNG BAO GIỜ RƠI MAP
            local bv = hrp:FindFirstChild("Hzayday_Antifall")
            if not bv then
                bv = Instance.new("BodyVelocity")
                bv.Name = "Hzayday_Antifall"
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bv.P = 15000
                bv.Velocity = Vector3.zero
                bv.Parent = hrp
            else
                bv.Velocity = Vector3.zero
            end

            -- Triệt tiêu quán tính rơi tự do của engine vật lý
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero

            -- 2. Chống lọt xuống dưới đáy biển / void (Anti-Void)
            if hrp.Position.Y < -3 then
                hrp.CFrame = CFrame.new(hrp.Position.X, 30, hrp.Position.Z)
            end

            -- 3. Bật Noclip xuyên vật cản
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        elseif H.WasFarming then
            -- KHI VỪA TẮT TẤT CẢ CHỨC NĂNG -> KHÔI PHỤC VA CHẠM TRƯỚC KHI XÓA BODYVELOCITY
            H.WasFarming = false
            H:StopTween()

            -- Bật lại va chạm cho thân nhân vật để đứng trên mặt đất không bị xuyên sàn
            local collideParts = {"HumanoidRootPart", "LowerTorso", "UpperTorso", "Torso", "Head"}
            for _, pName in ipairs(collideParts) do
                local p = char:FindFirstChild(pName)
                if p and p:IsA("BasePart") then
                    p.CanCollide = true
                end
            end

            -- Nếu đang bị kẹt dưới lòng đất hoặc sát mặt nước, nhấc nhẹ lên mặt đất an toàn
            if hrp.Position.Y < 5 then
                hrp.CFrame = CFrame.new(hrp.Position.X, 25, hrp.Position.Z)
            end

            local bv = hrp:FindFirstChild("Hzayday_Antifall")
            if bv then bv:Destroy() end
        end
    end)

    -- HÀM TWEEN BAY MƯỢT (Áp dụng trực tiếp thanh Fly Speed & giữ độ cao an toàn)
    function H:TweenTo(targetCF, applyOffset)
        local char = H.LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp or not targetCF then return false end

        local goalPos = targetCF.Position
        if applyOffset then
            goalPos = (targetCF * CFrame.new(H.Config.DistanceX or 0, H.Config.DistanceY or 15, H.Config.DistanceZ or 0)).Position
        end

        -- Đảm bảo mục tiêu không bao giờ nằm dưới đáy biển làm rơi map
        if goalPos.Y < 2 then
            goalPos = Vector3.new(goalPos.X, 18, goalPos.Z)
        end

        local goalCF = CFrame.new(goalPos)
        local dist = (hrp.Position - goalPos).Magnitude

        -- Khi đã tới rất gần (< 15 studs) hoặc bật Fast Teleport ở gần
        if dist <= 15 or (H.Config.FastTeleport and dist <= 220) then
            H:StopTween()
            hrp.CFrame = goalCF
            return true
        end

        -- Nếu đang bay tới đúng mục tiêu đó (xê dịch < 5 studs) thì giữ nguyên Tween đang chạy
        if H.ActiveTween and H.LastTweenTarget and (H.LastTweenTarget - goalPos).Magnitude < 5 then
            if H.ActiveTween.PlaybackState == Enum.PlaybackState.Playing then
                return false
            end
        end

        H:StopTween()

        local speed = math.clamp(tonumber(H.Config.TweenSpeed) or 200, 80, 450)
        local duration = math.max(0.05, dist / speed)

        H.LastTweenTarget = goalPos
        H.ActiveTween = H.Services.TweenService:Create(
            hrp,
            TweenInfo.new(duration, Enum.EasingStyle.Linear),
            { CFrame = goalCF }
        )
        H.ActiveTween:Play()
        return false
    end

    -- Nhận diện vũ khí đa ngôn ngữ (Tiếng Việt & Tiếng Anh)
    local WeaponMap = {
        ["Melee"] = { "melee", "cận chiến", "võ", "combat", "black leg", "electro", "fishman karate", "dragon breath", "superhuman", "death step", "sharkman karate", "electric claw", "dragon talon", "godhuman", "sanguine art" },
        ["Sword"] = { "sword", "kiếm", "katana", "cutlass", "saber", "yama", "tushita", "cursed dual katana", "rengoku", "midnight blade", "shark anchor" },
        ["Gun"] = { "gun", "súng", "slingshot", "musket", "flintlock", "kabucha", "acidum rifle", "bizarre rifle", "soul guitar", "skull guitar", "dragonstorm" },
        ["Blox Fruit"] = { "blox fruit", "demon fruit", "trái ác quỷ", "trái", "fruit", "-" }
    }

    local function IsMatchingWeapon(tool, category)
        if not tool:IsA("Tool") then return false end
        local tip = string.lower(tool.ToolTip or "")
        local name = string.lower(tool.Name or "")
        local keywords = WeaponMap[category]
        if not keywords then return false end

        for _, kw in ipairs(keywords) do
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
        if not char or not hum or not bp then return end

        local equipped = char:FindFirstChildOfClass("Tool")
        if equipped and IsMatchingWeapon(equipped, wType) then
            return
        end

        for _, tool in ipairs(bp:GetChildren()) do
            if IsMatchingWeapon(tool, wType) then
                hum:EquipTool(tool)
                return
            end
        end

        local firstTool = bp:FindFirstChildOfClass("Tool")
        if firstTool and not equipped then
            hum:EquipTool(firstTool)
        end
    end

    -- Bật Buso, Ken, Race V3/V4
    function H:UpdateCharacterBuffs()
        local char = H.LocalPlayer.Character
        if not char then return end

        if H.Config.AutoBuso and not char:FindFirstChild("HasBuso") then
            H:InvokeCommF("Buso")
        end

        if H.Config.AutoKen then
            pcall(function()
                H.Services.ReplicatedStorage.Remotes.CommE:FireServer("Ken", true)
            end)
        end

        if H.Config.AutoRaceV3 then
            pcall(function()
                H.Services.ReplicatedStorage.Remotes.CommE:FireServer("ActivateAbility")
            end)
        end

        if H.Config.AutoRaceV4 then
            local awk = H.LocalPlayer.Backpack:FindFirstChild("Awakening") or char:FindFirstChild("Awakening")
            if awk and awk:FindFirstChild("RemoteFunction") then
                pcall(function() awk.RemoteFunction:InvokeServer(true) end)
            end
        end

        local pgui = H.LocalPlayer:FindFirstChild("PlayerGui")
        local notif = pgui and pgui:FindFirstChild("Notifications")
        if notif then
            notif.Enabled = not H.Config.RemoveNotify
        end
    end

    -- Gom quái xung quanh về điểm đánh
    function H:BringNearbyMobs(mobFilterName, bringPosCF)
        if not H.Config.BringMob or not bringPosCF then return end
        local enemies = H.Services.Workspace:FindFirstChild("Enemies")
        if not enemies then return end

        pcall(function()
            if sethiddenproperty then
                sethiddenproperty(H.LocalPlayer, "SimulationRadius", math.huge)
            end
        end)

        local cleanFilter = mobFilterName and string.gsub(mobFilterName, "%s*%[Lv%.%s*%d+%]", "") or nil

        for _, mob in ipairs(enemies:GetChildren()) do
            local hum = mob:FindFirstChildOfClass("Humanoid")
            local hrp = mob:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local isSameMob = (not cleanFilter) or string.find(mob.Name, cleanFilter, 1, true)
                if isSameMob and (hrp.Position - bringPosCF.Position).Magnitude <= 300 then
                    hrp.CFrame = bringPosCF
                    hrp.CanCollide = false
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hum.WalkSpeed = 0
                    hum.JumpPower = 0
                    if hum:FindFirstChild("Animator") then
                        hum.Animator:Destroy()
                    end
                end
            end
        end
    end

    -- Tấn công mục tiêu (Chỉ thực thi khi đã áp sát quái)
    function H:AttackTarget(useSkillTable)
        local char = H.LocalPlayer.Character
        local myHRP = char and char:FindFirstChild("HumanoidRootPart")
        if not char or not myHRP then return end

        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            pcall(function() tool:Activate() end)
        end

        -- Gửi gói tin Net RegisterAttack & RegisterHit chuẩn Blox Fruits
        pcall(function()
            local modules = H.Services.ReplicatedStorage:FindFirstChild("Modules")
            local net = modules and modules:FindFirstChild("Net")
            if net then
                local regAttack = net:FindFirstChild("RE/RegisterAttack")
                local regHit = net:FindFirstChild("RE/RegisterHit")
                local enemies = H.Services.Workspace:FindFirstChild("Enemies")
                local hitTargets = {}
                local mainPart = nil

                if enemies then
                    for _, mob in ipairs(enemies:GetChildren()) do
                        local hrp = mob:FindFirstChild("HumanoidRootPart")
                        local hum = mob:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 and (hrp.Position - myHRP.Position).Magnitude <= 65 then
                            mainPart = mainPart or hrp
                            table.insert(hitTargets, { mob, hrp })
                        end
                    end
                end

                if mainPart then
                    if regAttack then regAttack:FireServer(0) end
                    if regHit then regHit:FireServer(mainPart, hitTargets) end
                end
            end
        end)

        pcall(function()
            H.Services.VirtualUser:CaptureController()
            H.Services.VirtualUser:ClickButton1(Vector2.new(800, 500))
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
-- // PHẦN 6 (FIX V2): FARM LEVEL CHUẨN LA BÀN (GUIDEMODULE) & FARM CHEST MƯỢT //
-- ==============================================================================
do
    local H = ((getgenv and getgenv()) or _G).Hzayday
    H.VisitedChests = {}
    H.CurrentChestTarget = nil
    H.CurrentChestStartTime = 0

    local function CleanMobName(name)
        if not name then return "" end
        return (string.gsub(name, "%s*%[Lv%.%s*%d+%]", ""))
    end

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
                local cleanMob = CleanMobName(mob.Name)
                local match = false

                if not nameFilter or nameFilter == "" then
                    match = true
                elseif type(nameFilter) == "string" then
                    local cleanFilter = CleanMobName(nameFilter)
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

    -- Tìm tọa độ bãi quái từ _WorldOrigin.EnemySpawns hoặc ReplicatedStorage
    function H:GetMobSpawnCFrame(mobName, fallbackCF)
        if not mobName or mobName == "" then return fallbackCF end
        local cleanTarget = string.lower(CleanMobName(mobName))

        local wo = H.Services.Workspace:FindFirstChild("_WorldOrigin")
        local spawns = wo and wo:FindFirstChild("EnemySpawns")
        if spawns then
            local bestCF, minDist = nil, math.huge
            local myPos = (H.LocalPlayer.Character and H.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and H.LocalPlayer.Character.HumanoidRootPart.Position) or Vector3.zero
            for _, sp in ipairs(spawns:GetChildren()) do
                local cleanSp = string.lower(CleanMobName(sp.Name))
                if cleanSp == cleanTarget or string.find(cleanSp, cleanTarget, 1, true) then
                    local cf = sp:IsA("BasePart") and sp.CFrame or (sp:IsA("Model") and sp:GetPivot())
                    if cf then
                        local d = (cf.Position - myPos).Magnitude
                        if d < minDist then
                            minDist = d
                            bestCF = cf
                        end
                    end
                end
            end
            if bestCF then return bestCF end
        end

        for _, obj in ipairs(H.Services.ReplicatedStorage:GetChildren()) do
            if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
                local cleanObj = string.lower(CleanMobName(obj.Name))
                if cleanObj == cleanTarget or string.find(cleanObj, cleanTarget, 1, true) then
                    return obj.HumanoidRootPart.CFrame
                end
            end
        end

        return fallbackCF
    end

    -- Bảng dữ liệu Quest dự phòng (nếu GuideModule chưa load kịp)
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
        { Sea = 1, MinLv = 190, MaxLv = 209, QuestName = "PrisonerQuest", QuestLv = 1, Mob = "Prisoner", NPCPos = CFrame.new(5308, 2, 474), MobPos = CFrame.new(5098, 2, 474) },
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
        { Sea = 2, MinLv = 725, MaxLv = 774, QuestName = "Area1Quest", QuestLv = 2, Mob = "Mercenary", NPCPos = CFrame.new(-429, 72, 1836), MobPos = CFrame.new(-1004, 80, 1424) },
        { Sea = 2, MinLv = 775, MaxLv = 799, QuestName = "Area2Quest", QuestLv = 1, Mob = "Swan Pirate", NPCPos = CFrame.new(638, 73, 918), MobPos = CFrame.new(1068, 137, 1322) },
        { Sea = 2, MinLv = 800, MaxLv = 874, QuestName = "Area2Quest", QuestLv = 2, Mob = "Factory Staff", NPCPos = CFrame.new(638, 73, 918), MobPos = CFrame.new(73, 81, -27) },
        { Sea = 2, MinLv = 875, MaxLv = 899, QuestName = "MarineQuest3", QuestLv = 1, Mob = "Marine Lieutenant", NPCPos = CFrame.new(-2440, 73, -3216), MobPos = CFrame.new(-2821, 75, -3070) },
        { Sea = 2, MinLv = 900, MaxLv = 949, QuestName = "MarineQuest3", QuestLv = 2, Mob = "Marine Captain", NPCPos = CFrame.new(-2440, 73, -3216), MobPos = CFrame.new(-1861, 80, -3254) },
        { Sea = 2, MinLv = 950, MaxLv = 974, QuestName = "ZombieQuest", QuestLv = 1, Mob = "Zombie", NPCPos = CFrame.new(-5497, 47, -795), MobPos = CFrame.new(-5657, 78, -928) },
        { Sea = 2, MinLv = 975, MaxLv = 999, QuestName = "ZombieQuest", QuestLv = 2, Mob = "Vampire", NPCPos = CFrame.new(-5497, 47, -795), MobPos = CFrame.new(-6037, 32, -1340) },
        { Sea = 2, MinLv = 1000, MaxLv = 1049, QuestName = "SnowMountainQuest", QuestLv = 1, Mob = "Snow Trooper", NPCPos = CFrame.new(609, 400, -5372), MobPos = CFrame.new(549, 427, -5563) },
        { Sea = 2, MinLv = 1050, MaxLv = 1099, QuestName = "SnowMountainQuest", QuestLv = 2, Mob = "Winter Warrior", NPCPos = CFrame.new(609, 400, -5372), MobPos = CFrame.new(1142, 475, -5199) },
        { Sea = 2, MinLv = 1100, MaxLv = 1124, QuestName = "IceSideQuest", QuestLv = 1, Mob = "Lab Subordinate", NPCPos = CFrame.new(-6064, 15, -4902), MobPos = CFrame.new(-5707, 15, -4513) },
        { Sea = 2, MinLv = 1125, MaxLv = 1174, QuestName = "IceSideQuest", QuestLv = 2, Mob = "Horned Warrior", NPCPos = CFrame.new(-6064, 15, -4902), MobPos = CFrame.new(-6341, 15, -5723) },
        { Sea = 2, MinLv = 1175, MaxLv = 1199, QuestName = "FireSideQuest", QuestLv = 1, Mob = "Magma Ninja", NPCPos = CFrame.new(-5428, 15, -5299), MobPos = CFrame.new(-5449, 76, -5808) },
        { Sea = 2, MinLv = 1200, MaxLv = 1249, QuestName = "FireSideQuest", QuestLv = 2, Mob = "Lava Pirate", NPCPos = CFrame.new(-5428, 15, -5299), MobPos = CFrame.new(-5213, 49, -4701) },
        { Sea = 2, MinLv = 1250, MaxLv = 1274, QuestName = "ShipQuest1", QuestLv = 1, Mob = "Ship Deckhand", NPCPos = CFrame.new(1037, 125, 32911), MobPos = CFrame.new(1212, 150, 33059) },
        { Sea = 2, MinLv = 1275, MaxLv = 1299, QuestName = "ShipQuest1", QuestLv = 2, Mob = "Ship Engineer", NPCPos = CFrame.new(1037, 125, 32911), MobPos = CFrame.new(919, 43, 32779) },
        { Sea = 2, MinLv = 1300, MaxLv = 1324, QuestName = "ShipQuest2", QuestLv = 1, Mob = "Ship Steward", NPCPos = CFrame.new(968, 125, 33244), MobPos = CFrame.new(919, 129, 33436) },
        { Sea = 2, MinLv = 1325, MaxLv = 1349, QuestName = "ShipQuest2", QuestLv = 2, Mob = "Ship Officer", NPCPos = CFrame.new(968, 125, 33244), MobPos = CFrame.new(1036, 181, 33315) },
        { Sea = 2, MinLv = 1350, MaxLv = 1374, QuestName = "FrostQuest", QuestLv = 1, Mob = "Arctic Warrior", NPCPos = CFrame.new(5667, 26, -6486), MobPos = CFrame.new(5966, 62, -6179) },
        { Sea = 2, MinLv = 1375, MaxLv = 1424, QuestName = "FrostQuest", QuestLv = 2, Mob = "Snow Lurker", NPCPos = CFrame.new(5667, 26, -6486), MobPos = CFrame.new(5407, 69, -6880) },
        { Sea = 2, MinLv = 1425, MaxLv = 1449, QuestName = "ForgottenQuest", QuestLv = 1, Mob = "Sea Soldier", NPCPos = CFrame.new(-3054, 235, -10142), MobPos = CFrame.new(-3028, 64, -9775) },
        { Sea = 2, MinLv = 1450, MaxLv = 9999, QuestName = "ForgottenQuest", QuestLv = 2, Mob = "Water Fighter", NPCPos = CFrame.new(-3054, 235, -10142), MobPos = CFrame.new(-3352, 285, -10534) },

        -- SEA 3
        { Sea = 3, MinLv = 1500, MaxLv = 1524, QuestName = "PiratePortQuest", QuestLv = 1, Mob = "Pirate Millionaire", NPCPos = CFrame.new(-290, 42, 5581), MobPos = CFrame.new(-245, 47, 5584) },
        { Sea = 3, MinLv = 1525, MaxLv = 1574, QuestName = "PiratePortQuest", QuestLv = 2, Mob = "Pistol Billionaire", NPCPos = CFrame.new(-290, 42, 5581), MobPos = CFrame.new(-187, 86, 6013) },
        { Sea = 3, MinLv = 1575, MaxLv = 1599, QuestName = "AmazonQuest", QuestLv = 1, Mob = "Dragon Crew Warrior", NPCPos = CFrame.new(5832, 51, -1101), MobPos = CFrame.new(6141, 51, -1340) },
        { Sea = 3, MinLv = 1600, MaxLv = 1624, QuestName = "AmazonQuest", QuestLv = 2, Mob = "Dragon Crew Archer", NPCPos = CFrame.new(5832, 51, -1101), MobPos = CFrame.new(6616, 441, 460) },
        { Sea = 3, MinLv = 1625, MaxLv = 1649, QuestName = "AmazonQuest2", QuestLv = 1, Mob = "Female Islander", NPCPos = CFrame.new(5448, 601, 751), MobPos = CFrame.new(4685, 735, 815) },
        { Sea = 3, MinLv = 1650, MaxLv = 1699, QuestName = "AmazonQuest2", QuestLv = 2, Mob = "Giant Islander", NPCPos = CFrame.new(5448, 601, 751), MobPos = CFrame.new(4729, 659, -44) },
        { Sea = 3, MinLv = 1700, MaxLv = 1724, QuestName = "MarineTreeIsland", QuestLv = 1, Mob = "Marine Commodore", NPCPos = CFrame.new(2180, 27, -6741), MobPos = CFrame.new(2286, 73, -7159) },
        { Sea = 3, MinLv = 1725, MaxLv = 1774, QuestName = "MarineTreeIsland", QuestLv = 2, Mob = "Marine Rear Admiral", NPCPos = CFrame.new(2180, 27, -6741), MobPos = CFrame.new(3656, 160, -7001) },
        { Sea = 3, MinLv = 1775, MaxLv = 1799, QuestName = "DeepForestIsland3", QuestLv = 1, Mob = "Fishman Raider", NPCPos = CFrame.new(-10581, 330, -8761), MobPos = CFrame.new(-10407, 331, -8368) },
        { Sea = 3, MinLv = 1800, MaxLv = 1824, QuestName = "DeepForestIsland3", QuestLv = 2, Mob = "Fishman Captain", NPCPos = CFrame.new(-10581, 330, -8761), MobPos = CFrame.new(-10994, 352, -9002) },
        { Sea = 3, MinLv = 1825, MaxLv = 1849, QuestName = "DeepForestIsland", QuestLv = 1, Mob = "Forest Pirate", NPCPos = CFrame.new(-13234, 331, -7625), MobPos = CFrame.new(-13479, 332, -7760) },
        { Sea = 3, MinLv = 1850, MaxLv = 1899, QuestName = "DeepForestIsland", QuestLv = 2, Mob = "Mythological Pirate", NPCPos = CFrame.new(-13234, 331, -7625), MobPos = CFrame.new(-13680, 501, -6991) },
        { Sea = 3, MinLv = 1900, MaxLv = 1924, QuestName = "DeepForestIsland2", QuestLv = 1, Mob = "Jungle Pirate", NPCPos = CFrame.new(-12680, 389, -9902), MobPos = CFrame.new(-12256, 331, -10485) },
        { Sea = 3, MinLv = 1925, MaxLv = 1974, QuestName = "DeepForestIsland2", QuestLv = 2, Mob = "Musketeer Pirate", NPCPos = CFrame.new(-12680, 389, -9902), MobPos = CFrame.new(-13457, 391, -9859) },
        { Sea = 3, MinLv = 1975, MaxLv = 1999, QuestName = "HauntedQuest1", QuestLv = 1, Mob = "Reborn Skeleton", NPCPos = CFrame.new(-9479, 141, 5566), MobPos = CFrame.new(-8763, 165, 6159) },
        { Sea = 3, MinLv = 2000, MaxLv = 2024, QuestName = "HauntedQuest1", QuestLv = 2, Mob = "Living Zombie", NPCPos = CFrame.new(-9479, 141, 5566), MobPos = CFrame.new(-10144, 138, 5838) },
        { Sea = 3, MinLv = 2025, MaxLv = 2049, QuestName = "HauntedQuest2", QuestLv = 1, Mob = "Demonic Soul", NPCPos = CFrame.new(-9516, 172, 6078), MobPos = CFrame.new(-9505, 172, 6158) },
        { Sea = 3, MinLv = 2050, MaxLv = 2074, QuestName = "HauntedQuest2", QuestLv = 2, Mob = "Posessed Mummy", NPCPos = CFrame.new(-9516, 172, 6078), MobPos = CFrame.new(-9582, 6, 6205) },
        { Sea = 3, MinLv = 2075, MaxLv = 2099, QuestName = "NutsIslandQuest", QuestLv = 1, Mob = "Peanut Scout", NPCPos = CFrame.new(-2104, 38, -10194), MobPos = CFrame.new(-2124, 123, -10435) },
        { Sea = 3, MinLv = 2100, MaxLv = 2124, QuestName = "NutsIslandQuest", QuestLv = 2, Mob = "Peanut President", NPCPos = CFrame.new(-2104, 38, -10194), MobPos = CFrame.new(-1859, 38, -10422) },
        { Sea = 3, MinLv = 2125, MaxLv = 2149, QuestName = "IceCreamIslandQuest", QuestLv = 1, Mob = "Ice Cream Chef", NPCPos = CFrame.new(-820, 65, -10965), MobPos = CFrame.new(-641, 126, -11062) },
        { Sea = 3, MinLv = 2150, MaxLv = 2199, QuestName = "IceCreamIslandQuest", QuestLv = 2, Mob = "Ice Cream Commander", NPCPos = CFrame.new(-820, 65, -10965), MobPos = CFrame.new(-558, 126, -11290) },
        { Sea = 3, MinLv = 2200, MaxLv = 2224, QuestName = "CakeQuest1", QuestLv = 1, Mob = "Cookie Crafter", NPCPos = CFrame.new(-2021, 37, -12028), MobPos = CFrame.new(-2374, 37, -12125) },
        { Sea = 3, MinLv = 2225, MaxLv = 2249, QuestName = "CakeQuest1", QuestLv = 2, Mob = "Cake Guard", NPCPos = CFrame.new(-2021, 37, -12028), MobPos = CFrame.new(-1598, 43, -12244) },
        { Sea = 3, MinLv = 2250, MaxLv = 2274, QuestName = "CakeQuest2", QuestLv = 1, Mob = "Baking Staff", NPCPos = CFrame.new(-1927, 37, -12842), MobPos = CFrame.new(-1887, 77, -12998) },
        { Sea = 3, MinLv = 2275, MaxLv = 9999, QuestName = "CakeQuest2", QuestLv = 2, Mob = "Head Baker", NPCPos = CFrame.new(-1927, 37, -12842), MobPos = CFrame.new(-2216, 82, -12869) }
    }

    -- HÀM ĐỌC NHIỆM VỤ CHUẨN LA BÀN TRONG GAME (GuideModule + Quests)
    function H:GetQuestInfoByLevel()
        local data = H.LocalPlayer:FindFirstChild("Data")
        local lvl = (data and data:FindFirstChild("Level") and data.Level.Value) or 1
        local myPos = (H.LocalPlayer.Character and H.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and H.LocalPlayer.Character.HumanoidRootPart.Position) or Vector3.zero

        -- 1. Xử lý chuẩn xác cấp độ 1 - 9 theo đảo đang đứng hoặc Phe (Hải Quân vs Hải Tặc)
        if H.CurrentSea == 1 and lvl < 10 then
            local distToMarine = (myPos - Vector3.new(-2709, 24, 2104)).Magnitude
            local distToPirate = (myPos - Vector3.new(1059, 16, 1549)).Magnitude
            local isMarineTeam = H.LocalPlayer.Team and string.find(string.lower(H.LocalPlayer.Team.Name), "marine")

            if distToMarine < distToPirate or isMarineTeam then
                return {
                    QuestName = "MarineQuest",
                    QuestLv = 1,
                    Mob = "Trainee",
                    NPCPos = CFrame.new(-2709, 24, 2104),
                    MobPos = CFrame.new(-2752, 25, 2066)
                }
            else
                return {
                    QuestName = "BanditQuest1",
                    QuestLv = 1,
                    Mob = "Bandit",
                    NPCPos = CFrame.new(1059, 16, 1549),
                    MobPos = CFrame.new(1145, 17, 1634)
                }
            end
        end

        -- 2. Đọc trực tiếp từ GuideModule & Quests của Blox Fruits để khớp 100% với La Bàn
        local dynamicQuest = nil
        pcall(function()
            local guideMod = require(H.Services.ReplicatedStorage:WaitForChild("GuideModule"))
            local questsMod = require(H.Services.ReplicatedStorage:WaitForChild("Quests"))

            if guideMod and guideMod.Data and guideMod.Data.NPCList and questsMod then
                local bestLvReq = -1
                local bestNPCData = nil
                local bestTierIndex = 1

                for npcKey, npcData in pairs(guideMod.Data.NPCList) do
                    if type(npcData) == "table" and type(npcData.Levels) == "table" then
                        for tierIdx, reqLv in ipairs(npcData.Levels) do
                            if type(reqLv) == "number" and lvl >= reqLv and reqLv >= bestLvReq then
                                -- Bỏ qua MarineQuest hoặc BanditQuest1 nếu đã trên Lv 10
                                local iName = npcData.InternalQuestName
                                if not (lvl >= 10 and (iName == "MarineQuest" or iName == "BanditQuest1")) then
                                    bestLvReq = reqLv
                                    bestNPCData = npcData
                                    bestTierIndex = tierIdx
                                end
                            end
                        end
                    end
                end

                if bestNPCData and bestNPCData.InternalQuestName and questsMod[bestNPCData.InternalQuestName] then
                    local qName = bestNPCData.InternalQuestName
                    local qTier = questsMod[qName][bestTierIndex]
                    if qTier and qTier.Task then
                        local mobName, mobCount = nil, 0
                        for mName, mCount in pairs(qTier.Task) do
                            mobName = mName
                            mobCount = mCount
                            break
                        end
                        -- Chỉ lấy nhiệm vụ đánh quái thường (count > 1), tránh nhận nhầm nhiệm vụ Boss
                        if mobName and mobCount > 1 then
                            local npcPos = nil
                            if typeof(bestNPCData.Position) == "Vector3" then
                                npcPos = CFrame.new(bestNPCData.Position)
                            elseif typeof(bestNPCData.CFrame) == "CFrame" then
                                npcPos = bestNPCData.CFrame
                            end

                            -- Đối chiếu thêm tọa độ trong QuestDatabase nếu cần
                            for _, dbQ in ipairs(QuestDatabase) do
                                if dbQ.QuestName == qName and dbQ.QuestLv == bestTierIndex then
                                    npcPos = npcPos or dbQ.NPCPos
                                    break
                                end
                            end

                            local mobPos = H:GetMobSpawnCFrame(mobName, npcPos)
                            if npcPos then
                                dynamicQuest = {
                                    QuestName = qName,
                                    QuestLv = bestTierIndex,
                                    Mob = mobName,
                                    NPCPos = npcPos,
                                    MobPos = mobPos or npcPos
                                }
                            end
                        end
                    end
                end
            end
        end)

        if dynamicQuest then
            return dynamicQuest
        end

        -- 3. Fallback qua bảng QuestDatabase
        for _, q in ipairs(QuestDatabase) do
            if q.Sea == H.CurrentSea and lvl >= q.MinLv and lvl <= q.MaxLv then
                return q
            end
        end

        return QuestDatabase[1]
    end

    -- Đánh 1 mục tiêu: Chỉ rút vũ khí & đánh khi đã bay vào tầm (<= 55 studs)
    function H:EngageEnemy(enemy, customSkills)
        if not enemy then return end
        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        local hum = enemy:FindFirstChildOfClass("Humanoid")
        local myChar = H.LocalPlayer.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not hrp or not hum or hum.Health <= 0 or not myHRP then return end

        -- Luôn bay tới vị trí phía trên đầu mục tiêu
        H:TweenTo(hrp.CFrame, true)

        -- CHỈ RÚT VŨ KHÍ, GOM QUÁI VÀ TẤN CÔNG KHI ĐÃ TỚI GẦN QUÁI (<= 55 STUDS)
        local distToMob = (myHRP.Position - hrp.Position).Magnitude
        if distToMob <= 55 then
            H:UpdateCharacterBuffs()

            local hpPct = (hum.Health / math.max(1, hum.MaxHealth)) * 100
            if H.Config.AutoFarmFruitMastery and hpPct <= H.Config.KillAtHP then
                H:EquipWeapon("Blox Fruit")
                H:BringNearbyMobs(enemy.Name, hrp.CFrame)
                H:AttackTarget(H.Config.MasterySkills)
            elseif H.Config.AutoFarmGunMastery and hpPct <= H.Config.KillAtHP then
                H:EquipWeapon("Gun")
                H:BringNearbyMobs(enemy.Name, hrp.CFrame)
                H:AttackTarget(H.Config.MasterySkills)
            else
                H:EquipWeapon(H.Config.SelectWeapon)
                H:BringNearbyMobs(enemy.Name, hrp.CFrame)
                H:AttackTarget(customSkills)
            end
        end
    end

    -- HÀM QUÉT RƯƠNG (FIX TRIỆT ĐỂ LỖI ĐỨNG ĐƠ Ở RƯƠNG ĐÃ MỞ)
    function H:GetClosestValidChest()
        local now = tick()
        -- Xóa lịch sử rương đã nhặt sau 90 giây để rương hồi lại
        for chestKey, visitTime in pairs(H.VisitedChests) do
            if now - visitTime > 90 then
                H.VisitedChests[chestKey] = nil
            end
        end

        local myPos = (H.LocalPlayer.Character and H.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and H.LocalPlayer.Character.HumanoidRootPart.Position) or Vector3.zero
        local bestObj, bestPart, minDist = nil, nil, math.huge

        local function EvaluateChest(obj)
            if H.VisitedChests[obj] then return end

            if obj:IsA("Model") and string.find(string.lower(obj.Name), "chest", 1, true) then
                -- Kiểm tra xem rương đã bị mở chưa
                if obj:GetAttribute("IsDisabled") or obj:FindFirstChild("Opened") then
                    H.VisitedChests[obj] = now
                    return
                end
                local part = obj:FindFirstChild("PushBox") or obj:FindFirstChild("RootPart") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                local hasTouch = obj:FindFirstChildWhichIsA("TouchTransmitter", true)
                if part and part.Parent and part.Position.Y > -5 and (hasTouch or part.Transparency < 1) then
                    local d = (part.Position - myPos).Magnitude
                    if d < minDist then
                        minDist = d
                        bestObj = obj
                        bestPart = part
                    end
                end
            elseif obj:IsA("BasePart") and string.find(string.lower(obj.Name), "chest", 1, true) then
                local hasTouch = obj:FindFirstChildOfClass("TouchTransmitter")
                if obj.Transparency < 1 and hasTouch and obj.Position.Y > -5 then
                    local d = (obj.Position - myPos).Magnitude
                    if d < minDist then
                        minDist = d
                        bestObj = obj
                        bestPart = obj
                    end
                end
            end
        end

        local chestModels = H.Services.Workspace:FindFirstChild("ChestModels")
        if chestModels then
            for _, c in ipairs(chestModels:GetChildren()) do
                EvaluateChest(c)
            end
        end

        for _, c in ipairs(H.Services.Workspace:GetChildren()) do
            EvaluateChest(c)
        end

        local map = H.Services.Workspace:FindFirstChild("Map")
        if map then
            for _, island in ipairs(map:GetChildren()) do
                for _, c in ipairs(island:GetChildren()) do
                    EvaluateChest(c)
                end
            end
        end

        return bestObj, bestPart
    end

    -- Vòng lặp chính thực thi Tab Main
    task.spawn(function()
        while task.wait(0.1) do
            if not H.ScreenGui or not H.ScreenGui.Parent then break end
            pcall(function()
                local myChar = H.LocalPlayer.Character
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                if not myHRP then return end

                -- 1. Mob Aura
                if H.Config.MobAura then
                    local nearMob = H:GetAliveEnemy(nil)
                    if nearMob then
                        H:EngageEnemy(nearMob)
                        return
                    end
                end

                -- 2. Auto Farm Chest / Hop Farm Chest (Bản Fix chống kẹt rương)
                if H.Config.AutoFarmChest or H.Config.HopFarmChest then
                    local chestObj, chestPart = H:GetClosestValidChest()
                    if chestObj and chestPart then
                        if H.CurrentChestTarget ~= chestObj then
                            H.CurrentChestTarget = chestObj
                            H.CurrentChestStartTime = tick()
                        end

                        H:TweenTo(chestPart.CFrame, false)
                        local dist = (myHRP.Position - chestPart.Position).Magnitude

                        if dist <= 18 then
                            -- Đưa nhân vật chạm trực tiếp qua rương để kích hoạt sự kiện nhặt tiền
                            myHRP.CFrame = chestPart.CFrame * CFrame.new(0, (tick() % 0.4 < 0.2) and 1.5 or -0.5, 0)
                            pcall(function()
                                if firetouchinterest then
                                    firetouchinterest(myHRP, chestPart, 0)
                                    firetouchinterest(myHRP, chestPart, 1)
                                end
                            end)

                            -- Sau khi đứng ở rương 0.55 giây -> đánh dấu đã nhặt để bay sang rương kế tiếp ngay!
                            if tick() - H.CurrentChestStartTime >= 0.55 then
                                H.VisitedChests[chestObj] = tick()
                                H.CurrentChestTarget = nil
                            end
                        elseif tick() - H.CurrentChestStartTime > 12 then
                            -- Quá 12 giây không bay tới được rương này (rương lỗi) -> bỏ qua
                            H.VisitedChests[chestObj] = tick()
                            H.CurrentChestTarget = nil
                        end
                    elseif H.Config.HopFarmChest then
                        H:HopServer()
                    end
                    return
                end

                -- 3. Auto Farm Level (Đã đồng bộ 100% với La Bàn & GuideModule)
                if H.Config.AutoFarmLevel or ((H.Config.AutoFarmFruitMastery or H.Config.AutoFarmGunMastery) and H.Config.MasteryMethod == "Level") then
                    local qInfo = H:GetQuestInfoByLevel()
                    if not qInfo then return end

                    local pgui = H.LocalPlayer:FindFirstChild("PlayerGui")
                    local questGui = pgui and pgui:FindFirstChild("Main") and pgui.Main:FindFirstChild("Quest")
                    local hasQuest = questGui and quest
