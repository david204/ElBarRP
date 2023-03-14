local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('nc-miner:givegold', function(gold, num)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem(gold, num)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[gold], 'add')
end)


local golds = {
    metalscrap = Config.price.metalscrap,
    copper = Config.price.copper,
    aluminum = Config.price.aluminum ,
    steel = Config.price.steel,
    rubber = Config.price.rubber,
  }
  
RegisterNetEvent('nc-miner:sellgold', function()
      local src = source
      local Player = QBCore.Functions.GetPlayer(src)
        for k,v in pairs(golds) do
           local item = Player.Functions.GetItemByName(k)
            if item ~= nil then
                if Player.Functions.RemoveItem(k, item.amount) then
                   Player.Functions.AddMoney('cash', v * item.amount)
                   TriggerClientEvent('QBCore:Notify', src, 'Good job! - You sold ' .. item.amount .. ' ' .. k .. ' ', 'success', 8000)
                end
            end
        end
  end)