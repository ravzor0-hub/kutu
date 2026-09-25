local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local GOD_MOD_ENABLED = false
local AUTO_CHEST_ENABLED = false
local ROCKS_HIDDEN = false
local ALWAYS_DAY = false
local boatSpeed = 1
local Number = math.random(1, 1000000)
local vu523 = false

local renderConnection = nil
local autoAttackConnection = nil
local fruitEspLoop = nil
local alwaysDayLoop = nil
local espConnections = {}
local speed = 350
local defaultSpeed = 16

local gui = Instance.new("ScreenGui")
gui.Name = "GodHubUI"
gui.ResetOnSpawn = false
if gethui then
    gui.Parent = gethui()
elseif syn and syn.protect_gui then 
    syn.protect_gui(gui)
    gui.Parent = CoreGui
else
    gui.Parent = CoreGui
end

local mainFrame = Instance.new("Frame", gui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 180, 0, 80)
mainFrame.Position = UDim2.new(0.5, -90, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)

local title = Instance.new("TextLabel", mainFrame)
title.Name = "Title"
title.Size = UDim2.new(1, -25, 0, 24)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "God Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 6)

local expandBtn = Instance.new("TextButton", mainFrame)
expandBtn.Size = UDim2.new(0, 25, 0, 24)
expandBtn.Position = UDim2.new(1, -25, 0, 0)
expandBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
expandBtn.BorderSizePixel = 0
expandBtn.Text = "▼"
expandBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
expandBtn.TextSize = 11
expandBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", expandBtn).CornerRadius = UDim.new(0, 6)

local godModToggle = Instance.new("TextButton", mainFrame)
godModToggle.Size = UDim2.new(0.94, 0, 0, 38)
godModToggle.Position = UDim2.new(0.03, 0, 0, 26)
godModToggle.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
godModToggle.Text = "God Mod: OFF"
godModToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
godModToggle.TextSize = 14
godModToggle.Font = Enum.Font.GothamBold
Instance.new("UICorner", godModToggle).CornerRadius = UDim.new(0, 4)

local fruitStatus = Instance.new("TextLabel", mainFrame)
fruitStatus.Size = UDim2.new(1, 0, 0, 16)
fruitStatus.Position = UDim2.new(0, 0, 0, 64)
fruitStatus.BackgroundTransparency = 1
fruitStatus.Text = "Fruits: 0"
fruitStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
fruitStatus.TextSize = 11
fruitStatus.Font = Enum.Font.Gotham

local container = Instance.new("Frame", mainFrame)
container.Name = "Container"
container.Size = UDim2.new(1, 0, 0, 140)
container.Position = UDim2.new(0, 0, 0, 80)
container.BackgroundTransparency = 1
container.Visible = false

local categoryPage = Instance.new("Frame", container)
categoryPage.Size = UDim2.new(1, 0, 1, 0)
categoryPage.BackgroundTransparency = 1
categoryPage.Visible = true

local farmSelectBtn = Instance.new("TextButton", categoryPage)
farmSelectBtn.Size = UDim2.new(0.94, 0, 0, 30)
farmSelectBtn.Position = UDim2.new(0.03, 0, 0, 5)
farmSelectBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
farmSelectBtn.Text = "Farm Menu >"
farmSelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
farmSelectBtn.TextSize = 12
farmSelectBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", farmSelectBtn).CornerRadius = UDim.new(0, 4)

local seaSelectBtn = Instance.new("TextButton", categoryPage)
seaSelectBtn.Size = UDim2.new(0.94, 0, 0, 30)
seaSelectBtn.Position = UDim2.new(0.03, 0, 0, 40)
seaSelectBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
seaSelectBtn.Text = "Sea Menu >"
seaSelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
seaSelectBtn.TextSize = 12
seaSelectBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", seaSelectBtn).CornerRadius = UDim.new(0, 4)

local farmPage = Instance.new("ScrollingFrame", container)
farmPage.Size = UDim2.new(1, 0, 1, 0)
farmPage.BackgroundTransparency = 1
farmPage.ScrollBarThickness = 2
farmPage.Visible = false
farmPage.CanvasSize = UDim2.new(0, 0, 0, 80)

local farmBackBtn = Instance.new("TextButton", farmPage)
farmBackBtn.Size = UDim2.new(0.3, 0, 0, 18)
farmBackBtn.Position = UDim2.new(0.03, 0, 0, 2)
farmBackBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
farmBackBtn.Text = "< Back"
farmBackBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
farmBackBtn.TextSize = 10
farmBackBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", farmBackBtn).CornerRadius = UDim.new(0, 4)

