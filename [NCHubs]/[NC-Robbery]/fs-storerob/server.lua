local QBCore= exports['qb-core']:GetCoreObject()


RegisterNetEvent("fs-robstore:s:gcash", function(balance)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddMoney('cash', balance)
end)

RegisterNetEvent('fs-storerob:server:setRegisterStatus', function(register)
    TriggerClientEvent('fs-storerob:client:setRegisterStatus', -1, register, true)
    Config.Registers[register].robbed = true

    SetTimeout(Config.RegisterCooldwon*1000*60, function()
        TriggerClientEvent('fs-storerob:client:setRegisterStatus', -1, register, false)
        Config.Registers[register].robbed = false
    end)
end)

QBCore.Functions.CreateCallback('fs-storerob:s:hasLockpick', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source) 
    if Player ~= nil then
        local HasLockpick= Player.Functions.GetItemByName(Config.LockPickItem)
        if HasLockpick ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)



RegisterNetEvent('fs-storerob:server:removeLockpick', function()
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then return end

    Player.Functions.RemoveItem(Config.LockPickItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lockpick'], "remove")
end)

QBCore.Functions.CreateCallback('fs-storerob:s:checkcops', function(source, cb)
    if Player ~= nil then
        if GetCurrentCops() >= Config.minPolice then
            cb(true)
        else
            cb(false)
        end
    end
end)

function GetCurrentCops()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount =amount+ 1
        end
    end
    return amount
end

RegisterNetEvent('fs-storerob:server:setSafeStatus', function(safe)
    TriggerClientEvent('fs-storerob:client:setSafeStatus', -1, safe, true)
    Config.Safes[safe].robbed = true

    SetTimeout(Config.SafeCooldwon*1000*60, function()
        TriggerClientEvent('fs-storerob:client:setSafeStatus', -1, safe, false)
        Config.Safes[safe].robbed = false
    end)
end)

RegisterNetEvent("fs-robstore:s:gsnote", function(code)

    if code==1111111 then
        local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.AddItem(Config.SafePrize, 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.SafePrize], "add")

    else
        local info = {
            label = "Code: " ..code
        }
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddItem('stickynote', 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stickynote'], "add")

    end
end)