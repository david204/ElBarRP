QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("nightvision", function(source)
    local player = QBCore.Functions.GetPlayer(source)
        if player ~= nil then 
            TriggerClientEvent("nc-nightvision:toggle", source)
        end 
end)