local autoChestBtn = Instance.new("TextButton", farmPage)
autoChestBtn.Size = UDim2.new(0.94, 0, 0, 26)
autoChestBtn.Position = UDim2.new(0.03, 0, 0, 25)
autoChestBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
autoChestBtn.Text = "Auto Chest: OFF"
autoChestBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoChestBtn.TextSize = 11
autoChestBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", autoChestBtn).CornerRadius = UDim.new(0, 4)

local chestStatusLabel = Instance.new("TextLabel", farmPage)
chestStatusLabel.Size = UDim2.new(0.94, 0, 0, 14)
chestStatusLabel.Position = UDim2.new(0.03, 0, 0, 54)
chestStatusLabel.BackgroundTransparency = 1
chestStatusLabel.Text = "Status: Idle"
chestStatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
chestStatusLabel.TextSize = 10
chestStatusLabel.Font = Enum.Font.Gotham
chestStatusLabel.TextXAlignment = Enum.TextXAlignment.Left

local seaPage = Instance.new("ScrollingFrame", container)
seaPage.Size = UDim2.new(1, 0, 1, 0)
seaPage.BackgroundTransparency = 1
seaPage.ScrollBarThickness = 2
seaPage.Visible = false
seaPage.CanvasSize = UDim2.new(0, 0, 0, 180)

local seaBackBtn = Instance.new("TextButton", seaPage)
seaBackBtn.Size = UDim2.new(0.3, 0, 0, 18)
seaBackBtn.Position = UDim2.new(0.03, 0, 0, 2)
seaBackBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
seaBackBtn.Text = "< Back"
seaBackBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
seaBackBtn.TextSize = 10
seaBackBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", seaBackBtn).CornerRadius = UDim.new(0, 4)

local boatLabel = Instance.new("TextLabel", seaPage)
boatLabel.Size = UDim2.new(0.9, 0, 0, 12)
boatLabel.Position = UDim2.new(0.03, 0, 0, 22)
boatLabel.BackgroundTransparency = 1
boatLabel.Text = "Boat Speed: 1"
boatLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
boatLabel.TextSize = 10
boatLabel.Font = Enum.Font.Gotham
boatLabel.TextXAlignment = Enum.TextXAlignment.Left

local sliderBg = Instance.new("Frame", seaPage)
sliderBg.Size = UDim2.new(0.94, 0, 0, 4)
sliderBg.Position = UDim2.new(0.03, 0, 0, 36)
sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

local sliderFill = Instance.new("Frame", sliderBg)
sliderFill.Size = UDim2.new(0, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

local sliderButton = Instance.new("TextButton", sliderBg)
sliderButton.Size = UDim2.new(0, 10, 0, 10)
sliderButton.Position = UDim2.new(0, -5, 0.5, -5)
sliderButton.Text = ""
sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", sliderButton).CornerRadius = UDim.new(1, 0)

local rocksBtn = Instance.new("TextButton", seaPage)
rocksBtn.Size = UDim2.new(0.94, 0, 0, 24)
rocksBtn.Position = UDim2.new(0.03, 0, 0, 48)
rocksBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
rocksBtn.Text = "Hide Rocks: OFF"
rocksBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rocksBtn.TextSize = 11
rocksBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", rocksBtn).CornerRadius = UDim.new(0, 4)

local dayBtn = Instance.new("TextButton", seaPage)
dayBtn.Size = UDim2.new(0.94, 0, 0, 24)
dayBtn.Position = UDim2.new(0.03, 0, 0, 76)
dayBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
dayBtn.Text = "Always Day: OFF"
dayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
dayBtn.TextSize = 11
dayBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", dayBtn).CornerRadius = UDim.new(0, 4)

local fogBtn = Instance.new("TextButton", seaPage)
fogBtn.Size = UDim2.new(0.94, 0, 0, 24)
fogBtn.Position = UDim2.new(0.03, 0, 0, 104)
fogBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
fogBtn.Text = "Remove Fog"
fogBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fogBtn.TextSize = 11
fogBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", fogBtn).CornerRadius = UDim.new(0, 4)

local dragging = false
local dragInput, mousePos, framePos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        mainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
end)

