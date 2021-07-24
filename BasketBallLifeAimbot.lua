local oldHook;
oldHook = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...};
    
    if (self.Name == "shoot") then
        args[1] = math.huge;
    end;
    
    return oldHook(self, unpack(args));
end);

print'loaded'; -- made by icee :)
