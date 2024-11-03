-- Scene UI Library
-- Modern, Minimal, Dark Theme UI Library
-- Version 2.0.0

local Scene = {}
Scene.__index = Scene

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Theme = {
    Primary = Color3.fromRGB(99, 102, 241),      
    Secondary = Color3.fromRGB(124, 58, 237),    
    Background = {
        Dark = Color3.fromRGB(17, 17, 17),       
        Default = Color3.fromRGB(23, 23, 23),    
        Light = Color3.fromRGB(32, 32, 32)       
    },
    Text = {
        Primary = Color3.fromRGB(255, 255, 255),    
        Secondary = Color3.fromRGB(156, 163, 175),  
        Disabled = Color3.fromRGB(75, 85, 99)       
    },
    Border = {
        Default = Color3.fromRGB(39, 39, 39),
        Hover = Color3.fromRGB(55, 55, 55)
    },
    States = {
        Success = Color3.fromRGB(34, 197, 94),    
        Warning = Color3.fromRGB(234, 179, 8),    
        Error = Color3.fromRGB(239, 68, 68),      
        Info = Color3.fromRGB(59, 130, 246)       
    },
    
    Font = {
        Default = Enum.Font.GothamMedium,
        Mono = Enum.Font.Code,
        Size = {
            Tiny = 10,
            Small = 12,
            Normal = 14,
            Large = 16,
            Title = 20,
            Header = 24
        }
    },
    
    Layout = {
        Padding = {
            Tiny = UDim.new(0, 4),
            Small = UDim.new(0, 8),
            Normal = UDim.new(0, 12),
            Large = UDim.new(0, 16),
            XLarge = UDim.new(0, 24)
        },
        Radius = {
            Small = UDim.new(0, 4),
            Normal = UDim.new(0, 6),
            Large = UDim.new(0, 8),
            XLarge = UDim.new(0, 12),
            Pill = UDim.new(0, 9999)
        }
    },
    
    Animation = {
        Spring = {
            Duration = 0.3,
            Style = Enum.EasingStyle.Back,
            Direction = Enum.EasingDirection.Out
        },
        Quick = {
            Duration = 0.15,
            Style = Enum.EasingStyle.Quad,
            Direction = Enum.EasingDirection.Out
        },
        Smooth = {
            Duration = 0.4,
            Style = Enum.EasingStyle.Sine,
            Direction = Enum.EasingDirection.InOut
        }
    }
}

local function ApplyTheme(instance, properties)
    for property, value in pairs(properties) do
        instance[property] = value
    end
end

local function CreateTween(object, properties, tweenInfo)
    local tween = TweenService:Create(object, tweenInfo, properties)
    return tween
end

local function ApplyRounding(instance, radius)
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = radius or Theme.Layout.Radius.Normal
    uiCorner.Parent = instance
    return uiCorner
end

local function ApplyPadding(instance, padding)
    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingTop = padding or Theme.Layout.Padding.Normal
    uiPadding.PaddingBottom = padding or Theme.Layout.Padding.Normal
    uiPadding.PaddingLeft = padding or Theme.Layout.Padding.Normal
    uiPadding.PaddingRight = padding or Theme.Layout.Padding.Normal
    uiPadding.Parent = instance
    return uiPadding
end

local function CreateDropShadow(instance, strength)
    strength = strength or 0.25
    
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, 24, 1, 24)
    shadow.ZIndex = instance.ZIndex - 1
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 1 - strength
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.Parent = instance
    
    return shadow
end

function Scene.new()
    local self = setmetatable({}, Scene)
    
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "Scene"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    self.Blur = Instance.new("BlurEffect")
    self.Blur.Size = 0
    self.Blur.Parent = game:GetService("Lighting")
    
    self.Window = Instance.new("Frame")
    self.Window.Name = "Window"
    self.Window.Size = UDim2.new(0, 500, 0, 350)
    self.Window.Position = UDim2.new(0.5, -250, 0.5, -175)
    self.Window.BackgroundColor3 = Theme.Background.Dark
    self.Window.BorderSizePixel = 0
    
    ApplyRounding(self.Window, Theme.Layout.Radius.Large)
    CreateDropShadow(self.Window, 0.5)
    
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Name = "TitleBar"
    self.TitleBar.Size = UDim2.new(1, 0, 0, 40)
    self.TitleBar.BackgroundColor3 = Theme.Background.Default
    self.TitleBar.BorderSizePixel = 0
    
    self.Title = Instance.new("TextLabel")
    self.Title.Name = "Title"
    self.Title.Size = UDim2.new(1, -40, 1, 0)
    self.Title.Position = UDim2.new(0, 20, 0, 0)
    self.Title.BackgroundTransparency = 1
    self.Title.Text = "Scene UI"
    self.Title.Font = Theme.Font.Default
    self.Title.TextSize = Theme.Font.Size.Title
    self.Title.TextColor3 = Theme.Text.Primary
    self.Title.TextXAlignment = Enum.TextXAlignment.Left
    
    self.Content = Instance.new("Frame")
    self.Content.Name = "Content"
    self.Content.Size = UDim2.new(1, -40, 1, -60)
    self.Content.Position = UDim2.new(0, 20, 0, 50)
    self.Content.BackgroundTransparency = 1
    
    self.Title.Parent = self.TitleBar
    self.TitleBar.Parent = self.Window
    self.Content.Parent = self.Window
    self.Window.Parent = self.ScreenGui
    
    self.Components = {}
    
    return self
