-- Script para Arsenal no Roblox

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/7yhx/kwargs_Ui_Library/main/source.lua"))()
      
local UI = Lib:Create{
    Theme = "Dark", -- or any other theme
    Size = UDim2.new(0, 555, 0, 400) -- default
 }
 
 local Main = UI:Tab{
    Name = "Inicio"
 }
 
 local Divider = Main:Divider{
    Name = "Inicio shit"
 }
 
 local QuitDivider = Main:Divider{
    Name = "Sair"
 }

 local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Configurações
local enemyColor = Color3.new(1, 0, 0) -- Vermelho
local friendlyColor = Color3.new(0, 0, 1) -- Azul
local fovDistance = 200 -- Distância do FOV
local toggleKey = Enum.KeyCode.Insert -- Tecla para ativar/desativar

-- Função para verificar se um jogador é inimigo
local function isEnemy(player)
    return player.Team ~= LocalPlayer.Team
end

-- Função para desenhar o FOV
local function drawFOV()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local position = player.Character.HumanoidRootPart.Position
            local screenPosition, onScreen = workspace.CurrentCamera:WorldToScreenPoint(position)
            if onScreen and (position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= fovDistance then
                local color = isEnemy(player) and enemyColor or friendlyColor
                -- Desenhe algo para marcar o jogador (por exemplo, uma seta)
                -- Você pode usar uma biblioteca de GUI como UiLib ou criar suas próprias UI elements.
            end
        end
    end
end

-- Ativar/desativar o FOV
local fovEnabled = true
toggleKey.InputBegan:Connect(function(input)
    if input.KeyCode == toggleKey then
        fovEnabled = not fovEnabled
    end
end)

-- Loop principal
game:GetService("RunService").RenderStepped:Connect(function()
    if fovEnabled then
        drawFOV()
    end
end)