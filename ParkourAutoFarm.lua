-- Stuff
repeat wait() until game:IsLoaded();

-- Checks for player
if (not game:GetService("Players").LocalPlayer.Character) then
    repeat wait() until game:GetService("Players").LocalPlayer.Character;
end;

-- Var
local Player            = game:GetService("Players").LocalPlayer;
local mainScript        = Player.Backpack.Main;
local pointScript       = Player.PlayerScripts.Points;
local pointScriptEnv    = getsenv(pointScript);
local FuncNeed          = pointScriptEnv.changeParkourRemoteParent;
local remote            = debug.getupvalue(pointScriptEnv.changeParkourRemoteParent, 2);

-- Bypass
getfenv().script = mainScript;

Player.CharacterAdded:Connect(function()
    repeat wait() until Player.Character and Player.Backpack:FindFirstChild("Main");

    mainScript = Player.Backpack.Main;
    getfenv().script = mainScript;
end);

-- Main Loop
while wait(1.3) do
    if (not Player.Backpack:FindFirstChild("Main")) then return; end;

    FuncNeed(Workspace);

    remote:FireServer(getsenv(mainScript).encrypt("walljump"), {
        [getsenv(mainScript).encrypt("walljumpDelta")]  = getsenv(mainScript).encrypt(tostring(math.random(2, 3)));
        [getsenv(mainScript).encrypt("combo")]          = getsenv(mainScript).encrypt(tostring(math.random(1, 5)));
    });
end;