end

function Scene:CreateButton(properties)
    local button = Instance.new("TextButton")
    button.Name = properties.Name or "Button"
    button.Size = properties.Size or UDim2.new(0, 200, 0, 40)
    button.Position = properties.Position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = properties.Primary and Theme.Primary or Theme.Background.Light
    button.BorderSizePixel = 0
    button.Text = properties.Text or "Button"
    button.TextColor3 = properties.Primary and Theme.Text.Primary or Theme.Text.Secondary
    button.Font = Theme.Font.Default
    button.TextSize = Theme.Font.Size.Normal
    button.AutoButtonColor = false
    
    ApplyRounding(button)
    CreateDropShadow(button, 0.2)
    
    button.MouseEnter:Connect(function()
        CreateTween(button, {
            BackgroundColor3 = properties.Primary and 
                Theme.Primary:Lerp(Color3.new(1,1,1), 0.1) or
                Theme.Background.Light:Lerp(Color3.new(1,1,1), 0.1)
        }, Theme.Animation.Quick):Play()
    end)
    
    button.MouseLeave:Connect(function()
        CreateTween(button, {
            BackgroundColor3 = properties.Primary and Theme.Primary or Theme.Background.Light
        }, Theme.Animation.Quick):Play()
    end)
    
    button.Parent = self.Content
    return button
end

function Scene:CreateInput(properties)
    local container = Instance.new("Frame")
    container.Name = properties.Name or "InputContainer"
    container.Size = properties.Size or UDim2.new(0, 200, 0, 40)
    container.Position = properties.Position or UDim2.new(0, 0, 0, 0)
    container.BackgroundColor3 = Theme.Background.Light
    container.BorderSizePixel = 0
    
    local input = Instance.new("TextBox")
    input.Name = "Input"
    input.Size = UDim2.new(1, -20, 1, 0)
    input.Position = UDim2.new(0, 10, 0, 0)
    input.BackgroundTransparency = 1
    input.Text = properties.Text or ""
    input.PlaceholderText = properties.PlaceholderText or "Type here..."
    input.TextColor3 = Theme.Text.Primary
    input.PlaceholderColor3 = Theme.Text.Disabled
    input.Font = Theme.Font.Default
    input.TextSize = Theme.Font.Size.Normal
    input.Parent = container
    
    ApplyRounding(container)
    CreateDropShadow(container, 0.2)
    
    container.Parent = self.Content
    return container
end

function Scene:CreateDropdown(properties)
    local container = Instance.new("Frame")
    container.Name = properties.Name or "DropdownContainer"
    container.Size = properties.Size or UDim2.new(0, 200, 0, 40)
    container.Position = properties.Position or UDim2.new(0, 0, 0, 0)
    container.BackgroundColor3 = Theme.Background.Light
    container.BorderSizePixel = 0
    container.ClipsDescendants = true
    
    local selected = Instance.new("TextLabel")
    selected.Name = "Selected"
    selected.Size = UDim2.new(1, -40, 1, 0)
    selected.Position = UDim2.new(0, 10, 0, 0)
    selected.BackgroundTransparency = 1
    selected.Text = properties.Text or "Select option..."
    selected.TextColor3 = Theme.Text.Primary
    selected.Font = Theme.Font.Default
    selected.TextSize = Theme.Font.Size.Normal
    selected.TextXAlignment = Enum.TextXAlignment.Left
    selected.Parent = container
    
    local options = Instance.new("Frame")
    options.Name = "Options"
    options.Size = UDim2.new(1, 0, 0, 0)
    options.Position = UDim2.new(0, 0, 1, 0)
    options.BackgroundColor3 = Theme.Background.Light
    options.BorderSizePixel = 0
    options.Visible = false
    options.Parent = container
    
    ApplyRounding(container)
    ApplyRounding(options)
    CreateDropShadow(container, 0.2)
    
    container.Parent = self.Content
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
    modal.Size = properties.Size or UDim2.new(0, 400, 0, 300)
    modal.Position = UDim2.new(0.5, -200, 0.5, -150)
    modal.BackgroundColor3 = Theme.Background.Default
    modal.BorderSizePixel = 0
    modal.Visible = false
    
    ApplyRounding(modal)
    CreateDropShadow(modal, 0.4)
    
    backdrop.Parent = self.Window
    modal.Parent = backdrop
    return modal
end

function Scene:Mount()
    self.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

function Scene:Unmount()
    self.ScreenGui:Destroy()
    self.Blur:Destroy()
end

return Scene
