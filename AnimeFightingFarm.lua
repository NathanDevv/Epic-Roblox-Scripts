-- vars
local Players               = game:GetService("Players");
local Player                = Players.LocalPlayer;
local Workspace             = game:GetService("Workspace");
local ReplicatedStorage     = game:GetService("ReplicatedStorage");
local RunService            = game:GetService("RunService");
local mobName               = "Frieza1";

-- game vars
local world = Workspace.Worlds[Player.World.Value];

-- lib functions
if (not NEON) then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/belkworks/neon/master/init.lua"))();
end;
local machine 	= NEON:github("belkworks", "machine");
local broom     = NEON:github("belkworks", "broom");

-- game functions
local utils = {
    attack = function(Enemy)
        local bool = 1;

        for i, v in next, Workspace.Pets:GetChildren() do
            if (v:FindFirstChild("Data") and v.Data.Owner.Value == Player) then
                ReplicatedStorage.Remote.SendPet:FireServer(v, Enemy, bool);
                bool = bool + 1;
            end;
        end;
    end;
    getCloseEnemy = function(name)
        local Distance, Closest = math.huge;
        name = name or "";

        for i, v in next, world.Enemies:GetChildren() do
            if (v.Name:find(name) and v:FindFirstChild("HumanoidRootPart")) then
                local Mag = Player:DistanceFromCharacter(v.HumanoidRootPart.Position);

                if (Mag < Distance) then
                    Distance    = Mag;
                    Closest     = v;
                end;
            end;
        end;

        return Closest;
    end;
};

-- auto pickup
Workspace.Effects.ChildAdded:Connect(function(Child)
    if (Child.Name == "Yen") then
        ReplicatedStorage.Remote.Pickup:FireServer("Gem", 100000, "Yen");
    end;
end);

-- main farm
local autoFarmMachine = machine({
    Data = {
        SearchBroom 	= broom();
        TeleportBroom 	= broom();
    };
    States = {
        Idle = function(self)
            self:on("search", "Search");
            self:on("teleport", "Teleport");
            self:initial();
        end;
        Search = function(self)
            self:on("idle", "Idle");
            self:on("teleport", "Teleport");
            self:entry(function(state)
                state.Data.SearchBroom:GiveTask(RunService.Heartbeat:Connect(function()
                    local mob = utils.getCloseEnemy(mobName);

                    if (mob) then
                        state.Data.Mob 	= mob;
                        state:input("teleport");
                    end;
                end));
            end);
            self:exit(function(state)
                state.Data.SearchBroom:DoCleaning();
            end);
        end;
        Teleport = function(self)
            self:on("idle", "Idle");
            self:on("search", "Search");
            self:entry(function(state)
                state.Data.TeleportBroom:GiveTask(RunService.Heartbeat:Connect(function()
                    local character = Player.Character;
                    local hrp 		= (character and character:FindFirstChild("HumanoidRootPart"));

                    if (not hrp) then 
                        return;
                    end;

                    utils.attack(state.Data.Mob);
                    if (state.Data.Mob:FindFirstChild("Health") and state.Data.Mob.Health.Value > 0) then
                        ReplicatedStorage.Remote.ClickerDamage:FireServer(); 
                    end;

                    state:input("search");
                end));
            end);
            self:exit(function(state)
                state.Data.TeleportBroom:DoCleaning();
            end);
        end;
    };
});

-- starts auto farm
autoFarmMachine:input("search");

-- made by the one and only sexy beast icee
