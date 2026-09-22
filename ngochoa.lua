local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({ Name = "ngoc hoadzver1 | Vietnam Hub", LoadingTitle = "Đang tải ngoc hoadzver1...", KeySystem = false })

-- Hàm chung xử lý Farm và Teleport
local function startFarm(pos, flagVar)
   task.spawn(function()
      while _G[flagVar] do
         task.wait(0.5)
         pcall(function()
            local char = game.Players.LocalPlayer.Character
            char:WaitForChild("HumanoidRootPart").CFrame = pos
            for _, v in pairs(workspace:GetDescendants()) do
               if v:IsA("ProximityPrompt") and v.Parent and (v.Parent.Position - char.HumanoidRootPart.Position).Magnitude < 10 then
                  fireproximityprompt(v)
               end
            end
         end)
      end
   end)
end

-- Tab Auto Farm
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
FarmTab:CreateToggle({ Name = "Auto Farm Bánh Mì", CurrentValue = false, Flag = "AF_BanhMi", Callback = function(v)
   _G.AF_BanhMi = v
   if v then startFarm(CFrame.new(530, 19, -449), "AF_BanhMi") end
end})

FarmTab:CreateToggle({ Name = "Auto Farm Chốt Công An", CurrentValue = false, Flag = "AF_CA", Callback = function(v)
   _G.AF_CA = v
   if v then startFarm(CFrame.new(734, 22, -812), "AF_CA") end
end})

-- Tab Tiện ích
local UtilTab = Window:CreateTab("Tiện ích", 4483362458)
local afkConn
UtilTab:CreateToggle({ Name = "Anti AFK", CurrentValue = false, Flag = "AntiAFK", Callback = function(v)
   if v then
      afkConn = game.Players.LocalPlayer.Idled:Connect(function()
         game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
         task.wait(1)
         game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
      end)
   elseif afkConn then
      afkConn:Disconnect()
   end
end})

UtilTab:CreateToggle({ Name = "Anti-Ban", CurrentValue = false, Flag = "AntiBan", Callback = function(v)
   if v then
      pcall(function()
         local mt = getrawmetatable(game)
         setreadonly(mt, false)
         local old = mt.__namecall
         mt.__namecall = newcclosure(function(self, ...)
            if getnamecallmethod():lower() == "kick" then return nil end
            return old(self, ...)
         end)
         setreadonly(mt, true)
      end)
   end
end})
