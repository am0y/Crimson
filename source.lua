-- Scene UI Library
-- Version 1.0.0
-- A modern, minimal UI library for Roblox

local Scene = {}
Scene.__index = Scene

-- Constants
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Theme Configuration
local DefaultTheme = {
    Primary = Color3.fromRGB(99, 102, 241),    -- Modern indigo
    Secondary = Color3.fromRGB(249, 250, 251),  -- Light gray
    Background = Color3.fromRGB(255, 255, 255), -- White
    Text = Color3.fromRGB(17, 24, 39),         -- Dark gray
    Border = Color3.fromRGB(229, 231, 235),    -- Light border
    Success = Color3.fromRGB(34, 197, 94),     -- Green
    Warning = Color3.fromRGB(234, 179, 8),     -- Yellow
    Error = Color3.fromRGB(239, 68, 68),       -- Red
    
    -- Typography
    FontFamily = Enum.Font.GothamMedium,
    FontSize = {
        Small = 12,
        Normal = 14,
        Large = 16,
        Header = 20
    },
    
    -- Spacing
    Padding = {
        Small = UDim.new(0, 8),
        Normal = UDim.new(0, 12),
        Large = UDim.new(0, 16)
    },
    
    -- Border Radius
    BorderRadius = {
        Small = UDim.new(0, 4),
        Normal = UDim.new(0, 6),
        Large = UDim.new(0, 8),
        Full = UDim.new(0, 9999)
    },
    
    -- Animation
    Animation = {
        Duration = 0.15,
        Style = Enum.EasingStyle.Quad,
        Direction = Enum.EasingDirection.Out
    }
}

