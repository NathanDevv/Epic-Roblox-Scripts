-- Var
local Player = game:GetService("Players").LocalPlayer;
local remoteKey;

-- Main Loop
while wait() do
    -- ik bad method but idc
    if (Player.Character and Player.Character:FindFirstChild("WeaponScript") and getsenv(Player.Character.WeaponScript).Fire and not remoteKey) then
        remoteKey = debug.getupvalue(getsenv(Player.Character.WeaponScript).Fire, 15);
    end;
    
    if (remoteKey) then
        for i, v in next, Workspace.Baddies:GetChildren() do 
            if (v.Parent:FindFirstChild("Zombie") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HeadBox") and v.Humanoid:FindFirstChild("Damage")) then
                local args = {
                    ["BodyPart"]    = v.HeadBox;
                    ["GibPower"]    = 0;
                    ["Damage"]      = math.huge;
                };

                v.Humanoid.Damage:FireServer(args, remoteKey);
            end;
        end;
    end;
end;
