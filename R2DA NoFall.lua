local old;
old = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)
    if (tostring(self) == "SelfDamage") then
        return;
    end;
    
    return old(self, ...);
end));

--game link: https://www.roblox.com/games/5108997584/Reason-2-Die-Awakening
