local QBCore = exports['qb-core']:GetCoreObject()

-----new, completely new
RegisterServerEvent('nc-gym:giveMembership')
AddEventHandler('nc-gym:giveMembership', function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src) 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['gym_membership'], "add") 
    Player.Functions.AddItem('gym_membership', 1) 
end)

RegisterServerEvent('nc-gym:removeMembership')
AddEventHandler('nc-gym:removeMembership', function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src) 
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['gym_membership'], "remove") 
    Player.Functions.AddItem('gym_membership', 1) 
end)

QBCore.Functions.CreateCallback('nc-gym:getMembership',function(source, cb)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    local pass = Player.Functions.GetItemByName('gym_membership')
    if pass ~= nil then 
        cb(true)
    else 
        cb(false)
    end
end)

RegisterNetEvent('nc-gym:server:BillPlayer', function(playerId, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "gym" then
        if OtherPlayer then
            OtherPlayer.Functions.RemoveMoney("bank", price, "paid-bills")
            TriggerEvent('nc-bossmenu:server:addAccountMoney', "gym", price)
            TriggerClientEvent('QBCore:Notify', OtherPlayer.PlayerData.source, "You received a bill of $" .. price)
        end
    end
end)
