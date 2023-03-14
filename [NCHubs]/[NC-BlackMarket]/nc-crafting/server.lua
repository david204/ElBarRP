local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("mesa_craft", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('qb-okokCrafting:client:SpawnarMesa', source)
    end
end)

RegisterNetEvent('qb-okokCrafting:server:AddPontos', function(pontos)
    local Player = QBCore.Functions.GetPlayer(source)
    
    Player.Functions.SetMetaData("craftinglevel", Player.PlayerData.metadata["craftinglevel"]+(pontos))
end)

RegisterNetEvent('qb-okokCrafting:server:RemoveItem', function(item, count)
    local Player = QBCore.Functions.GetPlayer(source)
    
    Player.Functions.RemoveItem(item, count)
end)

RegisterNetEvent('qb-okokCrafting:server:AddItem', function(item, count)
    local Player = QBCore.Functions.GetPlayer(source)
    
    Player.Functions.AddItem(item, count)
end)

RegisterNetEvent('qb-okokCrafting:server:TirarPontos', function(pontosPerdidos)
    local Player = QBCore.Functions.GetPlayer(source)
    
    Player.Functions.SetMetaData("craftinglevel", Player.PlayerData.metadata["craftinglevel"]-(pontosPerdidos))
end)

QBCore.Functions.CreateCallback('qb-okokCrafting:server:ItemsSuficientes', function(source, cb, items)
    local src = source
    local hasItems = false
    local numero = 0
    local player = QBCore.Functions.GetPlayer(source)
    for k, v in pairs(items) do
        if player.Functions.GetItemByName(v.item) and player.Functions.GetItemByName(v.item).amount >= v.amount then
            numero = numero + 1
            if numero == #items then
                cb(true)
            end
        else
            cb(false)
            return
        end
    end
end)