-- Utility Functions
local function CreateTween(object, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(
        duration or DefaultTheme.Animation.Duration,
        style or DefaultTheme.Animation.Style,
        direction or DefaultTheme.Animation.Direction
    )
    local tween = TweenService:Create(object, tweenInfo, properties)
    return tween
end

local function ApplyRounding(instance, radius)
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = radius or DefaultTheme.BorderRadius.Normal
    uiCorner.Parent = instance
    return uiCorner
end

local function ApplyPadding(instance, padding)
    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingTop = padding or DefaultTheme.Padding.Normal
    uiPadding.PaddingBottom = padding or DefaultTheme.Padding.Normal
    uiPadding.PaddingLeft = padding or DefaultTheme.Padding.Normal
    uiPadding.PaddingRight = padding or DefaultTheme.Padding.Normal
    uiPadding.Parent = instance
    return uiPadding
end

-- Component Creation Functions
function Scene.new()
    local self = setmetatable({}, Scene)
    
    -- Create main GUI
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "Scene"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Create main frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Size = UDim2.new(1, 0, 1, 0)
    self.MainFrame.BackgroundTransparency = 1
    self.MainFrame.Parent = self.ScreenGui
    
    -- Initialize components container
    self.Components = {}
    
    return self
end

function Scene:CreateButton(properties)
    local button = Instance.new("TextButton")
    button.Name = properties.Name or "Button"
    button.Size = properties.Size or UDim2.new(0, 200, 0, 40)
    button.Position = properties.Position or UDim2.new(0.5, -100, 0.5, -20)
    button.BackgroundColor3 = properties.BackgroundColor3 or DefaultTheme.Primary
    button.TextColor3 = properties.TextColor3 or DefaultTheme.Secondary
    button.Text = properties.Text or "Button"
    button.Font = properties.Font or DefaultTheme.FontFamily
    button.TextSize = properties.TextSize or DefaultTheme.FontSize.Normal
    button.AutoButtonColor = false
    
    -- Apply styling
    ApplyRounding(button)
    ApplyPadding(button)
    
    -- Hover animation
    button.MouseEnter:Connect(function()
        CreateTween(button, {
            BackgroundColor3 = properties.HoverColor or 
                DefaultTheme.Primary:Lerp(Color3.new(1, 1, 1), 0.1)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        CreateTween(button, {
            BackgroundColor3 = properties.BackgroundColor3 or DefaultTheme.Primary
        }):Play()
    end)
    
    -- Click animation
    button.MouseButton1Down:Connect(function()
        CreateTween(button, {
            Size = button.Size - UDim2.new(0, 4, 0, 4)
        }, 0.06):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        CreateTween(button, {
            Size = properties.Size or UDim2.new(0, 200, 0, 40)
        }, 0.06):Play()
    end)
    
    button.Parent = self.MainFrame
    return button
end

function Scene:CreateInput(properties)
    local container = Instance.new("Frame")
    container.Name = properties.Name or "InputContainer"
    container.Size = properties.Size or UDim2.new(0, 200, 0, 40)
    container.Position = properties.Position or UDim2.new(0.5, -100, 0.5, -20)
    container.BackgroundColor3 = properties.BackgroundColor3 or DefaultTheme.Secondary
    container.BorderSizePixel = 0
    
    local input = Instance.new("TextBox")
    input.Name = "Input"
    input.Size = UDim2.new(1, -20, 1, -10)
    input.Position = UDim2.new(0, 10, 0, 5)
    input.BackgroundTransparency = 1
    input.TextColor3 = properties.TextColor3 or DefaultTheme.Text
    input.PlaceholderText = properties.PlaceholderText or "Enter text..."
    input.PlaceholderColor3 = properties.PlaceholderColor3 or DefaultTheme.Text:Lerp(DefaultTheme.Secondary, 0.5)
    input.Text = properties.Text or ""
    input.Font = properties.Font or DefaultTheme.FontFamily
    input.TextSize = properties.TextSize or DefaultTheme.FontSize.Normal
    input.ClearTextOnFocus = properties.ClearTextOnFocus or false
    input.Parent = container
    
    -- Apply styling
    ApplyRounding(container)
    
    -- Focus animations
    input.Focused:Connect(function()
        CreateTween(container, {
            BackgroundColor3 = DefaultTheme.Primary:Lerp(DefaultTheme.Secondary, 0.9)
        }):Play()
    end)
    
    input.FocusLost:Connect(function()
        CreateTween(container, {
            BackgroundColor3 = properties.BackgroundColor3 or DefaultTheme.Secondary
        }):Play()
    end)
    
    container.Parent = self.MainFrame
    return container
end

function Scene:CreateDropdown(properties)
    local container = Instance.new("Frame")
    container.Name = properties.Name or "DropdownContainer"
    container.Size = properties.Size or UDim2.new(0, 200, 0, 40)
    container.Position = properties.Position or UDim2.new(0.5, -100, 0.5, -20)
    container.BackgroundColor3 = properties.BackgroundColor3 or DefaultTheme.Secondary
    container.BorderSizePixel = 0
    
    local button = Instance.new("TextButton")
    button.Name = "DropdownButton"
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = properties.Text or "Select option..."
    button.Font = properties.Font or DefaultTheme.FontFamily
    button.TextColor3 = properties.TextColor3 or DefaultTheme.Text
    button.TextSize = properties.TextSize or DefaultTheme.FontSize.Normal
    button.Parent = container
    
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Name = "Options"
    optionsFrame.Size = UDim2.new(1, 0, 0, 0)
    optionsFrame.Position = UDim2.new(0, 0, 1, 5)
    optionsFrame.BackgroundColor3 = properties.BackgroundColor3 or DefaultTheme.Secondary
    optionsFrame.BorderSizePixel = 0
    optionsFrame.Visible = false
    optionsFrame.ZIndex = 2
    optionsFrame.Parent = container
    
    -- Apply styling
    ApplyRounding(container)
    ApplyRounding(optionsFrame)
    
    local options = properties.Options or {}
    local optionButtons = {}
    
    local function UpdateOptions()
        -- Clear existing options
        for _, button in pairs(optionButtons) do
            button:Destroy()
        end
        optionButtons = {}
        
        -- Create new options
        for i, option in ipairs(options) do
            local optionButton = Instance.new("TextButton")
            optionButton.Name = "Option_" .. i
            optionButton.Size = UDim2.new(1, 0, 0, 30)
            optionButton.Position = UDim2.new(0, 0, 0, (i-1) * 30)
            optionButton.BackgroundColor3 = DefaultTheme.Secondary
            optionButton.Text = option
            optionButton.Font = DefaultTheme.FontFamily
            optionButton.TextColor3 = DefaultTheme.Text
            optionButton.TextSize = DefaultTheme.FontSize.Normal
            optionButton.ZIndex = 2
            optionButton.Parent = optionsFrame
            
            -- Option hover animation
            optionButton.MouseEnter:Connect(function()
                CreateTween(optionButton, {
                    BackgroundColor3 = DefaultTheme.Primary:Lerp(DefaultTheme.Secondary, 0.9)
                }):Play()
            end)
            
            optionButton.MouseLeave:Connect(function()
                CreateTween(optionButton, {
                    BackgroundColor3 = DefaultTheme.Secondary
                }):Play()
            end)
            
            optionButton.MouseButton1Click:Connect(function()
                button.Text = option
                CreateTween(optionsFrame, {
                    Size = UDim2.new(1, 0, 0, 0)
                }):Play()
                wait(0.15)
                optionsFrame.Visible = false
                
                if properties.OnOptionSelected then
                    properties.OnOptionSelected(option)
                end
            end)
            
            table.insert(optionButtons, optionButton)
        end
        
        optionsFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    end
    
    -- Toggle dropdown
    button.MouseButton1Click:Connect(function()
        if optionsFrame.Visible then
            CreateTween(optionsFrame, {
                Size = UDim2.new(1, 0, 0, 0)
            }):Play()
            wait(0.15)
            optionsFrame.Visible = false
        else
            optionsFrame.Size = UDim2.new(1, 0, 0, 0)
            optionsFrame.Visible = true
            CreateTween(optionsFrame, {
                Size = UDim2.new(1, 0, 0, #options * 30)
            }):Play()
        end
    end)
    
    UpdateOptions()
    container.Parent = self.MainFrame
    return container
end

function Scene:CreateModal(properties)
    local backdrop = Instance.new("Frame")
    backdrop.Name = "ModalBackdrop"
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.BackgroundColor3 = Color3.new(0, 0, 0)
    backdrop.BackgroundTransparency = 1
    backdrop.Visible = false
    
    local modal = Instance.new("Frame")
    modal.Name = properties.Name or "Modal"
    modal.Size = properties.Size or UDim2.new(0, 300, 0, 200)
    modal.Position = UDim2.new(0.5, -150, 0.5, -100)
    modal.BackgroundColor3 = properties.BackgroundColor3 or DefaultTheme.Background
    modal.BorderSizePixel = 0
    modal.Visible = false
    
    -- Apply styling
    ApplyRounding(modal)
    
    -- Create header
    local header = Instance.new("TextLabel")
    header.Name = "Header"
    header.Size = UDim2.new(1, -20, 0, 40)
    header.Position = UDim2.new(0, 10, 0, 10)
    header.BackgroundTransparency = 1
    header.Text = properties.Title or "Modal"
    header.Font = DefaultTheme.FontFamily
    header.TextColor3 = DefaultTheme.Text
    header.TextSize = DefaultTheme.FontSize.Header
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = modal
    
    -- Create close button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0, 10)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "×"
    closeButton.Font = DefaultTheme.FontFamily
    closeButton.TextColor3 = DefaultTheme.Text
    closeButton.TextSize = 24
    closeButton.Parent = modal
    
    -- Create content container
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -20, 1, -60)
    content.Position = UDim2.new(0, 10, 0, 50)
    content.BackgroundTransparency = 1
    content.Parent = modal
    
    local function Show()
        backdrop.Visible = true
        modal.Visible = true
        
        CreateTween(backdrop, {
            BackgroundTransparency = 0.5
        }):Play()
        
        modal.Size = UDim2.new(0, 300, 0, 0)
        modal.Position = UDim2.new(0.5, -150, 0.5, 0)
        
        CreateTween(modal, {
            Size = properties.Size or UDim2.new(0, 300, 0, 200),
            Position = UDim2.new(0.5, -150, 0.5, -100)
        }):Play()
    end
    
    local function Hide()
        CreateTween(backdrop, {
            BackgroundTransparency = 1
        }):Play()
        
        CreateTween(modal, {
            Size = UDim2.new(0, 300, 0, 0),
            Position = UDim2.new(0.5, -150, 0.5, 0)
        }):Play()
        
        wait(0.15)
        backdrop.Visible = false
        modal.Visible = false
    end
    
    closeButton.MouseButton1Click:Connect(Hide)
    backdrop.Parent = self.MainFrame
    modal.Parent = backdrop
    
    return {
        Show = Show,
        Hide = Hide,
        Content = content
    }
end

function Scene:CreateToast(properties)
    local toast = Instance.new("Frame")
    toast.Name = properties.Name or "Toast"
    toast.Size = UDim2.new(0, 300, 0, 60)
    toast.Position = UDim2.new(1, 20, 1, -80)
    toast.BackgroundColor3 = properties.BackgroundColor3 or DefaultTheme.Background
    toast.BorderSizePixel = 0
    toast.Visible = false
    
    -- Apply styling
    ApplyRounding(toast)
    
    -- Create icon (if specified)
    if properties.Icon then
        local icon = Instance.new("ImageLabel")
        icon.Name = "Icon"
        icon.Size = UDim2.new(0, 24, 0, 24)
        icon.Position = UDim2.new(0, 18, 0.5, -12)
        icon.BackgroundTransparency = 1
        icon.Image = properties.Icon
        icon.Parent = toast
    end
    
    -- Create message
    local message = Instance.new("TextLabel")
    message.Name = "Message"
    message.Size = UDim2.new(1, -80, 1, 0)
    message.Position = UDim2.new(0, properties.Icon and 50 or 20, 0, 0)
    message.BackgroundTransparency = 1
    message.Text = properties.Text or "Toast message"
    message.Font = DefaultTheme.FontFamily
    message.TextColor3 = DefaultTheme.Text
    message.TextSize = DefaultTheme.FontSize.Normal
    message.TextXAlignment = Enum.TextXAlignment.Left
    message.TextWrapped = true
    message.Parent = toast
    
    local function Show()
        toast.Position = UDim2.new(1, 20, 1, -80)
        toast.Visible = true
        
        CreateTween(toast, {
            Position = UDim2.new(1, -320, 1, -80)
        }):Play()
        
        wait(properties.Duration or 3)
        
        CreateTween(toast, {
            Position = UDim2.new(1, 20, 1, -80)
        }):Play()
        
        wait(0.15)
        toast.Visible = false
    end
    
    toast.Parent = self.MainFrame
    return {
        Show = Show
    }
end

-- Additional utility methods
function Scene:Mount()
    self.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

function Scene:Unmount()
    self.ScreenGui:Destroy()
end

return Scene
