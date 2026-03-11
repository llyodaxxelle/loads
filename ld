local MainTab = Window:Tab({Title = "Trade", Icon = "repeat"})

-- Button 1: Freeze Player
MainTab:Button({
    Title = "Freeze Player",
    Icon = "pause",
    Desc = "Player freeze in trade",
    Callback = function()
        local inTrade, partner = checkTrade()
        if inTrade and partner ~= "" then
            WindUI:Notify({
                Title = "Freeze Player", 
                Content = "Player " .. partner .. " freeze in trade",
                Icon = "pause", 
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "Freeze Player", 
                Content = "Player freeze in trade",
                Icon = "pause", 
                Duration = 3
            })
        end
    end
})

-- Button 2: Force Accept
MainTab:Button({
    Title = "Force Accept",
    Icon = "trending-up",
    Desc = "Player forcing to accept trade",
    Callback = function()
        local inTrade, partner = checkTrade()
        
        -- After 2 seconds: Trade Accepted!
        wait(1)
        if inTrade and partner ~= "" then
            WindUI:Notify({
                Title = "Force Accept", 
                Content = "Trade Accepted with " .. partner .. "!",
                Icon = "check-circle", 
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "Force Accept", 
                Content = "Trade Accepted!",
                Icon = "check-circle", 
                Duration = 3
            })
        end
        
        -- After 9 more seconds: Trade Success! (Total: 11 seconds)
        wait(11)
        if inTrade and partner ~= "" then
            WindUI:Notify({
                Title = "Trade Success!", 
                Content = "Trade Success with " .. partner .. "!",
                Icon = "check-circle", 
                Duration = 10
            })
        else
            WindUI:Notify({
                Title = "Trade Success!", 
                Content = "Trade Success!",
                Icon = "check-circle", 
                Duration = 10
            })
        end
    end
})

-- Button 3: Auto Gamepass
MainTab:Button({
    Title = "Auto Gamepass",
    Icon = "gift",
    Desc = "Player force to add gamepass",
    Callback = function()
        local inTrade, partner = checkTrade()
        if inTrade and partner ~= "" then
            WindUI:Notify({
                Title = "Auto Gamepass", 
                Content = "Force to add gamepass with " .. partner,
                Icon = "package", 
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "Auto Gamepass", 
                Content = "Auto add gamepass",
                Icon = "package", 
                Duration = 3
            })
        end
    end
})

-- Auto trade monitor
spawn(function()
    while true do
        local inTrade, partner = checkTrade()
        
        if inTrade and not wasInTrade then
            -- Start of trade
            currentTradePartner = partner
            WindUI:Notify({
                Title = "TRADE DETECTED",
                Content = "Now trading with: " .. partner,
                Icon = "users",
                Duration = 5
            })
            wasInTrade = true
            
        elseif not inTrade and wasInTrade then
            -- End of trade
            if currentTradePartner ~= "" then
                WindUI:Notify({
                    Title = "TRADE ENDED",
                    Content = "Trade with " .. currentTradePartner .. " has ended",
                    Icon = "x-circle",
                    Duration = 3
                })
            end
            currentTradePartner = ""
            wasInTrade = false
        end
        
        wait(2)
    end
end)

-- Trade Status Check Button
MainTab:Button({
    Title = "Check Partner",
    Icon = "eye",
    Desc = "Check who you're trading with",
    Callback = function()
        local inTrade, partner = checkTrade()
        if inTrade and partner ~= "" then
            WindUI:Notify({
                Title = "Current Trade Partner",
                Content = "Trading with: " .. partner,
                Icon = "user",
                Duration = 5
            })
        else
            WindUI:Notify({
                Title = "Trade Status",
                Content = "Not in trade",
                Icon = "x-circle",
                Duration = 3
            })
        end
    end
})

Window:Tab({Title="Settings", Icon="settings"}):Button({
    Title="Reset",
    Icon="refresh-cw",
    Desc = "Reset script settings",
    Callback=function()
        WindUI:Notify({
            Title="Reset", 
            Content="Script reset",
            Icon="check", 
            Duration=3
        })
    end
})
