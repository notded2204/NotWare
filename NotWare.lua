local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")


local function safeNotify(title, content)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = content,
			Duration = 5
		})
	end)
	print("[NotWare Notify] " .. title .. ": " .. content)
end

--                                                                                                      Functions
--                                                                                                      ButtonFrames                 
--                                                                                                      Frame
local function createFrame(name, parent, position, size, backgroundTrans, BackGroundFColor, visible)
    local val = Instance.new("Frame")
    val.Name = name
    val.Position = position
    val.Size = size
    val.BackgroundTransparency = backgroundTrans
    val.Parent = parent
    val.BorderSizePixel = 0
    val.BorderMode = "Inset"
    val.BackgroundColor3 = BackGroundFColor
    val.Visible = visible
    return val
end
--                                                                                                      Buttonsandtext               
--                                                                                                      TextLabel

local function createTextLabel(name, text, parent, position, size, textcolor, textsize, MinSize, MaxSize, myfont)
    local val = Instance.new("TextLabel")
    val.Name = name
    val.Position = position
    val.Size = size
    val.TextSize = textsize
    val.TextColor3 = textcolor
    val.Font = myfont
    val.BackgroundTransparency = 1
    val.TextXAlignment = Enum.TextXAlignment.Left
    val.Text = text
    val.Parent = parent
    val.TextScaled = true

    -- AUTO RESIZE
    local constraint = Instance.new("UITextSizeConstraint")
    constraint.MinTextSize = MinSize    -- smallest allowed size
    constraint.MaxTextSize = MaxSize   -- largest allowed size
    constraint.Parent = val

    return val
end
--                                                                                                      TextBox

local function createTextBox(name, placetext, parent, position, size, textcolor, textsize, MinSize, MaxSize)
    local val = Instance.new("TextBox")
    val.Name = name
    val.Position = position
    val.Size = size
    val.PlaceholderText = placetext
    val.TextSize = textsize
    val.TextColor3 = textcolor
    val.Font = Enum.Font.SourceSansBold
    val.BackgroundTransparency = 0.5
    val.Parent = parent
    val.Text = ""
    val.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    val.PlaceholderColor3 = Color3.fromRGB(255, 0, 0)

    local constraint = Instance.new("UITextSizeConstraint")
    constraint.MinTextSize = MinSize    -- smallest allowed size
    constraint.MaxTextSize = MaxSize   -- largest allowed size
    constraint.Parent = val

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = val

    return val
end
--                                                                                                      Button

local function createButton(name, parent, position, size)
    local val = Instance.new("ImageButton")
    val.Name = name
    val.Position = position
    val.Size = size
    val.Parent = parent
    val.BackgroundColor3 = Color3.fromRGB(0, 200, 200)

    return val
end
--                                                                                                      Image Button

local function createImageButton(name, parent, position, size, backgroundTrans, BackGroundFColor, visible)
    local val = Instance.new("ImageButton")
    val.Name = name
    val.Position = position
    val.Size = size
    val.BackgroundTransparency = backgroundTrans
    val.Parent = parent
    val.BorderSizePixel = 0
    val.BorderMode = "Inset"
    val.BackgroundColor3 = BackGroundFColor
    val.Visible = visible
    val.AutoButtonColor = false
    return val
end
--                                                                                                      Text Button
local function createTextButton(name, parent, position, size, text)
    local val = Instance.new("TextButton")
    val.Name = name
    val.Position = position
    val.Size = size
    val.Parent = parent
    val.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    val.BackgroundTransparency = 0.5
    val.Text = text
    val.BorderSizePixel = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = val

    return val
end
--                                                                                                      Main Window

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NotWare"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local screenGuiNotWarePosGui = Instance.new("ScreenGui")
screenGuiNotWarePosGui.Name = "NotWarePosGui"
screenGuiNotWarePosGui.ResetOnSpawn = false
screenGuiNotWarePosGui.Parent = playerGui

local screenGuiTeleport = Instance.new("ScreenGui")

local mainWindow = createImageButton(
"MainWindow",                             --Name
screenGui,                             --parent
UDim2.new(0.5, 0, 0.5, 0),              --Position
UDim2.new(0.65, 0, 0.85, 0),              --Size
0.025,                                  --BackgroundTransparency
Color3.fromRGB(10, 10, 10),           --BackgroundColor3
true
)

mainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
mainWindow.Visible = False

local mainWindowtp = createImageButton(
"MainWindow",                             --Name
screenGuiNotWareTPGui,                             --parent
UDim2.new(0.5, 0, 0.5, 0),              --Position
UDim2.new(0.65, 0, 0.85, 0),              --Size
1,                                  --BackgroundTransparency
Color3.fromRGB(10, 10, 10),           --BackgroundColor3
true
)

mainWindowtp.AnchorPoint = Vector2.new(0.5, 0.5)
mainWindowtp.Visible = False

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainWindow

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Delete then
		mainWindow.Visible = not mainWindow.Visible
        
	end
end)

--                                                                                                      TitleBar
local titleBar = createFrame(
"TitleBar",                             --Name
mainWindow,                             --parent
UDim2.new(0, 0, 0, 0),              --Position
UDim2.new(1, 0, 0.07, 0),              --Size
0.3,                                  --BackgroundTransparency
Color3.fromRGB(5, 5, 5),           --BackgroundColor3
true
)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = titleBar

local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainWindow.Position
	end
end)

titleBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		mainWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)


local titleBarTeleport = createFrame(
"TitleBar",                             --Name
mainWindowTeleport,                             --parent
UDim2.new(0, 0, 0, 0),              --Position
UDim2.new(1, 0, 0.07, 0),              --Size
1,                                  --BackgroundTransparency
Color3.fromRGB(5, 5, 5),           --BackgroundColor3
true
)

--                                                                                                      TitleBarText