local expanded = false
expandBtn.MouseButton1Click:Connect(function()
    expanded = not expanded
    if expanded then
        mainFrame:TweenSize(UDim2.new(0, 180, 0, 220), "Out", "Quad", 0.3, true)
        expandBtn.Text = "▲"
        container.Visible = true
        categoryPage.Visible = true
        farmPage.Visible = false
        seaPage.Visible = false
    else
        mainFrame:TweenSize(UDim2.new(0, 180, 0, 80), "Out", "Quad", 0.3, true)
        expandBtn.Text = "▼"
        container.Visible = false
    end
end)

farmSelectBtn.MouseButton1Click:Connect(function() categoryPage.Visible = false farmPage.Visible = true end)
seaSelectBtn.MouseButton1Click:Connect(function() categoryPage.Visible = false seaPage.Visible = true end)
farmBackBtn.MouseButton1Click:Connect(function() farmPage.Visible = false categoryPage.Visible = true end)
seaBackBtn.MouseButton1Click:Connect(function() seaPage.Visible = false categoryPage.Visible = true end)

function CheckNearestTeleporter(p525)
    local v526 = p525.Position
    local v527 = math.huge
    local v528 = nil
    local v529 = game.PlaceId
    local v531
    if v529 == 2753915549 then
        v531 = {
            ["Sky3"] = Vector3.new(-7894, 5547, -380),
            ["Sky3Exit"] = Vector3.new(-4607, 874, -1667),
            ["UnderWater"] = Vector3.new(61163, 11, 1819),
            ["Underwater City"] = Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
            ["Pirate Village"] = Vector3.new(-1242.4625244140625, 4.787059783935547, 3901.282958984375),
            ["UnderwaterExit"] = Vector3.new(4050, -1, -1814)
        }
    elseif v529 == 4442272183 then
        v531 = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    else
        v531 = v529 == 7449423635 and {
            ["Floating Turtle"] = Vector3.new(-12462, 375, -7552),
            ["Hydra Island"] = Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
            ["Mansion"] = Vector3.new(-12462, 375, -7552),
            ["Castle"] = Vector3.new(-5036, 315, -3179),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103)
        } or {}
    end
    for _, v535 in pairs(v531) do
        local v536 = (v535 - v526).Magnitude
        if v536 < v527 then
            v528 = v535
            v527 = v536
        end
    end
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        if v527 <= (v526 - player.Character.HumanoidRootPart.Position).Magnitude then
            return v528
        end
    end
    return nil
end

function requestEntrance(p537)
    pcall(function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", p537)
        local v538 = player.Character.HumanoidRootPart
        v538.CFrame = v538.CFrame + Vector3.new(0, 50, 0)
        task.wait(0.5)
    end)
end

function topos(p540)
    local vu541 = player
    if vu541.Character and vu541.Character.Humanoid.Health > 0 and vu541.Character:FindFirstChild("HumanoidRootPart") then
        local v542 = (p540.Position - vu541.Character.HumanoidRootPart.Position).Magnitude
        if not p540 then return end
        local v543 = CheckNearestTeleporter(p540)
        if v543 then
            requestEntrance(v543)
        end
        if not vu541.Character:FindFirstChild("PartTele") then
            local v544 = Instance.new("Part", vu541.Character)
            v544.Size = Vector3.new(10, 1, 10)
            v544.Name = "PartTele"
            v544.Anchored = true
            v544.Transparency = 1
            v544.CanCollide = true
            v544.CFrame = vu541.Character.HumanoidRootPart.CFrame
            v544:GetPropertyChangedSignal("CFrame"):Connect(function()
                if vu523 then
                    task.wait()
                    if vu541.Character and vu541.Character:FindFirstChild("HumanoidRootPart") then
                        vu541.Character.HumanoidRootPart.CFrame = v544.CFrame
                    end
                end
            end)
        end
        vu523 = true
        local v547 = TweenService:Create(vu541.Character.PartTele, TweenInfo.new(v542 / 360, Enum.EasingStyle.Linear), {
            ["CFrame"] = p540
        })
        v547:Play()
        v547.Completed:Connect(function(p548)
            if p548 == Enum.PlaybackState.Completed then
                if vu541.Character:FindFirstChild("PartTele") then
                    vu541.Character.PartTele:Destroy()
                end
                vu523 = false
            end
        end)
    end
end

function stopTeleport()
    vu523 = false
    if player.Character and player.Character:FindFirstChild("PartTele") then
        player.Character.PartTele:Destroy()
    end
end

