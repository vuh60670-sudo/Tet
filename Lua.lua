-- ==============================================================================
-- // HZAYDAY_BLOXFRUIT - BẢN GỘP ALL-IN-ONE (FULL UI & LOGIC) //
-- ==============================================================================
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local MainSuccess, MainError = xpcall(function()
    local Env = (getgenv and getgenv()) or _G
    Env.Hzayday = Env.Hzayday or {}
    local H = Env.Hzayday
    local Unpack = table.unpack or unpack

    -- 1. KHỞI TẠO DỊCH VỤ & THÔNG BÁO SELF-TEST
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
        StarterGui = game:GetService("StarterGui"),
        CoreGui = game:GetService("CoreGui")
    }

    H.LocalPlayer = H.Services.Players.LocalPlayer or H.Services.Players.PlayerAdded:Wait()
    H.LogoId = "rbxassetid://138691340576184"
    H.HubName = "hzayday_bloxfruit"
    H.StartTime = os.time()

    local function Notify(title, text, duration)
        pcall(function()
            H.Services.StarterGui:SetCore("SendNotification", {
                Title = title or H.HubName,
                Text = text or "",
                Duration = duration or 4
            })
        end)
    end

    Notify(H.HubName, "Đang khởi tạo hệ thống UI & Logic...", 3)

    -- Nhận diện Sea hiện tại
    local placeId = game.PlaceId
    H.CurrentSea = 1
    if placeId == 4442272183 then
        H.CurrentSea = 2
    elseif placeId == 7449423635 then
        H.CurrentSea = 3
    end

    -- 2. BẢNG CẤU HÌNH TOÀN CỤC (CONFIG)
    H.Config = {
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
        TweenSpeed = 160,
        BypassTeleport = false,
        FastTeleport = false,
        MasterySkills = {},
        HoldingSkill = false,
        HoldZ = 0, HoldX = 0, HoldC = 0, HoldV = 0,
        DistanceX = 0, DistanceY = 15, DistanceZ = 0,

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

        AutoBartilo = false,
        AutoDojoQuest = false,
        KeepSailingDojo = false,
        AutoDragonHunter = false,
        AutoUpgradeKenV2 = false,
        AutoFarmKen = false,
        RejoinFarmKen = false,
        AutoRainbowHaki = false,
        AutoCitizenQuest = false,

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

    -- 3. KHỞI TẠO NƠI CHỨA GUI AN TOÀN (HỖ TRỢ MỌI EXECUTOR PC & MOBILE)
    local function GetSafeGuiParent()
        local ok, res = pcall(function()
            if gethui then return gethui() end
            return H.Services.CoreGui
        end)
        if ok and res then return res end
        return H.LocalPlayer:WaitForChild("PlayerGui")
    end

    local ParentGui = GetSafeGuiParent()
    for _, old in ipairs(ParentGui:GetChildren()) do
        if old.Name == "Hzayday_BloxFruit_UI" then
            pcall(function() old:Destroy() end)
        end
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Hzayday_BloxFruit_UI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    local guiOk = pcall(function() ScreenGui.Parent = ParentGui end)
    if not guiOk then
        ScreenGui.Parent = H.LocalPlayer:WaitForChild("PlayerGui")
    end
    H.ScreenGui = ScreenGui

    -- Hàm kéo thả mượt cho cả Cảm ứng (Touch) và Chuột
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

    -- 4. XÂY DỰNG KHUNG CỬA SỔ CHÍNH & NÚT NỔI
    local MainWindow = Instance.new("Frame")
    MainWindow.Name = "MainWindow"
    MainWindow.Parent = ScreenGui
    MainWindow.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
    MainWindow.Position = UDim2.new(0.5, -300, 0.5, -195)
    MainWindow.Size = UDim2.new(0, 600, 0, 390)
    MainWindow.ClipsDescendants = true
    Instance.new("UICorner", MainWindow).CornerRadius = UDim.new(0, 12)

    local MainStroke = Instance.new("UIStroke", MainWindow)
    MainStroke.Color = Color3.fromRGB(35, 40, 52)
    MainStroke.Thickness = 1.2

    -- Nút Nổi Bật/Tắt (Floating Pill)
    local FloatingBtn = Instance.new("TextButton")
    FloatingBtn.Name = "FloatingToggle"
    FloatingBtn.Parent = ScreenGui
    FloatingBtn.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
    FloatingBtn.Position = UDim2.new(0.5, -85, 0.06, 0)
    FloatingBtn.Size = UDim2.new(0, 175, 0, 42)
    FloatingBtn.Text = ""
    FloatingBtn.AutoButtonColor = false
    Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(1, 0)

    local FloatStroke = Instance.new("UIStroke", FloatingBtn)
    FloatStroke.Color = Color3.fromRGB(45, 50, 65)
    FloatStroke.Thickness = 1.2

    local FloatIcon = Instance.new("ImageLabel")
    FloatIcon.Parent = FloatingBtn
    FloatIcon.BackgroundTransparency = 1
    FloatIcon.Position = UDim2.new(0, 8, 0.5, -13)
    FloatIcon.Size = UDim2.new(0, 26, 0, 26)
    FloatIcon.Image = H.LogoId
    Instance.new("UICorner", FloatIcon).CornerRadius = UDim.new(1, 0)

    local FloatText = Instance.new("TextLabel")
    FloatText.Parent = FloatingBtn
    FloatText.BackgroundTransparency = 1
    FloatText.Position = UDim2.new(0, 40, 0, 0)
    FloatText.Size = UDim2.new(1, -68, 1, 0)
    FloatText.Font = Enum.Font.GothamBold
    FloatText.Text = H.HubName
    FloatText.TextColor3 = Color3.fromRGB(240, 240, 245)
    FloatText.TextSize = 12
    FloatText.TextXAlignment = Enum.TextXAlignment.Left
    FloatText.TextTruncate = Enum.TextTruncate.AtEnd

    local StatusDot = Instance.new("Frame")
    StatusDot.Parent = FloatingBtn
    StatusDot.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    StatusDot.Position = UDim2.new(1, -20, 0.5, -5)
    StatusDot.Size = UDim2.new(0, 10, 0, 10)
    Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)

    MakeDraggable(FloatingBtn, FloatingBtn)
    FloatingBtn.MouseButton1Click:Connect(function()
        MainWindow.Visible = not MainWindow.Visible
        StatusDot.BackgroundColor3 = MainWindow.Visible and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
    end)

    -- Sidebar Trái
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainWindow
    Sidebar.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
    Sidebar.Size = UDim2.new(0, 175, 1, 0)
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

    local BrandHeader = Instance.new("Frame")
    BrandHeader.Parent = Sidebar
    BrandHeader.BackgroundTransparency = 1
    BrandHeader.Size = UDim2.new(1, 0, 0, 58)

    local BrandLogo = Instance.new("ImageLabel")
    BrandLogo.Parent = BrandHeader
    BrandLogo.BackgroundTransparency = 1
    BrandLogo.Position = UDim2.new(0, 12, 0.5, -17)
    BrandLogo.Size = UDim2.new(0, 34, 0, 34)
    BrandLogo.Image = H.LogoId
    Instance.new("UICorner", BrandLogo).CornerRadius = UDim.new(0, 8)

    local BrandTitle = Instance.new("TextLabel")
    BrandTitle.Parent = BrandHeader
    BrandTitle.BackgroundTransparency = 1
    BrandTitle.Position = UDim2.new(0, 52, 0, 12)
    BrandTitle.Size = UDim2.new(1, -58, 0, 18)
    BrandTitle.Font = Enum.Font.GothamBold
    BrandTitle.Text = H.HubName
    BrandTitle.TextColor3 = Color3.fromRGB(245, 245, 250)
    BrandTitle.TextSize = 12
    BrandTitle.TextXAlignment = Enum.TextXAlignment.Left
    BrandTitle.TextTruncate = Enum.TextTruncate.AtEnd

    local BrandSub = Instance.new("TextLabel")
    BrandSub.Parent = BrandHeader
    BrandSub.BackgroundTransparency = 1
    BrandSub.Position = UDim2.new(0, 52, 0, 30)
    BrandSub.Size = UDim2.new(1, -58, 0, 16)
    BrandSub.Font = Enum.Font.GothamMedium
    BrandSub.Text = "[ Blox Fruits ]"
    BrandSub.TextColor3 = Color3.fromRGB(88, 145, 255)
    BrandSub.TextSize = 11
    BrandSub.TextXAlignment = Enum.TextXAlignment.Left

    MakeDraggable(BrandHeader, MainWindow)

    local SearchBoxFrame = Instance.new("Frame")
    SearchBoxFrame.Parent = Sidebar
    SearchBoxFrame.BackgroundColor3 = Color3.fromRGB(24, 27, 36)
    SearchBoxFrame.Position = UDim2.new(0, 10, 0, 62)
    SearchBoxFrame.Size = UDim2.new(1, -20, 0, 32)
    Instance.new("UICorner", SearchBoxFrame).CornerRadius = UDim.new(0, 8)

    local SearchInput = Instance.new("TextBox")
    SearchInput.Parent = SearchBoxFrame
    SearchInput.BackgroundTransparency = 1
    SearchInput.Position = UDim2.new(0, 10, 0, 0)
    SearchInput.Size = UDim2.new(1, -20, 1, 0)
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
    TabList.Position = UDim2.new(0, 8, 0, 102)
    TabList.Size = UDim2.new(1, -16, 1, -110)
    TabList.ScrollBarThickness = 0
    TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local TabListLayout = Instance.new("UIListLayout", TabList)
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Khung Nội Dung Phải
    local ContentArea = Instance.new("Frame")
    ContentArea.Parent = MainWindow
    ContentArea.BackgroundTransparency = 1
    ContentArea.Position = UDim2.new(0, 175, 0, 0)
    ContentArea.Size = UDim2.new(1, -175, 1, 0)

    local TopBar = Instance.new("Frame")
    TopBar.Parent = ContentArea
    TopBar.BackgroundTransparency = 1
    TopBar.Size = UDim2.new(1, 0, 0, 54)

    local TopTabTitle = Instance.new("TextLabel")
    TopTabTitle.Parent = TopBar
    TopTabTitle.BackgroundTransparency = 1
    TopTabTitle.Position = UDim2.new(0, 18, 0, 10)
    TopTabTitle.Size = UDim2.new(1, -36, 0, 20)
    TopTabTitle.Font = Enum.Font.GothamBold
    TopTabTitle.Text = "Main"
    TopTabTitle.TextColor3 = Color3.fromRGB(245, 245, 250)
    TopTabTitle.TextSize = 15
    TopTabTitle.TextXAlignment = Enum.TextXAlignment.Left

    local TopTabDesc = Instance.new("TextLabel")
    TopTabDesc.Parent = TopBar
    TopTabDesc.BackgroundTransparency = 1
    TopTabDesc.Position = UDim2.new(0, 18, 0, 30)
    TopTabDesc.Size = UDim2.new(1, -36, 0, 16)
    TopTabDesc.Font = Enum.Font.Gotham
    TopTabDesc.Text = "Farming and progression."
    TopTabDesc.TextColor3 = Color3.fromRGB(135, 142, 160)
    TopTabDesc.TextSize = 11
    TopTabDesc.TextXAlignment = Enum.TextXAlignment.Left

    MakeDraggable(TopBar, MainWindow)

    local PagesHolder = Instance.new("Frame")
    PagesHolder.Parent = ContentArea
    PagesHolder.BackgroundTransparency = 1
    PagesHolder.Position = UDim2.new(0, 0, 0, 55)
    PagesHolder.Size = UDim2.new(1, 0, 1, -55)

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

    -- 5. HÀM TẠO TAB VÀ CÁC COMPONENT UI
    function H:CreateTab(name, desc)
        local TabObj = {}
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabList
        TabBtn.BackgroundColor3 = Color3.fromRGB(28, 34, 48)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Size = UDim2.new(1, 0, 0, 36)
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
        TabTitle.Position = UDim2.new(0, 12, 0, 0)
        TabTitle.Size = UDim2.new(1, -16, 1, 0)
        TabTitle.Font = Enum.Font.GothamMedium
        TabTitle.Text = name
        TabTitle.TextColor3 = Color3.fromRGB(160, 168, 185)
        TabTitle.TextSize = 13
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left

        local Page = Instance.new("ScrollingFrame")
        Page.Name = name .. "_Page"
        Page.Parent = PagesHolder
        Page.BackgroundTransparency = 1
        Page.Position = UDim2.new(0, 14, 0, 6)
        Page.Size = UDim2.new(1, -28, 1, -12)
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Color3.fromRGB(88, 145, 255)
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.Visible = false

        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.Padding = UDim.new(0, 7)
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
            SecFrame.Size = UDim2.new(1, 0, 0, 24)
            local Key = Instance.new("StringValue", SecFrame)
            Key.Name = "SearchKey"
            Key.Value = titleText
            local Lbl = Instance.new("TextLabel")
            Lbl.Parent = SecFrame
            Lbl.BackgroundTransparency = 1
            Lbl.Position = UDim2.new(0, 2, 0, 4)
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
            Card.Size = UDim2.new(1, 0, 0, subText ~= "" and 54 or 42)
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

            local Key = Instance.new("StringValue", Card)
            Key.Name = "SearchKey"
            Key.Value = titleText .. " " .. (subText or "")

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Parent = Card
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Position = UDim2.new(0, 12, 0, subText ~= "" and 8 or 11)
            TitleLbl.Size = UDim2.new(1, -70, 0, 18)
            TitleLbl.Font = Enum.Font.GothamBold
            TitleLbl.Text = titleText
            TitleLbl.TextColor3 = Color3.fromRGB(240, 240, 248)
            TitleLbl.TextSize = 12
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left

            if subText and subText ~= "" then
                local SubLbl = Instance.new("TextLabel")
                SubLbl.Parent = Card
                SubLbl.BackgroundTransparency = 1
                SubLbl.Position = UDim2.new(0, 12, 0, 28)
                SubLbl.Size = UDim2.new(1, -70, 0, 16)
                SubLbl.Font = Enum.Font.Gotham
                SubLbl.Text = subText
                SubLbl.TextColor3 = Color3.fromRGB(130, 138, 156)
                SubLbl.TextSize = 11
                SubLbl.TextXAlignment = Enum.TextXAlignment.Left
                SubLbl.TextTruncate = Enum.TextTruncate.AtEnd
            end

            local SwitchBg = Instance.new("TextButton")
            SwitchBg.Parent = Card
            SwitchBg.Position = UDim2.new(1, -52, 0.5, -11)
            SwitchBg.Size = UDim2.new(0, 40, 0, 22)
            SwitchBg.Text = ""
            SwitchBg.AutoButtonColor = false
            Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)

            local Knob = Instance.new("Frame")
            Knob.Parent = SwitchBg
            Knob.Size = UDim2.new(0, 16, 0, 16)
            Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

            local function UpdateVisual(state)
                if state then
                    SwitchBg.BackgroundColor3 = Color3.fromRGB(88, 145, 255)
                    Knob.Position = UDim2.new(1, -19, 0.5, -8)
                    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                else
                    SwitchBg.BackgroundColor3 = Color3.fromRGB(36, 40, 54)
                    Knob.Position = UDim2.new(0, 3, 0.5, -8)
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
            Card.Size = UDim2.new(1, 0, 0, 70)
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

            local Key = Instance.new("StringValue", Card)
            Key.Name = "SearchKey"
            Key.Value = titleText .. " " .. (subText or "")

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Parent = Card
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Position = UDim2.new(0, 12, 0, 8)
            TitleLbl.Size = UDim2.new(1, -70, 0, 18)
            TitleLbl.Font = Enum.Font.GothamBold
            TitleLbl.Text = titleText
            TitleLbl.TextColor3 = Color3.fromRGB(240, 240, 248)
            TitleLbl.TextSize = 12
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left

            local SubLbl = Instance.new("TextLabel")
            SubLbl.Parent = Card
            SubLbl.BackgroundTransparency = 1
            SubLbl.Position = UDim2.new(0, 12, 0, 26)
            SubLbl.Size = UDim2.new(1, -70, 0, 15)
            SubLbl.Font = Enum.Font.Gotham
            SubLbl.Text = subText or ""
            SubLbl.TextColor3 = Color3.fromRGB(130, 138, 156)
            SubLbl.TextSize = 11
            SubLbl.TextXAlignment = Enum.TextXAlignment.Left

            local ValBox = Instance.new("TextLabel")
            ValBox.Parent = Card
            ValBox.BackgroundColor3 = Color3.fromRGB(28, 32, 44)
            ValBox.Position = UDim2.new(1, -52, 0, 8)
            ValBox.Size = UDim2.new(0, 40, 0, 20)
            ValBox.Font = Enum.Font.GothamBold
            ValBox.Text = tostring(H.Config[configKey] or minVal)
            ValBox.TextColor3 = Color3.fromRGB(230, 235, 245)
            ValBox.TextSize = 11
            Instance.new("UICorner", ValBox).CornerRadius = UDim.new(0, 6)

            local Track = Instance.new("TextButton")
            Track.Parent = Card
            Track.BackgroundColor3 = Color3.fromRGB(36, 40, 54)
            Track.Position = UDim2.new(0, 12, 0, 50)
            Track.Size = UDim2.new(1, -24, 0, 6)
            Track.Text = ""
            Track.AutoButtonColor = false
            Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

            local Fill = Instance.new("Frame")
            Fill.Parent = Track
            Fill.BackgroundColor3 = Color3.fromRGB(88, 145, 255)
            Fill.Size = UDim2.new(0, 0, 1, 0)
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

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
                local rel = math.clamp((input.Position.X - Track.AbsolutePosition.X) / math.max(1, Track.AbsoluteSize.X), 0, 1)
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
            Card.Size = UDim2.new(1, 0, 0, 54)
            Card.ClipsDescendants = true
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

            local Key = Instance.new("StringValue", Card)
            Key.Name = "SearchKey"
            Key.Value = titleText .. " " .. (subText or "")

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Parent = Card
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Position = UDim2.new(0, 12, 0, 8)
            TitleLbl.Size = UDim2.new(0.52, 0, 0, 18)
            TitleLbl.Font = Enum.Font.GothamBold
            TitleLbl.Text = titleText
            TitleLbl.TextColor3 = Color3.fromRGB(240, 240, 248)
            TitleLbl.TextSize = 12
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
            TitleLbl.TextTruncate = Enum.TextTruncate.AtEnd

            local SubLbl = Instance.new("TextLabel")
            SubLbl.Parent = Card
            SubLbl.BackgroundTransparency = 1
            SubLbl.Position = UDim2.new(0, 12, 0, 28)
            SubLbl.Size = UDim2.new(0.52, 0, 0, 16)
            SubLbl.Font = Enum.Font.Gotham
            SubLbl.Text = subText or ""
            SubLbl.TextColor3 = Color3.fromRGB(130, 138, 156)
            SubLbl.TextSize = 11
            SubLbl.TextXAlignment = Enum.TextXAlignment.Left
            SubLbl.TextTruncate = Enum.TextTruncate.AtEnd

            local SelectBtn = Instance.new("TextButton")
            SelectBtn.Parent = Card
            SelectBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 44)
            SelectBtn.Position = UDim2.new(1, -152, 0, 12)
            SelectBtn.Size = UDim2.new(0, 140, 0, 30)
            SelectBtn.Font = Enum.Font.GothamMedium
            SelectBtn.TextColor3 = Color3.fromRGB(220, 225, 238)
            SelectBtn.TextSize = 11
            SelectBtn.TextTruncate = Enum.TextTruncate.AtEnd
            Instance.new("UICorner", SelectBtn).CornerRadius = UDim.new(0, 6)

            local DropSearch = Instance.new("TextBox")
            DropSearch.Parent = Card
            DropSearch.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
            DropSearch.Position = UDim2.new(0, 12, 0, 60)
            DropSearch.Size = UDim2.new(1, -24, 0, 28)
            DropSearch.Font = Enum.Font.Gotham
            DropSearch.PlaceholderText = "Search..."
            DropSearch.PlaceholderColor3 = Color3.fromRGB(115, 122, 140)
            DropSearch.Text = ""
            DropSearch.TextColor3 = Color3.fromRGB(235, 235, 245)
            DropSearch.TextSize = 11
            Instance.new("UICorner", DropSearch).CornerRadius = UDim.new(0, 6)

            local ItemsScroll = Instance.new("ScrollingFrame")
            ItemsScroll.Parent = Card
            ItemsScroll.BackgroundTransparency = 1
            ItemsScroll.Position = UDim2.new(0, 12, 0, 94)
            ItemsScroll.Size = UDim2.new(1, -24, 0, 120)
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
                    local isSelected = isMulti and (H.Config[configKey] and H.Config[configKey][optName] == true) or (H.Config[configKey] == optName)
                    btnData.Check.Text = isSelected and "✓" or ""
                    btnData.Btn.BackgroundColor3 = isSelected and Color3.fromRGB(32, 38, 54) or Color3.fromRGB(26, 29, 40)
                end
            end

            for _, opt in ipairs(optionsList) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Parent = ItemsScroll
                OptBtn.BackgroundColor3 = Color3.fromRGB(26, 29, 40)
                OptBtn.Size = UDim2.new(1, 0, 0, 28)
                OptBtn.Text = "   " .. opt
                OptBtn.Font = Enum.Font.GothamMedium
                OptBtn.TextColor3 = Color3.fromRGB(225, 230, 240)
                OptBtn.TextSize = 11
                OptBtn.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 6)

                local CheckMark = Instance.new("TextLabel")
                CheckMark.Parent = OptBtn
                CheckMark.BackgroundTransparency = 1
                CheckMark.Position = UDim2.new(1, -24, 0, 0)
                CheckMark.Size = UDim2.new(0, 20, 1, 0)
                CheckMark.Font = Enum.Font.GothamBold
                CheckMark.Text = ""
                CheckMark.TextColor3 = Color3.fromRGB(88, 145, 255)
                CheckMark.TextSize = 12

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
                Card.Size = isOpen and UDim2.new(1, 0, 0, 222) or UDim2.new(1, 0, 0, 54)
            end)

            return { Refresh = RefreshOptions }
        end

        function TabObj:AddButton(titleText, subText, callback)
            local BtnCard = Instance.new("TextButton")
            BtnCard.Parent = Page
            BtnCard.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
            BtnCard.Size = UDim2.new(1, 0, 0, subText ~= "" and 50 or 40)
            BtnCard.Text = ""
            BtnCard.AutoButtonColor = false
            Instance.new("UICorner", BtnCard).CornerRadius = UDim.new(0, 8)

            local Key = Instance.new("StringValue", BtnCard)
            Key.Name = "SearchKey"
            Key.Value = titleText .. " " .. (subText or "")

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Parent = BtnCard
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Position = UDim2.new(0, 12, 0, subText ~= "" and 7 or 11)
            TitleLbl.Size = UDim2.new(1, -40, 0, 18)
            TitleLbl.Font = Enum.Font.GothamBold
            TitleLbl.Text = titleText
            TitleLbl.TextColor3 = Color3.fromRGB(240, 240, 248)
            TitleLbl.TextSize = 12
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left

            if subText and subText ~= "" then
                local SubLbl = Instance.new("TextLabel")
                SubLbl.Parent = BtnCard
                SubLbl.BackgroundTransparency = 1
                SubLbl.Position = UDim2.new(0, 12, 0, 26)
                SubLbl.Size = UDim2.new(1, -40, 0, 16)
                SubLbl.Font = Enum.Font.Gotham
                SubLbl.Text = subText
                SubLbl.TextColor3 = Color3.fromRGB(130, 138, 156)
                SubLbl.TextSize = 11
                SubLbl.TextXAlignment = Enum.TextXAlignment.Left
            end

            BtnCard.MouseButton1Click:Connect(function()
                if callback then task.spawn(callback) end
            end)
        end

        function TabObj:AddStatusCard(titleText, defaultVal, statusKey)
            local Card = Instance.new("Frame")
            Card.Parent = Page
            Card.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
            Card.Size = UDim2.new(1, 0, 0, 52)
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

            local Key = Instance.new("StringValue", Card)
            Key.Name = "SearchKey"
            Key.Value = titleText

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Parent = Card
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Position = UDim2.new(0, 12, 0, 8)
            TitleLbl.Size = UDim2.new(1, -24, 0, 18)
            TitleLbl.Font = Enum.Font.GothamBold
            TitleLbl.Text = titleText
            TitleLbl.TextColor3 = Color3.fromRGB(240, 240, 248)
            TitleLbl.TextSize = 12
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left

            local ValLbl = Instance.new("TextLabel")
            ValLbl.Parent = Card
            ValLbl.BackgroundTransparency = 1
            ValLbl.Position = UDim2.new(0, 12, 0, 27)
            ValLbl.Size = UDim2.new(1, -24, 0, 16)
            ValLbl.Font = Enum.Font.Gotham
            ValLbl.Text = defaultVal
            ValLbl.TextColor3 = Color3.fromRGB(140, 148, 168)
            ValLbl.TextSize = 11
            ValLbl.TextXAlignment = Enum.TextXAlignment.Left

            if statusKey then H.StatusLabels[statusKey] = ValLbl end
            return ValLbl
        end

        return TabObj
    end

    -- 6. DỰNG ĐỦ 6 TAB GIAO DIỆN
    H.TabStatus = H:CreateTab("Status", "Character progress and server information.")
    H.TabFarmSettings = H:CreateTab("Farm Settings", "Combat and farming preferences.")
    H.TabMain = H:CreateTab("Main", "Farming and progression.")
    H.TabMultiFarm = H:CreateTab("Multi Farm", "Combine farming targets and activities.")
    H.TabQuests = H:CreateTab("Quests", "Quest completion and special unlocks.")
    H.TabItems = H:CreateTab("Items", "Collect and manage equipment and materials.")

    -- Tab 1: Status
    local TStatus = H.TabStatus
    TStatus:AddStatusCard("Place Id", tostring(game.PlaceId), "PlaceId")
    TStatus:AddStatusCard("Session Time", "0 Minute(s), 0 Second(s)", "SessionTime")
    TStatus:AddStatusCard("Server Age", "0 Hr(s), 0 Min(s), 0 Sec(s)", "ServerAge")
    TStatus:AddSection("Local Stats")
    TStatus:AddStatusCard("Elite Progress", "N/A", "EliteProgress")
    TStatus:AddStatusCard("Ken Level", "N/A", "KenLevel")
    TStatus:AddStatusCard("Cake Prince", "N/A", "CakePrince")
    TStatus:AddStatusCard("Mystic Island", "N/A", "MysticIsland")
    TStatus:AddStatusCard("Moon Status", "Phase: 4/8", "MoonStatus")
    TStatus:AddStatusCard("Prehistoric Island", "N/A", "PrehistoricIsland")
    TStatus:AddStatusCard("Awakened Bosses", "Auto Awakened Bosses is off", "AwakenedBosses")
    TStatus:AddStatusCard("Race Tier", "N/A", "RaceTier")
    TStatus:AddStatusCard("Pull Lever", "❌", "PullLever")

    -- Tab 2: Farm Settings
    local TFarm = H.TabFarmSettings
    TFarm:AddDropdown("Select Weapon", "Choose which weapon type...", "SelectWeapon", {"Melee", "Sword", "Gun", "Blox Fruit"}, false)
    TFarm:AddSection("Character Settings")
    TFarm:AddToggle("Auto Use Buso", "Auto-activates Buso (Armament) Haki.", "AutoBuso")
    TFarm:AddToggle("Auto Use Ken", "Auto-activates Ken (Observation) Haki.", "AutoKen")
    TFarm:AddSection("Race Ability Settings")
    TFarm:AddToggle("Auto Turn On Race V3", "Auto-activates your V3 race ability.", "AutoRaceV3")
    TFarm:AddToggle("Auto Turn On Race V4", "Auto-activates your V4 transformation.", "AutoRaceV4")
    TFarm:AddSection("Farm Settings")
    TFarm:AddToggle("Remove Notify Text", "Hides in-game notification popups.", "RemoveNotify")
    TFarm:AddToggle("Bring Mob", "Pulls nearby mobs to you while farming.", "BringMob")
    TFarm:AddSlider("Tween Speed", "Travel speed of the farm tween (studs/sec).", "TweenSpeed", 50, 350)
    TFarm:AddToggle("Bypass Teleport", "Crosses the map by setting spawn point.", "BypassTeleport")
    TFarm:AddToggle("Fast Teleport", "Warp across short distances.", "FastTeleport")
    TFarm:AddSection("Mastery Skill Settings")
    TFarm:AddDropdown("Select Skill", "Pick which skill keys...", "MasterySkills", {"Z", "X", "C", "V", "F"}, true)
    TFarm:AddToggle("Holding", "Holds skill keys for set duration.", "HoldingSkill")
    TFarm:AddSlider("Hold Z", "Seconds to hold skill Z.", "HoldZ", 0, 5)
    TFarm:AddSlider("Hold X", "Seconds to hold skill X.", "HoldX", 0, 5)
    TFarm:AddSlider("Hold C", "Seconds to hold skill C.", "HoldC", 0, 5)
    TFarm:AddSlider("Hold V", "Seconds to hold skill V.", "HoldV", 0, 5)
    TFarm:AddSection("Distance Settings")
    TFarm:AddSlider("Distance X", "X-axis offset from target.", "DistanceX", -30, 30)
    TFarm:AddSlider("Distance Y", "Y-axis (height) offset from target.", "DistanceY", -30, 30)
    TFarm:AddSlider("Distance Z", "Z-axis offset from target.", "DistanceZ", -30, 30)

    -- Tab 3: Main
    local TMain = H.TabMain
    TMain:AddToggle("Auto Farm Level", "Automatically farms mobs to level up.", "AutoFarmLevel")
    TMain:AddSection("Secret Quests")
    TMain:AddToggle("Auto Secret Quests", "Completes available Secret Quests.", "AutoSecretQuests")
    TMain:AddDropdown("Secret Quest", "Auto follows quest progression.", "SelectedSecretQuest", {"Auto", "Middle Town | Early Access", "Jungle | Zipline Repair", "Pirate Village | Tavern Brawl", "Desert | Save Hasan", "Frozen Village | Breaking the Ice", "Marine Fortress | Pirate Raid"}, false)
    TMain:AddStatusCard("Secret Quest Status", "0/39 | Auto Secret Quests is off", "SecretQuestStatus")

    TMain:AddSection("Awakened Bosses")
    TMain:AddToggle("Auto Awakened Bosses", "Farms active Awakened Bosses.", "AutoAwakenedBosses")
    local AwakenedBossList = {"Gorilla King", "Chef", "Yeti", "Vice Admiral", "Warden", "Magma General", "Fishman Lord", "Sky Warlord", "Lightning God", "Cyborg"}
    local AwkDrop = TMain:AddDropdown("Select...", "Choose Awakened Bosses...", "SelectedAwakenedBosses", AwakenedBossList, true)
    TMain:AddButton("Select All Awakened Bosses", "", function()
        for _, b in ipairs(AwakenedBossList) do H.Config.SelectedAwakenedBosses[b] = true end
        AwkDrop.Refresh()
    end)
    TMain:AddButton("Clear Awakened Boss Selection", "", function()
        H.Config.SelectedAwakenedBosses = {}
        AwkDrop.Refresh()
    end)
    TMain:AddToggle("Hop For Selected Awakened Bosses", "Changes server when boss is not spawned.", "HopAwakenedBosses")

    TMain:AddSection("Word Quest")
    TMain:AddToggle("Auto Dressrosa Quest", "Completes Dressrosa (World 2) quest.", "AutoDressrosa")
    TMain:AddToggle("Auto Zou Quest", "Completes Zou (World 3) quest.", "AutoZou")

    TMain:AddSection("Fishing")
    TMain:AddDropdown("Select Bait", "Selects fishing bait.", "SelectBait", {"None", "Basic Bait", "Good Bait", "Epic Bait", "Abyssal Bait"}, false)
    TMain:AddToggle("Auto Buy Bait", "Automatically buys fishing bait.", "AutoBuyBait")
    TMain:AddToggle("Auto Sell Fish", "Automatically sells caught fish.", "AutoSellFish")
    TMain:AddToggle("Auto Fishing", "Automatically fishes at your set position.", "AutoFishing")
    TMain:AddButton("Set Fishing Position", "Saves your current position as fishing spot.", function()
        if H.LocalPlayer.Character and H.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            H.Config.FishingPos = H.LocalPlayer.Character.HumanoidRootPart.CFrame
            Notify(H.HubName, "Đã lưu vị trí câu cá!", 2)
        end
    end)

    TMain:AddSection("Tyrant & Cake Prince & Bone")
    TMain:AddToggle("Auto Farm Tyrant", "Automatically farms the Tyrant boss.", "AutoFarmTyrant")
    TMain:AddToggle("Auto Farm Dough Boss", "Automatically farms the Dough/Cake boss.", "AutoFarmDoughBoss")
    TMain:AddToggle("Auto Spawn Boss", "Automatically spawns the Cake Prince boss.", "AutoSpawnCakeBoss")
    TMain:AddToggle("Auto Farm Bone", "Automatically farms Bones at Haunted Castle.", "AutoFarmBone")

    TMain:AddSection("Mastery")
    TMain:AddDropdown("Select Method", "Selects mastery farming mode.", "MasteryMethod", {"Cake", "Bone", "Level"}, false)
    TMain:AddSlider("Kill At", "Enemy HP % at which to switch weapon.", "KillAtHP", 1, 100)
    TMain:AddToggle("Auto Farm Gun Mastery", "Automatically farms Gun mastery.", "AutoFarmGunMastery")
    TMain:AddToggle("Auto Farm Fruit Mastery", "Automatically farms Devil Fruit mastery.", "AutoFarmFruitMastery")

    TMain:AddSection("Boss & Chest & Mob")
    local BossList = {"None", "Gorilla King", "Chef", "Yeti", "Mob Leader", "Vice Admiral", "Warden", "Magma General", "Fishman Lord", "Saber Expert", "Sky Warlord", "Lightning God", "Cyborg"}
    TMain:AddDropdown("Select Boss", "Selects which boss to farm.", "SelectedBoss", BossList, false)
    TMain:AddToggle("Auto Farm Boss", "Automatically farms the selected boss.", "AutoFarmBoss")
    TMain:AddToggle("Auto Farm Chest", "Automatically collects chests around the map.", "AutoFarmChest")
    TMain:AddToggle("Hop Farm Chest", "Server-hops to farm chests continuously.", "HopFarmChest")
    TMain:AddToggle("Mob Aura", "Automatically attacks all nearby mobs.", "MobAura")

    -- Tab 4: Multi Farm
    local TMulti = H.TabMultiFarm
    TMulti:AddSection("World 2 & World 3")
    TMulti:AddToggle("Auto Farm Factory", "Automatically farms the Factory.", "AutoFarmFactory")
    TMulti:AddToggle("Auto Farm Darkbeard", "Automatically farms Darkbeard.", "AutoFarmDarkbeard")
    TMulti:AddToggle("Find Chest Farm Darkbeard", "Farms chests for Fist of Darkness.", "FindChestDarkbeard")
    TMulti:AddToggle("Hop Farm Darkbeard", "Hops servers for Darkbeard.", "HopFarmDarkbeard")
    TMulti:AddToggle("Auto Castle Raid", "Automatically farms Castle on the Sea raid.", "AutoCastleRaid")
    TMulti:AddToggle("Auto Farm Elite Hunter", "Automatically farms Elite enemies.", "AutoFarmEliteHunter")
    TMulti:AddToggle("Hop Farm Elite Hunter", "Server-hops while farming Elite Hunters.", "HopFarmEliteHunter")
    TMulti:AddToggle("Stop Hop While Have God's Chalice", "Stops hopping when holding Chalice.", "StopHopGodChalice")
    TMulti:AddToggle("Auto Farm Soul Reaper", "Automatically farms Soul Reaper.", "AutoFarmSoulReaper")
    TMulti:AddSection("Fighting Styles")
    TMulti:AddToggle("Auto Get Superhuman", "Unlocks Superhuman.", "AutoSuperhuman")
    TMulti:AddToggle("Auto Get Death Step", "Unlocks Death Step.", "AutoDeathStep")
    TMulti:AddToggle("Auto Get Sharkman Karate", "Unlocks Sharkman Karate.", "AutoSharkmanKarate")
    TMulti:AddToggle("Auto Get Electric Claw", "Unlocks Electric Claw.", "AutoElectricClaw")
    TMulti:AddToggle("Auto Get Dragon Talon", "Unlocks Dragon Talon.", "AutoDragonTalon")
    TMulti:AddToggle("Auto Get Godhuman", "Unlocks Godhuman.", "AutoGodhuman")
    TMulti:AddSection("Stats")
    TMulti:AddDropdown("Select Stats", "Selects which stats to upgrade.", "SelectedStats", {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}, true)
    TMulti:AddToggle("Auto Stats", "Automatically spends stat points.", "AutoStats")

    -- Tab 5: Quests
    local TQuests = H.TabQuests
    TQuests:AddToggle("Auto Bartilo Quest", "Completes Bartilo quest.", "AutoBartilo")
    TQuests:AddToggle("Auto Dojo Quest", "Completes Dojo quest.", "AutoDojoQuest")
    TQuests:AddToggle("Auto Upgrade Ken V2", "Upgrades Observation Haki V2.", "AutoUpgradeKenV2")
    TQuests:AddToggle("Auto Rainbow Haki Quest", "Completes Rainbow Haki quest.", "AutoRainbowHaki")
    TQuests:AddToggle("Auto Citizen Quest", "Completes Citizen quest.", "AutoCitizenQuest")

    -- Tab 6: Items
    local TItems = H.TabItems
    TItems:AddToggle("Auto Get Saber", "Gets the Saber sword (World 1).", "AutoSaber")
    TItems:AddToggle("Auto Rengoku", "Gets the Rengoku sword (World 2).", "AutoRengoku")
    TItems:AddToggle("Auto Get Yama", "Gets the Yama sword (World 3).", "AutoYama")
    TItems:AddToggle("Auto Get Tushita", "Gets the Tushita sword (World 3).", "AutoTushita")
    TItems:AddToggle("Auto Get CDK", "Gets Cursed Dual Katana.", "AutoCDK")
    TItems:AddToggle("Auto Rip Indra", "Fights Rip Indra boss.", "AutoRipIndra")
    TItems:AddToggle("Auto Random Bone", "Buys Random Surprise from Death King.", "AutoRandomBone")
    TItems:AddToggle("Auto Buy Haki Color", "Buys Haki color from Dealer.", "AutoBuyHakiColor")
    TItems:AddToggle("Auto Buy Legendary Sword", "Buys Legendary Swords from Dealer.", "AutoBuyLegSword")
    TItems:AddDropdown("Select Materials", "Selects material to farm.", "SelectedMaterial", {"None", "Leather", "Scrap Metal", "Angel Wings", "Magma Ore", "Fish Tail", "Mystic Droplet", "Vampire Fang", "Demonic Wisp", "Dragon Scale", "Conjured Cocoa", "Mini Tusk"}, false)
    TItems:AddToggle("Auto Farm Materials", "Farms the selected material.", "AutoFarmMaterials")
    TItems:AddToggle("Auto Farm Ectoplasm", "Farms Ectoplasm at Cursed Ship.", "AutoFarmEctoplasm")

    H.TabMain.Activate()

    -- ==============================================================================
    -- // 7. HỆ THỐNG LOGIC CHẠY NGẦM (FARM, TWEEN, CHEST, BOSS, HOP) //
    -- ==============================================================================

    -- Anti-AFK
    H.LocalPlayer.Idled:Connect(function()
        pcall(function()
            H.Services.VirtualUser:CaptureController()
            H.Services.VirtualUser:ClickButton2(Vector2.new())
        end)
    end)

    function H:InvokeCommF(...)
        local args = {...}
        local ok, res = pcall(function()
            local rem = H.Services.ReplicatedStorage:FindFirstChild("Remotes")
            if rem and rem:FindFirstChild("CommF_") then
                return rem.CommF_:InvokeServer(Unpack(args))
            end
        end)
        return ok and res or nil
    end

    function H:HasItem(itemName)
        local bp = H.LocalPlayer:FindFirstChild("Backpack")
        local char = H.LocalPlayer.Character
        return (bp and bp:FindFirstChild(itemName) ~= nil) or (char and char:FindFirstChild(itemName) ~= nil)
    end

    H.IsHopping = false
    function H:HopServer()
        if H.IsHopping then return end
        if H.Config.StopHopGodChalice and (H:HasItem("God's Chalice") or H:HasItem("Sweet Chalice")) then return end
        H.IsHopping = true
        task.spawn(function()
            pcall(function()
                local url = "[https://games.roblox.com/v1/games/](https://games.roblox.com/v1/games/)" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Desc&limit=100"
                local res = H.Services.HttpService:JSONDecode(game:HttpGet(url))
                if res and res.data then
                    for _, srv in ipairs(res.data) do
                        if type(srv) == "table" and tonumber(srv.playing) and tonumber(srv.maxPlayers) then
                            if srv.playing < (srv.maxPlayers - 1) and srv.id ~= game.JobId then
                                H.Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, H.LocalPlayer)
                                task.wait(3)
                            end
                        end
                    end
                end
            end)
            task.wait(4)
            H.IsHopping = false
        end)
    end

    function H:IsAnyFarmActive()
        local c = H.Config
        return c.AutoFarmLevel or c.AutoSecretQuests or c.AutoAwakenedBosses or c.AutoDressrosa
            or c.AutoZou or c.AutoFarmTyrant or c.AutoFarmDoughBoss or c.AutoFarmBone
            or c.AutoFarmGunMastery or c.AutoFarmFruitMastery or c.AutoFarmBoss
            or c.AutoFarmChest or c.HopFarmChest or c.MobAura or c.AutoFarmFactory
            or c.AutoFarmDarkbeard or c.FindChestDarkbeard or c.AutoCastleRaid
            or c.AutoFarmEliteHunter or c.AutoFarmSoulReaper or c.AutoSaber
            or c.AutoRengoku or c.AutoRipIndra or c.AutoFarmMaterials or c.AutoFarmEctoplasm or c.AutoFishing
    end

    -- Noclip & Chống rơi khi đang bật Farm
    H.ActiveTween = nil
    H.LastTweenTarget = nil

    H.Services.RunService.Stepped:Connect(function()
        local char = H.LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")

        if H:IsAnyFarmActive() then
            if hum and hum.Sit then hum.Sit = false end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
            if hrp then
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
                H.ActiveTween:Cancel()
                H.ActiveTween = nil
                H.LastTweenTarget = nil
            end
        end
    end)

    function H:TweenTo(targetCF, applyOffset)
        local char = H.LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp or not targetCF then return false end

        local goalCF = targetCF
        if applyOffset then
            goalCF = targetCF * CFrame.new(H.Config.DistanceX or 0, H.Config.DistanceY or 15, H.Config.DistanceZ or 0)
        end

        local dist = (hrp.Position - goalCF.Position).Magnitude
        if dist <= 18 or (H.Config.FastTeleport and dist <= 230) then
            if H.ActiveTween then H.ActiveTween:Cancel(); H.ActiveTween = nil end
            hrp.CFrame = goalCF
            return true
        end

        if H.ActiveTween and H.LastTweenTarget and (H.LastTweenTarget - goalCF.Position).Magnitude < 4 then
            if H.ActiveTween.PlaybackState == Enum.PlaybackState.Playing then
                return false
            end
        end

        if H.ActiveTween then H.ActiveTween:Cancel() end
        local speed = math.clamp(tonumber(H.Config.TweenSpeed) or 170, 50, 350)
        H.LastTweenTarget = goalCF.Position
        H.ActiveTween = H.Services.TweenService:Create(
            hrp,
            TweenInfo.new(math.max(0.05, dist / speed), Enum.EasingStyle.Linear),
            { CFrame = goalCF }
        )
        H.ActiveTween:Play()
        return false
    end

    -- Nhận diện Vũ Khí Đa Ngôn Ngữ (Tiếng Việt + Tiếng Anh)
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
        if equipped and IsMatchingWeapon(equipped, wType) then return end

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
    end

    local function CleanMobName(name)
        if not name then return "" end
        return (string.gsub(name, "%s*%[Lv%.%s*%d+%]", ""))
    end

    function H:BringNearbyMobs(mobFilterName, bringPosCF)
        if not H.Config.BringMob or not bringPosCF then return end
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
                local isSame = (not cleanFilter) or string.find(mob.Name, cleanFilter, 1, true)
                if isSame and (hrp.Position - bringPosCF.Position).Magnitude <= 300 then
                    hrp.CFrame = bringPosCF
                    hrp.CanCollide = false
                    hum.WalkSpeed = 0
                    hum.JumpPower = 0
                end
            end
        end
    end

    function H:AttackTarget()
        local char = H.LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end

        local tool = char:FindFirstChildOfClass("Tool")
        if tool then pcall(function() tool:Activate() end) end

        pcall(function()
            local modules = H.Services.ReplicatedStorage:FindFirstChild("Modules")
            local net = modules and modules:FindFirstChild("Net")
            if net then
                local regAttack = net:FindFirstChild("RE/RegisterAttack")
                local regHit = net:FindFirstChild("RE/RegisterHit")
                if regAttack then regAttack:FireServer(0) end
                if regHit then
                    local enemies = H.Services.Workspace:FindFirstChild("Enemies")
                    local targets, mainPart = {}, nil
                    if enemies then
                        for _, mob in ipairs(enemies:GetChildren()) do
                            local hrp = mob:FindFirstChild("HumanoidRootPart")
                            local hum = mob:FindFirstChildOfClass("Humanoid")
                            if hrp and hum and hum.Health > 0 and (hrp.Position - char.HumanoidRootPart.Position).Magnitude <= 65 then
                                mainPart = mainPart or hrp
                                table.insert(targets, { mob, hrp })
                            end
                        end
                    end
                    if mainPart then regHit:FireServer(mainPart, targets) end
                end
            end
        end)

        pcall(function()
            H.Services.VirtualUser:CaptureController()
            H.Services.VirtualUser:ClickButton1(Vector2.new(800, 500))
        end)
    end

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
                    local cf = CleanMobName(nameFilter)
                    match = (cleanMob == cf or string.find(cleanMob, cf, 1, true) ~= nil)
                elseif type(nameFilter) == "table" then
                    for k, v in pairs(nameFilter) do
                        if v and (cleanMob == k or string.find(cleanMob, k, 1, true) ~= nil) then
                            match = true; break
                        end
                    end
                end
                if match then
                    local d = (hrp.Position - myPos).Magnitude
                    if d < minDist then minDist = d; closest = mob end
                end
            end
        end
        return closest
    end

    function H:GetMobSpawnCFrame(mobName, fallbackCF)
        if not mobName or mobName == "" then return fallbackCF end
        local cleanTarget = string.lower(CleanMobName(mobName))
        local wo = H.Services.Workspace:FindFirstChild("_WorldOrigin")
        local spawns = wo and wo:FindFirstChild("EnemySpawns")
        if spawns then
            for _, sp in ipairs(spawns:GetChildren()) do
                local cleanSp = string.lower(CleanMobName(sp.Name))
                if cleanSp == cleanTarget or string.find(cleanSp, cleanTarget, 1, true) then
                    if sp:IsA("BasePart") then return sp.CFrame end
                    if sp:IsA("Model") then return sp:GetPivot() end
                end
            end
        end
        return fallbackCF
    end

    local QuestDatabase = {
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
        { Sea = 1, MinLv = 190, MaxLv = 209, QuestName = "PrisonerQuest", QuestLv = 1, Mob = "Prisoner", NPCPos = CFrame.new(5308, 2, 474), MobPos = CFrame.new(5098, 0, 474) },
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
        { Sea = 2, MinLv = 700, MaxLv = 724, QuestName = "Area1Quest", QuestLv = 1, Mob = "Raider", NPCPos = CFrame.new(-429, 72, 1836), MobPos = CFrame.new(-728, 52, 2345) },
        { Sea = 2, MinLv = 725, MaxLv = 774, QuestName = "Area1Quest", QuestLv = 2, Mob = "Mercenary", NPCPos = CFrame.new(-429, 72, 1836), MobPos = CFrame.new(-1004, 80, 1424) },
        { Sea = 2, MinLv = 775, MaxLv = 9999, QuestName = "Area2Quest", QuestLv = 1, Mob = "Swan Pirate", NPCPos = CFrame.new(638, 73, 918), MobPos = CFrame.new(1068, 137, 1322) },
        { Sea = 3, MinLv = 1500, MaxLv = 9999, QuestName = "PiratePortQuest", QuestLv = 1, Mob = "Pirate Millionaire", NPCPos = CFrame.new(-290, 42, 5581), MobPos = CFrame.new(-245, 47, 5584) }
    }

    function H:GetQuestInfoByLevel()
        local data = H.LocalPlayer:FindFirstChild("Data")
        local lvl = (data and data:FindFirstChild("Level") and data.Level.Value) or 1
        if H.CurrentSea == 1 and lvl < 10 and H.LocalPlayer.Team and string.find(string.lower(H.LocalPlayer.Team.Name), "marine") then
            return { QuestName = "MarineQuest", QuestLv = 1, Mob = "Trainee", NPCPos = CFrame.new(-2709, 24, 2104), MobPos = CFrame.new(-2752, 25, 2066) }
        end
        for _, q in ipairs(QuestDatabase) do
            if q.Sea == H.CurrentSea and lvl >= q.MinLv and lvl <= q.MaxLv then
                return q
            end
        end
        return QuestDatabase[1]
    end

    function H:EngageEnemy(enemy)
        if not enemy then return end
        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        local hum = enemy:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end

        H:UpdateCharacterBuffs()
        local hpPct = (hum.Health / math.max(1, hum.MaxHealth)) * 100
        if H.Config.AutoFarmFruitMastery and hpPct <= H.Config.KillAtHP then
            H:EquipWeapon("Blox Fruit")
        elseif H.Config.AutoFarmGunMastery and hpPct <= H.Config.KillAtHP then
            H:EquipWeapon("Gun")
        else
            H:EquipWeapon(H.Config.SelectWeapon)
        end
        H:TweenTo(hrp.CFrame, true)
        H:BringNearbyMobs(enemy.Name, hrp.CFrame)
        H:AttackTarget()
    end

    function H:GetClosestChest()
        local myPos = (H.LocalPlayer.Character and H.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and H.LocalPlayer.Character.HumanoidRootPart.Position) or Vector3.zero
        local bestCF, bestPart, minDist = nil, nil, math.huge

        local function CheckObj(obj)
            if obj:IsA("Model") and string.find(string.lower(obj.Name), "chest", 1, true) then
                local part = obj.PrimaryPart or obj:FindFirstChild("RootPart") or obj:FindFirstChild("PushBox") or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    local d = (part.Position - myPos).Magnitude
                    if d < minDist then minDist = d; bestCF = part.CFrame; bestPart = part end
                end
            elseif obj:IsA("BasePart") and string.find(string.lower(obj.Name), "chest", 1, true) and obj.Transparency < 1 then
                local d = (obj.Position - myPos).Magnitude
                if d < minDist then minDist = d; bestCF = obj.CFrame; bestPart = obj end
            end
        end

        local chestModels = H.Services.Workspace:FindFirstChild("ChestModels")
        if chestModels then
            for _, c in ipairs(chestModels:GetChildren()) do CheckObj(c) end
        end
        for _, c in ipairs(H.Services.Workspace:GetChildren()) do CheckObj(c) end
        return bestCF, bestPart
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
                local data = H.LocalPlayer:FindFirstChild("Data")
                if data and data:FindFirstChild("Race") and H.StatusLabels.RaceTier then
                    H.StatusLabels.RaceTier.Text = tostring(data.Race.Value)
                end
            end)
        end
    end)

    -- Vòng lặp thực thi Farm Chính
    task.spawn(function()
        while task.wait(0.15) do
            if not H.ScreenGui or not H.ScreenGui.Parent then break end
            pcall(function()
                if H.Config.MobAura then
                    local nearMob = H:GetAliveEnemy(nil)
                    if nearMob then H:EngageEnemy(nearMob); return end
                end

                if H.Config.AutoFarmChest or H.Config.HopFarmChest then
                    local chestCF, chestPart = H:GetClosestChest()
                    if chestCF then
                        H:TweenTo(chestCF, false)
                        if chestPart and H.LocalPlayer.Character and H.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            if (H.LocalPlayer.Character.HumanoidRootPart.Position - chestCF.Position).Magnitude <= 20 then
                                pcall(function()
                                    if firetouchinterest then
                                        firetouchinterest(H.LocalPlayer.Character.HumanoidRootPart, chestPart, 0)
                                        firetouchinterest(H.LocalPlayer.Character.HumanoidRootPart, chestPart, 1)
                                    end
                                end)
                            end
                        end
                    elseif H.Config.HopFarmChest then
                        H:HopServer()
                    end
                    return
                end

                if H.Config.AutoFarmLevel then
                    local qInfo = H:GetQuestInfoByLevel()
                    local pgui = H.LocalPlayer:FindFirstChild("PlayerGui")
                    local questGui = pgui and pgui:FindFirstChild("Main") and pgui.Main:FindFirstChild("Quest")
                    local hasQuest = questGui and questGui.Visible

                    if not hasQuest then
                        H:TweenTo(qInfo.NPCPos, false)
                        local hrp = H.LocalPlayer.Character and H.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and (hrp.Position - qInfo.NPCPos.Position).Magnitude <= 25 then
                            H:InvokeCommF("StartQuest", qInfo.QuestName, qInfo.QuestLv)
                            task.wait(0.2)
                        end
                    else
                        local target = H:GetAliveEnemy(qInfo.Mob)
                        if target then
                            H:EngageEnemy(target)
                        else
                            local spawnCF = H:GetMobSpawnCFrame(qInfo.Mob, qInfo.MobPos)
                            if spawnCF then H:TweenTo(spawnCF, true) end
                        end
                    end
                    return
                end

                if H.Config.AutoFarmBoss and H.Config.SelectedBoss ~= "None" then
                    local b = H:GetAliveEnemy(H.Config.SelectedBoss)
                    if b then H:EngageEnemy(b) end
                    return
                end

                if H.Config.AutoAwakenedBosses then
                    local awk = H:GetAliveEnemy(H.Config.SelectedAwakenedBosses)
                    if awk then
                        H:EngageEnemy(awk)
                    elseif H.Config.HopAwakenedBosses then
                        H:HopServer()
                    end
                    return
                end

                if H.Config.AutoFarmBone then
                    local bm = H:GetAliveEnemy({ ["Reborn Skeleton"] = true, ["Living Zombie"] = true, ["Demonic Soul"] = true, ["Posessed Mummy"] = true })
                    if bm then H:EngageEnemy(bm) else H:TweenTo(CFrame.new(-9515, 142, 5535), true) end
                    return
                end

                if H.Config.AutoFarmDoughBoss then
                    local boss = H:GetAliveEnemy("Cake Prince") or H:GetAliveEnemy("Dough King")
                    if boss then
                        H:EngageEnemy(boss)
                    else
                        local cm = H:GetAliveEnemy({ ["Cookie Crafter"] = true, ["Cake Guard"] = true, ["Baking Staff"] = true, ["Head Baker"] = true })
                        if cm then H:EngageEnemy(cm) else H:TweenTo(CFrame.new(-2077, 70, -12370), true) end
                    end
                    return
                end
            end)
        end
    end)

    -- Vòng lặp Multi Farm, Stats & Items
    task.spawn(function()
        while task.wait(0.4) do
            if not H.ScreenGui or not H.ScreenGui.Parent then break end
            pcall(function()
                if H.Config.AutoStats and type(H.Config.SelectedStats) == "table" then
                    local data = H.LocalPlayer:FindFirstChild("Data")
                    local pts = data and data:FindFirstChild("Points") and data.Points.Value or 0
                    if pts > 0 then
                        for statName, isSelected in pairs(H.Config.SelectedStats) do
                            if isSelected then H:InvokeCommF("AddPoint", statName, math.min(pts, 3)) end
                        end
                    end
                end
                if H.Config.AutoSuperhuman then H:InvokeCommF("BuySuperhuman") end
                if H.Config.AutoDeathStep then H:InvokeCommF("BuyDeathStep") end
                if H.Config.AutoSharkmanKarate then H:InvokeCommF("BuySharkmanKarate") end
                if H.Config.AutoElectricClaw then H:InvokeCommF("BuyElectricClaw") end
                if H.Config.AutoDragonTalon then H:InvokeCommF("BuyDragonTalon") end
                if H.Config.AutoGodhuman then H:InvokeCommF("BuyGodhuman") end
                if H.Config.AutoRandomBone then H:InvokeCommF("Bones", "Buy", 1, 1) end
            end)
        end
    end)

    Notify(H.HubName, "Đã nạp thành công 100%! Bấm nút nổi để đóng/mở.", 5)
end, debug.traceback)

if not MainSuccess then
    warn("[hzayday_bloxfruit LỖI]: " .. tostring(MainError))
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Lỗi Script hzayday",
            Text = tostring(MainError),
            Duration = 10
        })
    end)
end
-- ==============================================================================
-- // KẾT THÚC FILE (ĐÓNG FILE) //
-- ==============================================================================
