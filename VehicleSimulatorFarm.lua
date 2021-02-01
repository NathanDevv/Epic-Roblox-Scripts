-- Var
local Player                = game:GetService("Players").LocalPlayer;
local VirtualInputManager   = game:GetService("VirtualInputManager");

-- Tp Bypass ( ik aids but idrc )
local meta      = debug.getmetatable(game);
local oldName   = meta.__namecall;
setreadonly(meta, false);

meta.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod();

    if (method == "FireServer" and tostring(self) ~= "VehicleRegen" and tostring(self) ~= "SayMessageRequest") then
        return;
    end;

    return oldName(self, ...);
end);

setreadonly(meta, true);

-- Gets Car
local function getCar()
    for i,v in next, Workspace.Vehicles:GetChildren() do
        if (v:FindFirstChild("owner") and v.owner.Value == Player.Name) then
            return v;
        end;
    end;
end;

-- Main Loop
while wait() do
    local car = getCar();

    if (car) then
        car:SetPrimaryPartCFrame(CFrame.new(3108.53809, 234.257156, -245.968567, -0.999986708, 0.000483330194, 0.00513798418, 0.00512808375, -0.0186382569, 0.999813139, 0.000579002954, 0.999826193, 0.01863553));
        VirtualInputManager:SendKeyEvent(true, "W", false, game);
        wait(3.5);
    end;
end;
