local Network;

for i,v in next, getgc() do
    if (typeof(v) == "function") then
        for a, b in next, debug.getupvalues(v) do
            if (typeof(b) == "table" and rawget(b, "send")) then
                Network = b;
                break;
            end;
        end;
    end;
end;

local oldNet = Network.send;

Network.send = newcclosure(function(self, ...)
    local args = {...};

    if (args[1] == "closeconnection" or args[1] == "logmessage") then
        return;
    end;

    return oldNet(self, ...);
end);

print("Bypassed.");

-- game link: https://www.roblox.com/games/292439477/Phantom-Forces
-- epic right? ( enjoy weebs xd )
