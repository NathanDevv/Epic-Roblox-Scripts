-- Waits until game is loaded
repeat wait() until game:IsLoaded();

-- Var
local Player = game:GetService("Players").LocalPlayer;

-- Checks for char
if (not Player.Character) then
    repeat wait() until Player.Character and Player.Character:FindFirstChild("CharacterHandler");
end;

-- Disables Errors
for i, v in next, getconnections(game:GetService("ScriptContext").Error) do
    v:Disable();    
end;

-- ChildAdded
if (Player.Character) then
    Player.Character.ChildAdded:connect(function(Child)
        if (tostring(Child) == "Burning" and Player.Character and Player.Character:FindFirstChild("CharacterHandler")) then
            -- For i,v loop on all remotes
            for i,v in next, Player.Character.CharacterHandler.Remotes:GetChildren() do
                if (v.Name:len() == 36 or v.Name == "Dodge") then
                    -- fires all remotes ( ik aids but its a meme method i found )
                    v:FireServer({math.random(1, 4), 0});
                    if (not Player.Character:FindFirstChild("Burning")) then break; end;
                end;
            end;
        end;
    end);
end;

print("running!");
