local QBCore = exports['qb-core']:GetCoreObject()
local lastrob = 0

QBCore.Functions.CreateCallback('artheist:server:checkRobTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['ArtHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['ArtHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('QBCore:Notify', source, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "error")
        cb(false)
    else
        lastrob = os.time()
        cb(true)
    end
end)

RegisterNetEvent('artheist:server:policeAlert')
AddEventHandler('artheist:server:policeAlert', function(coords)
    local players = QBCore.Functions.GetPlayers()
    
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if player.PlayerData.job.name == 'police' then
            TriggerClientEvent('artheist:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterServerEvent("nc-artheist:yonatan:GiveUSB")
AddEventHandler("nc-artheist:yonatan:GiveUSB", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('gold_usb', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['gold_usb'], "add")
end)

RegisterServerEvent("nc-artheist:yonatan:GiveCard")
AddEventHandler("nc-artheist:yonatan:GiveCard", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('security_card_04', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_04'], "add")
end)

RegisterServerEvent('artheist:server:syncHeistStart')
AddEventHandler('artheist:server:syncHeistStart', function()
    TriggerClientEvent('artheist:client:syncHeistStart', -1)
end)

RegisterServerEvent('artheist:server:syncPainting')
AddEventHandler('artheist:server:syncPainting', function(x)
    TriggerClientEvent('artheist:client:syncPainting', -1, x)
end)

RegisterServerEvent('artheist:server:syncAllPainting')
AddEventHandler('artheist:server:syncAllPainting', function()
    TriggerClientEvent('artheist:client:syncAllPainting', -1)
end)

RegisterServerEvent('artheist:server:rewardItem')
AddEventHandler('artheist:server:rewardItem', function(scene)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local item = scene['rewardItem']

    if player then
        player.Functions.AddItem(item, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")
    end
end)

RegisterServerEvent('artheist:server:finishHeist')
AddEventHandler('artheist:server:finishHeist', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        for k, v in pairs(Config['ArtHeist']['painting']) do
            local Item = Player.Functions.GetItemByName(v['rewardItem'])
            if Item ~= nil then
                if Item.amount > 0 then
                    for i = 1, Item.amount do
                        Player.Functions.RemoveItem(Item.name, 1)
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Item.name], "remove")
                        Player.Functions.AddMoney('cash', v['paintingPrice'], 'sold-fish')
                        Citizen.Wait(500)
                    end
                end
            end
        end
    end
end)

QBCore.Functions.CreateCallback('artheist:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)