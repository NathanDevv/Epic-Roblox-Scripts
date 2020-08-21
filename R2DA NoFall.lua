local old;
old = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)
    if (tostring(self) == "SelfDamage") then
        return;
    end;
    
    return old(self, ...);
end));
