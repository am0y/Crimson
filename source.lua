local Library = {}
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local function Create(instanceType)
    return function(properties)
        local instance = Instance.new(instanceType)
        for property, value in pairs(properties) do
            instance[property] = value
        end
        return instance
    end
end

function Library:CreateWindow(title)
    -- Main GUI
    local Crimson = Create "ScreenGui" {
        Name = "Crimson",
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }

    -- Main Frame
    local MainFrame = Create "Frame" {
        Name = "MainFrame",
        Parent = Crimson,
        BackgroundColor3 = Color3.fromRGB(24, 24, 27),
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -450, 0.5, -280),
        Size = UDim2.new(0, 900, 0, 560),
        ClipsDescendants = true
    }

    -- Main Corner
    local MainCorner = Create "UICorner" {
        CornerRadius = UDim.new(0, 16),
        Parent = MainFrame
    }

    -- Main Stroke
    local MainStroke = Create "UIStroke" {
        Parent = MainFrame,
        Color = Color3.fromRGB(39, 39, 42),
        Transparency = 0.5
    }

    -- Title Bar
    local TitleBar = Create "Frame" {
        Name = "TitleBar",
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 56),
        BorderSizePixel = 0
    }

    local TitleContainer = Create "Frame" {
        Name = "TitleContainer",
        Parent = TitleBar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 24, 0, 0),
        Size = UDim2.new(1, -48, 1, 0)
    }

    local StatusDot = Create "Frame" {
        Name = "StatusDot",
        Parent = TitleContainer,
        BackgroundColor3 = Color3.fromRGB(220, 38, 38),
        Position = UDim2.new(0, 0, 0.5, -4),
        Size = UDim2.new(0, 8, 0, 8)
    }

    Create "UICorner" {
        CornerRadius = UDim.new(1, 0),
        Parent = StatusDot
    }

    local TitleText = Create "TextLabel" {
        Name = "Title",
        Parent = TitleContainer,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 20, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = title,
        TextColor3 = Color3.fromRGB(115, 115, 115),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    }

    local VersionText = Create "TextLabel" {
        Name = "Version",
        Parent = TitleContainer,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -40, 0, 0),
        Size = UDim2.new(0, 40, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = "v2.1.0",
        TextColor3 = Color3.fromRGB(115, 115, 115),
        TextSize = 12
    }

    -- Content Container
    local ContentContainer = Create "Frame" {
        Name = "ContentContainer",
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 56),
        Size = UDim2.new(1, 0, 1, -56)
    }

    -- Sidebar
    local Sidebar = Create "Frame" {
        Name = "Sidebar",
        Parent = ContentContainer,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 224, 1, 0),
        BorderSizePixel = 0
    }

    local SidebarStroke = Create "Frame" {
        Name = "SidebarStroke",
        Parent = Sidebar,
        BackgroundColor3 = Color3.fromRGB(39, 39, 42),
        BackgroundTransparency = 0.5,
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 1, 1, 0)
    }

    local TabContainer = Create "Frame" {
        Name = "TabContainer",
        Parent = Sidebar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 0),
        Size = UDim2.new(1, -32, 1, -80)
    }

    local TabList = Create "UIListLayout" {
        Parent = TabContainer,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4)
    }

    -- User Panel
    local UserPanel = Create "Frame" {
        Name = "UserPanel",
        Parent = Sidebar,
        BackgroundColor3 = Color3.fromRGB(39, 39, 42),
        BackgroundTransparency = 0.6,
        Position = UDim2.new(0, 16, 1, -64),
        Size = UDim2.new(1, -32, 0, 48)
    }

    Create "UICorner" {
        CornerRadius = UDim.new(0, 8),
        Parent = UserPanel
    }

    Create "UIStroke" {
        Parent = UserPanel,
        Color = Color3.fromRGB(39, 39, 42),
        Transparency = 0.5
    }

    local UserAvatar = Create "Frame" {
        Name = "UserAvatar",
        Parent = UserPanel,
        BackgroundColor3 = Color3.fromRGB(220, 38, 38),
        Position = UDim2.new(0, 12, 0.5, -16),
        Size = UDim2.new(0, 32, 0, 32)
    }

    Create "UICorner" {
        CornerRadius = UDim.new(1, 0),
        Parent = UserAvatar
    }

    local UserInfo = Create "Frame" {
        Name = "UserInfo",
        Parent = UserPanel,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 56, 0, 0),
        Size = UDim2.new(1, -68, 1, 0)
    }

    local Username = Create "TextLabel" {
        Name = "Username",
        Parent = UserInfo,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 8),
        Size = UDim2.new(1, 0, 0, 16),
        Font = Enum.Font.GothamMedium,
        Text = "User420",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    }

    local UserType = Create "TextLabel" {
        Name = "UserType",
        Parent = UserInfo,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 1, -20),
        Size = UDim2.new(1, 0, 0, 12),
        Font = Enum.Font.GothamMedium,
        Text = "Premium",
        TextColor3 = Color3.fromRGB(115, 115, 115),
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }

    -- Content
    local Content = Create "Frame" {
        Name = "Content",
        Parent = ContentContainer,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 224, 0, 0),
        Size = UDim2.new(1, -224, 1, 0)
    }

    local TabSystem = {}
    local Tabs = {}
    local SelectedTab = nil

    function TabSystem:CreateTab(name)
        local Tab = {}
        
        local TabButton = Create "TextButton" {
            Name = name.."Tab",
            Parent = TabContainer,
            BackgroundColor3 = Color3.fromRGB(220, 38, 38),
            BackgroundTransparency = 0.8,
            Size = UDim2.new(1, 0, 0, 40),
            Font = Enum.Font.GothamMedium,
            Text = name,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14,
            AutoButtonColor = false
        }

        Create "UICorner" {
            CornerRadius = UDim.new(0, 8),
            Parent = TabButton
        }

        local TabPage = Create "ScrollingFrame" {
            Name = name.."Page",
            Parent = Content,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            ScrollBarThickness = 0,
            Visible = false
        }

        local PagePadding = Create "Frame" {
            Name = "PagePadding",
            Parent = TabPage,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 24, 0, 24),
            Size = UDim2.new(1, -48, 1, -48)
        }

        local PageList = Create "UIListLayout" {
            Parent = PagePadding,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 24)
        }

        function Tab:CreateSection(title)
            local Section = {}
            
            local SectionContainer = Create "Frame" {
                Name = title.."Section",
                Parent = PagePadding,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            }

            local SectionTitle = Create "TextLabel" {
                Name = "SectionTitle",
                Parent = SectionContainer,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 24),
                Font = Enum.Font.GothamBold,
                Text = title,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 16,
                TextXAlignment = Enum.TextXAlignment.Left
            }

            local ElementContainer = Create "Frame" {
                Name = "ElementContainer",
                Parent = SectionContainer,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 40),
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            }

            local ElementList = Create "UIGridLayout" {
                Parent = ElementContainer,
                SortOrder = Enum.SortOrder.LayoutOrder,
                CellPadding = UDim2.new(0, 16, 0, 16),
                CellSize = UDim2.new(0.5, -8, 0, 80),
                FillDirectionMaxCells = 2
            }

            function Section:CreateToggle(text, description, callback)
                local Toggle = {}
                
                local ToggleContainer = Create "Frame" {
                    Name = text.."Toggle",
                    Parent = ElementContainer,
                    BackgroundColor3 = Color3.fromRGB(39, 39, 42),
                    BackgroundTransparency = 0.6
                }

                Create "UICorner" {
                    CornerRadius = UDim.new(0, 12),
                    Parent = ToggleContainer
                }

                Create "UIStroke" {
                    Parent = ToggleContainer,
                    Color = Color3.fromRGB(39, 39, 42),
                    Transparency = 0.5
                }

                local ToggleInfo = Create "Frame" {
                    Name = "ToggleInfo",
                    Parent = ToggleContainer,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 16, 0, 16),
                    Size = UDim2.new(1, -32, 1, -32)
                }

                local ToggleTitle = Create "TextLabel" {
                    Name = "Title",
                    Parent = ToggleInfo,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -48, 0, 16),
                    Font = Enum.Font.GothamMedium,
                    Text = text,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left
                }

                local ToggleDescription = Create "TextLabel" {
                    Name = "Description",
                    Parent = ToggleInfo,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 20),
                    Size = UDim2.new(1, -48, 0, 12),
                    Font = Enum.Font.GothamMedium,
                    Text = description,
                    TextColor3 = Color3.fromRGB(115, 115, 115),
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                }

                local ToggleButton = Create "TextButton" {
                    Name = "ToggleButton",
                    Parent = ToggleInfo,
                    BackgroundColor3 = Color3.fromRGB(39, 39, 42),
                    Position = UDim2.new(1, -44, 0, 0),
                    Size = UDim2.new(0, 44, 0, 24),
                    Text = "",
                    AutoButtonColor = false
                }

                Create "UICorner" {
                    CornerRadius = UDim.new(1, 0),
                    Parent = ToggleButton
                }

                local ToggleCircle = Create "Frame" {
                    Name = "ToggleCircle",
                    Parent = ToggleButton,
                    BackgroundColor3 = Color3.fromRGB(115, 115, 115),
                    Position = UDim2.new(0, 2, 0.5, -10),
                    Size = UDim2.new(0, 20, 0, 20)
                }

                Create "UICorner" {
                    CornerRadius = UDim.new(1, 0),
                    Parent = ToggleCircle
                }

                local toggled = false
                
                ToggleButton.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    
                    local toggleTween = TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {
                        Position = toggled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
                        BackgroundColor3 = toggled and Color3.fromRGB(220, 38, 38) or Color3.fromRGB(115, 115, 115)
                    })
                    
                    toggleTween:Play()
                    callback(toggled)
                end)

                return Toggle
            end

            return Section
        end

        TabButton.MouseButton1Click:Connect(function()
            if SelectedTab ~= TabPage then
                if SelectedTab then
                    SelectedTab.Visible = false
                end
                TabPage.Visible = true
                SelectedTab = TabPage
            end
        end)

        if #Tabs == 0 then
            TabPage.Visible = true
            SelectedTab = TabPage
        end

        table.insert(Tabs, Tab)
        return Tab
    end

    -- Dragging
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    return TabSystem
end

return Library