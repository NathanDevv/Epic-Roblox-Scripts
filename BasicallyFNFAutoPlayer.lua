--[[
    Note: It wont auto hit the note ( just gives you a good score )
]]

-- Var
local Player        = game:GetService("Players").LocalPlayer;
local PlayerGui     = Player.PlayerGui;
local RemoteNeeded  = game:GetService("ReplicatedStorage").Battle;

-- ChildAdded
PlayerGui.ChildAdded:Connect(function(Child)
    if (Child.Name == "FNFMode") then
        wait(0.1);

        local mainScript    = Child:WaitForChild("FNFMain");
        local scriptEnv     = getsenv(mainScript);

        local oldFunc       = scriptEnv.Note;

        scriptEnv.Note = newcclosure(function(...)
            local args = {...};

            if (args[2] == "S1" or args[2] == "S2") then
                RemoteNeeded:FireServer(0, game:GetService("ReplicatedStorage"):FindFirstChild(Player.Name, true) and game:GetService("ReplicatedStorage"):FindFirstChild(Player.Name, true).Parent or Workspace:FindFirstChild(Player.Name, true).Parent);
            end;

            return oldFunc(...);
        end);
    end;
end);

print'running';
