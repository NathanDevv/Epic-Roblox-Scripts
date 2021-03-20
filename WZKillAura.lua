-- Made by the one and only sexy beast named icee :)

-- Vars
local Player            = game:GetService("Players").LocalPlayer;
local Combat 	        = require(game:GetService("ReplicatedStorage").Shared.Combat);
local CharProfileCheck 	= game:GetService("ReplicatedStorage"):FindFirstChild("Profiles"):FindFirstChild(Player.Name);
local ClassGUI 			= CharProfileCheck and game:GetService("ReplicatedStorage").Profiles[Player.Name].Class;
local GetEvent          = Combat and Combat:GetAttackEvent();
local MaxDistance       = 50; --> Change to your liking
local Speed             = 0.3; --> Change to liking

-- Support Stuff
if (not getconnections) then return Player:Kick("no getconnections support bye."); end;

-- Only supporting 3 bc why not? ( add more if u want )
local Classes = {
    ["Swordmaster"] 	= {"Swordmaster1", "Swordmaster2", "Swordmaster3", "Swordmaster4", "Swordmaster5", "Swordmaster6", "CrescentStrike1", "CrescentStrike2", "CrescentStrike3", "Leap"};
    ["Mage"] 			= {"Mage1", "ArcaneBlastAOE", "ArcaneBlast", "ArcaneWave1", "ArcaneWave2", "ArcaneWave3", "ArcaneWave4", "ArcaneWave5", "ArcaneWave6", "ArcaneWave7", "ArcaneWave8", "ArcaneWave9"};
    ["Defender"] 		= {"Defender1", "Defender2", "Defender3", "Defender4", "Defender5", "Groundbreaker", "Spin1", "Spin2", "Spin3", "Spin4", "Spin5"};
};

-- Gets Close Mob
local function getNearestMob()
    if (not Workspace:FindFirstChild("Mobs")) then return; end;

    local dis, mob = math.huge;

    for i,v in next, Workspace.Mobs:GetChildren() do 
        if (Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and v.PrimaryPart and v:FindFirstChild("HealthProperties") and v.HealthProperties.Health.Value > 0 and (v.PrimaryPart.Position - Player.Character.HumanoidRootPart.Position).magnitude <= MaxDistance) then
            mob = v;
        end;
    end;

    return mob;
end;

-- Bypass
if (GetEvent) then
    for i,v in next, getconnections(GetEvent.OnClientEvent) do
        v:Disable();
    end;
end;

-- Main Loop
while wait(Speed) do
    local mob = getNearestMob();

    if (mob and Player.Character and Player.Character.PrimaryPart) then
        for i,v in next, Classes[ClassGUI.Value] do
            Combat.AttackTargets({"Hi Wally!"}, {mob}, {Player.Character.PrimaryPart.Position}, v);
            game:GetService("RunService").Heartbeat:wait();
        end;
    end;
end;