autoChestBtn.MouseButton1Click:Connect(function()
    AUTO_CHEST_ENABLED = not AUTO_CHEST_ENABLED
    if AUTO_CHEST_ENABLED then
        autoChestBtn.Text = "Auto Chest: ON"
        autoChestBtn.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
        chestStatusLabel.Text = "Status: Farming..."
    else
        autoChestBtn.Text = "Auto Chest: OFF"
        autoChestBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        chestStatusLabel.Text = "Status: Stopped"
        stopTeleport()
    end
end)

spawn(function()
    while task.wait(0.1) do
        if AUTO_CHEST_ENABLED then
            pcall(function()
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local v830 = character:GetPivot().Position
                    local v831 = CollectionService:GetTagged("_ChestTagged")
                    local v832 = math.huge
                    local v833 = nil
                    for v834 = 1, #v831 do
                        local v835 = v831[v834]
                        local v836 = (v835:GetPivot().Position - v830).Magnitude
                        if not v835:GetAttribute("IsDisabled") then
                            if v836 < v832 then
                                v833 = v835
                                v832 = v836
                            end
                        end
                    end
                    if v833 then
                        local v837 = v833:GetPivot().Position
                        local v838 = CFrame.new(v837)
                        chestStatusLabel.Text = "Going to chest..."
                        topos(v838)
                    else
                        chestStatusLabel.Text = "No chest found"
                    end
                else
                    chestStatusLabel.Text = "Waiting respawn..."
                end
            end)
        end
    end
end)

spawn(function()
    while task.wait(0.1) do
        if AUTO_CHEST_ENABLED then
            pcall(function()
                local chr = player.Character
                local hum = chr and chr:FindFirstChild("Humanoid")
                if hum and (hum.Sit or hum:GetState() == Enum.HumanoidStateType.Seated) then
                    hum.Jump = true
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end
end)

local function Round(num)
    return math.floor(tonumber(num) + 0.5)
end

local function EnableWalkWater()
    pcall(function() workspace.Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000) end)
end

local function DisableWalkWater()
    pcall(function() workspace.Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000) end)
end

local function UpdateFruitEsp()
    for _, v in pairs(workspace:GetChildren()) do
        pcall(function()
            if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                if not v.Handle:FindFirstChild("NameEsp" .. Number) then
                    local bill = Instance.new("BillboardGui", v.Handle)
                    bill.Name = "NameEsp" .. Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1, 200, 1, 30)
                    bill.Adornee = v.Handle
                    bill.AlwaysOnTop = true
                    local name = Instance.new("TextLabel", bill)
                    name.Name = "TextLabel"
                    name.Font = Enum.Font.GothamBold
                    name.TextSize = 14
                    name.TextWrapped = true
                    name.Size = UDim2.new(1, 0, 1, 0)
                    name.TextYAlignment = Enum.TextYAlignment.Top
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(255, 0, 0)
                    if player.Character and player.Character:FindFirstChild("Head") then
                        name.Text = v.Name .. " \n" .. Round((player.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. " M"
                    else
                        name.Text = v.Name
                    end
                else
                    if player.Character and player.Character:FindFirstChild("Head") then
                        v.Handle["NameEsp" .. Number].TextLabel.Text = v.Name .. " \n" .. Round((player.Character.Head.Position - v.Handle.Position).Magnitude / 3) .. " M"
                    end
                end
            end
        end)
    end
end

local function CleanupFruitEsp()
    for _, v in pairs(workspace:GetChildren()) do
        pcall(function()
            if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                local esp = v.Handle:FindFirstChild("NameEsp" .. Number)
                if esp then esp:Destroy() end
            end
        end)
    end
end

local function createPlayerESP(character, targetPlayer)
    if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Head") then return end
    local success, nameText = pcall(function() return Drawing.new("Text") end)
    if not success then return end
    nameText.Visible = false
    nameText.Center = true
    nameText.Outline = true
    nameText.Color = Color3.fromRGB(255, 255, 255)
    nameText.Size = 20
    nameText.Font = 2
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not GOD_MOD_ENABLED or not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Head") or not character:FindFirstChild("Humanoid") or character.Humanoid.Health <= 0 or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            nameText:Remove()
            connection:Disconnect()
            espConnections[targetPlayer.UserId] = nil
            return
        end
        local head = character.Head
        local hrp = character.HumanoidRootPart
        local localHrp = player.Character.HumanoidRootPart
        local distance = (localHrp.Position - hrp.Position).Magnitude
        local headPos = head.Position + Vector3.new(0, head.Size.Y / 2 + 1.5, 0)
        local headVector, onScreen = Camera:WorldToViewportPoint(headPos)
        if onScreen then
            nameText.Position = Vector2.new(headVector.X, headVector.Y)
            nameText.Text = targetPlayer.Name .. " | " .. math.floor(distance) .. " M"
            nameText.Visible = true
            local healthPercent = character.Humanoid.Health / character.Humanoid.MaxHealth
            if healthPercent > 0.4 then
                nameText.Color = Color3.fromRGB(0, 255, 0)
            else
                nameText.Color = Color3.fromRGB(255, 0, 0)
            end
        else
            nameText.Visible = false
        end
    end)
    espConnections[targetPlayer.UserId] = {connection = connection, nameText = nameText}
