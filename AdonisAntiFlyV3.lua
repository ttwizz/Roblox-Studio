-- ttwiz_z#2081

local DELAY = 30

local Players = game:GetService("Players")
local WhitelistedStates = {0, 3, 4, 5, 7, 8, 10, 12, 15}

Players.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function(Character)
        pcall(function()
            delay(tonumber(DELAY), function()
                while task.wait(1) and _G.Adonis and not _G.Adonis.CheckAdmin(Player) do
                    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if not Humanoid or not HumanoidRootPart then
                        Player:LoadCharacter()
                        warn(string.format("Игрок @%s подозревается в использовании читов!", Player.Name))
                        return
                    end
                    local OldPosition, OldState = HumanoidRootPart.Position, Humanoid:GetState()
                    delay(1, function()
                        if (HumanoidRootPart.Position - OldPosition).Magnitude >= 25 then
                            task.wait(0.1)
                            if table.find(WhitelistedStates, Humanoid:GetState().Value) or table.find(WhitelistedStates, OldState) then return end
                            if Humanoid.FloorMaterial ~= Enum.Material.Air or Humanoid.Health == 0 or Humanoid.Sit then return end
                            Player:LoadCharacter()
                            warn(string.format("Игрок @%s попытался включить режим полёта, но был обнаружен античитом!", Player.Name))
                            Player:Kick("Обнаружены читы! Свяжитесь с ttwiz_z#2081, если считаете, что произошла ошибка.")
                        end
                    end)
                end
            end)
        end)
    end)
end)