local TitleBarText = createTextLabel("TitleBarText", "NotWare", titleBar, UDim2.new(0.05, 0, 0, 0), UDim2.new(0.1, 0, 1, 0), Color3.fromRGB(255,255,255), 40, 1, 40, Enum.Font.SourceSansBold)
local TitleBarText2 = createTextLabel("TitleBarText2", "By Notded2204", titleBar, UDim2.new(0.18, 0, 0.25, 0), UDim2.new(0.1, 0, 0.5, 0), Color3.fromRGB(120, 120, 120), 20, 1, 20, Enum.Font.SourceSansBold)

--                                                                                                       TableL

local tableL = createFrame("TableL", mainWindow, UDim2.new(0, 0, 0.07, 0), UDim2.new(0.3, 0, 0.93, 0), 1, Color3.fromRGB(255, 255, 255), true)

--                                                                                                      TableL 1 Main

local L1 = createFrame("L1", tableL, UDim2.new(0.05, 0, 0.025, 0), UDim2.new(0.9, 0, 0.075, 0), 1, Color3.fromRGB(35, 35, 35), true)

local TextButtonL1 = createTextButton("L1Button", L1, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 1, 0), "")

local L1Txt = createTextLabel("L1Txt", "Main", TextButtonL1, UDim2.new(0.1, 0, 0.25, 0), UDim2.new(0.2, 0, 0.5, 0), Color3.fromRGB(255, 255, 255), 30, 1, 30, Enum.Font.Arial)



--                                                                                                      TableL 2 Teleport

