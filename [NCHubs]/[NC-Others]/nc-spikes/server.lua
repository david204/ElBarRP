local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("policespikes", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent("spikestrips:client:usespikes", source, item)
end)

RegisterServerEvent("nc-spikes-use")
AddEventHandler("nc-spikes-use", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["policespikes"], 'remove')
    Player.Functions.RemoveItem('policespikes', Config.Amount, false, info) 
end)

RegisterServerEvent("nc-spikes-remove")
AddEventHandler("nc-spikes-remove", function(netid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["policespikes"], 'add')
    Player.Functions.AddItem('policespikes',  1, false, info) -- set to 1 still pulls the config spawned ammount...
    TriggerClientEvent("nc-spikes-delete", -1, netid) 
end)
