local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("nc-vape:server:effects", function(entity, coords)
	for _, player in pairs(QBCore.Functions.GetPlayers()) do
		TriggerClientEvent("nc-vape:client:effects", player, entity, coords)
    end
end)

QBCore.Functions.CreateUseableItem("vape", function(source, item)
    TriggerClientEvent("nc-vape:client:use", source)
end)