end

local function CleanupPlayerESP()
    for userId, data in pairs(espConnections) do
        if data.connection then data.connection:Disconnect() end
        if data.nameText then data.nameText:Remove() end
    end
    espConnections = {}
end

local function EnableGodMod()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    renderConnection = RunService.RenderStepped:Connect(function()
        if GOD_MOD_ENABLED and char and hum then
            hum.WalkSpeed = speed
            char:SetAttribute("DashLength", 100)
            char:SetAttribute("DashSpeed", 100)
        end
    end)
    EnableWalkWater()
    _G.FastAttack = true
    local Modules = ReplicatedStorage:FindFirstChild("Modules")
    local Net = Modules and Modules:FindFirstChild("Net")
    if Net then
        local RegisterAttack = Net:FindFirstChild("RE/RegisterAttack")
        local RegisterHit = Net:FindFirstChild("RE/RegisterHit")
        local Enemies = workspace:FindFirstChild("Enemies")
        local Characters = workspace:FindFirstChild("Characters")
        if RegisterAttack and RegisterHit then
            local Distance = 100
            local function IsAlive(chr)
                return chr and chr:FindFirstChild("Humanoid") and chr.Humanoid.Health > 0
            end
            local function ProcessEnemies(OthersEnemies, Folder)
                if not Folder then return nil end
                local BasePart = nil
                for _, Enemy in Folder:GetChildren() do
                    local Head = Enemy:FindFirstChild("Head")
                    if Head and IsAlive(Enemy) and player:DistanceFromCharacter(Head.Position) < Distance then
                        if Enemy ~= player.Character then
                            table.insert(OthersEnemies, {Enemy, Head})
                            BasePart = Head
                        end
                    end
                end
                return BasePart
            end
            autoAttackConnection = RunService.RenderStepped:Connect(function()
                if GOD_MOD_ENABLED then
                    local chr = player.Character
                    if chr and IsAlive(chr) then
                        local OthersEnemies = {}
                        local Part1 = ProcessEnemies(OthersEnemies, Enemies)
                        local Part2 = ProcessEnemies(OthersEnemies, Characters)
                        local equippedWeapon = chr:FindFirstChildOfClass("Tool")
                        if equippedWeapon and equippedWeapon:FindFirstChild("LeftClickRemote") then
                            for _, enemyData in ipairs(OthersEnemies) do
                                local enemy = enemyData[1]
                                if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                                    local direction = (enemy.HumanoidRootPart.Position - chr:GetPivot().Position).Unit
                                    pcall(function() equippedWeapon.LeftClickRemote:FireServer(direction, 1) end)
                                end
                            end
                        elseif #OthersEnemies > 0 then
                            local BasePart = Part1 or Part2
                            if BasePart then
                                pcall(function()
                                    RegisterAttack:FireServer(0)
                                    RegisterHit:FireServer(BasePart, OthersEnemies)
                                end)
                            end
                        end
                    end
                end
            end)
        end
    end
    fruitEspLoop = task.spawn(function()
        while GOD_MOD_ENABLED do
            UpdateFruitEsp()
            task.wait(1)
        end
    end)
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character then
            createPlayerESP(targetPlayer.Character, targetPlayer)
        end
    end
    Players.PlayerAdded:Connect(function(targetPlayer)
        targetPlayer.CharacterAdded:Connect(function(character)
            if GOD_MOD_ENABLED then
                task.wait(0.5)
                createPlayerESP(character, targetPlayer)
            end
        end)
    end)
end

local function DisableGodMod()
    if renderConnection then renderConnection:Disconnect() renderConnection = nil end
    if autoAttackConnection then autoAttackConnection:Disconnect() autoAttackConnection = nil end
    if fruitEspLoop then task.cancel(fruitEspLoop) fruitEspLoop = nil end
    _G.FastAttack = false
    local char = player.Character
    if char then
        char:SetAttribute("DashLength", nil)
        char:SetAttribute("DashSpeed", nil)
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = defaultSpeed end
    end
    DisableWalkWater()
    CleanupFruitEsp()
    CleanupPlayerESP()
