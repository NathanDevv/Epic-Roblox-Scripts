---------------------------------------------------
---              Fiusen Hub V2                  ---
---------------------------------------------------

-- Var
local Players       = game:GetService("Players"); --> Wally is sexy!
local Player        = Players.LocalPlayer;

-- Game Things
local scriptEnv     = require(game:GetService("ReplicatedStorage").Framework.Library);
local network       = scriptEnv.Network;
local gunCmds       = scriptEnv.GunCmds;
local SilentAimTog  = true;
local UnlockAllTog  = true;

-- Close Player Func
local function getClosestPlayer()
    local shortestDistance, closestPlayer  = math.huge;

    for i, v in next, Players:GetPlayers() do
        if (v.Name ~= Player.Name and v.Team ~= Player.Team and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and v.Character and v.Character:FindFirstChild("HumanoidRootPart")) then
            local mag = (v.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).magnitude;
            
            if (mag < shortestDistance) then
                closestPlayer = v;
                shortestDistance = mag;
            end;
        end;
    end;

    return closestPlayer;
end;

-- Kill Function
local function kill(code, plr)
    if (code and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")) then
        local data = 
            {
                [1] = 
            {
                [1] = plr.Character.Humanoid;
                [2] = code;
                [3] = 235;
                [4] = plr.Character.HumanoidRootPart.Position;
                [5] = false;
            };
                [2] = 
            {
                [1] = false;
                [2] = false;
                [3] = false;
                [4] = false;
                [5] = false;
            };
        };

        game:GetService("Workspace"):FindFirstChild("__THINGS"):FindFirstChild("__REMOTES"):FindFirstChild("do damage"):FireServer(data);
    end;
end;

-- Unlock All Hook
do
    -- Hook
    local oldUnlockAll = gunCmds.DoesOwnGun;

    gunCmds.DoesOwnGun = newcclosure(function(...)
        if (UnlockAllTog) then
            return true;
        end;

        return oldUnlockAll(...);
    end);
end;

-- Network Hook
do
    -- Hook
    local oldFire = network.Fire;

    network.Fire = newcclosure(function(self, ...)
        local args = {...};

        if (tostring(self) == "New Projectile" and SilentAimTog) then
            local closePlayer = getClosestPlayer();

            if (closePlayer) then
                kill(args[2], closePlayer); --> Epic func
            end;
        elseif (tostring(self) == "Request Respawn" and UnlockAllTog) then
            args[1] = "1"; --> Easy peasy bypass :)
        end;

        return oldFire(self, unpack(args));
    end);
end;

print'running!'; --> Prints for when its done loading gg
