local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Eliminar cualquier GUI existente con el mismo nombre
if playerGui:FindFirstChild("CustomPanelGui") then
    playerGui.CustomPanelGui:Destroy()
end

-- Crear el ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomPanelGui"
ScreenGui.Parent = playerGui
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Crear el marco principal
local PanelFrame = Instance.new("Frame")
PanelFrame.Name = "PanelFrame"
PanelFrame.Parent = ScreenGui
PanelFrame.Size = UDim2.new(0, 300, 0, 250)
PanelFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
PanelFrame.AnchorPoint = Vector2.new(0.5, 0.5)
PanelFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PanelFrame.BorderSizePixel = 4
PanelFrame.Active = true
PanelFrame.Draggable = true

-- Efecto "Rainbow" en los bordes del panel
spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            PanelFrame.BorderColor3 = Color3.fromHSV(i, 1, 1)
            wait(0.02)
        end
    end
end)

-- Crear el título del panel
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = PanelFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Adopt Me Spawner"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

-- Crear un cuadro de texto para ingresar el nombre de la mascota
local TextBox = Instance.new("TextBox")
TextBox.Name = "PetName"
TextBox.Parent = PanelFrame
TextBox.Size = UDim2.new(0.9, 0, 0, 40)
TextBox.Position = UDim2.new(0.05, 0, 0.25, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Pet Name"
TextBox.Text = ""
TextBox.Font = Enum.Font.SourceSans
TextBox.TextScaled = true
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Crear el botón para duplicar la mascota
local DupeButton = Instance.new("TextButton")
DupeButton.Name = "DupeButton"
DupeButton.Parent = PanelFrame
DupeButton.Size = UDim2.new(0.9, 0, 0, 40)
DupeButton.Position = UDim2.new(0.05, 0, 0.5, 0)
DupeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
DupeButton.BorderSizePixel = 4
DupeButton.Text = "Spawn Pet"
DupeButton.Font = Enum.Font.SourceSansBold
DupeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DupeButton.TextScaled = true

-- Efecto "Rainbow" en los bordes del botón
spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            DupeButton.BorderColor3 = Color3.fromHSV(i, 1, 1)
            wait(0.02)
        end
    end
end)


-- Cargar módulos necesarios
local Loads = require(game.ReplicatedStorage.Fsys).load
local RouterClient = Loads("RouterClient")
local ClientData = Loads("ClientData")
local InventoryDB = Loads("InventoryDB")
local Inventory = ClientData.get("inventory")
local properties = {"flyable", "rideable", "neon", "mega_neon"}

local function generate_prop(i)
    local props = {}
    for _, prop in ipairs(properties) do
        props[prop] = false
    end
    props["age"] = i
    return props
end

local function spawnPet(petName)
    for category_name, category_table in pairs(InventoryDB) do
        for id, item in pairs(category_table) do
            if category_name == "pets" and item.name == petName then
                local fake_uuid = game.HttpService:GenerateGUID()
                local n_item = table.clone(item)
                n_item["unique"] = fake_uuid
                n_item["category"] = "pets"
                n_item["properties"] = generate_prop(1)
                n_item["newness_order"] = math.random(1, 900000)
                Inventory[category_name][fake_uuid] = n_item
                print("Pet spawned: " .. petName)
                return true
            end
        end
    end
    warn("Pet not found: " .. petName)
    return false
end

-- Función para mostrar pantalla emergente con barra de carga y generar la mascota
DupeButton.MouseButton1Click:Connect(function()
    local petName = TextBox.Text
    if petName == "" then
        warn("No pet name entered")
        return
    end

    -- Crear la pantalla emergente
    local PopupFrame = Instance.new("Frame")
    PopupFrame.Name = "PopupFrame"
    PopupFrame.Parent = ScreenGui
    PopupFrame.Size = UDim2.new(0, 300, 0, 150)
    PopupFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    PopupFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    PopupFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    PopupFrame.BorderSizePixel = 4

    -- Texto principal
    local PopupText = Instance.new("TextLabel")
    PopupText.Parent = PopupFrame
    PopupText.Size = UDim2.new(1, -20, 0.5, 0)
    PopupText.Position = UDim2.new(0, 10, 0, 10)
    PopupText.BackgroundTransparency = 1
    PopupText.Text = "Spawning \"" .. petName .. "\""
    PopupText.Font = Enum.Font.SourceSansBold
    PopupText.TextColor3 = Color3.fromRGB(255, 255, 255)
    PopupText.TextScaled = true

    -- Barra de carga
    local LoadingBarBackground = Instance.new("Frame")
    LoadingBarBackground.Parent = PopupFrame
    LoadingBarBackground.Size = UDim2.new(0.8, 0, 0.1, 0)
    LoadingBarBackground.Position = UDim2.new(0.1, 0, 0.7, 0)
    LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

    local LoadingBar = Instance.new("Frame")
    LoadingBar.Parent = LoadingBarBackground
    LoadingBar.Size = UDim2.new(0, 0, 1, 0)
    LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    -- Animar barra de carga
    local duration = 2 -- duración en segundos
    for i = 0, 1, 0.01 do
        LoadingBar.Size = UDim2.new(i, 0, 1, 0)
        wait(duration / 100)
    end

    -- Intentar generar la mascota
    local success = spawnPet(petName)

    -- Mostrar resultado
    LoadingBarBackground:Destroy()
    if success then
        PopupText.Text = "Success ✅"
    else
        PopupText.Text = "Pet not found ❌"
    end

    -- Botón para cerrar
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = PopupFrame
    CloseButton.Size = UDim2.new(0.5, 0, 0.2, 0)
    CloseButton.Position = UDim2.new(0.25, 0, 0.75, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CloseButton.Text = "Close"
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextScaled = true

    CloseButton.MouseButton1Click:Connect(function()
        PopupFrame:Destroy()
    end)
end)
