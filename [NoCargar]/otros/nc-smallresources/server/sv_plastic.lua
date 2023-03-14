RegisterServerEvent('qb-plastics:surgeryfuck', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('surgerypass', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['surgerypass'], "remove")
end)