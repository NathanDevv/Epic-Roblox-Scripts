-- vars
local Players       = game:GetService("Players");
local Player        = Players.LocalPlayer;
local Mouse         = Player:GetMouse();
local Workspace     = game:GetService("Workspace");
local CurrentCam    = Workspace.CurrentCamera;
local require       = require;

-- player func
local function getClosestPlayer()
    local closestPlayer;
    local shortestDistance = math.huge;
    
    for i, v in next, Players:GetPlayers() do
        if (v ~= Player and v.Character and v.Character:FindFirstChild("Head")) then
            local pos       = CurrentCam:WorldToViewportPoint(v.Character.Head.Position);
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude;

            if (magnitude < shortestDistance) then
                closestPlayer       = v;
                shortestDistance    = magnitude;
            end;
        end;
    end;
    
    return closestPlayer;
end;

-- main func
local function run()
    task.wait(0.8); -- task lib winning

    if (Player.PlayerGui:FindFirstChild("MainGui")) then
        local gunModule = require(Player.PlayerGui.MainGui.NewLocal.Tools.Tool.Gun);
        local oldFunc   = gunModule.ConeOfFire;

        gunModule.ConeOfFire = function(...)
            if (getfenv(2).script.Name == "Extra") then
                local closePlayer = getClosestPlayer();
                
                if (closePlayer and closePlayer.Character) then
                    return closePlayer.Character.Head.CFrame * CFrame.new(math.random(0.1, 0.25), math.random(0.1, 0.25), math.random(0.1, 0.25)).p;
                end;
            end;
            
            return oldFunc(...);
        end;
    end;
end;

-- first run
run();

-- epic char added
Player.CharacterAdded:Connect(run);

-- made by once again the sexy beast named icee
