-- vars
local Players       = game.GetService(game, "Players"); -- only reason i did this is bc island royale would error if i use other way ( :shrug: )
local Player        = Players.LocalPlayer;
local Mouse         = Player:GetMouse();
local Workspace     = game.GetService(game, "Workspace");
local CurrentCam    = Workspace.CurrentCamera;

-- player func
local function getClosestPlayer()
    local closestPlayer;
    local shortestDistance = math.huge;
    
    for i, v in next, Players.GetPlayers(Players) do
        if (v ~= Player and v.Character and v.Character.FindFirstChild(v.Character, "Head")) then
            local pos       = CurrentCam.WorldToViewportPoint(CurrentCam, v.Character.Head.Position);
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude;

            if (magnitude < shortestDistance) then
                closestPlayer       = v;
                shortestDistance    = magnitude;
            end;
        end;
    end;
    
    return closestPlayer;
end;

-- main hook
local oldHook;
oldHook = hookmetamethod(game, "__namecall", function(self, ...)
    local args      = {...};
    local method    = getnamecallmethod();
    
    if (method == "FindPartOnRayWithIgnoreList" and getfenv(2).script.Name == "RC") then
        local closePlayer = getClosestPlayer();

        if (closePlayer and closePlayer.Character and closePlayer.Character.FindFirstChild(closePlayer.Character, "Head")) then
            local wally = (closePlayer.Character.Head.Position - CurrentCam.CFrame.Position);

            args[1] = Ray.new(CurrentCam.CFrame.Position, wally.unit * wally.magnitude);
            args[2] = {Workspace.Map_Objects, Workspace.MapBase};
        end;
    end;
    
    return oldHook(self, unpack(args));
end);

print'running' -- made by the sexy beast named icee
