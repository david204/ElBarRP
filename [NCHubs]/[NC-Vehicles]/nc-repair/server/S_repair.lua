local QBCore = exports['qb-core']:GetCoreObject()
RegisterServerEvent('khrp:costRepair', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.RemoveMoney('bank', 350, "repair-bill")
        TriggerEvent('qb-bossmenu:server:addAccountMoney', 'mechanic', 350)
        TriggerClientEvent('QBCore:Notify', src, 'Repair Done!!', 'success')
end)