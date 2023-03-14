local cooldowns = {}
local currentDurability

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("nc-containerrobbery:recivemoney",function()
	local src = tonumber(source)
	local Player = QBCore.Functions.GetPlayer(src)
    --local amount = Config.money
	--player.Functions.AddMoney('cash', amount, "Recived money")
	--TriggerClientEvent('QBCore:Notify', src, 'You recived ' .. amount .. "$", 'success')
    TriggerClientEvent('QBCore:Notify', src, 'You recieved some cash stacks', 'success')
    Player.Functions.AddItem("cashstack", math.random(1,3))
end)

RegisterNetEvent("nc-containerrobbery:reciveitems",function(items,amount)
	local src = tonumber(source)
	local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(items, amount)
	TriggerClientEvent('QBCore:Notify', src, 'You recived ' .. items, 'success')
end)

RegisterNetEvent("srp:setCooldown",function(netID)
	cooldowns[netID] = GetGameTimer() + 3600 * 500
end)

-- RegisterNetEvent("nc-containerrobbery:server:cooldown",function(time)
--     local src = source
--     if time then 
--         cooldowns[src] = time
--     elseif cooldowns[src] ~= nil then 
--         TriggerClientEvent("nc-containerrobbery:client:cooldown", src, cooldowns[src])
--     end
-- end)

QBCore.Functions.CreateCallback("srp:canRob", function(src,cb,networkID,name)
    if cooldowns[networkID] ~= nil and cooldowns[networkID] > GetGameTimer() then
        return cb(false,"This "..name .." was robbed.")
    end
    local players = QBCore.Functions.GetPlayers()
    local count = 0
    for k,v in next, players do 
        local player = QBCore.Functions.GetPlayer(v).PlayerData
        if player.job.name == "police" then 
            count = count + 1
        end
    end
    cb(count >= Config.needCops,"Not enough police")
end)

RegisterNetEvent("nc-containerrobbery:logs",function(choice, success, street, zone)
    local src = source
    local playerName = GetPlayerName(src)
    local label = choice == "atm" and "atm" or "container";

    TriggerEvent('nn:log', {
        src = src, 
        webhook = label,
        description = "Lockpick %s %s.",
        args = { label, success and 'successfully' or 'failed' },
        fields = {
            { name = "Zone", value = zone, inline = true },
            { name = "Street", value = street, inline = true },
        }
    });
end)