local L2 = createFrame(
"L2",                             --Name
tableL,                             --parent
UDim2.new(0.05, 0, 0.13, 0),              --Position
UDim2.new(0.9, 0, 0.075, 0),              --Size
1,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local TextButtonL2 = createTextButton(
"L2Button",                             --Name
L2,                             --Parent
UDim2.new(0, 0, 0, 0),              --Position
UDim2.new(1, 0, 1, 0),               --Size
""
)

local L2Txt = createTextLabel(
"L2Txt",                             --Name
"Teleport",                             --Text
TextButtonL2,                             --Parent
UDim2.new(0.1, 0, 0.25, 0),              --Position
UDim2.new(0.3, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
30,                                 --TextSize
1,                                  --MinTextSize
30,                                  --MaxTextSize
Enum.Font.Arial
)

--                                                                                                      TableL 2 Anti-AFK

local L3 = createFrame(
"L3",                             --Name
tableL,                             --parent
UDim2.new(0.05, 0, 0.235, 0),              --Position
UDim2.new(0.9, 0, 0.075, 0),              --Size
1,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local TextButtonL3 = createTextButton(
"L3Button",                             --Name
L3,                             --Parent
UDim2.new(0, 0, 0, 0),              --Position
UDim2.new(1, 0, 1, 0),               --Size
""
)

local L3Txt = createTextLabel(
"L3Txt",                             --Name
"Anti-AFK",                             --Text
TextButtonL3,                             --Parent
UDim2.new(0.1, 0, 0.25, 0),              --Position
UDim2.new(0.3, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
30,                                 --TextSize
1,                                  --MinTextSize
30,                                  --MaxTextSize
Enum.Font.Arial
)

--                                                                                                      TableRMain

local tableRMain = createFrame(
"TableRMain",                             --Name
mainWindow,                             --parent
UDim2.new(0.3, 0, 0.07, 0),              --Position
UDim2.new(0.7, 0, 0.93, 0),              --Size
1,                                  --BackgroundTransparency
Color3.fromRGB(255, 255, 255),           --BackgroundColor3
true
)

--                                                                                                      Text R1

local R1 = createFrame(
"R1",                             --Name
tableRMain,                             --parent
UDim2.new(0.05, 0, 0.025, 0),              --Position
UDim2.new(0.9, 0, 0.075, 0),              --Size
1,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local R1Txt = createTextLabel(
"R1Txt",                             --Name
"Vault Options",                             --Text
R1,                             --Parent
UDim2.new(0.05, 0, 0.25, 0),              --Position
UDim2.new(0.2, 0, 0.55, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
30,                                 --TextSize
1,                                  --MinTextSize
30,                                  --MaxTextSize
Enum.Font.SourceSansBold
)

--                                                                                                      R2

local vaultmoneybutton = createTextButton(
"R2Button",                             --Name
tableRMain,                             --Parent
UDim2.new(0.1, 0, 0.1, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),               --Size
""
)

local R2Txt = createTextLabel(
"R2Txt",                             --Name
"Get Vault Money",                             --Text
vaultmoneybutton,                             --Parent
UDim2.new(0.05, 0, 0.1, 0),              --Position
UDim2.new(0.25, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local R3Txt = createTextLabel(
"R3Txt",                             --Name
"Gives you the money in the Vault",        --Text
vaultmoneybutton,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.3, 0, 0.4, 0),              --Size
Color3.fromRGB(150, 150, 150),        --Color3
15,                                 --TextSize
1,                                  --MinTextSize
15,                                  --MaxTextSize
Enum.Font.Arial
)

--                                                                                                      R3

local vaultmoneytoggle = createTextButton(
"R3Button",                             --Name
tableRMain,                             --Parent
UDim2.new(0.1, 0, 0.2, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),               --Size
""
)

local delayamount = createTextBox(
"Textdelayamount",                             --Name
"delay in sec",                        --PlaceholderText
vaultmoneytoggle,                             --Parent
UDim2.new(0.55, 0, 0.25, 0),              --Position
UDim2.new(0.2, 0, 0.5, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
25,                            --TextSize
1,
25
)

local R1Txt = createTextLabel(
"R2Txt",                             --Name
"Get Vault Money Toggle",                             --Text
vaultmoneytoggle,                             --Parent
UDim2.new(0.05, 0, 0.1, 0),              --Position
UDim2.new(0.35, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local R2Txt = createTextLabel(
"R3Txt",                             --Name
"Gives you the Vault money in the given delay 0 = 0.5 sec",        --Text
vaultmoneytoggle,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.4, 0, 0.4, 0),              --Size
Color3.fromRGB(150, 150, 150),        --Color3
15,                                 --TextSize
1,                                  --MinTextSize
15,                                  --MaxTextSize
Enum.Font.Arial
)

local pillToggle = createFrame(
"PillToggle",                             --Name
vaultmoneytoggle,                             --parent
UDim2.new(0.83, 0, 0.15, 0),              --Position
UDim2.new(0.12, 0, 0.7, 0),              --Size
0,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 100)
corner.Parent = pillToggle

local pillDot = createFrame(
"PillDot",                             --Name
pillToggle,                             --parent
UDim2.new(0.1, 0, 0.15, 0),              --Position
UDim2.new(0.3, 0, 0.7, 0),              --Size
0,                                  --BackgroundTransparency
Color3.fromRGB(0, 50, 50),           --BackgroundColor3
true
)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 100)
corner.Parent = pillDot

--                                                                                                      Text R2

local R4 = createFrame(
"R4",                             --Name
tableRMain,                             --parent
UDim2.new(0.05, 0, 0.3, 0),              --Position
UDim2.new(0.9, 0, 0.075, 0),              --Size
1,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local R2Txt = createTextLabel(
"R1Txt",                             --Name
"Auto Open",                             --Text
R4,                             --Parent
UDim2.new(0.05, 0, 0.25, 0),              --Position
UDim2.new(0.15, 0, 0.55, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
30,                                 --TextSize
1,                                  --MinTextSize
30,                                  --MaxTextSize
Enum.Font.SourceSansBold
)

--                                                                                                      R5

local autoopentoggle = createTextButton(
"R5Button",                             --Name
tableRMain,                             --Parent
UDim2.new(0.1, 0, 0.375, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),               --Size
""
)

local R1Txt = createTextLabel(
"R5Txt",                             --Name
"Auto Open Case",                             --Text
autoopentoggle,                             --Parent
UDim2.new(0.05, 0, 0.1, 0),              --Position
UDim2.new(0.25, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local R2Txt = createTextLabel(
"R5Txt",                             --Name
"Automatically opens cases when possible",        --Text
autoopentoggle,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.4, 0, 0.4, 0),              --Size
Color3.fromRGB(150, 150, 150),        --Color3
15,                                 --TextSize
1,                                  --MinTextSize
15,                                  --MaxTextSize
Enum.Font.Arial
)

local pillToggle5 = createFrame(
"PillToggle",                             --Name
autoopentoggle,                             --parent
UDim2.new(0.83, 0, 0.15, 0),              --Position
UDim2.new(0.12, 0, 0.7, 0),              --Size
0,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 100)
corner.Parent = pillToggle5

local pillDot5 = createFrame(
"PillDot",                             --Name
pillToggle5,                             --parent
UDim2.new(0.1, 0, 0.15, 0),              --Position
UDim2.new(0.3, 0, 0.7, 0),              --Size
0,                                  --BackgroundTransparency
Color3.fromRGB(0, 50, 50),           --BackgroundColor3
true
)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 100)
corner.Parent = pillDot5

--                                                                                                      R6

local R6 = createFrame(
"R6",                             --Name
tableRMain,                             --parent
UDim2.new(0.1, 0, 0.475, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),              --Size
0.5,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = R6

local R1Txt = createTextLabel(
"R5Txt",                             --Name
"Case Selection",                             --Text
R6,                             --Parent
UDim2.new(0.05, 0, 0.1, 0),              --Position
UDim2.new(0.23, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local R2Txt = createTextLabel(
"R5Txt",                             --Name
"Select the Case you want to Auto Open",        --Text
R6,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.35, 0, 0.4, 0),              --Size
Color3.fromRGB(150, 150, 150),        --Color3
15,                                 --TextSize
1,                                  --MinTextSize
15,                                  --MaxTextSize
Enum.Font.Arial
)

                                                                                                                                    -- Dropdown

local Players = game:GetService("Players")

-----------------------------------------------------------
-- HOLDER FRAME
-----------------------------------------------------------

local dropdownholdframecase = createFrame(
"dropdownholdframe",
tableRMain,
UDim2.new(0.5, 0, 0.485, 0),
UDim2.new(0.4, 0, 0.35, 0),
1,
Color3.fromRGB(255, 255, 255),
true
)

-----------------------------------------------------------
-- MAIN BUTTON
-----------------------------------------------------------

local dropdownbuttoncase = createTextButton(
"dropdownbuttoncase",
dropdownholdframecase,
UDim2.new(0, 0, 0, 0),
UDim2.new(1, 0, 0.16, 0),
""
)
dropdownbuttoncase.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local dropdownbuttontextcase = createTextLabel(
"dropdownbuttontext",
"Select Case",
dropdownbuttoncase,
UDim2.new(0, 0, 0, 0),
UDim2.new(1, 0, 1, 0),
Color3.fromRGB(150, 150, 150),
25,
1,
25,
Enum.Font.Arial
)
dropdownbuttontextcase.TextXAlignment = Enum.TextXAlignment.Center

-----------------------------------------------------------
-- DROPDOWN LIST FRAME
-----------------------------------------------------------

local listframecase = createFrame(
"listframe",
dropdownholdframecase,
UDim2.new(0, 0, 0.16, 0),
UDim2.new(1, 0, 0, 0), -- <--- starts closed
0.5,
Color3.fromRGB(35, 35, 35),
true
)
listframecase.Visible = false -- <--- FIXED (hide until open)

-----------------------------------------------------------
-- SCROLLING FRAME
-----------------------------------------------------------

local scrollcase = Instance.new("ScrollingFrame")
scrollcase.Name = "Scroll"
scrollcase.Parent = listframecase
scrollcase.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollcase.Size = UDim2.new(1,0,1,0)
scrollcase.CanvasSize = UDim2.new(0,0,0,0)
scrollcase.BackgroundTransparency = 1
scrollcase.ScrollBarThickness = 4

-----------------------------------------------------------
-- LIST LAYOUT
-----------------------------------------------------------

local layoutcase = Instance.new("UIListLayout")
layoutcase.Parent = scrollcase
layoutcase.SortOrder = Enum.SortOrder.LayoutOrder
layoutcase.Padding = UDim.new(0, 4)

layoutcase:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollcase.CanvasSize = UDim2.new(0, 0, 0, layoutcase.AbsoluteContentSize.Y)
end)

-----------------------------------------------------------
-- DROPDOWN TOGGLE
-----------------------------------------------------------

local isOpencase = false

local function toggle()
    isOpencase = not isOpencase

    if isOpencase then
        listframecase.Visible = true
        listframecase:TweenSize(UDim2.new(1,0,0.85,0), "Out", "Quad", 0.15)
    else
        listframecase:TweenSize(UDim2.new(1,0,0,0), "Out", "Quad", 0.15)
        task.delay(0.15, function()
            if not isOpencase then
                listframecase.Visible = false
            end
        end)
    end
end
dropdownbuttoncase.MouseButton1Click:Connect(toggle)

-----------------------------------------------------------
-- PLAYER REFRESH SYSTEM
-----------------------------------------------------------

local caseList = {
    "Recoil Case",
    "Revolution Case",
    "Fracture Case",
    "Kilowatt Case",
    "Snakebite Case",
    "Prisma 2 Case",
    "Clutch Case",
    "Fever Case",
    "Dreams & Nightmares",
    "Revolver Case",
    "Gamma 2 Case",
    "Chroma Case",
    "Weapon Case 3",
    "Huntsman Case",
    "Breakout Case",
    "2013 Winter Case",
    "2014 Summer Case",
    "Hydra Case",
    "Bravo Case",
    "2013 Case",
    "Weapon Case",
    "Desert Fang Case",
    "St. Marc Collection",
    "Norse Collection",
    "Cobblestone Collection",
    "EMS Katowice 2014"
}


local Selectedcase = nil

local function RefreshPlayers()
    -- remove old buttons
    for _, child in ipairs(scrollcase:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end

    -- create new buttons from the list
    for _, caseName in ipairs(caseList) do

        local btncase = Instance.new("TextButton")
        btncase.Parent = scrollcase
        btncase.Size = UDim2.new(1, -8, 0, 28)
        btncase.Text = caseName
        btncase.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btncase.TextColor3 = Color3.new(1, 1, 1)
        btncase.TextSize = 16
        btncase.BorderSizePixel = 0
        btncase.MouseButton1Click:Connect(function()
            dropdownbuttontextcase.Text = caseName
            Selectedcase = caseName
            toggle() -- CLOSE dropdown properly
        end)
    end
end


Players.PlayerAdded:Connect(RefreshPlayers)
Players.PlayerRemoving:Connect(RefreshPlayers)

RefreshPlayers()


--                                                                                                      TableRTeleport

local tableRTeleport = createFrame(
"TableRTeleport",                             --Name
mainWindow,                             --parent
UDim2.new(0.3, 0, 0.07, 0),              --Position
UDim2.new(0.7, 0, 0.93, 0),              --Size
1,                                  --BackgroundTransparency
Color3.fromRGB(255, 255, 255),           --BackgroundColor3
false
)

--                                                                                                      R1

local R1tp = createFrame(
"R1",                             --Name
tableRTeleport,                             --parent
UDim2.new(0.05, 0, 0.025, 0),              --Position
UDim2.new(0.9, 0, 0.075, 0),              --Size
1,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local R1Txttp = createTextLabel(
"R1Txt",                             --Name
"Teleport",                             --Text
R1tp,                             --Parent
UDim2.new(0.05, 0, 0.25, 0),              --Position
UDim2.new(0.13, 0, 0.55, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
30,                                 --TextSize
1,                                  --MinTextSize
30,                                  --MaxTextSize
Enum.Font.SourceSansBold
)

--                                                                                                      R2

local textButtonR2tp = createTextButton(
"R3Button",                             --Name
tableRTeleport,                             --Parent
UDim2.new(0.1, 0, 0.1, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),               --Size
""
)

local R1Txttp = createTextLabel(
"R2Txt",                             --Name
"Show current Position",                             --Text
textButtonR2tp,                             --Parent
UDim2.new(0.05, 0, 0.1, 0),              --Position
UDim2.new(0.33, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local R2Txttp = createTextLabel(
"R3Txt",                             --Name
"Shows the current Position in a new window",        --Text
textButtonR2tp,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.4, 0, 0.4, 0),              --Size
Color3.fromRGB(150, 150, 150),        --Color3
15,                                 --TextSize
1,                                  --MinTextSize
15,                                  --MaxTextSize
Enum.Font.Arial
)

local pillToggle1tp = createFrame(
"PillToggle",                             --Name
textButtonR2tp,                             --parent
UDim2.new(0.83, 0, 0.15, 0),              --Position
UDim2.new(0.12, 0, 0.7, 0),              --Size
0,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 100)
corner.Parent = pillToggle1tp

local pillDot1tp = createFrame(
"PillDot",                             --Name
pillToggle1tp,                             --parent
UDim2.new(0.1, 0, 0.15, 0),              --Position
UDim2.new(0.3, 0, 0.7, 0),              --Size
0,                                  --BackgroundTransparency
Color3.fromRGB(0, 50, 50),           --BackgroundColor3
true
)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 100)
corner.Parent = pillDot1tp

local posgui = createImageButton(
"posgui",                             --Name
screenGuiNotWarePosGui,                             --parent
UDim2.new(0.9, 0, 0.01, 0),              --Position
UDim2.new(0.1, 0, 0.1, 0),              --Size
0.025,                                  --BackgroundTransparency
Color3.fromRGB(10, 10, 10),           --BackgroundColor3
false
)

posgui.AnchorPoint = Vector2.new(0.5, 0.5)

local pos1txt = createTextLabel(
"pos1txt",                             --Name
"Position",                             --Text
posgui,                             --Parent
UDim2.new(0.35, 0, 0.05, 0),              --Position
UDim2.new(0.3, 0, 0.2, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
20,                                 --TextSize
1,                                  --MinTextSize
20,                                  --MaxTextSize
Enum.Font.SourceSansBold                      --Font
)
local pos = hrp.Position

local pos1Xtxt = createTextLabel(
"pos1Xtxt",                             --Name
"X: " .. pos.X,                             --Text
posgui,                             --Parent
UDim2.new(0.05, 0, 0.3, 0),              --Position
UDim2.new(0.9, 0, 0.2, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
20,                                 --TextSize
1,                                  --MinTextSize
20,                                  --MaxTextSize
Enum.Font.SourceSansBold                      --Font
)

local pos1Ytxt = createTextLabel(
"pos1Ytxt",                             --Name
"Y: " .. pos.Y,                             --Text
posgui,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.9, 0, 0.2, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
20,                                 --TextSize
1,                                  --MinTextSize
20,                                  --MaxTextSize
Enum.Font.SourceSansBold                      --Font
)

local pos1Ztxt = createTextLabel(
"pos1Ztxt",                             --Name
"Z: " .. pos.Z,                             --Text
posgui,                             --Parent
UDim2.new(0.05, 0, 0.7, 0),              --Position
UDim2.new(0.9, 0, 0.2, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
20,                                 --TextSize
1,                                  --MinTextSize
20,                                  --MaxTextSize
Enum.Font.SourceSansBold                      --Font
)


local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = posgui

local dragging = false
local dragStart, startPos

posgui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = posgui.Position
	end
end)

posgui.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		posgui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

--                                                                                                      R3tp

local teleportToButton = createTextButton(
"R3Buttontp",                             --Name
tableRTeleport,                             --Parent
UDim2.new(0.1, 0, 0.2, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),               --Size
""
)

local TextboxtpX = createTextBox(
"TextboxtpX",                             --Name
"X",                        --PlaceholderText
teleportToButton,                             --Parent
UDim2.new(0.55, 0, 0.25, 0),              --Position
UDim2.new(0.1, 0, 0.5, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
25,                            --TextSize
1,
25
)

local TextboxtpY = createTextBox(
"TextboxtpY",                             --Name
"Y",                        --PlaceholderText
teleportToButton,                             --Parent
UDim2.new(0.7, 0, 0.25, 0),              --Position
UDim2.new(0.1, 0, 0.5, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
25,                            --TextSize
1,
25
)

local TextboxtpZ = createTextBox(
"TextboxtpZ",                             --Name
"Z",                        --PlaceholderText
teleportToButton,                             --Parent
UDim2.new(0.85, 0, 0.25, 0),              --Position
UDim2.new(0.1, 0, 0.5, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
25,                            --TextSize
1,
25
)


local R1Txttp = createTextLabel(
"R2Txt",                             --Name
"Teleport to",                             --Text
teleportToButton,                             --Parent
UDim2.new(0.05, 0, 0.1, 0),              --Position
UDim2.new(0.15, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local R2Txttp = createTextLabel(
"R3Txt",                             --Name
"Teleports you to the given Position",        --Text
teleportToButton,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.3, 0, 0.4, 0),              --Size
Color3.fromRGB(150, 150, 150),        --Color3
15,                                 --TextSize
1,                                  --MinTextSize
15,                                  --MaxTextSize
Enum.Font.Arial
)

--                                                                                                      R4 

local textButtonR4tp = createTextButton(
"R4Buttontp",                             --Name
tableRTeleport,                             --Parent
UDim2.new(0.1, 0, 0.3, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),               --Size
""
)

local R1Txttp = createTextLabel(
"R2Txt",                             --Name
"Copy current Position",                             --Text
textButtonR4tp,                             --Parent
UDim2.new(0.05, 0, 0.1, 0),              --Position
UDim2.new(0.32, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local R2Txttp = createTextLabel(
"R3Txt",                             --Name
"Copys current Position to Teleport",        --Text
textButtonR4tp,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.3, 0, 0.4, 0),              --Size
Color3.fromRGB(150, 150, 150),        --Color3
15,                                 --TextSize
1,                                  --MinTextSize
15,                                  --MaxTextSize
Enum.Font.Arial
)

--                                                                                                      R5 Spawn Platform

local SpawnPlatformButton = createTextButton(
"R5Buttontp",                             --Name
tableRTeleport,                             --Parent
UDim2.new(0.1, 0, 0.4, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),               --Size
""
)

local textboxtpXPlat = createTextBox(
"TextboxtpXPlat",                             --Name
"X",                        --PlaceholderText
SpawnPlatformButton,                             --Parent
UDim2.new(0.55, 0, 0.25, 0),              --Position
UDim2.new(0.1, 0, 0.5, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
25,                            --TextSize
1,
25
)

local textboxtpYPlat = createTextBox(
"TextboxtpYPlat",                             --Name
"Y",                        --PlaceholderText
SpawnPlatformButton,                             --Parent
UDim2.new(0.7, 0, 0.25, 0),              --Position
UDim2.new(0.1, 0, 0.5, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
25,                            --TextSize
1,
25
)

local textboxtpZPlat = createTextBox(
"TextboxtpZPlat",                             --Name
"Z",                        --PlaceholderText
SpawnPlatformButton,                             --Parent
UDim2.new(0.85, 0, 0.25, 0),              --Position
UDim2.new(0.1, 0, 0.5, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
25,                            --TextSize
1,
25
)


local R5Txttp = createTextLabel(
"R2Txt",                             --Name
"Spawn Platform at",                             --Text
SpawnPlatformButton,                             --Parent
UDim2.new(0.05, 0, 0.1, 0),              --Position
UDim2.new(0.28, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local R5Txttp = createTextLabel(
"R3Txt",                             --Name
"Spawns a Platform at given Position",        --Text
SpawnPlatformButton,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.32, 0, 0.4, 0),              --Size
Color3.fromRGB(150, 150, 150),        --Color3
15,                                 --TextSize
1,                                  --MinTextSize
15,                                  --MaxTextSize
Enum.Font.Arial
)

--                                                                                                      R6 Copy Platform Pos

local textButtonR6tp = createTextButton(
"R6Buttontp",                             --Name
tableRTeleport,                             --Parent
UDim2.new(0.1, 0, 0.5, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),               --Size
""
)

local R6Txttp = createTextLabel(
"R2Txt",                             --Name
"Copy current Position",                             --Text
textButtonR6tp,                             --Parent
UDim2.new(0.05, 0, 0.1, 0),              --Position
UDim2.new(0.32, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local R6Txttp = createTextLabel(
"R3Txt",                             --Name
"Copys current Position to Platform",        --Text
textButtonR6tp,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.3, 0, 0.4, 0),              --Size
Color3.fromRGB(150, 150, 150),        --Color3
15,                                 --TextSize
1,                                  --MinTextSize
15,                                  --MaxTextSize
Enum.Font.Arial
)
--                                                                                                     R7 TP to Vault

local vaulttpbutton = createTextButton(
"R8Buttontp",                             --Name
tableRTeleport,                             --Parent
UDim2.new(0.1, 0, 0.6, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),               --Size
""
)

local R8Txttp = createTextLabel(
"R2Txt",                             --Name
"Teleport to Vault",                             --Text
vaulttpbutton,                             --Parent
UDim2.new(0.05, 0, 0.1, 0),              --Position
UDim2.new(0.25, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local R82Txttp = createTextLabel(
"R3Txt",                             --Name
"Teleports you to the Vault and back",        --Text
vaulttpbutton,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.32, 0, 0.4, 0),              --Size
Color3.fromRGB(150, 150, 150),        --Color3
15,                                 --TextSize
1,                                  --MinTextSize
15,                                  --MaxTextSize
Enum.Font.Arial
)
--                                                                                                      FindTableRAntiAFK

local tableRAntiAFK = createFrame(
"TableRAntiAFK",                             --Name
mainWindow,                             --parent
UDim2.new(0.3, 0, 0.07, 0),              --Position
UDim2.new(0.7, 0, 0.93, 0),              --Size
1,                                  --BackgroundTransparency
Color3.fromRGB(255, 255, 255),           --BackgroundColor3
false
)

--                                                                                                      Text R1

local R1afk = createFrame(
"R1",                             --Name
tableRAntiAFK,                             --parent
UDim2.new(0.05, 0, 0.025, 0),              --Position
UDim2.new(0.9, 0, 0.075, 0),              --Size
1,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local R1Txtafk = createTextLabel(
"R1Txt",                             --Name
"Anti-AFK",                             --Text
R1afk,                             --Parent
UDim2.new(0.05, 0, 0.25, 0),              --Position
UDim2.new(0.15, 0, 0.55, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
30,                                 --TextSize
1,                                  --MinTextSize
30,                                  --MaxTextSize
Enum.Font.SourceSansBold
)

--                                                                                                      R2

local TextButtonR2afk = createTextButton(
"R2Button",                             --Name
tableRAntiAFK,                             --Parent
UDim2.new(0.1, 0, 0.1, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),               --Size
""
)

local R2Txtafk = createTextLabel(
"R2Txt",                             --Name
"Enable Anti-AFK",                             --Text
TextButtonR2afk,                             --Parent
UDim2.new(0.05, 0, 0.1, 0),              --Position
UDim2.new(0.25, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local R3Txtafk = createTextLabel(
"R2Txt",                             --Name
"Prevents you from being AFK kicked",        --Text
TextButtonR2afk,                             --Parent
UDim2.new(0.05, 0, 0.5, 0),              --Position
UDim2.new(0.33, 0, 0.4, 0),              --Size
Color3.fromRGB(150, 150, 150),        --Color3
15,                                 --TextSize
1,                                  --MinTextSize
15,                                  --MaxTextSize
Enum.Font.Arial
)

local pillToggle2afk = createFrame(
"PillToggle",                             --Name
TextButtonR2afk,                             --parent
UDim2.new(0.83, 0, 0.15, 0),              --Position
UDim2.new(0.12, 0, 0.7, 0),              --Size
0,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 100)
corner.Parent = pillToggle2afk

local pillDot2afk = createFrame(
"PillDot",                             --Name
pillToggle2afk,                             --parent
UDim2.new(0.1, 0, 0.15, 0),              --Position
UDim2.new(0.3, 0, 0.7, 0),              --Size
0,                                  --BackgroundTransparency
Color3.fromRGB(0, 50, 50),           --BackgroundColor3
true
)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 100)
corner.Parent = pillDot2afk

--                                                                                                      R3

local R3afk = createFrame(
"R3",                             --Name
tableRAntiAFK,                             --parent
UDim2.new(0.1, 0, 0.2, 0),              --Position
UDim2.new(0.85, 0, 0.075, 0),              --Size
0.5,                                  --BackgroundTransparency
Color3.fromRGB(35, 35, 35),           --BackgroundColor3
true
)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = R3afk

local R2Txtafk = createTextLabel(
"R2Txt",                             --Name
"Anti-AFK Interval",                             --Text
R3afk,                             --Parent
UDim2.new(0.05, 0, 0.25, 0),              --Position
UDim2.new(0.33, 0, 0.5, 0),              --Size
Color3.fromRGB(255, 255, 255),        --Color3
25,                                 --TextSize
1,                                  --MinTextSize
25,                                  --MaxTextSize
Enum.Font.Arial
)

local Textboxminafk = createTextBox(
"interval min",                             --Name
"min",                        --PlaceholderText
R3afk,                             --Parent
UDim2.new(0.65, 0, 0.25, 0),              --Position
UDim2.new(0.1, 0, 0.5, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
25,                            --TextSize
1,
25
)

local Textboxsecafk = createTextBox(
"interval min sec",                             --Name
"sec",                        --PlaceholderText
R3afk,                             --Parent
UDim2.new(0.8, 0, 0.25, 0),              --Position
UDim2.new(0.1, 0, 0.5, 0),              --Size
Color3.fromRGB(255,255,255),        --Color3
25,                            --TextSize
1,
25
)

--                                                                                                      Button Functions

--                                                                                                      Table L 1

TextButtonL1.MouseButton1Click:Connect(function()

    tableRMain.Visible = true
    tableRTeleport.Visible = false
    tableRAntiAFK.Visible = false

end)

--                                                                                                      Table L 2

TextButtonL2.MouseButton1Click:Connect(function()

    tableRMain.Visible = false
    tableRTeleport.Visible = true
    tableRAntiAFK.Visible = false

end)

--                                                                                                      Table L 3

TextButtonL3.MouseButton1Click:Connect(function()

    tableRMain.Visible = false
    tableRTeleport.Visible = false
    tableRAntiAFK.Visible = true

end)

--                                                                                                      Table R2 main

vaultmoneybutton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
 
    -- Finde den RemoteEvent-Pfad
    local remote = ReplicatedStorage:WaitForChild("Bank"):WaitForChild("Remotes"):FindFirstChild("Collect")
 
    if remote then
        remote:FireServer()
        print("[NotWare] Vault Collect Remote erfolgreich gefeuert.")
    else
        warn("[NotWare] Konnte Collect Remote nicht finden.")
    end
end)

--                                                                                                      Table R3 main

local TweenService = game:GetService("TweenService")

local button = vaultmoneytoggle
local toggle = pillToggle
local dot = pillDot

local isOn = false

-- Tween settings
local tweenInfo = TweenInfo.new(
    0.18,
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.Out
)

local function getVector3FromInput()
    local delayvault = tonumber(delayamount.Text)

    if x and y and z then
        return Vector3.new(x, y, z)
    else
        warn("Invalid XYZ input")
        return nil
    end
end

local function updateToggle()
    if isOn then
        -- Move dot right
        TweenService:Create(dot, tweenInfo, {
            Position = UDim2.new(0.55, 0, dot.Position.Y.Scale, dot.Position.Y.Offset)
        }):Play()

        -- Toggle background color
        TweenService:Create(toggle, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        }):Play()

        -- Dot color ON
        TweenService:Create(dot, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(0, 150, 150)
        }):Play()

    else
        -- Move dot left
        TweenService:Create(dot, tweenInfo, {
            Position = UDim2.new(0.1, 0, dot.Position.Y.Scale, dot.Position.Y.Offset)
        }):Play()

        -- Toggle background color
        TweenService:Create(toggle, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        }):Play()

        -- Dot color OFF
        TweenService:Create(dot, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(0, 50, 50)
        }):Play()
    end
    autoVault = state
    safeNotify("Auto Open Vault", isOn and "Enabled" or "Disabled")
    task.spawn(function()
    while true do
        
        if not isOn then
            print("[DEBUG] Auto Vault is disabled. Exiting.")
            return
        end

        local player = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local remote = ReplicatedStorage:WaitForChild("Bank"):WaitForChild("Remotes"):FindFirstChild("Collect")
        if remote then
            remote:FireServer()
        else
            warn("[NotWare] Konnte Collect Remote nicht finden.")
        end

        local delayvault = tonumber(delayamount.Text) or 0  -- fallback to 0
        if delayvault < 1 then
            delayvault = 0.5
        end

        task.wait(delayvault)
    end
end)

end

button.MouseButton1Click:Connect(function()
    isOn = not isOn
    updateToggle()
end)

RunService.RenderStepped:Connect(function()
    if isOn then
        local pos = hrp.Position
        local delayvault = tonumber(delayamount.Text)
    end
end)

--                                                                                                      Table R 5 main

local TweenService = game:GetService("TweenService")

local button = autoopentoggle
local toggle = pillToggle5
local dot = pillDot5
local caseType = dropdownbuttontextcase.Text
local amount = game.Players.LocalPlayer:WaitForChild("CaseSlots").Value

local isOn = false

-- Tween settings
local tweenInfo = TweenInfo.new(
    0.18,
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.Out
)

local function updateToggle()
    if isOn then
        -- Move dot right
        TweenService:Create(dot, tweenInfo, {
            Position = UDim2.new(0.55, 0, dot.Position.Y.Scale, dot.Position.Y.Offset)
        }):Play()

        -- Toggle background color
        TweenService:Create(toggle, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        }):Play()

        -- Dot color ON
        TweenService:Create(dot, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(0, 150, 150)
        }):Play()

        
        

    else
        -- Move dot left
        TweenService:Create(dot, tweenInfo, {
            Position = UDim2.new(0.1, 0, dot.Position.Y.Scale, dot.Position.Y.Offset)
        }):Play()

        -- Toggle background color
        TweenService:Create(toggle, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        }):Play()

        -- Dot color OFF
        TweenService:Create(dot, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(0, 50, 50)
        }):Play()
    end
        safeNotify("Auto Open Case", isOn and "Enabled" or "Disabled")
    task.spawn(function()
        while true do
            if not isOn then
            print("[DEBUG] Auto Open is disabled. Exiting.")
            return
            end

            local rs = game:GetService("ReplicatedStorage")
            local rem = rs.Cases.Remotes.OpenCase
            local bind = rs.Assets.Bindables.beginRoll
        
        -- IMPORTANT: Use the selected case from the dropdown
           if Selectedcase then
            local data = {rem:InvokeServer(Selectedcase, amount)}
            bind:Fire(unpack(data))
            else
            warn("No case selected!")
            end

            task.wait(1)
        end
    end)

end

button.MouseButton1Click:Connect(function()
    isOn = not isOn
    updateToggle()
end)

--                                                                                                      Table R 2 tp

local TweenService = game:GetService("TweenService")

local button = textButtonR2tp
local toggle = pillToggle1tp
local dot = pillDot1tp

local isOn = false

-- Tween settings
local tweenInfo = TweenInfo.new(
    0.18,
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.Out
)

local function updateToggle()
    if isOn then
        -- Move dot right
        TweenService:Create(dot, tweenInfo, {
            Position = UDim2.new(0.55, 0, dot.Position.Y.Scale, dot.Position.Y.Offset)
        }):Play()

        -- Toggle background color
        TweenService:Create(toggle, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        }):Play()

        -- Dot color ON
        TweenService:Create(dot, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(0, 150, 150)
        }):Play()

        posgui.Visible = not posgui.Visible

    else
        -- Move dot left
        TweenService:Create(dot, tweenInfo, {
            Position = UDim2.new(0.1, 0, dot.Position.Y.Scale, dot.Position.Y.Offset)
        }):Play()

        -- Toggle background color
        TweenService:Create(toggle, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        }):Play()

        -- Dot color OFF
        TweenService:Create(dot, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(0, 50, 50)
        }):Play()
        posgui.Visible = not posgui.Visible
    end
end

button.MouseButton1Click:Connect(function()
    isOn = not isOn
    updateToggle()
end)

RunService.RenderStepped:Connect(function()
    if isOn then
        local pos = hrp.Position
        pos1Xtxt.Text = "X: " .. math.floor(pos.X)
        pos1Ytxt.Text = "Y: " .. math.floor(pos.Y)
        pos1Ztxt.Text = "Z: " .. math.floor(pos.Z)
    end
end)


--                                                                                                      Table R3 tp

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local function getVector3()

    if x and y and z then
        return Vector3.new(x, y, z)
    else
        warn("Invalid XYZ input")
        return nil
    end
end

local function getVector3FromInput()
    local x = tonumber(TextboxtpX.Text)
    local y = tonumber(TextboxtpY.Text)
    local z = tonumber(TextboxtpZ.Text)

    if x and y and z then
        return Vector3.new(x, y, z)
    else
        warn("Invalid XYZ input")
        return nil
    end
end

teleportToButton.MouseButton1Click:Connect(function()
    local vec = getVector3FromInput()
    if not vec then return end  -- stop if invalid input

    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(vec)
    end
end)

--                                                                                                      Table R 4 copy tp

textButtonR4tp.MouseButton1Click:Connect(function()
    local pos = hrp.Position

    TextboxtpX.Text = tostring(math.floor(pos.X))
    TextboxtpY.Text = tostring(math.floor(pos.Y))
    TextboxtpZ.Text = tostring(math.floor(pos.Z))
end)

--                                                                                                      Table R 5 Spawn platform tp
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local function getVector3()

    if x and y and z then
        return Vector3.new(x, y, z)
    else
        warn("Invalid XYZ input")
        return nil
    end
end

local function getNumberFromBox(box)
    local n = tonumber(box.Text)
    if not n then
        warn("Invalid number in box:", box.Name)
        return 0
    end
    return n
end

local function createPlatform()
    local x = getNumberFromBox(textboxtpXPlat)
    local y = getNumberFromBox(textboxtpYPlat)
    local z = getNumberFromBox(textboxtpZPlat)

    -- Create the part
    local part = Instance.new("Part")
    part.Size = Vector3.new(20, 1, 20)  -- platform size (change if needed)
    part.Position = Vector3.new(x, y, z)
    part.Anchored = true
    part.Color = Color3.fromRGB(255, 255, 255)
    part.Parent = workspace

    print("Created platform at:", part.Position)
end

SpawnPlatformButton.MouseButton1Click:Connect(createPlatform)

--                                                                                                      Table R 5 Copy pos Platform

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local function getVector3()

    if x and y and z then
        return Vector3.new(x, y, z)
    else
        warn("Invalid XYZ input")
        return nil
    end
end

local function getNumberFromBox(box)
    local n = tonumber(box.Text)
    if not n then
        warn("Invalid number in box:", box.Name)
        return 0
    end
    return n
end

textButtonR6tp.MouseButton1Click:Connect(function()
    local pos = hrp.Position

    textboxtpXPlat.Text = tostring(math.floor(pos.X))
    textboxtpYPlat.Text = tostring(math.floor(pos.Y))
    textboxtpZPlat.Text = tostring(math.floor(pos.Z))
end)

--                                                                                                      TP to Vault

vaulttpbutton.MouseButton1Click:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local pos2 = hrp.Position
        char.HumanoidRootPart.CFrame = CFrame.new(-150, 5, -115)

        task.wait(0.3)

        char.HumanoidRootPart.CFrame = CFrame.new(pos2)
    end
end)
--                                                                                                      Table R 2 afk

-- Store the final usable interval here:
local afkInterval = 0

local function updateAFKInterval()
    -- Safely convert text → number
    local min = tonumber(Textboxminafk.Text) or 0
    local sec = tonumber(Textboxsecafk.Text) or 0

    -- Convert minutes to seconds
    local afkIntervalmin = min * 60
    local afkIntervalsec = sec

    -- Final combined interval
    afkInterval = afkIntervalmin + afkIntervalsec

    print("AFK interval updated:", afkInterval)
end

-- Update whenever text changes
Textboxminafk:GetPropertyChangedSignal("Text"):Connect(updateAFKInterval)
Textboxsecafk:GetPropertyChangedSignal("Text"):Connect(updateAFKInterval)


local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local button = TextButtonR2afk
local toggle = pillToggle2afk
local dot = pillDot2afk

local isOn = false
local afkConnection = nil

-- Tween settings
local tweenInfo = TweenInfo.new(
    0.18,
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.Out
)

local function updateToggle()
    if isOn then
        -- Move dot right
        TweenService:Create(dot, tweenInfo, {
            Position = UDim2.new(0.55, 0, dot.Position.Y.Scale, dot.Position.Y.Offset)
        }):Play()

        TweenService:Create(toggle, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        }):Play()

        TweenService:Create(dot, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(0, 150, 150)
        }):Play()

    else
        -- Move dot left
        TweenService:Create(dot, tweenInfo, {
            Position = UDim2.new(0.1, 0, dot.Position.Y.Scale, dot.Position.Y.Offset)
        }):Play()

        TweenService:Create(toggle, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        }):Play()

        TweenService:Create(dot, tweenInfo, {
            BackgroundColor3 = Color3.fromRGB(0, 50, 50)
        }):Play()
    end
end

button.MouseButton1Click:Connect(function()
    isOn = not isOn
    updateToggle()

    -- Stop previous connection if any
    if afkConnection then
        afkConnection:Disconnect()
        afkConnection = nil
    end

    if isOn then
        -- Start interval jump loop
        afkConnection = RunService.RenderStepped:Connect(function()
            if tick() % afkInterval < 0.1 then
                local char = player.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end
        end)
    end
end)
