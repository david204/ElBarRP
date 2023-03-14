local QBCore = exports['qb-core']:GetCoreObject()

local trunkBusy = {}

RegisterServerEvent('nc-trunk:server:setTrunkBusy')
AddEventHandler('nc-trunk:server:setTrunkBusy', function(plate, busy)
    trunkBusy[plate] = busy
end)

QBCore.Functions.CreateCallback('nc-trunk:server:getTrunkBusy', function(source, cb, plate)
    if trunkBusy[plate] then
        cb(true)
    end
    cb(false)
end)

RegisterServerEvent('nc-trunk:server:KidnapTrunk')
AddEventHandler('nc-trunk:server:KidnapTrunk', function(targetId, closestVehicle)
    TriggerClientEvent('nc-trunk:client:KidnapGetIn', targetId, closestVehicle)
end)

RegisterNetEvent('vehicle:flipit')
AddEventHandler('vehicle:flipit', function()
	TriggerClientEvent('vehicle:flipit')
end)