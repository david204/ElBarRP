local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("binds", "Open commandbinding menu", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent("nc-commandbinding:client:openUI", source)
end)

RegisterNetEvent('nc-commandbinding:server:setKeyMeta', function(keyMeta)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)

    ply.Functions.SetMetaData("commandbinds", keyMeta)
end)