end

godModToggle.MouseButton1Click:Connect(function()
    GOD_MOD_ENABLED = not GOD_MOD_ENABLED
    if GOD_MOD_ENABLED then
        godModToggle.Text = "God Mod: ON"
        godModToggle.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
        EnableGodMod()
    else
        godModToggle.Text = "God Mod: OFF"
        godModToggle.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        DisableGodMod()
    end
end)

local draggingSlider = false
sliderButton.MouseButton1Down:Connect(function() draggingSlider = true end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end end)

RunService.RenderStepped:Connect(function()
    if draggingSlider then
        local mPos = UIS:GetMouseLocation()
        local rPos = math.clamp(mPos.X - sliderBg.AbsolutePosition.X, 0, sliderBg.AbsoluteSize.X)
        local pct = rPos / sliderBg.AbsoluteSize.X
        boatSpeed = math.clamp(1 + (pct * 5), 1, 6)
        sliderFill.Size = UDim2.new(pct, 0, 1, 0)
        sliderButton.Position = UDim2.new(pct, -5, 0.5, -5)
        boatLabel.Text = "Boat Speed: " .. math.floor(boatSpeed + 0.5)
        local speedVal = 150 + 50 * (math.floor(boatSpeed + 0.5) - 1)
        pcall(function()
            for _, b in pairs(workspace.Boats:GetChildren()) do
                if b:IsA("Model") then
                    for _, p in pairs(b:GetChildren()) do
                        if p:IsA("VehicleSeat") then p.MaxSpeed = speedVal end
                    end
                end
            end
        end)
    end
end)

rocksBtn.MouseButton1Click:Connect(function()
    ROCKS_HIDDEN = not ROCKS_HIDDEN
    if ROCKS_HIDDEN then
        rocksBtn.Text = "Hide Rocks: ON"
        rocksBtn.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
        local rocks = workspace:FindFirstChild("Rocks")
        if rocks then rocks.Parent = ReplicatedStorage end
    else
        rocksBtn.Text = "Hide Rocks: OFF"
        rocksBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        local rocks = ReplicatedStorage:FindFirstChild("Rocks")
        if rocks then rocks.Parent = workspace end
    end
end)

dayBtn.MouseButton1Click:Connect(function()
    ALWAYS_DAY = not ALWAYS_DAY
    if ALWAYS_DAY then
        dayBtn.Text = "Always Day: ON"
        dayBtn.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
        alwaysDayLoop = task.spawn(function()
            while ALWAYS_DAY do
                RunService.Heartbeat:Wait()
                Lighting.ClockTime = 12
            end
        end)
    else
        dayBtn.Text = "Always Day: OFF"
        dayBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        if alwaysDayLoop then
            task.cancel(alwaysDayLoop)
            alwaysDayLoop = nil
        end
    end
end)

fogBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if Lighting:FindFirstChild("BaseAtmosphere") then
            Lighting.BaseAtmosphere:Destroy()
        end
        if Lighting:FindFirstChild("SeaTerrorCC") then
            Lighting.SeaTerrorCC:Destroy()
        end
        if Lighting:FindFirstChild("LightingLayers") then
            if Lighting.LightingLayers:FindFirstChild("DarkFog") then
                Lighting.LightingLayers.DarkFog:Destroy()
            end
        end
    end)
    fogBtn.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
    fogBtn.Text = "Fog Removed"
    task.wait(2)
    fogBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    fogBtn.Text = "Remove Fog"
end)

UIS.JumpRequest:Connect(function()
    if GOD_MOD_ENABLED then
        local c = player.Character
        if c and c:FindFirstChild("Humanoid") then
            c.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

task.spawn(function()
    while gui.Parent do
        local count = 0
        for _, v in pairs(workspace:GetChildren()) do
            if v.Name ~= "Blox Fruit Dealer" and string.find(v.Name, "Fruit") and v:IsA("Model") then
                count = count + 1
            end
        end
        fruitStatus.Text = "Fruits: " .. count
        task.wait(1)
    end
end)

gui.Destroying:Connect(function()
    DisableGodMod()
    stopTeleport()
    if ROCKS_HIDDEN then
        local rocks = ReplicatedStorage:FindFirstChild("Rocks")
        if rocks then rocks.Parent = workspace end
    end
    if alwaysDayLoop then
        task.cancel(alwaysDayLoop)
        alwaysDayLoop = nil
    end
end)
