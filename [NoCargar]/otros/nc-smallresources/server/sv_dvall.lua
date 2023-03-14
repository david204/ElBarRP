QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('dvall', 'Delete All Vehicles', {}, false, function(source, args)
    TriggerClientEvent("wld:delallveh", -1)
end, 'god')